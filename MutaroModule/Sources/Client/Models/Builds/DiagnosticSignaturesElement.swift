
import Foundation

struct DiagnosticSignaturesElement: Codable {
    let links: LinksElement?

    enum CodingKeys: String, CodingKey {
        case links = "links"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        links = try values.decodeIfPresent(LinksElement.self, forKey: .links)
    }
}
