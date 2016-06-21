//
//  IconSimulatorView.swift
//  ScreenSim
//
//  Created by kyb on 21/06/16.
//  Copyright © 2016 Suborbital Softworks Ltd. All rights reserved.
//

import Cocoa

class IconSimulatorView: NSView {
    @IBInspectable var wallpaperImage: NSImage? = NSImage(named: "Wallpaper")
    @IBInspectable var masImage: NSImage? = NSImage(named: "MasIcon")
    
    var icon: NSImage? = nil {
        didSet {
            self.needsDisplay = true
        }
    }
    
    private var currentColRow: (col: Int, row: Int) = (col: 0, row: 0) {
        didSet {
            self.needsDisplay = true
        }
    }
    
    private func iconRectAt(col: Int, row: Int) -> CGRect {
        //all values derived from a 2880x1440 screenshot
        func coordsForColRow(col: Int, row: Int) -> (x: CGFloat, y: CGFloat) {
            func xForCol(col: Int) -> CGFloat {
                let colw: CGFloat = 0.1607638889
                return 0.08576388889 + colw * CGFloat(col)
            }
            
            func yForRow(row: Int) -> CGFloat {
                let rowh: CGFloat = 0.121
                return 0.6916666667 - rowh * CGFloat(row)
            }
            
            return (xForCol(col), yForRow(row))
        }

        let wf: CGFloat = 76.0 / 1440.0
        let hf: CGFloat = 76.0 / 900.0
        
        let w = wf * self.cbounds.width
        let h = hf * self.cbounds.height
        
        let coords = coordsForColRow(col, row: row)
        let x = coords.x * self.cbounds.width
        let y = coords.y * self.cbounds.height
        
        return CGRect(x: x, y: y, width: w, height: h)
    }
    
    //dirtey iterating lol
    func colRowAtPoint(point: CGPoint) -> (col: Int, row: Int)? {
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

    private var iconRect: CGRect {
        return self.iconRectAt(self.currentColRow.col, row: self.currentColRow.row)
    }

    
    private var lastClickLocation: CGPoint = CGPointZero
    
    private var cbounds: NSRect {
        return self.centerScanRect(self.bounds)
    }
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        
        self.wallpaperImage?.drawInRect(self.cbounds)
        self.masImage?.drawInRect(self.cbounds)
        
        NSColor.whiteColor().set()
        NSRectFill(self.iconRect)
        
        self.icon?.drawInRect(self.iconRect)
    }
    
    override func mouseUp(theEvent: NSEvent) {
        let clickLocation = self.convertPoint(theEvent.locationInWindow, fromView:  nil)
        if let coords = self.colRowAtPoint(clickLocation) {
            self.currentColRow = coords
        }
    }

    
}
