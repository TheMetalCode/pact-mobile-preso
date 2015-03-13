import Alamofire

public class CatKitClient {
  private let baseUrl: String
  
  public init(baseUrl: String) {
    self.baseUrl = baseUrl
    Alamofire.Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders?.updateValue("application/json", forKey: "Accept")
  }
  
  public func feedMe(feedMeResponse: (String, String) -> Void) {
    Alamofire.request(.GET, "\(baseUrl)/feedMe")
      .responseJSON { (_, _, json, _) in
        if let json = json as? Dictionary<String, String> {
          feedMeResponse(json["message"]!, json["status"]!)
        }
      }
  }
}