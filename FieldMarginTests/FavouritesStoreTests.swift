import XCTest
import SwiftUI
@testable import FieldMargin

final class FavouritesStoreTests: XCTestCase {
    private var certificate: Certificate!
    private var favouritesStore: FavouritesStore!

    override func setUp() {
        super.setUp()
        certificate = Certificate(id: "123", originator: "Prince", originatorCountry: "Uk", owner: "Debest", ownerCountry: "Nigeria", status: "alive")
        favouritesStore = FavouritesStore()
        favouritesStore.removeCertificate(certificate) // Ensure it's not in favourites initially
    }

    override func tearDown() {
        favouritesStore.removeCertificate(certificate) // Clean up after tests
        certificate = nil
        favouritesStore = nil
        super.tearDown()
    }

    func testSaveCertificate() {
        favouritesStore.saveCertificate(certificate)
        let savedCertificates = favouritesStore.loadCertificates()
        XCTAssertTrue(savedCertificates.contains(certificate))
    }

    func testRemoveCertificate() {
        favouritesStore.saveCertificate(certificate)
        favouritesStore.removeCertificate(certificate)
        let savedCertificates = favouritesStore.loadCertificates()
        XCTAssertFalse(savedCertificates.contains(certificate))
    }

    func testLoadCertificates_NoCertificates() {
        let savedCertificates = favouritesStore.loadCertificates()
        XCTAssertTrue(savedCertificates.isEmpty)
    }

    func testLoadCertificates_WithCertificates() {
        favouritesStore.saveCertificate(certificate)
        let savedCertificates = favouritesStore.loadCertificates()
        XCTAssertEqual(savedCertificates, [certificate])
    }
}
