//
//  SegmentVC.swift
//  CommonSwift
//
//  Created by lipeng on 2017/3/30.
//  Copyright © 2017年 com.jsinda. All rights reserved.
//

import UIKit

class SegmentVC: CMBaseVC {

    var segmentView: SMSegmentView!
    var margin: CGFloat = 10.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK - init JTSegement
        var frame = CGRect(x: 10.0, y: 130.0, width: self.view.bounds.size.width - 20.0, height: 44.0)
        let segmentControl = JTSegmentControl(frame: frame)
        segmentControl.delegate = self
        segmentControl.items = ["first", "second", "third", "fouth"]
        segmentControl.showBridge(show: true, index: 1)
        segmentControl.autoScrollWhenIndexChange = false
        view.addSubview(segmentControl)
        
        
        
        //MARK - init autoAdjustWidth JTSegement
        frame = CGRect(x: 10.0, y: 250.0, width: self.view.bounds.size.width - 20.0, height: 44.0)
        let autoWidthControl = JTSegmentControl(frame: frame)
        autoWidthControl.delegate = self
        autoWidthControl.items = ["first", "second", "third", "fouth", "fifth", "sixth", "seventh", "eighth"]
        autoWidthControl.showBridge(show: true, index: 4)
        autoWidthControl.selectedIndex = 1
        autoWidthControl.autoAdjustWidth = true
        autoWidthControl.bounces = false
        view.addSubview(autoWidthControl)
        
        
        
        
        let appearance = SMSegmentAppearance()
        appearance.segmentOnSelectionColour = UIColor(red: 245.0/255.0, green: 174.0/255.0, blue: 63.0/255.0, alpha: 1.0)
        appearance.segmentOffSelectionColour = UIColor.white
        appearance.titleOnSelectionFont = UIFont.systemFont(ofSize: 12.0)
        appearance.titleOffSelectionFont = UIFont.systemFont(ofSize: 12.0)
        appearance.contentVerticalMargin = 10.0
        
        
        /*
         Init SMsegmentView
         Set divider colour and width here if there is a need
         */
        let segmentFrame = CGRect(x: self.margin, y: 320.0, width: self.view.frame.size.width - self.margin*2, height: 40.0)
        self.segmentView = SMSegmentView(frame: segmentFrame, dividerColour: UIColor(white: 0.95, alpha: 0.3), dividerWidth: 1.0, segmentAppearance: appearance)
        self.segmentView.backgroundColor = UIColor.clear
        
        self.segmentView.layer.cornerRadius = 5.0
        self.segmentView.layer.borderColor = UIColor(white: 0.85, alpha: 1.0).cgColor
        self.segmentView.layer.borderWidth = 1.0
        
        // Add segments
        self.segmentView.addSegmentWithTitle("Clip", onSelectionImage: UIImage(named: "clip_light"), offSelectionImage: UIImage(named: "clip"))
        self.segmentView.addSegmentWithTitle("Blub", onSelectionImage: UIImage(named: "bulb_light"), offSelectionImage: UIImage(named: "bulb"))
        self.segmentView.addSegmentWithTitle("Cloud", onSelectionImage: UIImage(named: "cloud_light"), offSelectionImage: UIImage(named: "cloud"))
        
        self.segmentView.addTarget(self, action: #selector(selectSegmentInSegmentView(segmentView:)), for: .valueChanged)
        
        // Set segment with index 0 as selected by default
        self.segmentView.selectedSegmentIndex = 0
        self.view.addSubview(self.segmentView)
    }
    
    // SMSegment selector for .ValueChanged
    func selectSegmentInSegmentView(segmentView: SMSegmentView) {
        /*
         Replace the following line to implement what you want the app to do after the segment gets tapped.
         */
        print("Select segment at index: \(segmentView.selectedSegmentIndex)")
    }
}

extension SegmentVC : JTSegmentControlDelegate {
    func didSelected(segement: JTSegmentControl, index: Int) {
        print("current index \(index)")
        //        self.label.text = "this is index:"+String(index)
        
        segement.showBridge(show: false, index: index)
    }
}
