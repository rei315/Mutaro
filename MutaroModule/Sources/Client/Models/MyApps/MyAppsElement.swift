
import Foundation

public struct MyAppsElement: Codable {
    public let links: LinksElement?
    public let data: [DataElement]?
    public let meta: MetaElement?

    enum CodingKeys: String, CodingKey {
        case links = "links"
        case data = "data"
        case meta = "meta"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        links = try values.decodeIfPresent(LinksElement.self, forKey: .links)
        data = try values.decodeIfPresent([DataElement].self, forKey: .data)
        meta = try values.decodeIfPresent(MetaElement.self, forKey: .meta)
    }
}
