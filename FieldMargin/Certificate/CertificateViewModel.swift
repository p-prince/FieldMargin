import Foundation
import SwiftUI


protocol CertificateViewModelProtocol: ObservableObject {
    var certificate: Certificate { get }
    var buttonImage: Image { get }
    var isFavourite: Bool { get }
    func toggleFavourite()
    func refresh()
}

final class CertificateViewModel: CertificateViewModelProtocol {
    @Published private(set) var certificate: Certificate
    @Published private var favouritesContainsCertificate: Bool
    
    private(set) var favouritesStore: FavouritesStoreProtocol
    
    var buttonImage: Image {
       return favouritesContainsCertificate ? Image(systemName: "bookmark.fill") : Image(systemName: "bookmark")
    }
    
    var isFavourite: Bool {
           return favouritesContainsCertificate
       }
    
    init(certificate: Certificate, favouritesStore: FavouritesStoreProtocol) {
        self.certificate = certificate
        self.favouritesStore = favouritesStore
        self.favouritesContainsCertificate = favouritesStore.loadCertificates().contains { $0 == certificate }
    }
    
    func toggleFavourite() {
        if favouritesContainsCertificate {
            favouritesStore.removeCertificate(certificate)
        } else {
            favouritesStore.saveCertificate(certificate)
        }

        favouritesContainsCertificate.toggle()
    }
    
    func refresh() {
        favouritesContainsCertificate = favouritesStore.loadCertificates().contains { $0 == certificate }
    }
}
