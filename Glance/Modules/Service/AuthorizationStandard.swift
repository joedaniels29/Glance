//
// Created by Joseph Daniels on 10/9/15.
// Copyright (c) 2015 Joseph Daniels. All rights reserved.
//

import Foundation
import OAuthSwift

//protocol AuthorizaitonCredential{

//}

enum AuthorizationStatus:Equatable{
    case Unauthorized
    case Authorized(OAuthSwiftCredential)
    
    
}
func ==(lhs: AuthorizationStatus, rhs: AuthorizationStatus) -> Bool{
    switch (lhs, rhs){
    case (.Unauthorized, .Unauthorized): fallthrough
    case (.Authorized(_), .Authorized(_)):
        return true
    default:
        return false
        
    }
}

protocol OAuthStandard {
//    static func handleOpenURL(url:NSURL)
}



protocol AuthorizationStandard  : OAuthStandard{



}
