 
import UIKit
import Intents
import CoreSpotlight
import MobileCoreServices

// 1- Add activity type identifier
// the identifier you’ll use to determine if you’re dealing with a “new article” shortcut.
public let kNewArticleActivityType = "com.razeware.NewArticle"
 
public class Article {
  public let title: String
  public let content: String
  public let published: Bool
  
  // 2- Create user activity for new articles
    public static func newArticleShortcut(thumbnail: UIImage?) -> NSUserActivity {
      let activity = NSUserActivity(activityType: kNewArticleActivityType)
      activity.persistentIdentifier =
        NSUserActivityPersistentIdentifier(kNewArticleActivityType)
        // search for this feature in Spotlight
        activity.isEligibleForSearch = true
        // allows Siri to look at the activity and suggest it to your users in the future.
        activity.isEligibleForPrediction = true
        // UI settings for the shortcut
        let attributes = CSSearchableItemAttributeSet(itemContentType: kUTTypeItem as String)
        activity.title = "Write a new article"
        attributes.contentDescription = "Get those creative juices flowing!"
        attributes.thumbnailData = thumbnail?.jpegData(compressionQuality: 1.0)
        
        activity.suggestedInvocationPhrase = "Time to write!"
        activity.contentAttributeSet = attributes
        
        
      return activity
    }
  
  // Create an intent for publishing articles
  
  
  // MARK: - Init
  public init(title: String, content: String, published: Bool) {
    self.title = title
    self.content = content
    self.published = published
  }
  
  // MARK: - Helpers
  public func toData() -> Data? {
    let dict = ["title": title, "content": content, "published": published] as [String : Any]
    let data = try? NSKeyedArchiver.archivedData(withRootObject: dict, requiringSecureCoding: false)
    return data
  }
  
  public func formattedDate() -> String {
    let date = Date()
    let formatter = DateFormatter()
    
    formatter.dateFormat = "MM/dd/yyyy"
    let result = formatter.string(from: date)
    
    return result
  }
}
