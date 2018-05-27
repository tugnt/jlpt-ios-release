//
//  ListDocumentViewController.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/10/22.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit
import Alamofire
import Foundation

class ListDocumentViewController: UIViewController {
    var level: Int!
    var type: TypeJLPT!
    var isExam: Bool!
    fileprivate let cellId = "documentCell"
    @IBOutlet weak var tableView: UITableView!
    private var documents: [DocumentReponse] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Danh sách giáo trình"
        self.setUpNavBar()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = #colorLiteral(red: 0.9219999909, green: 0.9250000119, blue: 0.9449999928, alpha: 1)
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchDocumentsData()
    }

    private func fetchDocumentsData() {
        startAnimationLoading()
        let typeValue = isExam ? "Exam" : type.rawValue
        let request = DocumentRequest(type: typeValue, level: level)
        ApiClient.instance.request(request: request, completion: { response in
            self.stopAnimationLoading()
            switch response {
            case .success(let value):
                self.documents = value.documents
                if value.documents.isEmpty {
                    self.tableView.isHidden = true
                    self.addEmptyStateView()
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                self.tableView.isHidden = true
                self.addEmptyStateView()
                print(error.localizedDescription)
            }
        })
    }

    private func showCheckDownloadDialog(indexPath: IndexPath, cell: DocumentCell) {
        let documentUrl = documents[indexPath.row].linkDocument
        let fileExits = FileHelper.checkFileExits(documentUrl: documentUrl)
        if fileExits {
            let fileSavePath = FileHelper.createDocumentSavePath(documentUrl: documentUrl)
            self.moveDetailDocumentViewController(documentUrl: fileSavePath, fileName: self.documents[indexPath.row].jpName)
        } else {
            let confirmDialog = TDConfirmDialog(frame: self.view.bounds)
            confirmDialog.set(title: "Thông báo")
            confirmDialog.set(message: "Bạn phải download tài liệu trước khi xem.")
            confirmDialog.cancelButtonTitle = "Huỷ"
            confirmDialog.confirmButtonTitle = "Download"
            confirmDialog.confirmDidSelected = {
                cell.addLoadingView()
                self.downloadDocument(documentUrl: self.documents[indexPath.row].linkDocument, cell: cell, fileName: self.documents[indexPath.row].jpName)
            }
            self.view.addSubview(confirmDialog)
        }
    }

    private func downloadDocument(documentUrl: String, cell: DocumentCell, fileName: String) {
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            let savePath = FileHelper.createDocumentSavePath(documentUrl: documentUrl)
            return (savePath, [.removePreviousFile, .createIntermediateDirectories])
        }
        Alamofire.download(documentUrl, to: destination).response { response in
            if response.error == nil, let pdfPath = response.destinationURL {
                self.moveDetailDocumentViewController(documentUrl: pdfPath, fileName: fileName)
            }
        }
    }
    
    private func moveDetailDocumentViewController(documentUrl: URL, fileName: String) {
        let vc = StoryboardScene.ShowDocumentViewController.showDocumentViewController.instantiate()
        vc.documentUrl = documentUrl
        vc.title = fileName
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ListDocumentViewController: UITableViewDataSource, UITableViewDelegate {
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
        cell.downloadDocumentProgress = {
            self.showCheckDownloadDialog(indexPath: indexPath, cell: cell)
        }
        cell.selectionStyle = .none
        return cell
    }
}
