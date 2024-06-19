import Foundation

protocol FavouritesViewModelProtocol: ObservableObject {
    var certificates: [Certificate] { get }

    func loadCertificates()
}

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

