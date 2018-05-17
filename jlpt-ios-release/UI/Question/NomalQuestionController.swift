//
//  NomalQuestionController.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/10/08.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit
import GoogleMobileAds

class NomalQuestionController: AdmobsViewController {
    var questions: [NormalQuestionViewModel] = [] {
        didSet {
            for _ in questions { solutionOfUser.append(5) }
        }
    }
    @IBOutlet weak var tableView: UITableView!
    private let cellId = "cellQuestion"
    private var solutionOfUser: [Int] = []
    private var point: Int = 0
    private var doneButton: UIBarButtonItem!
    var isShowSolution: Bool = false
    var isHasDoneButton: Bool = true
    var needLoadRequest: Bool = false
    var level: LevelJLPT!
    var unit: String!
    var type: TypeJLPT!
    // For admob

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBar()
        self.title = "Luyện tập"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .clear
        tableView.allowsSelection = false
        for _ in questions { solutionOfUser.append(5) }
        self.loadAdsVideo()
        // - Init array solution
        if questions.count == 0 {
            tableView.isHidden = true
            addEmptyStateView()
        }
        isHasDoneButton ? addBarDoneButton() : ()
        neededLoadRequest()
    }
    
    private func neededLoadRequest() {
        if needLoadRequest {
            startAnimationLoading()
            let request = QuestionRequest(type: type, level: level, unit: unit)
            ApiClient.instance.request(request: request, completion: { (response) in
                print(response)
                switch response {
                case .success(let value):
                    let normalQuestion = self.convertViewModelObject(questions: value)
                    self.questions = normalQuestion.reversed()
                    self.stopAnimationLoading()
                    if self.questions.count != 0 {
                        self.tableView.isHidden = false
                        self.removeEmptyStateView()
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                case .failure:
                    break
                }
            })
        }
    }

    private func convertViewModelObject(questions: JLPTQuestionResponse) -> [NormalQuestionViewModel] {
        var normalQuestions: [NormalQuestionViewModel] = []
        for item in questions.jlptQuestion {
            let question = NormalQuestionViewModel(question: item.question, answerA: item.answerA, answerB: item.answerB, answerC: item.answerC,
                                                   answerD: item.answerD, solution: item.solution, linkAudio: item.linkAudio as? String)
            normalQuestions.append(question)
        }
        return normalQuestions
    }

    private func addBarDoneButton() {
        doneButton = UIBarButtonItem(title: "Hoàn thành", style: .done, target: self, action: #selector(checkAnswer))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc private func checkAnswer() {
        for index in 0..<questions.count {
            if Int(questions[index].solution) == solutionOfUser[index] {
                point += 1
            }
        }
        let confirmDialog = TDConfirmDialog(frame: view.bounds)
        confirmDialog.set(title: "Kết quả")
        confirmDialog.set(message: "Bạn trả lời đúng \(point) / \(questions.count) câu hỏi.")
        confirmDialog.cancelButtonTitle = "Huỷ"
        confirmDialog.confirmButtonTitle = "Xem kết quả"
        view.addSubview(confirmDialog)
        confirmDialog.confirmDidSelected = {
            self.point = 0
            self.isShowSolution = true
            self.tableView.reloadData()
            self.presentRewardAdVideo()
        }
        confirmDialog.cancelDidSelected = {
            self.presentRewardAdVideo()
        }
    }
}

extension NomalQuestionController: UITableViewDelegate, UITableViewDataSource, NormalQuestionCellDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? NomalQuestionCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        cell.isShowSolution = isShowSolution
        cell.normalQuestion = questions[indexPath.row]
        cell.showAnswerOfUser(ofUser: solutionOfUser[indexPath.row])
        return cell
    }

    func radioClicked(_ indexButton: Int, didSelected: NomalQuestionCell) {
        guard let indexPath = tableView.indexPath(for: didSelected) else { return }
        solutionOfUser[indexPath.row] = indexButton
    }
}
