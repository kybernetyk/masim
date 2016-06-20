//
//  SimulatorViewController.swift
//  ScreenSim
//
//  Created by kyb on 20/06/16.
//  Copyright © 2016 Suborbital Softworks Ltd. All rights reserved.
//

import Cocoa

class SimulatorViewController: NSViewController {
    @IBOutlet var simView: SimulatorView!
    var images: [NSImage] = [] {
        didSet {
            self.simView.images = self.images
        }
    }

    convenience init(images: [NSImage]) {
        self.init()
        self.images = images
    }
    
    override var nibName: String? {
        return "SimulatorViewController"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.simView.images = images
    }
    
}
