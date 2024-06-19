import Foundation
import Combine

@MainActor
protocol ContentViewModelProtocol: ObservableObject {
    var error: Error? { get }
    var showAlert: Bool { get }
    var alertMessage: String { get }

    func fetchCertificates(limit: Int, page: Int)
}

@MainActor
final class ContentViewModel: ContentViewModelProtocol {
    @Published private(set) var certificates: [Certificate] = []
    
    @Published var error: Error? = nil // Published property to hold error state
    @Published var showAlert = false
    @Published var alertMessage = ""

    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
        
    func fetchCertificates(limit: Int, page: Int) {
        networkManager.fetchCertificates(limit: limit, page: page) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let certificates):
                    self.certificates = certificates
                    self.error = nil
                case .failure(let error):
                    self.error = error
                    self.alertMessage = error.localizedDescription
                    self.showAlert = true
                }
            }
        }
    }
}
