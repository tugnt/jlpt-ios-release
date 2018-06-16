// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

// swiftlint:disable sorted_imports
import Foundation
import UIKit

// swiftlint:disable file_length

protocol StoryboardType {
  static var storyboardName: String { get }
}

extension StoryboardType {
  static var storyboard: UIStoryboard {
    let name = self.storyboardName
    return UIStoryboard(name: name, bundle: Bundle(for: BundleToken.self))
  }
}

struct SceneType<T: Any> {
  let storyboard: StoryboardType.Type
  let identifier: String

  func instantiate() -> T {
    let identifier = self.identifier
    guard let controller = storyboard.storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
      fatalError("ViewController '\(identifier)' is not of the expected class \(T.self).")
    }
    return controller
  }
}

struct InitialSceneType<T: Any> {
  let storyboard: StoryboardType.Type

  func instantiate() -> T {
    guard let controller = storyboard.storyboard.instantiateInitialViewController() as? T else {
      fatalError("ViewController is not of the expected class \(T.self).")
    }
    return controller
  }
}

protocol SegueType: RawRepresentable { }

extension UIViewController {
  func perform<S: SegueType>(segue: S, sender: Any? = nil) where S.RawValue == String {
    let identifier = segue.rawValue
    performSegue(withIdentifier: identifier, sender: sender)
  }
}

// swiftlint:disable explicit_type_interface identifier_name line_length type_body_length type_name
enum StoryboardScene {
  enum ChatRoomViewController: StoryboardType {
    static let storyboardName = "ChatRoomViewController"

    static let chatRoomViewController = SceneType<jlpt_ios_release.ChatRoomViewController>(storyboard: ChatRoomViewController.self, identifier: "ChatRoomViewController")
  }
  enum DocumentDetailViewController: StoryboardType {
    static let storyboardName = "DocumentDetailViewController"

    static let documentDetailViewController = SceneType<jlpt_ios_release.DocumentDetailViewController>(storyboard: DocumentDetailViewController.self, identifier: "DocumentDetailViewController")
  }
  enum DocumentsViewController: StoryboardType {
    static let storyboardName = "DocumentsViewController"

    static let documentViewController = SceneType<jlpt_ios_release.DocumentViewController>(storyboard: DocumentsViewController.self, identifier: "DocumentViewController")
  }
  enum EditProfileViewController: StoryboardType {
    static let storyboardName = "EditProfileViewController"

    static let editProfileViewController = SceneType<jlpt_ios_release.EditProfileViewController>(storyboard: EditProfileViewController.self, identifier: "EditProfileViewController")
  }
  enum FeedBackViewController: StoryboardType {
    static let storyboardName = "FeedBackViewController"

    static let feedbackViewController = SceneType<jlpt_ios_release.FeedbackViewController>(storyboard: FeedBackViewController.self, identifier: "FeedbackViewController")
  }
  enum GroupChatViewController: StoryboardType {
    static let storyboardName = "GroupChatViewController"

    static let groupChatViewController = SceneType<jlpt_ios_release.GroupChatViewController>(storyboard: GroupChatViewController.self, identifier: "GroupChatViewController")
  }
  enum LaunchScreen: StoryboardType {
    static let storyboardName = "LaunchScreen"

    static let initialScene = InitialSceneType<UIViewController>(storyboard: LaunchScreen.self)
  }
  enum ListDocumentOfTypeViewController: StoryboardType {
    static let storyboardName = "ListDocumentOfTypeViewController"

    static let listDocumentViewController = SceneType<jlpt_ios_release.ListDocumentViewController>(storyboard: ListDocumentOfTypeViewController.self, identifier: "ListDocumentViewController")
  }
  enum ListHintViewController: StoryboardType {
    static let storyboardName = "ListHintViewController"

    static let listHintController = SceneType<jlpt_ios_release.ListHintController>(storyboard: ListHintViewController.self, identifier: "ListHintController")
  }
  enum ListJLPTQuestionViewController: StoryboardType {
    static let storyboardName = "ListJLPTQuestionViewController"

    static let listQuestionViewController = SceneType<jlpt_ios_release.ListQuestionViewController>(storyboard: ListJLPTQuestionViewController.self, identifier: "ListQuestionViewController")
  }
  enum ListeningQuestionViewController: StoryboardType {
    static let storyboardName = "ListeningQuestionViewController"

    static let listeningQuestionViewController = SceneType<jlpt_ios_release.ListeningQuestionViewController>(storyboard: ListeningQuestionViewController.self, identifier: "ListeningQuestionViewController")
  }
  enum LoginViewController: StoryboardType {
    static let storyboardName = "LoginViewController"

    static let loginViewController = SceneType<jlpt_ios_release.LoginViewController>(storyboard: LoginViewController.self, identifier: "LoginViewController")
  }
  enum NomalQuestionViewController: StoryboardType {
    static let storyboardName = "NomalQuestionViewController"

    static let normalQuestionViewController = SceneType<jlpt_ios_release.NormalQuestionViewController>(storyboard: NomalQuestionViewController.self, identifier: "NormalQuestionViewController")
  }
  enum NotificationViewController: StoryboardType {
    static let storyboardName = "NotificationViewController"

    static let notificationViewController = SceneType<jlpt_ios_release.NotificationViewController>(storyboard: NotificationViewController.self, identifier: "NotificationViewController")
  }
  enum PrivacyPolicyViewController: StoryboardType {
    static let storyboardName = "PrivacyPolicyViewController"

    static let privacyPolicyViewController = SceneType<jlpt_ios_release.PrivacyPolicyViewController>(storyboard: PrivacyPolicyViewController.self, identifier: "PrivacyPolicyViewController")
  }
  enum ProcessViewController: StoryboardType {
    static let storyboardName = "ProcessViewController"

    static let processViewController = SceneType<jlpt_ios_release.ProcessViewController>(storyboard: ProcessViewController.self, identifier: "ProcessViewController")
  }
  enum ProfileViewController: StoryboardType {
    static let storyboardName = "ProfileViewController"

    static let profileViewController = SceneType<jlpt_ios_release.ProfileViewController>(storyboard: ProfileViewController.self, identifier: "ProfileViewController")
  }
  enum RegisterViewController: StoryboardType {
    static let storyboardName = "RegisterViewController"

    static let registerViewController = SceneType<jlpt_ios_release.RegisterViewController>(storyboard: RegisterViewController.self, identifier: "RegisterViewController")
  }
  enum ShowDocumentViewController: StoryboardType {
    static let storyboardName = "ShowDocumentViewController"

    static let showDocumentViewController = SceneType<jlpt_ios_release.ShowDocumentViewController>(storyboard: ShowDocumentViewController.self, identifier: "ShowDocumentViewController")
  }
  enum StartAppViewController: StoryboardType {
    static let storyboardName = "StartAppViewController"

    static let initialScene = InitialSceneType<jlpt_ios_release.StartAppViewController>(storyboard: StartAppViewController.self)

    static let startAppViewController = SceneType<jlpt_ios_release.StartAppViewController>(storyboard: StartAppViewController.self, identifier: "StartAppViewController")
  }
  enum TheoryHintViewController: StoryboardType {
    static let storyboardName = "TheoryHintViewController"

    static let theoryHintViewController = SceneType<jlpt_ios_release.TheoryHintViewController>(storyboard: TheoryHintViewController.self, identifier: "TheoryHintViewController")
  }
}

enum StoryboardSegue {
}
// swiftlint:enable explicit_type_interface identifier_name line_length type_body_length type_name

private final class BundleToken {}
