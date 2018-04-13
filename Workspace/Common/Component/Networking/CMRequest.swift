//
//  CMBaseRequest.swift
//  CommonSwift
//
//  Created by lipeng on 2017/2/27.
//  Copyright © 2017年 com.jsinda. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import HandyJSON

public enum CMRequestMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case post    = "POST"
}

func adapterMethod(_ method: CMRequestMethod) -> HTTPMethod {
    switch method {
    case CMRequestMethod.post:
        return HTTPMethod.post
    case CMRequestMethod.get:
        return HTTPMethod.get
    default:
        return HTTPMethod.post
    }
}

class CMRequest: NSObject {
    
    typealias ResponseType = (CMResponse) -> ()
    var success: ResponseType = {_ in }
    var failed: ResponseType = {_ in }
    var response: ResponseType = {_ in }
    var progress: (Progress) -> () = {_ in }
    
    var url: String = "" {
        didSet {
            if url.characters.count > 0 && !url.hasPrefix("http") {
                url = URL(string: ServerAddress)!.appendingPathComponent(url).absoluteString
            }
        }
    }
    var method: CMRequestMethod = .post
    var parameters: [String: Any]? = nil
    var isJsonParameters: Bool = false
    var responseModel: HandyJSON.Type? = nil
    
    // file
    var fileUrl: URL? = nil
    var fileData: Data? = nil
    var fileName: String = "fileName"
    var fileMimeType: String = ""
    
    var alamoRequest: Request? {
        didSet {
            oldValue?.cancel()
        }
    }
    
    // MARK: - method
    
    func cancel() {
        self.alamoRequest?.cancel()
    }
    
    @discardableResult
    func success(_ success: @escaping ResponseType) -> Self {
        self.success = success
        return self
    }
    
    @discardableResult
    func failed(_ failed: @escaping ResponseType) -> Self {
        self.failed = failed
        return self
    }
    
    @discardableResult
    func progress(_ progress: @escaping (Progress) -> ()) -> Self {
        self.progress = progress
        return self
    }
    
    
    // MARK: - request
    
    func request() -> Self {
        cmShowLoading()
        
        // 参数转为json串
        var requestParameters = parameters
        if isJsonParameters {
            if let parameters = parameters {
                if let jsonData = JSON(dictionary: parameters).rawString() {
                    requestParameters = ["jsonData": jsonData]
                }
            }
        }
        
        self.alamoRequest = Alamofire.request(url, method: adapterMethod(method), parameters: requestParameters)
        if let request = alamoRequest as? DataRequest {
            request.responseData(completionHandler: { (response) in
                self.handleResponse(response)
            })
        }
        
        return self
    }
    
    
    // MARK: - download
    
    func downLoad() -> Self {
        self.alamoRequest = Alamofire.download(url, method: adapterMethod(method), parameters: parameters, encoding: URLEncoding.default, headers: nil, to: { _, response in
            let fileUrl = self.fileUrl ?? cmCacheUrl(name: response.suggestedFilename!)
            //两个参数表示如果有同名文件则会覆盖，如果路径中文件夹不存在则会自动创建
            return (fileUrl, [.removePreviousFile, .createIntermediateDirectories])
        }).response { response in
            print(response)
            
            if let error = response.error {
                self.handleError(error)
            }
            else {
                let cmResponse = CMResponse()
                cmResponse.fileUrl = response.destinationURL
                self.success(cmResponse)
            }
        }.downloadProgress(closure: { (progress) in
            self.progress(progress)
        })
        
        return self
    }
    
    
    // MARK: - upload
    
    func upload() -> Self {
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            if let fileData = self.fileData {
                multipartFormData.append(fileData, withName: "filePath", fileName: self.fileName, mimeType: self.fileMimeType)
            }
            
            if let parameters = self.parameters {
                if let jsonData = JSON(dictionary: parameters).rawString() {
                    multipartFormData.append(jsonData.data(using: .utf8)!, withName: "jsonData")
                }
            }
        }, to: self.url) { (result) in
            switch result {
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (progress) in
                    self.progress(progress)
                })
                
                upload.responseData(completionHandler: { (response) in
                    self.handleResponse(response)
                })
                
            case .failure(let error):
                self.handleError(error)
            }
        }
        
        return self
    }
    
    func handleResponse(_ response: DataResponse<Data>) {
        if response.result.isSuccess {
            let json = JSON(data: response.result.value!)
            print(json)
            
            let model = self.responseModel?.deserialize(from: json.rawString())
            
            if let response = model as? CMResponse {
                response.json = json
                self.success(response)
            }
            else {
                let response = CMResponse()
                response.json = json
                self.success(response)
            }
        }
        else {
            self.handleError(response.error)
        }
        
        cmHideLoading()
    }
    
    func handleError(_ error: Error?) {
        let response = CMResponse()
        response.error = error
        self.failed(response)
        
        cmHideLoading()
    }
    
    public enum PXFError: Error {
        case deserialize_Error(String?)
    }
    
//    getBaseParamters(paramters, requestCode: requestApi)
    func sendNetworkRequest<T:HandyJSON>(_ paramters: [String : String],requestApi:String,finished:@escaping (_ responseModel: T,_ error: Error?)->()){
        
        Alamofire.request(url, method: .post, parameters: paramters).responseString { response in
            
            if response.result.isSuccess{
                
                if let responseObject = T.deserialize(from: response.result.value) {
                    finished(responseObject,nil)
                }else{
                    finished(T(),PXFError.deserialize_Error(response.result.value))
                }
                
            }else{
                finished(T(),response.result.error)
            }
            
        }
    }
    
//    @objc func requestUpdate(){
//        var paramters = [String : String]()
//        paramters["current_version_num"] = APP_VERSION_CODE
//
//        NetworkTool.sharedInstance.sendNetworkRequest(paramters, requestApi: VERSION_UPDATE_API) { (updateInfo:UpdateInfo, error) in
//
//            if error == nil{
//                ALinLog(error)
//            }else{
//                ALinLog(updateInfo)
//            }
//        }
//    }
    
}


