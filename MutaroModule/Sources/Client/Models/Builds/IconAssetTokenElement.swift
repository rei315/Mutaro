
import Foundation

public struct IconAssetTokenElement: Codable {
    let width: Int?
    let templateUrl: String?
    let height: Int?

    enum CodingKeys: String, CodingKey {
        case width = "width"
        case templateUrl = "templateUrl"
        case height = "height"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        width = try values.decodeIfPresent(Int.self, forKey: .width)
        templateUrl = try values.decodeIfPresent(String.self, forKey: .templateUrl)
        height = try values.decodeIfPresent(Int.self, forKey: .height)
    }
}
