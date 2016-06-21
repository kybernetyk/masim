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

    var icon: NSImage? = nil {
        didSet {
            self.simView.icon = icon
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}
