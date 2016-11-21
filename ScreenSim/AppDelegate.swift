//
//  AppDelegate.swift
//  ScreenSim
//
//  Created by kyb on 20/06/16.
//  Copyright © 2016 Suborbital Softworks Ltd. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    var windowControllers: [SimulatorWindowController] = []
    var iconWindowControllers: [IconSimulatorWindowController] = []
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
//        let path = "/Users/kyb/code/vector3/promo-materials/screenshots"
//        let wc = SimulatorWindowController(imageFolder: path)
//        self.windowControllers.append(wc)
//        wc.showWindow(self)

//        let iconPath = "/Users/kyb/code/vector3/vec3icon.icns"
        let iconPaths = ["/Users/kyb/Dropbox/nframe/as-icon/1024.png",
                         "/Users/kyb/Dropbox/nframe/tp-icon/1024.png"]
                         
        let wc = IconSimulatorWindowController(iconPaths: iconPaths)
        self.iconWindowControllers.append(wc)
        wc.showWindow(self)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}

