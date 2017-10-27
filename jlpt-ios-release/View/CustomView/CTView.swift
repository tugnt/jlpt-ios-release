//
//  CTView.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/10/08.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//
/*
     Class này sẽ sử dụng core text để hiện thị các văn bản. Nó sẽ cung cấp các chức năng để làm việc
     Để sau này hiểu rõ hơn, thì phần này sẽ comment bằng tiếng Việt, nếu có thể sẽ dùng cả tiếng anh
     Link: https://www.raywenderlich.com/153591/core-text-tutorial-ios-making-magazine-app
*/

import UIKit
import CoreText

class CTView: UIView {

    override func draw(_ rect: CGRect) {
        // - Unwrap context graphic hiện tại, để sử dụng trong phần này
        guard let context = UIGraphicsGetCurrentContext() else { return }
        // Khi render sử dụng context thì nó sẽ sử dụng hệ toạ độ khác. Vì vậy nó sẽ ko còn chính xác, do đo ta phải setting ở đây.
        // Flip the coordinate system
        context.textMatrix = .identity
        context.translateBy(x: 0, y: bounds.height)
        context.scaleBy(x: 1.0, y: -1.0)

        // - Tạo path xung quanh screen
        let path = CGMutablePath()
        // - Trong trường hợp này là toàn bộ màn hình
        path.addRect(bounds)

        // - Trong context bạn sẽ phải sử dụng NSAttribuedString thay cho String hay NSString, vì nó sẽ lưu dữ các thuộc tính mà bạn sẽ phải thiết đặt
        let arrString = NSAttributedString(string: "Hello world")
        // - frameSetter chủ yếu sẽ quản lý Font và render ra khung hình
        let frameSetter = CTFramesetterCreateWithAttributedString(arrString as CFAttributedString)
        // - Tạo một CTFrame bởi là CTFramesetterCreateFrame sẽ bắt đầu render string trong path (Chính là toàn màn hình)
        let frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, arrString.length), path, nil)
        // - Vẽ frame và truyền vào một context
        CTFrameDraw(frame, context)
    }

}
