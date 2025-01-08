import Foundation

struct Home {
  let videos: [Video]
  let ranking: [Ranking]
  let recents: [Recent]
  let recommends: [VideoListItem]
  
  struct Video {
    let videoID: Int
    let isHot: Bool
    let title: String
    let subtitle: String
    let imageURL: URL
    let channel: String
    let channelThumbnailURL: URL
    let channelDescription: String
  }
  
  struct Ranking {
    let imageURL: URL
    let videoID: Int
  }
  
  struct Recent {
    let imageURL: URL
    let timeStamp: Double
    let title: String
    let channel: String
  }
}
