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
  static let background = ImageAsset(name: "background")
  static let galaxyBackground = ImageAsset(name: "galaxy_background")
  static let lesson = ImageAsset(name: "lesson")
  static let lesson1 = ImageAsset(name: "lesson_1")
  static let lesson10 = ImageAsset(name: "lesson_10")
  static let lesson11 = ImageAsset(name: "lesson_11")
  static let lesson12 = ImageAsset(name: "lesson_12")
  static let lesson13 = ImageAsset(name: "lesson_13")
  static let lesson14 = ImageAsset(name: "lesson_14")
  static let lesson15 = ImageAsset(name: "lesson_15")
  static let lesson16 = ImageAsset(name: "lesson_16")
  static let lesson17 = ImageAsset(name: "lesson_17")
  static let lesson18 = ImageAsset(name: "lesson_18")
  static let lesson19 = ImageAsset(name: "lesson_19")
  static let lesson2 = ImageAsset(name: "lesson_2")
  static let lesson20 = ImageAsset(name: "lesson_20")
  static let lesson21 = ImageAsset(name: "lesson_21")
  static let lesson3 = ImageAsset(name: "lesson_3")
  static let lesson4 = ImageAsset(name: "lesson_4")
  static let lesson5 = ImageAsset(name: "lesson_5")
  static let lesson6 = ImageAsset(name: "lesson_6")
  static let lesson7 = ImageAsset(name: "lesson_7")
  static let lesson8 = ImageAsset(name: "lesson_8")
  static let lesson9 = ImageAsset(name: "lesson_9")
  static let loading0 = ImageAsset(name: "loading_0")
  static let loading1 = ImageAsset(name: "loading_1")
  static let loading2 = ImageAsset(name: "loading_2")
  static let loading3 = ImageAsset(name: "loading_3")
  static let navbarBackground = ImageAsset(name: "navbar_background")
  static let nextButton = ImageAsset(name: "next_button")
  static let process = ImageAsset(name: "process")
  static let profile = ImageAsset(name: "profile")
  static let skipButton = ImageAsset(name: "skip_button")
  static let startButton = ImageAsset(name: "start_button")
  static let startButton1 = ImageAsset(name: "start_button1")

  // swiftlint:disable trailing_comma
  static let allColors: [ColorAsset] = [
  ]
  static let allImages: [ImageAsset] = [
    background,
    galaxyBackground,
    lesson,
    lesson1,
    lesson10,
    lesson11,
    lesson12,
    lesson13,
    lesson14,
    lesson15,
    lesson16,
    lesson17,
    lesson18,
    lesson19,
    lesson2,
    lesson20,
    lesson21,
    lesson3,
    lesson4,
    lesson5,
    lesson6,
    lesson7,
    lesson8,
    lesson9,
    loading0,
    loading1,
    loading2,
    loading3,
    navbarBackground,
    nextButton,
    process,
    profile,
    skipButton,
    startButton,
    startButton1,
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
