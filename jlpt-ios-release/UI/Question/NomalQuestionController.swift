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
    var isShowSolution: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Luyện tập"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .clear
        tableView.allowsSelection = false
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
        _ = tableView.indexPath(for: didSelected)
    }
}
