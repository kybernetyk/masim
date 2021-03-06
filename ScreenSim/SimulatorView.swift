//
//  SimulatorView.swift
//  ScreenSim
//
//  Created by kyb on 20/06/16.
//  Copyright © 2016 Suborbital Softworks Ltd. All rights reserved.
//

import Cocoa

@IBDesignable
class SimulatorView: NSView {
    @IBInspectable var wallpaperImage: NSImage? = NSImage(named: "Wallpaper")
    @IBInspectable var masImage: NSImage? = NSImage(named: "Mas")
    
    var images: [NSImage] = [] {
        didSet {
            self.needsDisplay = true
        }
    }
    fileprivate var currentImageIndex = 0 {
        didSet {
            self.needsDisplay = true
        }
    }
    
    fileprivate var mainImage: NSImage? {
        if self.currentImageIndex < 0 || self.currentImageIndex >= self.images.count {
            return nil
        }
        return self.images[self.currentImageIndex]
    }
   
    fileprivate func secondaryImageAtIndex(_ imageIndex: Int) -> NSImage? {
        if imageIndex < 0 || imageIndex >= self.images.count {
            return nil
        }
        return self.images[imageIndex]
    }
    
    fileprivate var mainAnchorRect: CGRect = CGRect(x: 0.169309711456299,
                                                y: 0.207394137912326,
                                                width: 0.682473670111762 - 0.169309711456299,
                                                height: 0.710408426920573 - 0.207394137912326)
    fileprivate var mainImageRect: CGRect {
        let bnds = self.cbounds
        let x = self.mainAnchorRect.origin.x * bnds.width
        let y = self.mainAnchorRect.origin.y * bnds.height
        let w = self.mainAnchorRect.width * bnds.width
        let h = self.mainAnchorRect.height * bnds.height
        return CGRect(x: x, y: y, width: w, height: h)
    }
    
    fileprivate var secondaryAnchorRects: [CGRect] = [
        CGRect(x: 0.273902723524306, y: 0.111719292534722, width: 0.325254080030653 - 0.273902723524306, height: 0.161405368381076 - 0.111719292534722),
        CGRect(x: 0.338488154941135, y: 0.111719292534722, width: 0.325254080030653 - 0.273902723524306, height: 0.161405368381076 - 0.111719292534722),
        CGRect(x: 0.400712119208442, y: 0.111719292534722, width: 0.325254080030653 - 0.273902723524306, height: 0.161405368381076 - 0.111719292534722),
        CGRect(x: 0.463467491997613, y: 0.111719292534722, width: 0.325254080030653 - 0.273902723524306, height: 0.161405368381076 - 0.111719292534722),
        CGRect(x: 0.526669947306315, y: 0.111719292534722, width: 0.325254080030653 - 0.273902723524306, height: 0.161405368381076 - 0.111719292534722),
    ]
    
    fileprivate func secondaryImageRectForImageAtIndex(_ imageIndex: Int) -> CGRect? {
        if imageIndex < 0 || imageIndex >= self.secondaryAnchorRects.count {
            return nil
        }
        let r = self.secondaryAnchorRects[imageIndex]
        
        let bnds = self.cbounds
        let x = r.origin.x * bnds.width
        let y = r.origin.y * bnds.height
        let w = r.width * bnds.width
        let h = r.height * bnds.height
        return CGRect(x: x, y: y, width: w, height: h)
    }
    
    fileprivate func imageIndexForClickLocation(_ clickLocation: CGPoint) -> Int? {
        for index in 0..<self.secondaryAnchorRects.count {
            if let r = self.secondaryImageRectForImageAtIndex(index) {
                if r.contains(clickLocation) {
                    return index
                }
            }
        }
        return nil
    }
    
    fileprivate var lastClickLocation: CGPoint = CGPoint.zero
    
    fileprivate var cbounds: NSRect {
        return self.centerScanRect(self.bounds)
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        self.wallpaperImage?.draw(in: self.cbounds)
        self.masImage?.draw(in: self.cbounds)
        self.mainImage?.draw(in: self.mainImageRect)
        
        for index in 0..<self.images.count {
            guard let img = self.secondaryImageAtIndex(index), let rect = self.secondaryImageRectForImageAtIndex(index) else {
                continue
            }
            img.draw(in: rect)
        }
//        
//        NSColor.greenColor().set()
//        let cr = CGRect(origin: self.lastClickLocation, size: CGSize(width: 10, height: 10))
//        NSRectFill(cr)
    }
    
//    override func mouseDown(theEvent: NSEvent) {
//        let clickLocation = self.convertPoint(theEvent.locationInWindow, fromView:  nil)
//        let bnds = self.cbounds
//        
//        let x = clickLocation.x / bnds.width
//        let y = clickLocation.y / bnds.height
//        
//        NSLog("click: \(x), \(y)")
//        
//        self.lastClickLocation = clickLocation
//        self.needsDisplay = true
//    }
    
    override func mouseUp(with theEvent: NSEvent) {
        let clickLocation = self.convert(theEvent.locationInWindow, from:  nil)
        if let idx = self.imageIndexForClickLocation(clickLocation) {
            self.currentImageIndex = idx
        }
    }
}
