import Foundation

struct Home: Decodable {
  let videos: [Video]
  let rankings: [Ranking]
  let recents: [Recent]
  let recommends: [Recommend]
}

extension Home {
  struct Video: Decodable {
    let videoID: Int
    let isHot: Bool
    let title: String
    let subtitle: String
    let imageURL: URL
    let channel: String
    let channelThumbnailURL: URL
    let channelDescription: String
  }
  
  struct Ranking: Decodable {
    let imageURL: URL
    let videoID: Int
  }
  
  struct Recent: Decodable {
    let imageURL: URL
    let timeStamp: Double
    let title: String
    let channel: String
  }
  
  struct Recommend: Decodable {
    let imageURL: URL
    let title: String
    let playtime: Double
    let channel: String
    let videoID: Int
  }
}
