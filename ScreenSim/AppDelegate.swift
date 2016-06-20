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
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        
        let path = "/Users/kyb/code/vector3/promo-materials/screenshots"
        let wc = SimulatorWindowController(imageFolder: path)
        self.windowControllers.append(wc)
        wc.showWindow(self)
        
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

