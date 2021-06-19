
import UIKit
import ArticleKit
import Intents
import CoreSpotlight
import MobileCoreServices

class ArticleFeedViewController: UIViewController {
  let tableView = UITableView(frame: .zero, style: .plain)
  let cellReuseIdentifier = "kArticleCellReuse"
  
  var articles: [Article] = []
  
  @objc func newArticleWasTapped() {
    let vc = NewArticleViewController()
    
    // Create and donate an activity-based Shortcut
    //1 First, you create an activity object. Then, you attach it to the view controller that’ll be on screen.
    let activity = Article.newArticleShortcut(thumbnail: UIImage(named: "notePad"))
    vc.userActivity = activity

    //2 Next, you call becomeCurrent() to officially become the “current” activity. This is the method that registers your activity with the system.
    activity.becomeCurrent()

    navigationController?.pushViewController(vc, animated: true)
  }
  
  // MARK: - Initialization
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nil, bundle: nil)
    
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(ArticleTableViewCell.classForCoder(), forCellReuseIdentifier: cellReuseIdentifier)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension ArticleFeedViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vc = EditDraftViewController(article: articles[indexPath.row])
    navigationController?.pushViewController(vc, animated: true)
  }
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  func remove(article: Article, at indexPath: IndexPath) {
    ArticleManager.remove(article: article)
    articles = ArticleManager.allArticles()
    tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
    
    // Remove intent for article
    
  }
}
