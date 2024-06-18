import Foundation

struct Certificate: Codable, Equatable {
    let id: String
    let originator: String
    let originatorCountry: String
    let owner: String
    let ownerCountry: String
    let status: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case originator
        case originatorCountry = "originator-country"
        case owner
        case ownerCountry = "owner-country"
        case status
    }
}
