
import Foundation

public struct PagingElement: Codable {
    public let total: Int?
    public let limit: Int?

    enum CodingKeys: String, CodingKey {
        case total = "total"
        case limit = "limit"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        total = try values.decodeIfPresent(Int.self, forKey: .total)
        limit = try values.decodeIfPresent(Int.self, forKey: .limit)
    }
}
