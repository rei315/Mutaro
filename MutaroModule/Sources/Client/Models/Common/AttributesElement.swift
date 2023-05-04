
import Foundation

public struct AttributesElement: Codable {
    public let subscriptionStatusUrlVersionForSandbox: String?
    public let subscriptionStatusUrlVersion: String?
    public let availableInNewTerritories: Bool?
    public let sku: String?
    public let contentRightsDeclaration: String?
    public let bundleId: String?
    public let primaryLocale: String?
    public let subscriptionStatusUrl: String?
    public let subscriptionStatusUrlForSandbox: String?
    public let name: String?
    public let isOrEverWasMadeForKids: Bool?

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

    public init(from decoder: Decoder) throws {
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
