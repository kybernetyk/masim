//
//  IconSimulatorView.swift
//  ScreenSim
//
//  Created by kyb on 21/06/16.
//  Copyright © 2016 Suborbital Softworks Ltd. All rights reserved.
//

import Cocoa

class IconSimulatorView: NSView {
//    @IBInspectable var wallpaperImage: NSImage? = NSImage(named: "Wallpaper")
    @IBInspectable var masImage: NSImage? = NSImage(named: "MasIcon")
    
    var icons: [NSImage] = [] {
        didSet {
            for idx in 0..<icons.count {
                self.currentColRows[idx] = (col: 0, row: 0)
            }
            self.needsDisplay = true
        }
    }
    
    fileprivate var currentColRows: [Int : (col: Int, row: Int)] = [:] {
        didSet {
            self.needsDisplay = true
        }
    }
    
    
    fileprivate func iconRectAt(_ col: Int, row: Int) -> CGRect {
        //all values derived from a 2880x1440 screenshot (MasIcon in assets)
        func coordsForColRow(_ col: Int, row: Int) -> (x: CGFloat, y: CGFloat) {
            func xForCol(_ col: Int) -> CGFloat {
                let colw: CGFloat = 0.16085
                return 0.08576388889 + colw * CGFloat(col)
            }
            
            func yForRow(_ row: Int) -> CGFloat {
                let rowh: CGFloat = 0.120
                return 0.69 - rowh * CGFloat(row)
            }
            
            return (xForCol(col), yForRow(row))
        }

        let wf: CGFloat = 75.0 / 1440.0
        let hf: CGFloat = 75.0 / 900.0
        
        let w = wf * self.cbounds.width
        let h = hf * self.cbounds.height
        
        let coords = coordsForColRow(col, row: row)
        let x = coords.x * self.cbounds.width
        let y = coords.y * self.cbounds.height
        
        return CGRect(x: x, y: y, width: w, height: h)
    }
    
    //dirtey iterating lol
    func colRowAtPoint(_ point: CGPoint) -> (col: Int, row: Int)? {
        for c in 0..<5 {
            for r in 0..<6 {
                let rct = self.iconRectAt(c, row: r)
                if rct.contains(point) {
                    return (col: c, row: r)
                }
            }
        }
        return nil
    }

    fileprivate func iconRectForIconAtIndex(_ iconIndex: Int) -> CGRect? {
        if let rc = self.currentColRows[iconIndex] {
            return self.iconRectAt(rc.col, row: rc.row)
        }
        return nil
    }
    
    fileprivate var lastClickLocation: CGPoint = CGPoint.zero
    fileprivate var cbounds: NSRect {
        return self.centerScanRect(self.bounds)
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        self.masImage?.draw(in: self.cbounds)
        
        NSColor.white.set()
        for idx in 0..<self.icons.count {
            if let r = self.iconRectForIconAtIndex(idx) {
                NSRectFill(NSInsetRect(r, -1, -1))
                self.icons[idx].draw(in: r)
            }
        }
    }
    
    override func mouseUp(with theEvent: NSEvent) {
        let clickLocation = self.convert(theEvent.locationInWindow, from:  nil)
        if let coords = self.colRowAtPoint(clickLocation) {
            self.currentColRows[0] = coords
        }
    }

    override func rightMouseUp(with theEvent: NSEvent) {
        let clickLocation = self.convert(theEvent.locationInWindow, from:  nil)
        if let coords = self.colRowAtPoint(clickLocation) {
            self.currentColRows[1] = coords
        }
    }

    
}
