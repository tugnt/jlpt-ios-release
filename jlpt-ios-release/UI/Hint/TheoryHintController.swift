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
    var type: TypeJLPT!
    var content: String?
    var questions: [HintQuestionModel] = []
    private let mdView = MarkdownView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBar()
        self.title = "Lý thuyết"
        self.addMarkdownView()
        self.loadContent()
        self.addExerciseButton()
    }
    
    private func addMarkdownView() {
        view.addSubview(mdView)
        mdView.translatesAutoresizingMaskIntoConstraints = false
        mdView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-50)
        }
    }
    
    private func loadContent() {
        guard let content = self.content else {
            addEmptyStateView()
            return
        }
        startAnimationLoading()
        mdView.load(markdown: content, enableImage: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
            self.stopAnimationLoading()
        })
    }
    
    private func addExerciseButton() {
        let exerciseButton = UIButton()
        view.addSubview(exerciseButton)
        exerciseButton.snp.makeConstraints { make in
            make.width.equalTo(view.snp.width).offset(-50)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-5)
            make.centerX.equalToSuperview()
        }
        exerciseButton.setTitle("Luyện tập", for: .normal)
        exerciseButton.setUpPrimaryButton()
        exerciseButton.addTarget(self, action: #selector(moveQuestionScreen), for: .touchUpInside)
    }

    @objc private func moveQuestionScreen() {
        var normalQuestions: [NormalQuestionViewModel] = []
        normalQuestions = questions.map { NormalQuestionViewModel(question: $0.question,
                                                                  answerA: $0.answerA,
                                                                  answerB: $0.answerB,
                                                                  answerC: $0.answerC,
                                                                  answerD: $0.answerD,
                                                                  solution: $0.solution,
                                                                  linkAudio: $0.audioUrl) }
        type == .listening ? moveListeningQuestionScreen() : moveNormalQuestionScreen(normalQuestions: normalQuestions)
    }

    private func moveListeningQuestionScreen() {
        let vc = StoryboardScene.ListeningQuestion.listeningQuestionController.instantiate()
        // Check if question.count == 0 will be show alert and do nothing.
        if questions.isEmpty {
            self.showAlertDialog(title: "Thông báo", content: "Hiện chưa có câu hỏi cho phần này. Chúng tôi sẽ cập nhật sau.", titleButton: "OK", cancelAction: { return })
        }
        vc.questions = questions
        navigationController?.pushViewController(vc, animated: true)
    }

    private func moveNormalQuestionScreen(normalQuestions: [NormalQuestionViewModel]) {
        let vc = StoryboardScene.NomalQuestion.nomalQuestionController.instantiate()
        self.reductionCoins()
        vc.questions = normalQuestions
        navigationController?.pushViewController(vc, animated: true)
    }
}
