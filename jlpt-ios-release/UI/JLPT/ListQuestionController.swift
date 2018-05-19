//
//  ListQuestionController.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/10/01.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit
import GoogleMobileAds
import ExpandingCollection

class ListQuestionController: ExpandingViewController {
    var level: LevelJLPT!
    var type: TypeJLPT!
    var units = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Danh sách đề thi"
        self.view.backgroundColor = #colorLiteral(red: 0.1570000052, green: 0.5839999914, blue: 1, alpha: 1)
        setUpNavBar()
        setUpExpandingCollectionView()
        fetchUnitData()
    }
    
    
    private func setUpExpandingCollectionView() {
        itemSize = CGSize(width: 256, height: 460)
        collectionView?.register(UnitQuestionCell.nib, forCellWithReuseIdentifier: UnitQuestionCell.identifier)
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
    }

    private func setUpCollectionLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        let numberItemInRow = UIScreen.main.bounds.width <= 320 ? 3 : 4
        let _ = (UIScreen.main.bounds.width - 20 - 30) / CGFloat(numberItemInRow)
        layout.itemSize = CGSize(width: 300, height: 300)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        layout.scrollDirection = .horizontal
        collectionView?.collectionViewLayout = layout
        collectionView?.register(UnitQuestionCell.nib, forCellWithReuseIdentifier: UnitQuestionCell.identifier)
    }
    
    private func fetchUnitData() {
        startAnimationLoading()
        let request = UnitRequest(method: .get, level: level, type: type)
        ApiClient.instance.request(request: request, completion: { (result) in
            switch result {
            case .failure:
                self.collectionView?.isHidden = true
                self.addEmptyStateView()
            case .success(let value):
                self.units = value.units
                if self.units.isEmpty {
                    self.collectionView?.isHidden = true
                    self.addEmptyStateView()
                }
                self.collectionView?.reloadData()
            }
            self.stopAnimationLoading()
        })
    }
    
    private func moveDetailQuestionScreen(indexPath: IndexPath) {
        let unit = units[indexPath.row]
        let vc = StoryboardScene.NomalQuestion.nomalQuestionController.instantiate()
        self.reductionCoins()
        vc.type = type
        vc.level = level
        vc.unit = unit
        vc.needLoadRequest = true
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ListQuestionController {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return units.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UnitQuestionCell.identifier, for: indexPath) as? UnitQuestionCell else {
            return UICollectionViewCell()
        }
        let jlptLevelString = "LEVEL N\(level.rawValue)"
        cell.levelLabel.text = jlptLevelString
        cell.jlptTypeLabel.text = type.rawValue
        cell.unitLabel.text = "Bài \(indexPath.row + 1)"
        cell.detaillButtonDidSelected = {
            self.moveDetailQuestionScreen(indexPath: indexPath)
        }
        return cell
    }
}
