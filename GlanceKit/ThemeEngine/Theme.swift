//
//  Theme.swift
//  Glance
//
//  Created by Joseph Daniels on 7/12/15.
//  Copyright (c) 2015 Joseph Daniels. All rights reserved.
//

import Cocoa
import ReactiveCocoa



public protocol Theme {

    var colorPalette:AnyProperty<ColorPalette> { get }
    var border:AnyProperty<NSEdgeInsets> { get }
    var borderRadius:AnyProperty<CGFloat> { get }
    var padding:AnyProperty<NSEdgeInsets> { get }
    var margin:AnyProperty<NSEdgeInsets> { get }
    var defaultBackgroundViewClass:AnyProperty<NSView.Type> { get }
    var defaultWindowBackgroundViewClass:AnyProperty<NSView.Type> { get }

}
public protocol ColorPalette{
    var rootColor:AnyProperty<NSColor> { get }
    var auxilaryColor:AnyProperty<NSColor> { get }
    var backgroundColor:AnyProperty<NSColor> { get }
    var auxBackgroundColor:AnyProperty<NSColor> { get }
}