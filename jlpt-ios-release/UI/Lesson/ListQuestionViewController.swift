//
//  ListQuestionViewController.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/10/01.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit
import GoogleMobileAds
import ExpandingCollection

class ListQuestionViewController: ExpandingViewController {
    var level: LevelJLPT!
    var type: TypeJLPT!
    var units = [Int]()
    // For admob
    private var adRequestInProgress = false
    private var rewardBasedVideo: GADRewardBasedVideoAd?
    private let rewardVideoUnitId = "ca-app-pub-8167183150215759/3144550312"
    lazy var normalVC: NormalQuestionViewController = {
        let vc = StoryboardScene.NomalQuestionViewController.normalQuestionViewController.instantiate()
        vc.type = type
        vc.level = level
        vc.needLoadRequest = true
        return vc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Danh sách đề thi"
        self.view.backgroundColor = #colorLiteral(red: 0.1570000052, green: 0.5839999914, blue: 1, alpha: 1)
        setUpNavBar()
        setUpExpandingCollectionView()
        fetchUnitData()
        configAdVideo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadAdsVideo()
    }
    
    private func configAdVideo() {
        rewardBasedVideo = GADRewardBasedVideoAd.sharedInstance()
        rewardBasedVideo?.delegate = self
    }
    
    func loadAdsVideo() {
        let request = GADRequest()
        if !adRequestInProgress && rewardBasedVideo?.isReady == false {
            rewardBasedVideo?.load(request, withAdUnitID: rewardVideoUnitId)
            adRequestInProgress = true
        }
    }
    
    func presentRewardAdVideo() {
        if rewardBasedVideo?.isReady == true {
            rewardBasedVideo?.present(fromRootViewController: self)
        } else {
            // Todo: Show alert or toast here
            self.showAlertDialog(title: "Thông báo", content: "Có lỗi xảy ra trong quá trình tải dữ liệu. Vui lòng chờ giây lát và thử lại sau.", titleButton: "OK", cancelAction: {
                self.loadAdsVideo()
            })
        }
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
            self.stopAnimationLoading()
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
        })
    }
    
    private func moveDetailQuestionScreen(indexPath: IndexPath) {
        self.reductionCoins()
        if Setting.coins <= 0 {
            // TODO: Để sang version tiếp theo
            //presentRewardAdVideo()
        }
        if type == .listening {
            let vc = StoryboardScene.ListeningQuestionViewController.listeningQuestionViewController.instantiate()
            let unit = units[indexPath.row]
            vc.type = type
            vc.level = level
            vc.unit = unit
            vc.isNormalQuestion = true
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let unit = units[indexPath.row]
            normalVC.unit = unit
            navigationController?.pushViewController(normalVC, animated: true)
        }
    }
    
    private func showAlert(indexPath: IndexPath) {
        let alert = TDConfirmDialog(frame: view.bounds)
        alert.set(title: "Thông báo")
        alert.set(message: "Quảng cáo này giúp duy trì bài học miễn phí cho bạn.")
        alert.cancelButtonTitle = "Cancel"
        alert.confirmButtonTitle = "Đồng ý"
        alert.confirmDidSelected = {
            self.moveDetailQuestionScreen(indexPath: indexPath)
        }
        view.addSubview(alert)
    }
}

extension ListQuestionViewController {
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
            self.showAlert(indexPath: indexPath)
        }
        return cell
    }
}

// MARK: GADRewardBasedVideoAdDelegate implementation

extension ListQuestionViewController: GADRewardBasedVideoAdDelegate {
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd, didFailToLoadWithError error: Error) {
        adRequestInProgress = false
        print("Reward based video ad failed to load: \(error.localizedDescription)")
    }
    
    func rewardBasedVideoAdDidReceive(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        adRequestInProgress = false
        print("Reward based video ad is received.")
    }
    
    func rewardBasedVideoAdDidOpen(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Opened reward based video ad.")
    }
    
    func rewardBasedVideoAdDidStartPlaying(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad started playing.")
    }
    
    func rewardBasedVideoAdDidClose(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad is closed.")
        loadAdsVideo()
    }
    
    func rewardBasedVideoAdWillLeaveApplication(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad will leave application.")
    }
    
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd, didRewardUserWith reward: GADAdReward) {
        self.earnCoins()
        print("Reward received with currency: \(reward.type), amount \(reward.amount).")
    }
}
