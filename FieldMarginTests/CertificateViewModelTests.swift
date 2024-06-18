import XCTest
import SwiftUI
@testable import FieldMargin

final class CertificateViewModelTests: XCTestCase {
    private var certificate: Certificate!
    private var viewModel: CertificateViewModel!
    private var favouritesStore: FavouritesStoreProtocol!

    override func setUp() {
        super.setUp()
        certificate = Certificate(id: "123", originator: "Prince", originatorCountry: "Uk", owner: "Debest", ownerCountry: "Nigeria", status: "alive")
        favouritesStore = MockFavouritesStore()
        viewModel = CertificateViewModel(certificate: certificate, favouritesStore: favouritesStore)

        favouritesStore.removeCertificate(certificate) // Ensure it's not in favourites initially
    }

    override func tearDown() {
        favouritesStore.removeCertificate(certificate) // Clean up after tests
        certificate = nil
        viewModel = nil
        favouritesStore = nil
        super.tearDown()
    }

    func testInitialState() {
        XCTAssertFalse(viewModel.isFavourite)
        XCTAssertEqual(viewModel.buttonImage, Image(systemName: "bookmark"))
    }

    func testToggleFavourite_AddsToFavourites() {
        viewModel.toggleFavourite()
        XCTAssertTrue(viewModel.isFavourite)
        XCTAssertEqual(viewModel.buttonImage, Image(systemName: "bookmark.fill"))
    }

    func testToggleFavourite_RemovesFromFavourites() {
        viewModel.toggleFavourite() // First toggle to add
        viewModel.toggleFavourite() // Second toggle to remove
        XCTAssertFalse(viewModel.isFavourite)
        XCTAssertEqual(viewModel.buttonImage, Image(systemName: "bookmark"))
    }
}


final class MockFavouritesStore: FavouritesStoreProtocol {
    private var mockCertificates: [Certificate] = []
    
    func saveCertificate(_ certificate: Certificate) {
        mockCertificates.append(certificate)
        print("Mock: Certificate saved.")
    }
    
    func removeCertificate(_ certificate: Certificate) {
        mockCertificates = mockCertificates.filter { $0 != certificate }
        print("Mock: Certificate removed.")
    }
    
    func loadCertificates() -> [Certificate] {
        print("Mock: Certificates loaded.")
        return mockCertificates
    }
}
