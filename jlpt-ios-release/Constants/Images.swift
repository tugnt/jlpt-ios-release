// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSImage
  internal typealias AssetColorTypeAlias = NSColor
  internal typealias Image = NSImage
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIImage
  internal typealias AssetColorTypeAlias = UIColor
  internal typealias Image = UIImage
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

@available(*, deprecated, renamed: "ImageAsset")
internal typealias AssetType = ImageAsset

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  internal var image: Image {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    let image = bundle.image(forResource: NSImage.Name(name))
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else { fatalError("Unable to load image named \(name).") }
    return result
  }
}

internal struct ColorAsset {
  internal fileprivate(set) var name: String

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  internal var color: AssetColorTypeAlias {
    return AssetColorTypeAlias(asset: self)
  }
}

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal static let background = ImageAsset(name: "background")
  internal static let backgroundLogin = ImageAsset(name: "background_login")
  internal static let bubbleBlue = ImageAsset(name: "bubble_blue")
  internal static let bubbleGray = ImageAsset(name: "bubble_gray")
  internal static let cameraBtn = ImageAsset(name: "camera_btn")
  internal static let circleN1 = ImageAsset(name: "circle_n1")
  internal static let circleN2 = ImageAsset(name: "circle_n2")
  internal static let circleN3 = ImageAsset(name: "circle_n3")
  internal static let circleN4 = ImageAsset(name: "circle_n4")
  internal static let circleN5 = ImageAsset(name: "circle_n5")
  internal static let dismissBtn = ImageAsset(name: "dismiss_btn")
  internal static let download = ImageAsset(name: "download")
  internal static let downloadDone = ImageAsset(name: "download_done")
  internal static let emptyStatePlaceholder = ImageAsset(name: "empty_state_placeholder")
  internal static let exam = ImageAsset(name: "exam")
  internal static let facebook = ImageAsset(name: "facebook")
  internal static let g1 = ImageAsset(name: "g1")
  internal static let g10 = ImageAsset(name: "g10")
  internal static let g11 = ImageAsset(name: "g11")
  internal static let g12 = ImageAsset(name: "g12")
  internal static let g13 = ImageAsset(name: "g13")
  internal static let g14 = ImageAsset(name: "g14")
  internal static let g15 = ImageAsset(name: "g15")
  internal static let g2 = ImageAsset(name: "g2")
  internal static let g3 = ImageAsset(name: "g3")
  internal static let g4 = ImageAsset(name: "g4")
  internal static let g5 = ImageAsset(name: "g5")
  internal static let g6 = ImageAsset(name: "g6")
  internal static let g7 = ImageAsset(name: "g7")
  internal static let g8 = ImageAsset(name: "g8")
  internal static let g9 = ImageAsset(name: "g9")
  internal static let google = ImageAsset(name: "google")
  internal static let grammar = ImageAsset(name: "grammar")
  internal static let kanji = ImageAsset(name: "kanji")
  internal static let listening = ImageAsset(name: "listening")
  internal static let n1 = ImageAsset(name: "n1")
  internal static let n2 = ImageAsset(name: "n2")
  internal static let n3 = ImageAsset(name: "n3")
  internal static let n4 = ImageAsset(name: "n4")
  internal static let n5 = ImageAsset(name: "n5")
  internal static let notificationIcon = ImageAsset(name: "notification_icon")
  internal static let pin = ImageAsset(name: "pin")
  internal static let profile = ImageAsset(name: "profile")
  internal static let reading = ImageAsset(name: "reading")
  internal static let sendDisable = ImageAsset(name: "send_disable")
  internal static let sendNormal = ImageAsset(name: "send_normal")
  internal static let sendPressed = ImageAsset(name: "send_pressed")
  internal static let tips1 = ImageAsset(name: "tips-1")
  internal static let tips = ImageAsset(name: "tips")
  internal static let user = ImageAsset(name: "user")

  // swiftlint:disable trailing_comma
  internal static let allColors: [ColorAsset] = [
  ]
  internal static let allImages: [ImageAsset] = [
    background,
    backgroundLogin,
    bubbleBlue,
    bubbleGray,
    cameraBtn,
    circleN1,
    circleN2,
    circleN3,
    circleN4,
    circleN5,
    dismissBtn,
    download,
    downloadDone,
    emptyStatePlaceholder,
    exam,
    facebook,
    g1,
    g10,
    g11,
    g12,
    g13,
    g14,
    g15,
    g2,
    g3,
    g4,
    g5,
    g6,
    g7,
    g8,
    g9,
    google,
    grammar,
    kanji,
    listening,
    n1,
    n2,
    n3,
    n4,
    n5,
    notificationIcon,
    pin,
    profile,
    reading,
    sendDisable,
    sendNormal,
    sendPressed,
    tips1,
    tips,
    user,
  ]
  // swiftlint:enable trailing_comma
  @available(*, deprecated, renamed: "allImages")
  internal static let allValues: [AssetType] = allImages
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

internal extension Image {
  @available(iOS 1.0, tvOS 1.0, watchOS 1.0, *)
  @available(OSX, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init!(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = Bundle(for: BundleToken.self)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

internal extension AssetColorTypeAlias {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  convenience init!(asset: ColorAsset) {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

private final class BundleToken {}
