
import Foundation

public struct BetaAppReviewSubmissionElement: Codable {
    let links: LinksElement?

    public enum CodingKeys: String, CodingKey {
        case links = "links"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        links = try values.decodeIfPresent(LinksElement.self, forKey: .links)
    }
}
