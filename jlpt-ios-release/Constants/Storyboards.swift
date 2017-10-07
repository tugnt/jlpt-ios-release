// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

// swiftlint:disable sorted_imports
import Foundation
import UIKit
import jlpt_ios_release

// swiftlint:disable file_length

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

// swiftlint:disable explicit_type_interface identifier_name line_length type_body_length type_name
enum StoryboardScene {
  enum ChildIntroduction: StoryboardType {
    static let storyboardName = "ChildIntroduction"

    static let childIntroductionController = SceneType<jlpt_ios_release.ChildIntroductionController>(storyboard: ChildIntroduction.self, identifier: "ChildIntroductionController")
  }
  enum HintQuestionController: StoryboardType {
    static let storyboardName = "HintQuestionController"
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
  enum ListHintController: StoryboardType {
    static let storyboardName = "ListHintController"

    static let listHintController = SceneType<jlpt_ios_release.ListHintController>(storyboard: ListHintController.self, identifier: "ListHintController")
  }
  enum ListQuestionController: StoryboardType {
    static let storyboardName = "ListQuestionController"

    static let listQuestionController = SceneType<jlpt_ios_release.ListQuestionController>(storyboard: ListQuestionController.self, identifier: "ListQuestionController")
  }
  enum Process: StoryboardType {
    static let storyboardName = "Process"

    static let processController = SceneType<jlpt_ios_release.ProcessController>(storyboard: Process.self, identifier: "ProcessController")
  }
  enum Profile: StoryboardType {
    static let storyboardName = "Profile"

    static let profileController = SceneType<jlpt_ios_release.ProfileController>(storyboard: Profile.self, identifier: "ProfileController")
  }
  enum StartApp: StoryboardType {
    static let storyboardName = "StartApp"

    static let initialScene = InitialSceneType<jlpt_ios_release.StartAppController>(storyboard: StartApp.self)

    static let startAppController = SceneType<jlpt_ios_release.StartAppController>(storyboard: StartApp.self, identifier: "StartAppController")
  }
  enum TheoryHintController: StoryboardType {
    static let storyboardName = "TheoryHintController"
  }
}

enum StoryboardSegue {
}
// swiftlint:enable explicit_type_interface identifier_name line_length type_body_length type_name

private final class BundleToken {}
