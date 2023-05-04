
import Foundation

struct MetaElement: Codable {
    let paging: PagingElement?

    enum CodingKeys: String, CodingKey {
        case paging = "paging"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        paging = try values.decodeIfPresent(PagingElement.self, forKey: .paging)
    }
}
