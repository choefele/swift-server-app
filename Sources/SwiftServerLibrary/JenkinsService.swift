import KituraNet
import Foundation
import SwiftyJSON


public struct JenkinsService {
    public enum Status: String {
        case Success = "SUCCESS", Failure = "FAILURE"
    }


    public static func fetchLatestBuild(_ completionHandler : (String, Status) -> Void) {
        let URL = "http://cijenkins04.rnd.in.here.com:8080/job/team-heresuite/job/hereapp-ios/job/master/job/post-submit/job/Trigger/lastCompletedBuild/api/json?pretty=false"
        let _ = HTTP.get(URL, callback: { (jenkinsResponse) in

            var data = Data()
            try! jenkinsResponse!.readAllData(into: &data)
            let dict = JSON(data: data)

            if let result = dict["result"].string,
                let status = JenkinsService.Status(rawValue: result) {
                let buildNumber = dict["number"].stringValue
                completionHandler(buildNumber, status)
            }
        })
    }
}
