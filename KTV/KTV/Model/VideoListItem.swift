import Foundation

struct VideoListItem: Decodable {
  let imageUrl: URL
  let title: String
  let playtime: Double
  let channel: String
  let videoId: Int
}
