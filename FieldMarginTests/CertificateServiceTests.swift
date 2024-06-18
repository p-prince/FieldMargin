import XCTest
import Moya
@testable import FieldMargin

class CertificateServiceTests: XCTestCase {

    func testFetchCertificatesEndpoint() throws {
        let service = CertificateService.fetchCertificates(limit: 10, page: 1)

        // Test baseURL
        XCTAssertEqual(service.baseURL, URL(string: "https://api-dev-v2.fieldmargin.com/tech-test"))

        // Test path
        XCTAssertEqual(service.path, "/certificates")

        // Test method
        XCTAssertEqual(service.method, .get)

        // Test request parameters
        switch service.task {
        case .requestParameters(let parameters, _):
            XCTAssertEqual(parameters["limit"] as? Int, 10)
            XCTAssertEqual(parameters["page"] as? Int, 1)
        default:
            XCTFail("Unexpected task type")
        }

        // Test headers
        XCTAssertEqual(service.headers?["Content-Type"], "application/json")
        XCTAssertEqual(service.headers?["API-KEY"], "FIELDMARGIN-TECH-TEST")
    }
    
    func testFetchCertificatesDefaultValues() throws {
        // Test with default values (if applicable)
        let defaultService = CertificateService.fetchCertificates(limit: 0, page: 0)

        XCTAssertEqual(defaultService.baseURL, URL(string: "https://api-dev-v2.fieldmargin.com/tech-test"))
        XCTAssertEqual(defaultService.path, "/certificates")
        XCTAssertEqual(defaultService.method, .get)

        switch defaultService.task {
        case .requestParameters(let parameters, _):
            XCTAssertEqual(parameters["limit"] as? Int, 0)
            XCTAssertEqual(parameters["page"] as? Int, 0)
        default:
            XCTFail("Unexpected task type")
        }

        XCTAssertEqual(defaultService.headers?["Content-Type"], "application/json")
        XCTAssertEqual(defaultService.headers?["API-KEY"], "FIELDMARGIN-TECH-TEST")
    }
    
    func testFetchCertificatesMultipleRequests() throws {
        let service1 = CertificateService.fetchCertificates(limit: 5, page: 1)
        let service2 = CertificateService.fetchCertificates(limit: 20, page: 3)

        // Test for service1
        XCTAssertEqual(service1.baseURL, URL(string: "https://api-dev-v2.fieldmargin.com/tech-test"))
        XCTAssertEqual(service1.path, "/certificates")
        XCTAssertEqual(service1.method, .get)

        switch service1.task {
        case .requestParameters(let parameters, _):
            XCTAssertEqual(parameters["limit"] as? Int, 5)
            XCTAssertEqual(parameters["page"] as? Int, 1)
        default:
            XCTFail("Unexpected task type")
        }

        XCTAssertEqual(service1.headers?["Content-Type"], "application/json")
        XCTAssertEqual(service1.headers?["API-KEY"], "FIELDMARGIN-TECH-TEST")

        // Test for service2
        XCTAssertEqual(service2.baseURL, URL(string: "https://api-dev-v2.fieldmargin.com/tech-test"))
        XCTAssertEqual(service2.path, "/certificates")
        XCTAssertEqual(service2.method, .get)

        switch service2.task {
        case .requestParameters(let parameters, _):
            XCTAssertEqual(parameters["limit"] as? Int, 20)
            XCTAssertEqual(parameters["page"] as? Int, 3)
        default:
            XCTFail("Unexpected task type")
        }

        XCTAssertEqual(service2.headers?["Content-Type"], "application/json")
        XCTAssertEqual(service2.headers?["API-KEY"], "FIELDMARGIN-TECH-TEST")
    }
    
    func testFetchCertificatesNilHeaders() throws {
        // Simulate a case where headers are nil or not provided
        let service = CertificateService.fetchCertificates(limit: 10, page: 1)
        let headers = service.headers
        
        XCTAssertNotNil(headers)
        XCTAssertNil(headers?["SomeHeader"]) // Ensure specific headers are not accidentally added
    }
    
    func testFetchCertificatesLargeParameters() throws {
        // Test with large parameter values
        let largeLimit = 1_000
        let largePage = 1_000_000
        let service = CertificateService.fetchCertificates(limit: largeLimit, page: largePage)

        XCTAssertEqual(service.baseURL, URL(string: "https://api-dev-v2.fieldmargin.com/tech-test"))
        XCTAssertEqual(service.path, "/certificates")
        XCTAssertEqual(service.method, .get)

        switch service.task {
        case .requestParameters(let parameters, _):
            XCTAssertEqual(parameters["limit"] as? Int, largeLimit)
            XCTAssertEqual(parameters["page"] as? Int, largePage)
        default:
            XCTFail("Unexpected task type")
        }

        XCTAssertEqual(service.headers?["Content-Type"], "application/json")
        XCTAssertEqual(service.headers?["API-KEY"], "FIELDMARGIN-TECH-TEST")
    }
}
