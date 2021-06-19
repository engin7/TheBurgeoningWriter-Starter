 
import UIKit
import IntentsUI
import ArticleKit

class NewArticleViewController: UIViewController {
  let titleTextField = UITextField()
  let contentsTextView = UITextView()
  let addShortcutButton = UIButton()
  
  @objc func saveWasTapped() {
    if let title = titleTextField.text, let content = contentsTextView.text {
      let article = Article(title: title, content: content, published: false)
      
      ArticleManager.add(article: article)
      
      // Donate publish intent
      
      
      navigationController?.popViewController(animated: true)
    }
  }
  
  @objc func addNewArticleShortcutWasTapped() {
    // Open View Controller to Create New Shortcut
    
  }
}

// Add Shortcut View Controller Delegate Extension

