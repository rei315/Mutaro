
import Foundation

struct LinksElement: Codable {
    let selfUrl: String?
    let relatedUrl: String?

    enum CodingKeys: String, CodingKey {
        case selfUrl = "self"
        case relatedUrl = "related"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        selfUrl = try values.decodeIfPresent(String.self, forKey: .selfUrl)
        relatedUrl = try values.decodeIfPresent(String.self, forKey: .relatedUrl)
    }
}
