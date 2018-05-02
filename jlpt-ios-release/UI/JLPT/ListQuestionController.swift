//
//  ListQuestionController.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/10/01.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ListQuestionController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var level: LevelJLPT!
    var type: TypeJLPT!
    var units = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Danh sách đề thi"
        setUpNavBar()
        collectionView.delegate = self
        collectionView.dataSource = self
        setUpCollectionLayout()
        fetchUnitData()
    }

    private func setUpCollectionLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        let numberItemInRow = UIScreen.main.bounds.width <= 320 ? 3 : 4
        let itemWidth = (UIScreen.main.bounds.width - 20 - 30) / CGFloat(numberItemInRow)
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        collectionView.collectionViewLayout = layout
        collectionView.register(JLPTUnitCellCollectionViewCell.nib, forCellWithReuseIdentifier: JLPTUnitCellCollectionViewCell.identifier)
    }
    
    private func fetchUnitData() {
        startAnimationLoading()
        let request = UnitRequest(method: .get, level: level, type: type)
        ApiClient.instance.request(request: request, completion: { (result) in
            switch result {
            case .failure:
                self.collectionView.isHidden = true
                self.addEmptyStateView()
            case .success(let value):
                self.units = value.units
                if self.units.count == 0 {
                    self.collectionView.isHidden = true
                    self.addEmptyStateView()
                }
                self.collectionView.reloadData()
            }
            self.stopAnimationLoading()
        })
    }
}

extension ListQuestionController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return units.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: JLPTUnitCellCollectionViewCell.identifier, for: indexPath) as? JLPTUnitCellCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.unit = units[indexPath.row]
        cell.levelJLPT = level
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let unit = units[indexPath.row]
        let vc = StoryboardScene.NomalQuestion.nomalQuestionController.instantiate()
        vc.type = type
        vc.level = level
        vc.unit = unit
        vc.needLoadRequest = true
        navigationController?.pushViewController(vc, animated: true)
    }
}
