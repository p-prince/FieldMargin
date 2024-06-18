import Foundation
import Moya


enum CertificateService {
    case fetchCertificates(limit: Int, page: Int)
}


extension CertificateService: TargetType {
    
    var baseURL: URL { URL(string: "https://api-dev-v2.fieldmargin.com/tech-test")! }
    var path: String {
        switch self {
        case .fetchCertificates:
            return "/certificates"
        }
    }
    var method: Moya.Method {
        switch self {
        case .fetchCertificates:
            return .get
        }
    }
    var task: Task {
        switch self {
        case .fetchCertificates(let limit, let page):
            return .requestParameters(parameters: ["limit": limit, "page": page], encoding: URLEncoding.queryString)
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json", "API-KEY": "FIELDMARGIN-TECH-TEST"]
    }

}

private extension String {
    var urlEscaped: String {
        addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }

    var utf8Encoded: Data { Data(self.utf8) }
}
