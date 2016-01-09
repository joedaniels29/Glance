//
// Created by Joseph Daniels on 7/12/15.
// Copyright (c) 2015 Joseph Daniels. All rights reserved.
//

import Foundation
import AppKit
import ReactiveCocoa


class BaseColorPalette: ColorPalette {
    var rootColor: AnyProperty<NSColor> = anyProperty(NSColor.blackColor())
    var auxilaryColor: AnyProperty<NSColor> = anyProperty(NSColor.greenColor())
    var backgroundColor: AnyProperty<NSColor> = anyProperty(NSColor.greenColor().colorWithAlphaComponent(0.1))
    var windowBackgroundColor: AnyProperty<NSColor> = anyProperty(NSColor.blueColor().colorWithAlphaComponent(0.3))
    
    var auxBackgroundColor: AnyProperty<NSColor> = anyProperty(NSColor.greenColor())
}


public class BaseTheme: Theme {
    public var colorPalette: AnyProperty<ColorPalette> = anyProperty(BaseColorPalette())
    public var border: AnyProperty<NSEdgeInsets> = anyProperty(NSEdgeInsets(inset: 1))
    public var borderRadius: AnyProperty<CGFloat> = anyProperty(1)
    public var padding: AnyProperty<NSEdgeInsets> = anyProperty(NSEdgeInsets(inset: 1))
    public var margin: AnyProperty<NSEdgeInsets> = anyProperty(NSEdgeInsets(inset: 1))
    public var defaultBackgroundViewClass: AnyProperty<NSView.Type> = anyProperty(LightStylizedView.self)
    
    public var defaultWindowBackgroundViewClass: AnyProperty<NSView.Type> = anyProperty(SolidView.self)
}
