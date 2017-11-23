//
//  NomalQuestionController.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/10/08.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit

class NomalQuestionController: UIViewController {
    var questions: [NormalQuestionViewModel] = []
    @IBOutlet weak var tableView: UITableView!
    let cellId = "cellQuestion"
    var isShowSolution: Bool = false
    var solutionOfUser: [Int] = []
    var point: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBar()
        self.title = "Luyện tập"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .clear
        tableView.allowsSelection = false
        // - Init array solution
        for _ in questions { solutionOfUser.append(5) }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if questions.count == 0 {
            tableView.isHidden = true
            addEmptyStateView()
        } else {
            addRightBarButton()
        }
    }

    func addRightBarButton() {
        let rightBarButton = UIBarButtonItem(title: "Hoàn thành", style: .done, target: self, action: #selector(checkAnswer))
        navigationItem.rightBarButtonItem = rightBarButton
    }

    @objc func checkAnswer() {
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
            self.isShowSolution = true
            self.tableView.reloadData()
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
        return cell
    }

    func radioClicked(_ indexButton: Int, didSelected: NomalQuestionCell) {
        guard let indexPath = tableView.indexPath(for: didSelected) else { return }
        solutionOfUser[indexPath.row] = indexButton
    }
}
