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

    static let URL = "http://cijenkins04.rnd.in.here.com:8080/job/team-heresuite/job/hereapp-ios/job/master/job/post-submit/job/Trigger/api/json?pretty=false"

    public static func fetchAllBuilds(_ completionHandler : (JenkinsReponse) -> Void) {
        let _ = HTTP.get(URL, callback: { (jenkinsResponse) in
            if let response = parseResponse(jenkinsResponse!),
                let statuses = parseAllBuildsResult(response) {
                    completionHandler(.success(statuses))
            } else {
                completionHandler(.error(1))
            }
        })
    }

    public static func parseResponse(_ response: KituraNet.ClientResponse) -> JSON? {
        var data = Data()
        try! response.readAllData(into: &data)
        let dict = JSON(data: data)

        return dict
    }

    public static func parseAllBuildsResult(_ json: JSON) -> BuildStatuses? {
        guard
            let lastCompletedBuild = json["lastCompletedBuild"]["number"].int,
            let lastStableBuild = json["lastStableBuild"]["number"].int,
            let lastFailedBuild = json["lastFailedBuild"]["number"].int
        else {
                return nil
        }
        let buildStatuses = BuildStatuses(completed: lastCompletedBuild, stable: lastStableBuild, failed: lastFailedBuild)

        return buildStatuses
    }
}

public struct BuildStatuses {
    public let completed: Int
    public let stable: Int
    public let failed: Int
}

public enum JenkinsReponse {
    case success(BuildStatuses)
    case error(Int)
}

