import Foundation

final class FavouritesViewModel: FavouritesViewModelProtocol {
    @Published var certificates: [Certificate] = []

    private let favouritesStore = FavouritesStore()

    init() {
        loadCertificates()
    }

    func loadCertificates() {
        certificates = favouritesStore.loadCertificates()
    }
}

