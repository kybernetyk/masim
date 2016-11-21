//
//  IconSimulatorViewController.swift
//  ScreenSim
//
//  Created by kyb on 21/06/16.
//  Copyright © 2016 Suborbital Softworks Ltd. All rights reserved.
//

import Cocoa

class IconSimulatorViewController: NSViewController {
    @IBOutlet var simView: IconSimulatorView!

    var icons: [NSImage] = [] {
        didSet {
            self.simView.icons = icons
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}
