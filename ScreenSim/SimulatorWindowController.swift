//
//  SimulatorWindowController.swift
//  ScreenSim
//
//  Created by kyb on 20/06/16.
//  Copyright © 2016 Suborbital Softworks Ltd. All rights reserved.
//

import Cocoa

extension String {
    var lastPathComponent: String {
        return String(NSString(string: self).lastPathComponent)
    }
    
    func stringByAppendingPathComponent(_ comp: String) -> String {
        let ns = NSString(string: self).appendingPathComponent(comp)
        return String(ns)
    }
}

class SimulatorWindowController: NSWindowController {
    fileprivate var simViewController = SimulatorViewController()
    
    var imageFolder: String? = nil
    
    convenience init(imageFolder: String) {
        self.init()
        self.imageFolder = imageFolder
    }
    
    override var windowNibName: String? {
        return "SimulatorWindowController"
    }

    func loadImagesFromFolder(_ path: String) -> [NSImage] {
        let fmgr = FileManager.default
        do {
            let fcontents = try fmgr.contentsOfDirectory(atPath: path)
            let fns = fcontents.filter {
                $0.contains(".png") && !$0.contains("exp")
            }
            return fns.flatMap { (fn: String) -> NSImage? in
                let absp = path.stringByAppendingPathComponent(fn)
                return NSImage(contentsOfFile: absp)
            }
        } catch {
            return []
        }
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        guard let ifdr = self.imageFolder else {
            fatalError("no image folder set")
            //TODO: trigger NSOpenPanel in this case
        }
        self.window?.contentViewController = self.simViewController
        self.window?.setTitleWithRepresentedFilename(ifdr)
        self.simViewController.images = self.loadImagesFromFolder(ifdr)
        
    }
    
    @IBAction func reload(_ sender: AnyObject?) {
        guard let ifdr = self.imageFolder else {
            fatalError("no image folder set")
            //TODO: trigger NSOpenPanel in this case
        }

        self.simViewController.images = self.loadImagesFromFolder(ifdr)
    }
}
