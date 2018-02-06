//
//  ListDocumentOfTypeController.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/10/22.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit

class ListDocumentOfTypeController: UIViewController {
    var level: LevelJLPT!
    var type: TypeJLPT!
    fileprivate let cellId = "documentCell"
    @IBOutlet weak var tableView: UITableView!
    private var documents: [DocumentReponse] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Danh sách giáo trình"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(rgb: 0xEBECF1)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchDocumentsData()
    }

    private func fetchDocumentsData() {
        startAnimationLoading()
        let request = DocumentRequest(type: type, level: level)
        ApiClient.instance.request(request: request, completion: { response in
            self.stopAnimationLoading()
            switch response {
            case .success(let value):
                self.documents = value.documents
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}

extension ListDocumentOfTypeController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return documents.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? DocumentCell else {
            return UITableViewCell()
        }
        cell.document = documents[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let documentUrl = documents[indexPath.row].linkDocument
        let vc = StoryboardScene.ShowDocumentViewController.showDocumentViewController.instantiate()
        vc.documentUrl = documentUrl
        navigationController?.pushViewController(vc, animated: true)
    }
}
