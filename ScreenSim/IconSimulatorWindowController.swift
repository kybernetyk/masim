//
//  IconSimulatorWindowController.swift
//  ScreenSim
//
//  Created by kyb on 21/06/16.
//  Copyright © 2016 Suborbital Softworks Ltd. All rights reserved.
//

import Cocoa

class IconSimulatorWindowController: NSWindowController {
    var iconPaths: [String] = []
    var simViewController = IconSimulatorViewController()
    
    convenience init(iconPaths: [String]) {
        self.init()
        self.iconPaths = iconPaths
    }
    
    override var windowNibName: String? {
        return "IconSimulatorWindowController"
    }

    override func windowDidLoad() {
        super.windowDidLoad()

        self.window?.contentViewController = self.simViewController
        self.loadIcons()
    }
    
    @IBAction func reload(_ sender: AnyObject?) {
        self.loadIcons()
    }

    func loadIcons() {
        var icons: [NSImage] = []
        for iconp in self.iconPaths {
            if let icon = NSImage(contentsOfFile: iconp) {
                icons.append(icon)
            }
        }
        self.simViewController.icons = icons
    }
}
