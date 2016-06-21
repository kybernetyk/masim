//
//  IconSimulatorWindowController.swift
//  ScreenSim
//
//  Created by kyb on 21/06/16.
//  Copyright © 2016 Suborbital Softworks Ltd. All rights reserved.
//

import Cocoa

class IconSimulatorWindowController: NSWindowController {
    var iconPath: String? = nil
    var simViewController = IconSimulatorViewController()
    
    convenience init(iconPath: String) {
        self.init()
        self.iconPath = iconPath
//        self.imageFolder = imageFolder
    }
    
    override var windowNibName: String? {
        return "IconSimulatorWindowController"
    }

    override func windowDidLoad() {
        super.windowDidLoad()

        guard let iconp = self.iconPath else {
            fatalError("no image folder set")
            //TODO: trigger NSOpenPanel in this case
        }
        self.window?.contentViewController = self.simViewController
        self.window?.setTitleWithRepresentedFilename(iconp)
        self.simViewController.icon = NSImage(contentsOfFile: iconp)
    }
    
}
