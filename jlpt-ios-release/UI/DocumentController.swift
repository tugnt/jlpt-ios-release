//
//  DocumentController.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/10/14.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit

class DocumentController: UIViewController {
    fileprivate let cellId = "cellDocument"
    @IBOutlet weak var tableView: UITableView!

    lazy var headerSection: [DocumentHeader] = {
        let headerN1 = DocumentHeader(color: ColorName.n1ColorBg.color, image: Asset.n1.image, title: "JLPT N1", titleNumberDocument: "", isExpanded: true, level: .n1)
        let headerN2 = DocumentHeader(color: ColorName.n2ColorBg.color, image: Asset.n2.image, title: "JLPT N2", titleNumberDocument: "", isExpanded: false, level: .n2)
        let headerN3 = DocumentHeader(color: ColorName.n3ColorBg.color, image: Asset.n3.image, title: "JLPT N3", titleNumberDocument: "", isExpanded: false, level: .n3)
        let headerN4 = DocumentHeader(color: ColorName.n4ColorBg.color, image: Asset.n4.image, title: "JLPT N4", titleNumberDocument: "", isExpanded: false, level: .n4)
        let headerN5 = DocumentHeader(color: ColorName.n5ColorBg.color, image: Asset.n5.image, title: "JLPT N5", titleNumberDocument: "", isExpanded: false, level: .n5)
        return [headerN1, headerN2, headerN3, headerN4, headerN5]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Tài liệu"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.tableFooterView = UIView()
        tableView.register(DocumentExpandHeaderView.nib, forHeaderFooterViewReuseIdentifier: DocumentExpandHeaderView.identifier)
        tableView.register(DocumentTypeCell.nib, forCellReuseIdentifier: DocumentTypeCell.identifier)
    }

}

extension DocumentController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return headerSection.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headerSection[section].isExpanded ? 1 : 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DocumentTypeCell.identifier, for: indexPath) as? DocumentTypeCell else {
            return UITableViewCell()
        }
        cell.documentItem = headerSection[indexPath.section]
        cell.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let headerHeight: CGFloat = 100
        return headerHeight
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: DocumentExpandHeaderView.identifier) as? DocumentExpandHeaderView else {
            return UIView()
        }
        headerView.headerItem = headerSection[section]
        headerView.section = section
        headerView.delegate = self
        return headerView
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showCheckDownloadDialog(indexPath: indexPath)
    }

    private func showCheckDownloadDialog(indexPath: IndexPath) {
        let confirmDialog = TDConfirmDialog(frame: self.view.bounds)
        confirmDialog.set(title: "Thông báo")
        confirmDialog.set(message: "Bạn phải download tài liệu trước khi xem.")
        confirmDialog.cancelButtonTitle = "Huỷ"
        confirmDialog.confirmButtonTitle = "Đồng ý"
        let vc = StoryboardScene.DocumentDetailViewController.documentDetailViewController.instantiate()
        self.navigationController?.pushViewController(vc, animated: true)
//        confirmDialog.cancelDidSelected = {
//            // Todo: do nothing
//        }
//        confirmDialog.confirmDidSelected = {
//            // Todo: Move to DocumentDetailViewController
//        }
        //self.view.addSubview(confirmDialog)
    }
}

extension DocumentController: DocumentHeaderViewDeleagate, DocumentTypeCellDelegate {
    func cell(_ cell: DocumentTypeCell, type: TypeJLPT) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let vc = StoryboardScene.ListDocumentOfType.listDocumentOfTypeController.instantiate()
        vc.type = type
        vc.level = headerSection[indexPath.section].level
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }

    func header(didSelected header: DocumentExpandHeaderView, section: Int) {
        headerSection[section].isExpanded = !headerSection[section].isExpanded
        tableView.beginUpdates()
        tableView.reloadSections([section], with: .fade)
        tableView.endUpdates()
    }
}
