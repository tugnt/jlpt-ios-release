//
//  LessonModel.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/10/27.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import Foundation

class LessonModel {
    static var lessonModel: [Section] = {
        /// Tips section
        let categoriesTip =
            [LessonCategory(itemLessons:
                [ItemLesson(title: "Đọc hiểu", image: Asset.reading.image, typeLesson: .tip, typeJLPT: .reading, level: nil, isHaveRightLine: true, isHaveLeftLine: false),
                 ItemLesson(title: "Ngữ pháp", image: Asset.grammar.image, typeLesson: .tip, typeJLPT: .grammar, level: nil, isHaveRightLine: true, isHaveLeftLine: true),
                 ItemLesson(title: "Từ vựng", image: Asset.kanji.image, typeLesson: .tip, typeJLPT: .vocabulary, level: nil, isHaveRightLine: false, isHaveLeftLine: true)]),
             LessonCategory(itemLessons:
                [ItemLesson(title: "Nghe hiểu", image: Asset.listening.image, typeLesson: .tip, typeJLPT: .listening, level: nil, isHaveRightLine: true, isHaveLeftLine: false),
                 ItemLesson(title: "Kanji", image: Asset.kanji.image, typeLesson: .tip, typeJLPT: .kanji, level: nil, isHaveRightLine: false, isHaveLeftLine: true)])]
        let headerTips = CategoryHeader(sectionColor: ColorName.tipsColorBg.color, title: "Mẹo luyện thi JLPT", detailDescription: "Tổng hợp các mẹo hữu ích khi thi JLPT", sectionImage: Asset.tips.image, isExpanded: false)
        let sectionTip = Section(header: headerTips, categories: categoriesTip)

        /// N1 section
        let categoryN1 = [LessonCategory(itemLessons:
            [ItemLesson(title: "Đọc hiểu", image: Asset.reading.image, typeLesson: .jlpt, typeJLPT: .reading, level: .n1, isHaveRightLine: true, isHaveLeftLine: false),
             ItemLesson(title: "Ngữ pháp", image: Asset.grammar.image, typeLesson: .jlpt, typeJLPT: .grammar, level: .n1, isHaveRightLine: true, isHaveLeftLine: true),
             ItemLesson(title: "Nghe hiểu", image: Asset.kanji.image, typeLesson: .jlpt, typeJLPT: .vocabulary, level: .n1, isHaveRightLine: true, isHaveLeftLine: true),
             ItemLesson(title: "Từ vựng", image: Asset.kanji.image, typeLesson: .jlpt, typeJLPT: .vocabulary, level: .n1, isHaveRightLine: false, isHaveLeftLine: true)])]
        let headerN1 = CategoryHeader(sectionColor: ColorName.n1ColorBg.color, title: "Thượng cấp N1", detailDescription: "Tổng hợp đề luyện thi cấp độ N1", sectionImage: Asset.n1.image, isExpanded: false)
        let sectionN1 = Section(header: headerN1, categories: categoryN1)

        /// N2 section
        let categoryN2 = [LessonCategory(itemLessons:
            [ItemLesson(title: "Đọc hiểu", image: Asset.reading.image, typeLesson: .jlpt, typeJLPT: .reading, level: .n2, isHaveRightLine: true, isHaveLeftLine: false),
             ItemLesson(title: "Ngữ pháp", image: Asset.grammar.image, typeLesson: .jlpt, typeJLPT: .grammar, level: .n2, isHaveRightLine: true, isHaveLeftLine: true),
             ItemLesson(title: "Nghe hiểu", image: Asset.kanji.image, typeLesson: .jlpt, typeJLPT: .vocabulary, level: .n2, isHaveRightLine: true, isHaveLeftLine: true),
             ItemLesson(title: "Từ vựng", image: Asset.kanji.image, typeLesson: .jlpt, typeJLPT: .vocabulary, level: .n2, isHaveRightLine: false, isHaveLeftLine: true)])]
        let headerN2 = CategoryHeader(sectionColor: ColorName.n2ColorBg.color, title: "Thượng cấp N2", detailDescription: "Tổng hợp đề luyện thi cấp độ N2", sectionImage: Asset.n2.image, isExpanded: false)
        let sectionN2 = Section(header: headerN2, categories: categoryN2)

        /// N3 section
        let categoryN3 = [LessonCategory(itemLessons:
            [ItemLesson(title: "Đọc hiểu", image: Asset.reading.image, typeLesson: .jlpt, typeJLPT: .reading, level: .n3, isHaveRightLine: true, isHaveLeftLine: false),
             ItemLesson(title: "Ngữ pháp", image: Asset.grammar.image, typeLesson: .jlpt, typeJLPT: .grammar, level: .n3, isHaveRightLine: true, isHaveLeftLine: true),
             ItemLesson(title: "Nghe hiểu", image: Asset.kanji.image, typeLesson: .jlpt, typeJLPT: .vocabulary, level: .n3, isHaveRightLine: true, isHaveLeftLine: true),
             ItemLesson(title: "Từ vựng", image: Asset.kanji.image, typeLesson: .jlpt, typeJLPT: .vocabulary, level: .n3, isHaveRightLine: false, isHaveLeftLine: true)])]
        let headerN3 = CategoryHeader(sectionColor: ColorName.n3ColorBg.color, title: "Trung cấp N3", detailDescription: "Tổng hợp đề luyện thi cấp độ N3", sectionImage: Asset.n3.image, isExpanded: false)
        let sectionN3 = Section(header: headerN3, categories: categoryN3)

        /// N4 section
        let categoryN4 = [LessonCategory(itemLessons:
            [ItemLesson(title: "Đọc hiểu", image: Asset.reading.image, typeLesson: .jlpt, typeJLPT: .reading, level: .n4, isHaveRightLine: true, isHaveLeftLine: false),
             ItemLesson(title: "Ngữ pháp", image: Asset.grammar.image, typeLesson: .jlpt, typeJLPT: .grammar, level: .n4, isHaveRightLine: true, isHaveLeftLine: true),
             ItemLesson(title: "Nghe hiểu", image: Asset.kanji.image, typeLesson: .jlpt, typeJLPT: .vocabulary, level: .n4, isHaveRightLine: true, isHaveLeftLine: true),
             ItemLesson(title: "Từ vựng", image: Asset.kanji.image, typeLesson: .jlpt, typeJLPT: .vocabulary, level: .n4, isHaveRightLine: false, isHaveLeftLine: true)])]
        let headerN4 = CategoryHeader(sectionColor: ColorName.n4ColorBg.color, title: "Sơ cấp N4", detailDescription: "Tổng hợp đề luyện thi cấp độ N4", sectionImage: Asset.n4.image, isExpanded: false)
        let sectionN4 = Section(header: headerN4, categories: categoryN4)

        /// N5 section
        let categoryN5 = [LessonCategory(itemLessons:
            [ItemLesson(title: "Đọc hiểu", image: Asset.reading.image, typeLesson: .jlpt, typeJLPT: .reading, level: .n5, isHaveRightLine: true, isHaveLeftLine: false),
             ItemLesson(title: "Ngữ pháp", image: Asset.grammar.image, typeLesson: .jlpt, typeJLPT: .grammar, level: .n5, isHaveRightLine: true, isHaveLeftLine: true),
             ItemLesson(title: "Nghe hiểu", image: Asset.kanji.image, typeLesson: .jlpt, typeJLPT: .vocabulary, level: .n5, isHaveRightLine: true, isHaveLeftLine: true),
             ItemLesson(title: "Từ vựng", image: Asset.kanji.image, typeLesson: .jlpt, typeJLPT: .vocabulary, level: .n5, isHaveRightLine: false, isHaveLeftLine: true)])]
        let headerN5 = CategoryHeader(sectionColor: ColorName.n5ColorBg.color, title: "Sơ cấp N5", detailDescription: "Tổng hợp đề luyện thi cấp độ N5", sectionImage: Asset.n5.image, isExpanded: false)
        let sectionN5 = Section(header: headerN5, categories: categoryN5)

        return [sectionTip, sectionN1, sectionN2, sectionN3, sectionN4, sectionN5]
    }()
}
