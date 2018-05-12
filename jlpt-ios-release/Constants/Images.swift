// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSImage
  typealias AssetColorTypeAlias = NSColor
  typealias Image = NSImage
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIImage
  typealias AssetColorTypeAlias = UIColor
  typealias Image = UIImage
#endif

// swiftlint:disable file_length

@available(*, deprecated, renamed: "ImageAsset")
typealias AssetType = ImageAsset

struct ImageAsset {
  fileprivate var name: String

  var image: Image {
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

struct ColorAsset {
  fileprivate var name: String

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  var color: AssetColorTypeAlias {
    return AssetColorTypeAlias(asset: self)
  }
}

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
enum Asset {
  static let tips = ImageAsset(name: "tips")
  static let g12 = ImageAsset(name: "g12")
  static let g13 = ImageAsset(name: "g13")
  static let g6 = ImageAsset(name: "g6")
  static let g7 = ImageAsset(name: "g7")
  static let n4 = ImageAsset(name: "n4")
  static let n5 = ImageAsset(name: "n5")
  static let circleN3 = ImageAsset(name: "circle_n3")
  static let circleN2 = ImageAsset(name: "circle_n2")
  static let facebook = ImageAsset(name: "facebook")
  static let notificationIcon = ImageAsset(name: "notification_icon")
  static let cameraBtn = ImageAsset(name: "camera_btn")
  static let loading3 = ImageAsset(name: "loading_3")
  static let loading2 = ImageAsset(name: "loading_2")
  static let circleN4 = ImageAsset(name: "circle_n4")
  static let circleN5 = ImageAsset(name: "circle_n5")
  static let bubbleGray = ImageAsset(name: "bubble_gray")
  static let reading = ImageAsset(name: "reading")
  static let grammar = ImageAsset(name: "grammar")
  static let g15 = ImageAsset(name: "g15")
  static let g14 = ImageAsset(name: "g14")
  static let n3 = ImageAsset(name: "n3")
  static let n2 = ImageAsset(name: "n2")
  static let g1 = ImageAsset(name: "g1")
  static let pin = ImageAsset(name: "pin")
  static let dismissBtn = ImageAsset(name: "dismiss_btn")
  static let download = ImageAsset(name: "download")
  static let sendDisable = ImageAsset(name: "send_disable")
  static let downloadDone = ImageAsset(name: "download_done")
  static let background = ImageAsset(name: "background")
  static let circleN1 = ImageAsset(name: "circle_n1")
  static let google = ImageAsset(name: "google")
  static let profile = ImageAsset(name: "profile")
  static let g5 = ImageAsset(name: "g5")
  static let g4 = ImageAsset(name: "g4")
  static let bubbleBlue = ImageAsset(name: "bubble_blue")
  static let g11 = ImageAsset(name: "g11")
  static let g10 = ImageAsset(name: "g10")
  static let sendPressed = ImageAsset(name: "send_pressed")
  static let n1 = ImageAsset(name: "n1")
  static let g2 = ImageAsset(name: "g2")
  static let g3 = ImageAsset(name: "g3")
  static let sendNormal = ImageAsset(name: "send_normal")
  static let tips1 = ImageAsset(name: "tips-1")
  static let g8 = ImageAsset(name: "g8")
  static let g9 = ImageAsset(name: "g9")
  static let listening = ImageAsset(name: "listening")
  static let kanji = ImageAsset(name: "kanji")
  static let backgroundLogin = ImageAsset(name: "background_login")
  static let emptyStatePlaceholder = ImageAsset(name: "empty_state_placeholder")
  static let loading0 = ImageAsset(name: "loading_0")
  static let loading1 = ImageAsset(name: "loading_1")

  // swiftlint:disable trailing_comma
  static let allColors: [ColorAsset] = [
  ]
  static let allImages: [ImageAsset] = [
    tips,
    g12,
    g13,
    g6,
    g7,
    n4,
    n5,
    circleN3,
    circleN2,
    facebook,
    notificationIcon,
    cameraBtn,
    loading3,
    loading2,
    circleN4,
    circleN5,
    bubbleGray,
    reading,
    grammar,
    g15,
    g14,
    n3,
    n2,
    g1,
    pin,
    dismissBtn,
    download,
    sendDisable,
    downloadDone,
    background,
    circleN1,
    google,
    profile,
    g5,
    g4,
    bubbleBlue,
    g11,
    g10,
    sendPressed,
    n1,
    g2,
    g3,
    sendNormal,
    tips1,
    g8,
    g9,
    listening,
    kanji,
    backgroundLogin,
    emptyStatePlaceholder,
    loading0,
    loading1,
  ]
  // swiftlint:enable trailing_comma
  @available(*, deprecated, renamed: "allImages")
  static let allValues: [AssetType] = allImages
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

extension Image {
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

extension AssetColorTypeAlias {
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
