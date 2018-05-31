// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// swiftlint:disable explicit_type_interface identifier_name line_length nesting type_body_length type_name
internal enum L10n {

  internal enum Data {

    internal enum Hintcell {
      /// Tổng hợp các mẹo hữu ích khi thi JLPT
      internal static let description = L10n.tr("Localizable", "data.hintcell.description")
      /// Mẹo luyện thi JLPT
      internal static let title = L10n.tr("Localizable", "data.hintcell.title")
    }

    internal enum N1 {
      /// Tổng hợp đề luyện thi cấp độ N1
      internal static let description = L10n.tr("Localizable", "data.n1.description")
      /// Thượng cấp N1
      internal static let title = L10n.tr("Localizable", "data.n1.title")
    }

    internal enum N2 {
      /// Tổng hợp đề luyện thi cấp độ N2
      internal static let description = L10n.tr("Localizable", "data.n2.description")
      /// Thượng cấp N2
      internal static let title = L10n.tr("Localizable", "data.n2.title")
    }

    internal enum N3 {
      /// Tổng hợp đề luyện thi cấp độ N3
      internal static let description = L10n.tr("Localizable", "data.n3.description")
      /// Trung cấp N3
      internal static let title = L10n.tr("Localizable", "data.n3.title")
    }

    internal enum N4 {
      /// Tổng hợp đề luyện thi cấp độ N4
      internal static let description = L10n.tr("Localizable", "data.n4.description")
      /// Sơ cấp N4
      internal static let title = L10n.tr("Localizable", "data.n4.title")
    }

    internal enum N5 {
      /// Tổng hợp đề luyện thi cấp độ N5
      internal static let description = L10n.tr("Localizable", "data.n5.description")
      /// Sơ cấp N5
      internal static let title = L10n.tr("Localizable", "data.n5.title")
    }
  }

  internal enum Jlpt {

    internal enum `Type` {
      /// Ngữ pháp
      internal static let grammar = L10n.tr("Localizable", "jlpt.type.grammar")
      /// Hán tự
      internal static let kanji = L10n.tr("Localizable", "jlpt.type.kanji")
      /// Nghe hiểu
      internal static let listening = L10n.tr("Localizable", "jlpt.type.listening")
      /// Đọc hiểu
      internal static let reading = L10n.tr("Localizable", "jlpt.type.reading")
      /// Từ vựng
      internal static let vocabulary = L10n.tr("Localizable", "jlpt.type.vocabulary")
    }
  }

  internal enum Lesson {

    internal enum Screen {
      /// Bài học
      internal static let title = L10n.tr("Localizable", "lesson.screen.title")
    }
  }

  internal enum Level {
    /// JLPT N1
    internal static let n1 = L10n.tr("Localizable", "level.n1")
    /// JLPT N2
    internal static let n2 = L10n.tr("Localizable", "level.n2")
    /// JLPT N3
    internal static let n3 = L10n.tr("Localizable", "level.n3")
    /// JLPT N4
    internal static let n4 = L10n.tr("Localizable", "level.n4")
    /// JLPT N5
    internal static let n5 = L10n.tr("Localizable", "level.n5")
  }

  internal enum Login {

    internal enum Button {
      /// Đăng nhập
      internal static let title = L10n.tr("Localizable", "login.button.title")
    }

    internal enum Label {
      /// Đăng nhập
      internal static let title = L10n.tr("Localizable", "login.label.title")
    }

    internal enum Noaccount {
      /// Bạn chưa có tài khoản
      internal static let label = L10n.tr("Localizable", "login.noaccount.label")
    }

    internal enum Skip {
      /// Đăng ký sau
      internal static let label = L10n.tr("Localizable", "login.skip.label")
    }

    internal enum Social {
      /// Đăng nhập bằng tài khoản
      internal static let label = L10n.tr("Localizable", "login.social.label")
    }
  }

  internal enum Register {
    /// Đăng ký tài khoản
    internal static let title = L10n.tr("Localizable", "register.title")

    internal enum Button {
      /// Đăng ký
      internal static let title = L10n.tr("Localizable", "register.button.title")
    }

    internal enum Email {
      /// Nhập email
      internal static let placeholder = L10n.tr("Localizable", "register.email.placeholder")
    }

    internal enum Name {
      /// Tên hiển thị
      internal static let placeholder = L10n.tr("Localizable", "register.name.placeholder")
    }

    internal enum Pass {
      /// Nhập mật khẩu
      internal static let placeholder = L10n.tr("Localizable", "register.pass.placeholder")
    }

    internal enum Repass {
      /// Xác nhận mật khẩu
      internal static let placeholder = L10n.tr("Localizable", "register.repass.placeholder")
    }
  }

  internal enum Tab {

    internal enum Chatroom {
      /// Trò chuyện
      internal static let title = L10n.tr("Localizable", "tab.chatroom.title")
    }

    internal enum Document {
      /// Tài liệu
      internal static let title = L10n.tr("Localizable", "tab.document.title")
    }

    internal enum Lesson {
      /// Bài học
      internal static let title = L10n.tr("Localizable", "tab.lesson.title")
    }

    internal enum Profile {
      /// Tài khoản
      internal static let title = L10n.tr("Localizable", "tab.profile.title")
    }
  }
}
// swiftlint:enable explicit_type_interface identifier_name line_length nesting type_body_length type_name

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
