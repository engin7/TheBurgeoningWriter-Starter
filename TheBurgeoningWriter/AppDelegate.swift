 
import UIKit
import IntentsUI
import ArticleKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  var nav: UINavigationController?
  
  let rootVC = ArticleFeedViewController()
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    nav = UINavigationController(rootViewController: rootVC)
    window?.rootViewController = nav
    window?.makeKeyAndVisible()
    
    ArticleManager.loadArticles()
    return true
  }
  
  func applicationWillResignActive(_ application: UIApplication) {
    ArticleManager.writeArticlesToDisk()
  }
  
  func applicationDidEnterBackground(_ application: UIApplication) {
    ArticleManager.writeArticlesToDisk()
  }
  
  func application(_ application: UIApplication, willContinueUserActivityWithType userActivityType: String) -> Bool {
    if userActivityType == "com.razeware.NewArticle" {
      return true
    }
    return false
  }
  
    func application(
      _ application: UIApplication,
      continue userActivity: NSUserActivity,
      restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void
    ) -> Bool {
        let vc = NewArticleViewController()
        nav?.pushViewController(vc, animated: false)
      return true
    }
  
}
