
import Foundation

struct MyAppsDataElement: Codable {
    let id: String?
    let relationships: RelationshipsElement?
    let links: LinksElement?
    let type: String?
    let attributes: AttributesElement?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case relationships = "relationships"
        case links = "links"
        case type = "type"
        case attributes = "attributes"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        id = try values.decodeIfPresent(String.self, forKey: .id)
        relationships = try values.decodeIfPresent(RelationshipsElement.self, forKey: .relationships)
        links = try values.decodeIfPresent(LinksElement.self, forKey: .links)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        attributes = try values.decodeIfPresent(AttributesElement.self, forKey: .attributes)
    }
}
