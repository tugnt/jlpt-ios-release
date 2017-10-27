//
//  ListHintController.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/10/01.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit

struct HintTableData {
    let listHint: [HintViewModel]
    init(response: JLPTHintResponse) {
        var tmpArr: [HintViewModel] = []
        for item in response.hints {
            tmpArr.append(HintViewModel(response: item))
        }
        self.listHint = tmpArr
    }
}
class ListHintController: UIViewController {
    var type: TypeJLPT?
    let cellId = "cellHint"
    @IBOutlet weak var tableView: UITableView!
    var listHint: [HintViewModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .clear
        //fetchHintData()
    }

    func fetchHintData() {
        guard let type = self.type else { return }
        _ = HintRequest(type: type)
//        ApiClient.instance.request(request: request, g: { (result) in
//            switch result {
//            case .success(let response):
//                let tableData = HintTableData(response: response)
//                self.listHint = tableData.listHint
//                print(self.listHint.count)
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//            case .failure:
//                // Send error and show image empty
//                break
//            }
//        })
    }
}

extension ListHintController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? HintCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        //cell.hintItem = listHint[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = StoryboardScene.TheoryHint.theoryHintController.instantiate()
        navigationController?.pushViewController(vc, animated: true)
    }
}
