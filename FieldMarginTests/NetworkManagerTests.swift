import XCTest
import Moya
@testable import FieldMargin

// https://github.com/Moya/Moya/blob/master/docs/Testing.md

final class NetworkManagerTests: XCTestCase {
    
    var sut: NetworkManager!
    var provider: MoyaProvider<CertificateService>!

    override func setUp() {
        super.setUp()
        provider = MoyaProvider<CertificateService>(stubClosure: MoyaProvider.immediatelyStub)
        sut = NetworkManager()
    }
    
    override func tearDown() {
        sut = nil
        provider = nil
        super.tearDown()
    }
    
    func testFetchCertificatesSuccess() {
        let expectation = self.expectation(description: "Success fetch certificates")
        
        sut.fetchCertificates(limit: 10, page: 1) { result in
            switch result {
            case .success(let certificates):
                XCTAssertFalse(certificates.isEmpty, "Certificates should not be empty")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Expected success but got failure with \(error)")
            }
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
   
    
    private var customEndpointClosure: (CertificateService) -> Endpoint {
        return { target in
            let sampleResponse = {
                return Endpoint(
                    url: URL(target: target).absoluteString,
                    sampleResponseClosure: {
                        .networkResponse(200, Data())
                    },
                    method: target.method,
                    task: target.task,
                    httpHeaderFields: target.headers
                )
            }
            
            switch target {
            case .fetchCertificates:
                return sampleResponse()
            }
        }
    }
}
