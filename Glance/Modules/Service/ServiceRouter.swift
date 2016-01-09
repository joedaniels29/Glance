//
// Created by Joseph Daniels on 11/24/15.
// Copyright (c) 2015 Joseph Daniels. All rights reserved.
//

import Foundation
import ReactiveCocoa
import Mantle
import Alamofire
import OAuthSwift

class RESTfulRoute<S:ServiceRouter>{
    
    
    var method:Alamofire.Method
    var path: String
    var params: [String:AnyObject]
    var parent: S?

    init(router:S, method:Alamofire.Method, path:String, params:[String:AnyObject]){
        self.method = method
        self.path = path
        self.params = params
    }

    init(router:S, component:String, nestedRoute:RESTfulRoute<S>){
        self.method = nestedRoute.method
        self.path = "\(component)/\(nestedRoute)"
        self.params = nestedRoute.params
    }
}





protocol SubServiceRouter:ServiceRouter {

}

extension SubServiceRouter {
//
//    func subroute<S:ServiceRouter>(path: String, route: Self) -> RESTfulRoute<S> {
//        return RESTfulRoute(router: self, component: path, nestedRoute: route)
//    }
}

protocol ServiceRouter: URLRequestConvertible{
    typealias T:Service
    var route: RESTfulRoute<Self> { get }
    static var service: T { get }
    var url: NSURL { get }

}

extension ServiceRouter {
    var url: NSURL {
        return self.dynamicType.service.baseURL.URLByAppendingPathComponent(route.path)
    }
    
    func route(method: Alamofire.Method = .GET, path:String, params:[String:AnyObject] = [:]) -> RESTfulRoute<Self> {
        return RESTfulRoute(router:self, method:.GET, path:path, params:params)
    }
    


    func fetchMany<T:MTLModel>(headKey: String = "") -> SignalProducer<[T]?, NoError> {
        return SignalProducer {
            s, d in
            Alamofire.request(self).responseJSON {
                if let model = $0.result.value as? [[NSObject:AnyObject]] {
                    do {
                        s.sendNext(try MTLJSONAdapter.modelsOfClass(T.self, fromJSONArray: model) as! [T])
                    } catch let error as NSError {
                        print(error)
                    }
                }
            }
        }
    }

    func fetch<T:MTLModel>(headKey: String) -> SignalProducer<[T]?, NoError> {
        return SignalProducer {
            s, d in
            Alamofire.request(self).responseJSON {
                if let jsonDictionary = $0.result.value as? NSDictionary,
                model = jsonDictionary[headKey] as? [NSObject:AnyObject] {
                    do {
                        s.sendNext(try MTLJSONAdapter.modelOfClass(T.self, fromJSONDictionary: model) as! [T])
                    } catch let error as NSError {
                        print(error)
                        //                            s.sendFailed(error)
                    }
                }
            }
        }
    }
    var URLRequest: NSMutableURLRequest {
        let url = self.url
        let rest = self.route
        let req = NSMutableURLRequest(URL: url)
        req.HTTPMethod = route.method.rawValue
        switch (self.dynamicType.service){
        case let oauth as OAuth:
            switch oauth.authorizationStatus.value {
            case .Unauthorized:
                break
            case .Authorized(let auth):
                for (key, value) in auth.makeHeaders(url, method: OAuthSwiftHTTPRequest.Method(rawValue: route.method.rawValue)!, parameters: rest.params) {
                    req.setValue(value, forHTTPHeaderField: key)
                }
            }
        default:
            ()
            
        }
        
        return req
    }

}

