// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

// swiftlint:disable sorted_imports
import Foundation
import UIKit

protocol StoryboardType {
  static var storyboardName: String { get }
}

extension StoryboardType {
  static var storyboard: UIStoryboard {
    return UIStoryboard(name: self.storyboardName, bundle: Bundle(for: BundleToken.self))
  }
}

struct SceneType<T: Any> {
  let storyboard: StoryboardType.Type
  let identifier: String

  func instantiate() -> T {
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
    performSegue(withIdentifier: segue.rawValue, sender: sender)
  }
}

enum StoryboardScene {
  enum ChatRoom: StoryboardType {
    static let storyboardName = "ChatRoom"

    static let chatRoomController = SceneType<jlpt_ios_release.ChatRoomController>(storyboard: ChatRoom.self, identifier: "ChatRoomController")
  }
  enum ChildIntroduction: StoryboardType {
    static let storyboardName = "ChildIntroduction"

    static let childIntroductionController = SceneType<jlpt_ios_release.ChildIntroductionController>(storyboard: ChildIntroduction.self, identifier: "ChildIntroductionController")
  }
  enum Documents: StoryboardType {
    static let storyboardName = "Documents"

    static let documentController = SceneType<jlpt_ios_release.DocumentController>(storyboard: Documents.self, identifier: "DocumentController")
  }
  enum EditProfile: StoryboardType {
    static let storyboardName = "EditProfile"

    static let editProfileController = SceneType<jlpt_ios_release.EditProfileController>(storyboard: EditProfile.self, identifier: "EditProfileController")
  }
  enum FeedBack: StoryboardType {
    static let storyboardName = "FeedBack"

    static let feedbackController = SceneType<jlpt_ios_release.FeedbackController>(storyboard: FeedBack.self, identifier: "FeedbackController")
  }
  enum Introduction: StoryboardType {
    static let storyboardName = "Introduction"

    static let initialScene = InitialSceneType<jlpt_ios_release.IntroductionController>(storyboard: Introduction.self)

    static let introductionController = SceneType<jlpt_ios_release.IntroductionController>(storyboard: Introduction.self, identifier: "IntroductionController")
  }
  enum LaunchScreen: StoryboardType {
    static let storyboardName = "LaunchScreen"

    static let initialScene = InitialSceneType<UIViewController>(storyboard: LaunchScreen.self)
  }
  enum ListDocumentOfType: StoryboardType {
    static let storyboardName = "ListDocumentOfType"

    static let listDocumentOfTypeController = SceneType<jlpt_ios_release.ListDocumentOfTypeController>(storyboard: ListDocumentOfType.self, identifier: "ListDocumentOfTypeController")
  }
  enum ListHint: StoryboardType {
    static let storyboardName = "ListHint"

    static let listHintController = SceneType<jlpt_ios_release.ListHintController>(storyboard: ListHint.self, identifier: "ListHintController")
  }
  enum ListJLPTQuestion: StoryboardType {
    static let storyboardName = "ListJLPTQuestion"

    static let listQuestionController = SceneType<jlpt_ios_release.ListQuestionController>(storyboard: ListJLPTQuestion.self, identifier: "ListQuestionController")
  }
  enum ListeningQuestion: StoryboardType {
    static let storyboardName = "ListeningQuestion"

    static let listeningQuestionController = SceneType<jlpt_ios_release.ListeningQuestionController>(storyboard: ListeningQuestion.self, identifier: "ListeningQuestionController")
  }
  enum Login: StoryboardType {
    static let storyboardName = "Login"

    static let loginViewController = SceneType<jlpt_ios_release.LoginViewController>(storyboard: Login.self, identifier: "LoginViewController")
  }
  enum NomalQuestion: StoryboardType {
    static let storyboardName = "NomalQuestion"

    static let nomalQuestionController = SceneType<jlpt_ios_release.NomalQuestionController>(storyboard: NomalQuestion.self, identifier: "NomalQuestionController")
  }
  enum Notification: StoryboardType {
    static let storyboardName = "Notification"

    static let notificationController = SceneType<jlpt_ios_release.NotificationController>(storyboard: Notification.self, identifier: "NotificationController")
  }
  enum PrivacyPolicy: StoryboardType {
    static let storyboardName = "PrivacyPolicy"

    static let privacyPolicyController = SceneType<jlpt_ios_release.PrivacyPolicyController>(storyboard: PrivacyPolicy.self, identifier: "PrivacyPolicyController")
  }
  enum Process: StoryboardType {
    static let storyboardName = "Process"

    static let processController = SceneType<jlpt_ios_release.ProcessController>(storyboard: Process.self, identifier: "ProcessController")
  }
  enum Profile: StoryboardType {
    static let storyboardName = "Profile"

    static let profileController = SceneType<jlpt_ios_release.ProfileController>(storyboard: Profile.self, identifier: "ProfileController")
  }
  enum Register: StoryboardType {
    static let storyboardName = "Register"

    static let registerViewController = SceneType<jlpt_ios_release.RegisterViewController>(storyboard: Register.self, identifier: "RegisterViewController")
  }
  enum StartApp: StoryboardType {
    static let storyboardName = "StartApp"

    static let initialScene = InitialSceneType<jlpt_ios_release.StartAppController>(storyboard: StartApp.self)

    static let startAppController = SceneType<jlpt_ios_release.StartAppController>(storyboard: StartApp.self, identifier: "StartAppController")
  }
  enum TheoryHint: StoryboardType {
    static let storyboardName = "TheoryHint"

    static let theoryHintController = SceneType<jlpt_ios_release.TheoryHintController>(storyboard: TheoryHint.self, identifier: "TheoryHintController")
  }
}

enum StoryboardSegue {
}
// swiftlint:enable explicit_type_interface identifier_name line_length type_body_length type_name

private final class BundleToken {}
