// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable file_length

// swiftlint:disable explicit_type_interface identifier_name line_length nesting type_body_length type_name
enum L10n {

  enum Data {

    enum Hintcell {
      /// Tổng hợp các mẹo hữu ích khi thi JLPT
      static let description = L10n.tr("Localizable", "data.hintcell.description")
      /// Mẹo luyện thi JLPT
      static let title = L10n.tr("Localizable", "data.hintcell.title")
    }

    enum N1 {
      /// Tổng hợp đề luyện thi cấp độ N1
      static let description = L10n.tr("Localizable", "data.n1.description")
      /// Thượng cấp N1
      static let title = L10n.tr("Localizable", "data.n1.title")
    }

    enum N2 {
      /// Tổng hợp đề luyện thi cấp độ N2
      static let description = L10n.tr("Localizable", "data.n2.description")
      /// Thượng cấp N2
      static let title = L10n.tr("Localizable", "data.n2.title")
    }

    enum N3 {
      /// Tổng hợp đề luyện thi cấp độ N3
      static let description = L10n.tr("Localizable", "data.n3.description")
      /// Trung cấp N3
      static let title = L10n.tr("Localizable", "data.n3.title")
    }

    enum N4 {
      /// Tổng hợp đề luyện thi cấp độ N4
      static let description = L10n.tr("Localizable", "data.n4.description")
      /// Sơ cấp N4
      static let title = L10n.tr("Localizable", "data.n4.title")
    }

    enum N5 {
      /// Tổng hợp đề luyện thi cấp độ N5
      static let description = L10n.tr("Localizable", "data.n5.description")
      /// Sơ cấp N5
      static let title = L10n.tr("Localizable", "data.n5.title")
    }
  }

  enum Jlpt {

    enum `Type` {
      /// Ngữ pháp
      static let grammar = L10n.tr("Localizable", "jlpt.type.grammar")
      /// Hán tự
      static let kanji = L10n.tr("Localizable", "jlpt.type.kanji")
      /// Nghe hiểu
      static let listening = L10n.tr("Localizable", "jlpt.type.listening")
      /// Đọc hiểu
      static let reading = L10n.tr("Localizable", "jlpt.type.reading")
      /// Từ vựng
      static let vocabulary = L10n.tr("Localizable", "jlpt.type.vocabulary")
    }
  }

  enum Lesson {

    enum Screen {
      /// Bài học
      static let title = L10n.tr("Localizable", "lesson.screen.title")
    }
  }

  enum Level {
    /// JLPT N1
    static let n1 = L10n.tr("Localizable", "level.n1")
    /// JLPT N2
    static let n2 = L10n.tr("Localizable", "level.n2")
    /// JLPT N3
    static let n3 = L10n.tr("Localizable", "level.n3")
    /// JLPT N4
    static let n4 = L10n.tr("Localizable", "level.n4")
    /// JLPT N5
    static let n5 = L10n.tr("Localizable", "level.n5")
  }

  enum Login {

    enum Button {
      /// Đăng nhập
      static let title = L10n.tr("Localizable", "login.button.title")
    }

    enum Label {
      /// Đăng nhập
      static let title = L10n.tr("Localizable", "login.label.title")
    }

    enum Noaccount {
      /// Bạn chưa có tài khoản
      static let label = L10n.tr("Localizable", "login.noaccount.label")
    }

    enum Skip {
      /// Đăng ký sau
      static let label = L10n.tr("Localizable", "login.skip.label")
    }

    enum Social {
      /// Đăng nhập bằng tài khoản
      static let label = L10n.tr("Localizable", "login.social.label")
    }
  }

  enum Register {
    /// Đăng ký tài khoản
    static let title = L10n.tr("Localizable", "register.title")

    enum Button {
      /// Đăng ký
      static let title = L10n.tr("Localizable", "register.button.title")
    }

    enum Email {
      /// Nhập email
      static let placeholder = L10n.tr("Localizable", "register.email.placeholder")
    }

    enum Name {
      /// Tên hiển thị
      static let placeholder = L10n.tr("Localizable", "register.name.placeholder")
    }

    enum Pass {
      /// Nhập mật khẩu
      static let placeholder = L10n.tr("Localizable", "register.pass.placeholder")
    }

    enum Repass {
      /// Xác nhận mật khẩu
      static let placeholder = L10n.tr("Localizable", "register.repass.placeholder")
    }
  }

  enum Tab {

    enum Chatroom {
      /// Trò chuyện
      static let title = L10n.tr("Localizable", "tab.chatroom.title")
    }

    enum Document {
      /// Tài liệu
      static let title = L10n.tr("Localizable", "tab.document.title")
    }

    enum Lesson {
      /// Bài học
      static let title = L10n.tr("Localizable", "tab.lesson.title")
    }

    enum Profile {
      /// Tài khoản
      static let title = L10n.tr("Localizable", "tab.profile.title")
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
