
import Foundation

public struct IndividualTestersElement: Codable {
    let links: LinksElement?

    enum CodingKeys: String, CodingKey {
        case links = "links"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        links = try values.decodeIfPresent(LinksElement.self, forKey: .links)
    }
}
