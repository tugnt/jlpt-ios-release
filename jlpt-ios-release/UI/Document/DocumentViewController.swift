//
//  DocumentViewController.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/10/14.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit
import Alamofire

class DocumentViewController: UIViewController {
    fileprivate let cellId = "cellDocument"
    @IBOutlet weak var tableView: UITableView!

    lazy var headerSection: [DocumentHeader] = {
        let headerN1 = DocumentHeader(color: ColorName.n1ColorBg.color, image: Asset.n1.image, title: "JLPT N1", titleNumberDocument: "", isExpanded: true, level: 1)
        let headerN2 = DocumentHeader(color: ColorName.n2ColorBg.color, image: Asset.n2.image, title: "JLPT N2", titleNumberDocument: "", isExpanded: false, level: 2)
        let headerN3 = DocumentHeader(color: ColorName.n3ColorBg.color, image: Asset.n3.image, title: "JLPT N3", titleNumberDocument: "", isExpanded: false, level: 3)
        let headerN4 = DocumentHeader(color: ColorName.n4ColorBg.color, image: Asset.n4.image, title: "JLPT N4 & N5", titleNumberDocument: "", isExpanded: false, level: 45)
        return [headerN1, headerN2, headerN3, headerN4]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Tài liệu"
        self.setUpNavBar()
        configTableView()
    }
    
    private func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.tableFooterView = UIView()
        tableView.register(DocumentExpandHeaderView.nib, forHeaderFooterViewReuseIdentifier: DocumentExpandHeaderView.identifier)
        tableView.register(DocumentTypeCell.nib, forCellReuseIdentifier: DocumentTypeCell.identifier)
    }
}

extension DocumentViewController: UITableViewDelegate, UITableViewDataSource {
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
        let headerHeight: CGFloat = 80
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
}

extension DocumentViewController: DocumentHeaderViewDeleagate, DocumentTypeCellDelegate {
    func cell(_ cell: DocumentTypeCell, type: TypeJLPT, isExam: Bool) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let vc = StoryboardScene.ListDocumentOfTypeViewController.listDocumentViewController.instantiate()
        vc.type = type
        vc.level = headerSection[indexPath.section].level
        vc.isExam = isExam
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
