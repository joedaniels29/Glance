//
// Created by Joseph Daniels on 10/8/15.
// Copyright (c) 2015 Joseph Daniels. All rights reserved.
//

import Foundation
import ReactiveCocoa

class ServicesSettingsSplitViewControl:NSSplitViewController, RHPreferencesViewControllerProtocol{

    var detailController: MutableProperty<ServiceDetailContainerViewController?> = MutableProperty(nil)
    var serviceListViewController: MutableProperty<ServiceListViewController?> = MutableProperty(nil)
    var selectedService: MutableProperty<Service?> = MutableProperty(nil)
    var d = CompositeDisposable()
    deinit {
        d.dispose()
    }
    
    override init?(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName:nibNameOrNil, bundle: nibBundleOrNil)
        commonInit()
    }
    func commonInit(){
        self.identifier = "Services"
        selectedService <~ serviceListViewController.producer.ignoreNil() =-= { $0.selectedService.producer }
        d += self.detailController !=> { [unowned self] in
            $0.childViewController <~ self.selectedService.producer.map{ service in
                guard let service = service else { return ServicesSplashScreenViewController() }
                return service.instanciateSettingsViewController()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.detailController.value = self.splitViewItems[1].viewController as? ServiceDetailContainerViewController
        self.serviceListViewController.value = (self.splitViewItems[0].viewController) as? ServiceListViewController
    }
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
        commonInit()
    }
    var toolbarItemImage: NSImage! {
        return NSImage()
    }
    var toolbarItemLabel: String! {
        return "Services"
    }


}
