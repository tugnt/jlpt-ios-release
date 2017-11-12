//
//  TheoryHintController.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/10/06.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit
import MarkdownView

class TheoryHintController: UIViewController {
    var content: String?
    var questions: [HintQuestionModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Lý thuyết"
        let mdView = MarkdownView()
        view.addSubview(mdView)
        mdView.translatesAutoresizingMaskIntoConstraints = false
        mdView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-50)
        }
        guard let content = self.content else {
            addEmptyStateView()
            return
        }
        startAnimationLoading()
        mdView.load(markdown: content, enableImage: true)
        let transitionButton = UIButton()
        view.addSubview(transitionButton)
        transitionButton.snp.makeConstraints { make in
            make.width.equalTo(view.snp.width).offset(-50)
            make.height.equalTo(42)
            make.bottom.equalToSuperview().offset(-5)
            make.centerX.equalToSuperview()
        }
        transitionButton.setTitle("Luyện tập", for: .normal)
        transitionButton.setUpPrimaryButton()
        transitionButton.addTarget(self, action: #selector(moveQuestionScreen), for: .touchUpInside)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
            self.stopAnimationLoading()
        })
    }

    @objc func moveQuestionScreen() {
        let vc = StoryboardScene.NomalQuestion.nomalQuestionController.instantiate()
        var normalQuestions: [NormalQuestionViewModel] = []
        for item in questions {
            normalQuestions.append(NormalQuestionViewModel(question: item.question,
                                                          answerA: item.answerA,
                                                          answerB: item.answerB,
                                                          answerC: item.answerC,
                                                          answerD: item.answerD,
                                                          solution: item.solution,
                                                          linkAudio: item.linkAudio))
        }
        vc.questions = normalQuestions
        navigationController?.pushViewController(vc, animated: true)
    }
}
