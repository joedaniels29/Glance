import Foundation
import ReactiveCocoa
import Alamofire


enum TwitterRouter: ServiceRouter {
    static var service = Twitter.instance


    case StatusesHomeTimeline
    case StatusesUserTimeline
//    case PhotoInfo(Int, ImageSize)
//    case Comments(Int, Int)

    var route: RESTfulRoute<TwitterRouter> {
        switch self {
        case .StatusesHomeTimeline:
            return route( path: "statuses/home_timeline.json")
        case .StatusesUserTimeline:
            return route(path: "statuses/user_timeline.json")
        }
    }


    func tweets() -> SignalProducer<[TTweet]?, NoError> {
        return self.fetchMany()
    }
}