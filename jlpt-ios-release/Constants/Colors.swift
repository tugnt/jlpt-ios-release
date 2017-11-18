// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSColor
  typealias Color = NSColor
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIColor
  typealias Color = UIColor
#endif

// swiftlint:disable file_length

// swiftlint:disable operator_usage_whitespace
extension Color {
  convenience init(rgbaValue: UInt32) {
    let red   = CGFloat((rgbaValue >> 24) & 0xff) / 255.0
    let green = CGFloat((rgbaValue >> 16) & 0xff) / 255.0
    let blue  = CGFloat((rgbaValue >>  8) & 0xff) / 255.0
    let alpha = CGFloat((rgbaValue      ) & 0xff) / 255.0

    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }
}
// swiftlint:enable operator_usage_whitespace

// swiftlint:disable identifier_name line_length type_body_length
struct ColorName {
  let rgbaValue: UInt32
  var color: Color { return Color(named: self) }

  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#f5f5f5"></span>
  /// Alpha: 100% <br/> (0xf5f5f5ff)
  static let logoutBtn = ColorName(rgbaValue: 0xf5f5f5ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#2895ff"></span>
  /// Alpha: 100% <br/> (0x2895ffff)
  static let navBackground = ColorName(rgbaValue: 0x2895ffff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#f5f5f5"></span>
  /// Alpha: 100% <br/> (0xf5f5f5ff)
  static let acceptBtnBg = ColorName(rgbaValue: 0xf5f5f5ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#3d9fff"></span>
  /// Alpha: 100% <br/> (0x3d9fffff)
  static let acceptBtnBgSelected = ColorName(rgbaValue: 0x3d9fffff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#fafafa"></span>
  /// Alpha: 100% <br/> (0xfafafaff)
  static let acceptTitle = ColorName(rgbaValue: 0xfafafaff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#fafafa"></span>
  /// Alpha: 100% <br/> (0xfafafaff)
  static let acceptTitleSelected = ColorName(rgbaValue: 0xfafafaff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#d8d8d8"></span>
  /// Alpha: 100% <br/> (0xd8d8d8ff)
  static let borderTextFieldColor = ColorName(rgbaValue: 0xd8d8d8ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#f5f5f5"></span>
  /// Alpha: 100% <br/> (0xf5f5f5ff)
  static let bottomHeaderLine = ColorName(rgbaValue: 0xf5f5f5ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#f5f5f5"></span>
  /// Alpha: 100% <br/> (0xf5f5f5ff)
  static let cancelBtnBg = ColorName(rgbaValue: 0xf5f5f5ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#f5f5f5"></span>
  /// Alpha: 100% <br/> (0xf5f5f5ff)
  static let cancelBtnBgSelected = ColorName(rgbaValue: 0xf5f5f5ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#d50000"></span>
  /// Alpha: 100% <br/> (0xd50000ff)
  static let cancelTitle = ColorName(rgbaValue: 0xd50000ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ff1744"></span>
  /// Alpha: 100% <br/> (0xff1744ff)
  static let cancelTitleSelected = ColorName(rgbaValue: 0xff1744ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#50d2c2"></span>
  /// Alpha: 100% <br/> (0x50d2c2ff)
  static let n1ColorBg = ColorName(rgbaValue: 0x50d2c2ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#d667cd"></span>
  /// Alpha: 100% <br/> (0xd667cdff)
  static let n2ColorBg = ColorName(rgbaValue: 0xd667cdff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#fc3768"></span>
  /// Alpha: 100% <br/> (0xfc3768ff)
  static let n3ColorBg = ColorName(rgbaValue: 0xfc3768ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ffc000"></span>
  /// Alpha: 100% <br/> (0xffc000ff)
  static let n4ColorBg = ColorName(rgbaValue: 0xffc000ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#00b9ff"></span>
  /// Alpha: 100% <br/> (0x00b9ffff)
  static let n5ColorBg = ColorName(rgbaValue: 0x00b9ffff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#6563a4"></span>
  /// Alpha: 100% <br/> (0x6563a4ff)
  static let tipsColorBg = ColorName(rgbaValue: 0x6563a4ff)
}
// swiftlint:enable identifier_name line_length type_body_length

extension Color {
  convenience init(named color: ColorName) {
    self.init(rgbaValue: color.rgbaValue)
  }
}
