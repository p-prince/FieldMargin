import Foundation
import Moya

protocol NetworkManagerProtocol: ObservableObject {
    func fetchCertificates(limit: Int, page: Int, completion: @escaping (Result<[Certificate], Error>) -> Void)
}

final class NetworkManager: NetworkManagerProtocol {
    private let provider = MoyaProvider<CertificateService>()
    
    func fetchCertificates(limit: Int, page: Int, completion: @escaping (Result<[Certificate], Error>) -> Void) {
            provider.request(.fetchCertificates(limit: limit, page: page)) { result in
                switch result {
                case .success(let response):
                    do {
                        let certificates = try JSONDecoder().decode([Certificate].self, from: response.data)
                        completion(.success(certificates))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
}
