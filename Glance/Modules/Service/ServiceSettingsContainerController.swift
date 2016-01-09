//
//  ServiceSettingsContainerController.swift
//  Glance
//
//  Created by Joseph Daniels on 10/2/15.
//  Copyright © 2015 Joseph Daniels. All rights reserved.
//

import Foundation
import Cartography
import ReactiveCocoa

class ServiceSettingsContainerController: GenericContainerViewController, RHPreferencesViewControllerProtocol{
    var service: MutableProperty<Service?>
//    override func loadView() {
//        self.view = NSView(frame:CGRect(x: 0, y: 0, width: 400, height: 700))
//        
//    }
    init?(service:Service){
        self.service = MutableProperty(service)
        super.init(nibName: nil, bundle: nil)
        d += self.service !=> { [unowned self] in self.identifier = $0.name}
    }

    convenience override init?(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        self.init(service:Twitter.service)

    }
    
    required init?(coder: NSCoder) {
        self.service = MutableProperty(Instagram.service)
        super.init(coder:coder)
    }
//    override func viewWillLayout(){

//    }

    @objc var toolbarItemImage:NSImage{ return service.value!.icon}
    @objc var toolbarItemLabel:String!{ return service.value!.name}
}



class OAuthServiceSettingsContainerController: ServiceSettingsContainerController {
    override init?(service:Service){
        super.init(service:service)
        configure()
    }
    func configure(){
		childViewController <~ (self
            .service
            .producer
            .map{ $0 as? OAuth }
            .ignoreNil() =-= { $0.authorizationStatus.producer }).map { [unowned self]  in
                    switch ($0){
                    case .Unauthorized:
                        return UnathorizedAccountViewController(currentState: .Splash)
                    case .Authorized(_):
                        return self.service.value!.instanciateSettingsContentViewController()
                    }
        }
        
        childViewController.producer./*delay(1, onScheduler: QueueScheduler.mainQueueScheduler).*/startWithNext{
            switch($0){
                case let uavc as UnathorizedAccountViewController:
//                    #workaround :( 
                    uavc.service <~ self.service.producer.startOn(QueueScheduler())
            default:
                ()
            }
        }
        self.service !=> { [unowned self] in
            self.identifier = $0.name
        }
        
    }
//    override func loadView(){
//        self.view = NSView(frame:CGRect(x: 0, y: 0, width: 400, height: 400))
//    }
    
    override func viewDidLoad() {
		super.viewDidLoad()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
        configure()

    }
}
