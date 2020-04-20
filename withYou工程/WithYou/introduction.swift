//
//  introduction.swift
//  WithYou
//
//  Created by kelo on 2020/4/13.
//  Copyright © 2020 邓萌达. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setStaticGuidePage()
    }
    
    func setStaticGuidePage() {
        let imageNameArray: [String] = ["guide00", "guide01", "guide02"]
        let guideView = HHGuidePageHUD.init(imageNameArray: imageNameArray, isHiddenSkipButton: false)
        self.navigationController?.view.addSubview(guideView)
    }
    
}

