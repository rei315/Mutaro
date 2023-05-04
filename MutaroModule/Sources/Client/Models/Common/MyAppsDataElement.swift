
import Foundation

public struct DataElement: Codable {
    public let id: String?
    public let relationships: RelationshipsElement?
    public let links: LinksElement?
    public let type: String?
    public let attributes: AttributesElement?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case relationships = "relationships"
        case links = "links"
        case type = "type"
        case attributes = "attributes"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        id = try values.decodeIfPresent(String.self, forKey: .id)
        relationships = try values.decodeIfPresent(RelationshipsElement.self, forKey: .relationships)
        links = try values.decodeIfPresent(LinksElement.self, forKey: .links)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        attributes = try values.decodeIfPresent(AttributesElement.self, forKey: .attributes)
    }
}
