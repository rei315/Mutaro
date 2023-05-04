
import Foundation

public struct MetaElement: Codable {
    public let paging: PagingElement?

    enum CodingKeys: String, CodingKey {
        case paging = "paging"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        paging = try values.decodeIfPresent(PagingElement.self, forKey: .paging)
    }
}
