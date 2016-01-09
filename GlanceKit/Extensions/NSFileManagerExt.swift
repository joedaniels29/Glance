//
//  NSFileManagerExt.swift
//  Glance
//
//  Created by Joseph Daniels on 7/12/15.
//  Copyright (c) 2015 Joseph Daniels. All rights reserved.
//

import Foundation
extension NSFileManager{
    public var supportDir:NSURL{
        get{
            do{
                 return try self.URLForDirectory(.ApplicationSupportDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: true).URLByAppendingPathComponent("glance")
                
            } catch  _ {
                return NSURL()
            }
            
        }
    }
    
    
}