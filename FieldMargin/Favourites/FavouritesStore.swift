import Foundation

protocol FavouritesStoreProtocol {
    func saveCertificate(_ certificate: Certificate)
    func removeCertificate(_ certificate: Certificate)
    func loadCertificates() -> [Certificate]
}

final class FavouritesStore:  FavouritesStoreProtocol {
    private let userDefaults = UserDefaults.standard
    private let certificateKey = "savedCertificates"
    
    
    // Save a certificate to certificates in UserDefaults
    func saveCertificate(_ certificate: Certificate) {
        var certificates = loadCertificates()
        certificates.append(certificate)
        
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(certificates)
            userDefaults.set(data, forKey: certificateKey)
            print("Certificates saved successfully.")
        } catch {
            print("Failed to encode certificates: \(error)")
        }
    }
    
    // Save a certificate to certificates in UserDefaults
    func removeCertificate(_ certificate: Certificate) {
        var certificates = loadCertificates()
        certificates = certificates.filter { $0 != certificate }
        
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(certificates)
            userDefaults.set(data, forKey: certificateKey)
            print("Certificates removed successfully.")
        } catch {
            print("Failed to encode certificates: \(error)")
        }
    }
    
    // Load all certificates from UserDefaults
    func loadCertificates() -> [Certificate] {
        guard let data = userDefaults.data(forKey: certificateKey) else {
            print("No certificates found in UserDefaults.")
            return []
        }
        
        let decoder = JSONDecoder()
        do {
            let certificates = try decoder.decode([Certificate].self, from: data)
            return certificates
        } catch {
            print("Failed to decode certificates: \(error)")
            return []
        }
    }
}
