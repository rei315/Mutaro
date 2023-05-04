
import Foundation

struct AttributesElement: Codable {
    let subscriptionStatusUrlVersionForSandbox: String?
    let subscriptionStatusUrlVersion: String?
    let availableInNewTerritories: Bool?
    let sku: String?
    let contentRightsDeclaration: String?
    let bundleId: String?
    let primaryLocale: String?
    let subscriptionStatusUrl: String?
    let subscriptionStatusUrlForSandbox: String?
    let name: String?
    let isOrEverWasMadeForKids: Bool?

    enum CodingKeys: String, CodingKey {
        case subscriptionStatusUrlVersionForSandbox = "subscriptionStatusUrlVersionForSandbox"
        case subscriptionStatusUrlVersion = "subscriptionStatusUrlVersion"
        case availableInNewTerritories = "availableInNewTerritories"
        case sku = "sku"
        case contentRightsDeclaration = "contentRightsDeclaration"
        case bundleId = "bundleId"
        case primaryLocale = "primaryLocale"
        case subscriptionStatusUrl = "subscriptionStatusUrl"
        case subscriptionStatusUrlForSandbox = "subscriptionStatusUrlForSandbox"
        case name = "name"
        case isOrEverWasMadeForKids = "isOrEverWasMadeForKids"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        subscriptionStatusUrlVersionForSandbox = try values.decodeIfPresent(String.self, forKey: .subscriptionStatusUrlVersionForSandbox)
        subscriptionStatusUrlVersion = try values.decodeIfPresent(String.self, forKey: .subscriptionStatusUrlVersion)
        availableInNewTerritories = try values.decodeIfPresent(Bool.self, forKey: .availableInNewTerritories)
        sku = try values.decodeIfPresent(String.self, forKey: .sku)
        contentRightsDeclaration = try values.decodeIfPresent(String.self, forKey: .contentRightsDeclaration)
        bundleId = try values.decodeIfPresent(String.self, forKey: .bundleId)
        primaryLocale = try values.decodeIfPresent(String.self, forKey: .primaryLocale)
        subscriptionStatusUrl = try values.decodeIfPresent(String.self, forKey: .subscriptionStatusUrl)
        subscriptionStatusUrlForSandbox = try values.decodeIfPresent(String.self, forKey: .subscriptionStatusUrlForSandbox)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        isOrEverWasMadeForKids = try values.decodeIfPresent(Bool.self, forKey: .isOrEverWasMadeForKids)
    }
}
