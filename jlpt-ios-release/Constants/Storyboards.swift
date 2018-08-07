// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

// swiftlint:disable sorted_imports
import Foundation
import UIKit

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

internal protocol StoryboardType {
  static var storyboardName: String { get }
}

internal extension StoryboardType {
  static var storyboard: UIStoryboard {
    let name = self.storyboardName
    return UIStoryboard(name: name, bundle: Bundle(for: BundleToken.self))
  }
}

internal struct SceneType<T: Any> {
  internal let storyboard: StoryboardType.Type
  internal let identifier: String

  internal func instantiate() -> T {
    let identifier = self.identifier
    guard let controller = storyboard.storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
      fatalError("ViewController '\(identifier)' is not of the expected class \(T.self).")
    }
    return controller
  }
}

internal struct InitialSceneType<T: Any> {
  internal let storyboard: StoryboardType.Type

  internal func instantiate() -> T {
    guard let controller = storyboard.storyboard.instantiateInitialViewController() as? T else {
      fatalError("ViewController is not of the expected class \(T.self).")
    }
    return controller
  }
}

internal protocol SegueType: RawRepresentable { }

internal extension UIViewController {
  func perform<S: SegueType>(segue: S, sender: Any? = nil) where S.RawValue == String {
    let identifier = segue.rawValue
    performSegue(withIdentifier: identifier, sender: sender)
  }
}

// swiftlint:disable explicit_type_interface identifier_name line_length type_body_length type_name
internal enum StoryboardScene {
  internal enum AppodealBannerViewController: StoryboardType {
    internal static let storyboardName = "AppodealBannerViewController"

    internal static let appodealBannerViewController = SceneType<jlpt_ios_release.AppodealBannerViewController>(storyboard: AppodealBannerViewController.self, identifier: "AppodealBannerViewController")
  }
  internal enum ChatRoomViewController: StoryboardType {
    internal static let storyboardName = "ChatRoomViewController"

    internal static let chatRoomViewController = SceneType<jlpt_ios_release.ChatRoomViewController>(storyboard: ChatRoomViewController.self, identifier: "ChatRoomViewController")
  }
  internal enum DocumentDetailViewController: StoryboardType {
    internal static let storyboardName = "DocumentDetailViewController"

    internal static let documentDetailViewController = SceneType<jlpt_ios_release.DocumentDetailViewController>(storyboard: DocumentDetailViewController.self, identifier: "DocumentDetailViewController")
  }
  internal enum DocumentsViewController: StoryboardType {
    internal static let storyboardName = "DocumentsViewController"

    internal static let documentViewController = SceneType<jlpt_ios_release.DocumentViewController>(storyboard: DocumentsViewController.self, identifier: "DocumentViewController")
  }
  internal enum EditProfileViewController: StoryboardType {
    internal static let storyboardName = "EditProfileViewController"

    internal static let editProfileViewController = SceneType<jlpt_ios_release.EditProfileViewController>(storyboard: EditProfileViewController.self, identifier: "EditProfileViewController")
  }
  internal enum FeedBackViewController: StoryboardType {
    internal static let storyboardName = "FeedBackViewController"

    internal static let feedbackViewController = SceneType<jlpt_ios_release.FeedbackViewController>(storyboard: FeedBackViewController.self, identifier: "FeedbackViewController")
  }
  internal enum GroupChatViewController: StoryboardType {
    internal static let storyboardName = "GroupChatViewController"

    internal static let groupChatViewController = SceneType<jlpt_ios_release.GroupChatViewController>(storyboard: GroupChatViewController.self, identifier: "GroupChatViewController")
  }
  internal enum LaunchScreen: StoryboardType {
    internal static let storyboardName = "LaunchScreen"

    internal static let initialScene = InitialSceneType<UIViewController>(storyboard: LaunchScreen.self)
  }
  internal enum ListDocumentOfTypeViewController: StoryboardType {
    internal static let storyboardName = "ListDocumentOfTypeViewController"

    internal static let listDocumentViewController = SceneType<jlpt_ios_release.ListDocumentViewController>(storyboard: ListDocumentOfTypeViewController.self, identifier: "ListDocumentViewController")
  }
  internal enum ListHintViewController: StoryboardType {
    internal static let storyboardName = "ListHintViewController"

    internal static let listHintController = SceneType<jlpt_ios_release.ListHintController>(storyboard: ListHintViewController.self, identifier: "ListHintController")
  }
  internal enum ListJLPTQuestionViewController: StoryboardType {
    internal static let storyboardName = "ListJLPTQuestionViewController"

    internal static let listQuestionViewController = SceneType<jlpt_ios_release.ListQuestionViewController>(storyboard: ListJLPTQuestionViewController.self, identifier: "ListQuestionViewController")
  }
  internal enum ListeningQuestionViewController: StoryboardType {
    internal static let storyboardName = "ListeningQuestionViewController"

    internal static let listeningQuestionViewController = SceneType<jlpt_ios_release.ListeningQuestionViewController>(storyboard: ListeningQuestionViewController.self, identifier: "ListeningQuestionViewController")
  }
  internal enum LoginViewController: StoryboardType {
    internal static let storyboardName = "LoginViewController"

    internal static let loginViewController = SceneType<jlpt_ios_release.LoginViewController>(storyboard: LoginViewController.self, identifier: "LoginViewController")
  }
  internal enum NomalQuestionViewController: StoryboardType {
    internal static let storyboardName = "NomalQuestionViewController"

    internal static let normalQuestionViewController = SceneType<jlpt_ios_release.NormalQuestionViewController>(storyboard: NomalQuestionViewController.self, identifier: "NormalQuestionViewController")
  }
  internal enum NotificationViewController: StoryboardType {
    internal static let storyboardName = "NotificationViewController"

    internal static let notificationViewController = SceneType<jlpt_ios_release.NotificationViewController>(storyboard: NotificationViewController.self, identifier: "NotificationViewController")
  }
  internal enum PrivacyPolicyViewController: StoryboardType {
    internal static let storyboardName = "PrivacyPolicyViewController"

    internal static let privacyPolicyViewController = SceneType<jlpt_ios_release.PrivacyPolicyViewController>(storyboard: PrivacyPolicyViewController.self, identifier: "PrivacyPolicyViewController")
  }
  internal enum ProcessViewController: StoryboardType {
    internal static let storyboardName = "ProcessViewController"

    internal static let processViewController = SceneType<jlpt_ios_release.ProcessViewController>(storyboard: ProcessViewController.self, identifier: "ProcessViewController")
  }
  internal enum ProfileViewController: StoryboardType {
    internal static let storyboardName = "ProfileViewController"

    internal static let profileViewController = SceneType<jlpt_ios_release.ProfileViewController>(storyboard: ProfileViewController.self, identifier: "ProfileViewController")
  }
  internal enum RegisterViewController: StoryboardType {
    internal static let storyboardName = "RegisterViewController"

    internal static let registerViewController = SceneType<jlpt_ios_release.RegisterViewController>(storyboard: RegisterViewController.self, identifier: "RegisterViewController")
  }
  internal enum ShowDocumentViewController: StoryboardType {
    internal static let storyboardName = "ShowDocumentViewController"

    internal static let showDocumentViewController = SceneType<jlpt_ios_release.ShowDocumentViewController>(storyboard: ShowDocumentViewController.self, identifier: "ShowDocumentViewController")
  }
  internal enum StartAppViewController: StoryboardType {
    internal static let storyboardName = "StartAppViewController"

    internal static let initialScene = InitialSceneType<jlpt_ios_release.StartAppViewController>(storyboard: StartAppViewController.self)

    internal static let startAppViewController = SceneType<jlpt_ios_release.StartAppViewController>(storyboard: StartAppViewController.self, identifier: "StartAppViewController")
  }
  internal enum TheoryHintViewController: StoryboardType {
    internal static let storyboardName = "TheoryHintViewController"

    internal static let theoryHintViewController = SceneType<jlpt_ios_release.TheoryHintViewController>(storyboard: TheoryHintViewController.self, identifier: "TheoryHintViewController")
  }
}

internal enum StoryboardSegue {
}
// swiftlint:enable explicit_type_interface identifier_name line_length type_body_length type_name

private final class BundleToken {}
