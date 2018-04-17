//
//  ListDocumentOfTypeController.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/10/22.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit
import Alamofire
import Foundation

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
        showCheckDownloadDialog(indexPath: indexPath)
    }

    private func showCheckDownloadDialog(indexPath: IndexPath) {
        let confirmDialog = TDConfirmDialog(frame: self.view.bounds)
        confirmDialog.set(title: "Thông báo")
        confirmDialog.set(message: "Bạn phải download tài liệu trước khi xem.")
        confirmDialog.cancelButtonTitle = "Cancel"
        confirmDialog.confirmButtonTitle = "Download"
        confirmDialog.confirmDidSelected = {
            self.downloadDocument(documentUrl: "https://www.rhodeshouse.ox.ac.uk/media/1002/sample-pdf-file.pdf")
        }
        self.view.addSubview(confirmDialog)
    }

    private func downloadDocument(documentUrl: String) {
        let fileExits = FileHelper.checkFileExits(documentUrl: documentUrl)
        if fileExits {
            let fileSavePath = FileHelper.createDocumentSavePath(documentUrl: documentUrl)
            let vc = StoryboardScene.ShowDocumentViewController.showDocumentViewController.instantiate()
            vc.documentUrl = fileSavePath
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let destination: DownloadRequest.DownloadFileDestination = { _, _ in
                let savePath = FileHelper.createDocumentSavePath(documentUrl: documentUrl)
                return (savePath, [.removePreviousFile, .createIntermediateDirectories])
            }
            Alamofire.download(documentUrl, to: destination).response { response in
                if response.error == nil, let pdfPath = response.destinationURL {
                    let confirmDialog = TDConfirmDialog(frame: self.view.bounds)
                    confirmDialog.set(title: "Thông báo")
                    confirmDialog.set(message: "Đã tải xong tài liệu.")
                    confirmDialog.cancelButtonTitle = "Huỷ"
                    confirmDialog.confirmButtonTitle = "Xem"
                    confirmDialog.confirmDidSelected = {
                        let vc = StoryboardScene.ShowDocumentViewController.showDocumentViewController.instantiate()
                        vc.documentUrl = pdfPath
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                    self.view.addSubview(confirmDialog)
                }
            }
        }
    }
}
