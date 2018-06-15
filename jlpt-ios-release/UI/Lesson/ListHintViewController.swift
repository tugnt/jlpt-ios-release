//
//  ListHintController.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/10/01.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit
import GoogleMobileAds

struct HintTableData {
    var listHint: [HintViewModel]
    init(response: JLPTHintResponse) {
        var tmpArr: [HintViewModel] = []
        response.hints.forEach { tmpArr.append(HintViewModel(response: $0)) }
        self.listHint = tmpArr
    }
}
class ListHintController: UIViewController {
    var type: TypeJLPT?
    var listHint: [HintViewModel] = []
    @IBOutlet weak var tableView: UITableView!
    private let cellId = "cellHint"
    private let bannerCellId = "BannerCellItem"
    private var dataSource = [AnyObject]()
    private var adsToLoad = [GADBannerView]()
    private var loadStateForAds = [GADBannerView: Bool]()
    private let adInterval = UIDevice.current.userInterfaceIdiom == .pad ? 16 : 4
    private let adViewHeight = CGFloat(100)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBar()
        let title = setUpTitle(type: type)
        self.title = "Mẹo luyện thi \(title)"
        configTableView()
        fetchHintData()
    }
    
    private func configTableView() {
        tableView.register(UINib(nibName: "BannerAd", bundle: nil), forCellReuseIdentifier: bannerCellId)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .clear
        // Allow row height to be determined dynamically while optimizing with an estimated row height.
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 135
    }
    
    private func fetchHintData() {
        startAnimationLoading()
        guard let type = self.type else { return }
        let request = HintRequest(type: type)
        ApiClient.instance.request(request: request, completion: { (result) in
            switch result {
            case .success(let response):
                var hintModel = HintTableData(response: response)
                hintModel.listHint = hintModel.listHint.sorted(by: { $0.unit < $1.unit })
                if hintModel.listHint.count == 0 {
                    self.tableView.isHidden = true
                    self.addEmptyStateView()
                }
                hintModel.listHint.forEach { self.dataSource.append($0 as AnyObject) }
                self.configAds()
                self.preloadNextAd()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure:
                self.tableView.isHidden = true
                self.addEmptyStateView()
            }
            self.stopAnimationLoading()
        })
    }
}

// MARK: Config ads method
extension ListHintController {
    private func configAds() {
        var index = adInterval
        // Ensure subview layout has been performed before accessing subview sizes.
        tableView.layoutIfNeeded()
        while index <= dataSource.count {
            let adSize = GADAdSizeFromCGSize(CGSize(width: tableView.contentSize.width, height: adViewHeight))
            let adView = GADBannerView(adSize: adSize)
            adView.adUnitID = Env.banerUnitId
            adView.rootViewController = self
            adView.delegate = self
            dataSource.insert(adView, at: index)
            adsToLoad.append(adView)
            loadStateForAds[adView] = false
            index += adInterval
        }
    }
    
    // Preload banner ads sequentially. Dequeue and load next ad from `adsToLoad` list.
    private func preloadNextAd() {
        if !adsToLoad.isEmpty {
            let ad = adsToLoad.removeFirst()
            let adRequest = GADRequest()
            // Todo: Fix here when release
            adRequest.testDevices = [kGADSimulatorID]
            ad.load(adRequest)
        }
    }
}

// MARK: Tableview delegate method
extension ListHintController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let hintModel = dataSource[indexPath.row] as? HintViewModel {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? HintCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.hintItem = hintModel
            return cell
        } else {
            let bannerCell = tableView.dequeueReusableCell(withIdentifier: bannerCellId, for: indexPath)
            bannerCell.subviews.forEach { $0.removeFromSuperview() }
            if let bannerView = dataSource[indexPath.row] as? GADBannerView {
                bannerCell.addSubview(bannerView)
                bannerView.snp.makeConstraints { make in
                    make.centerY.centerX.equalToSuperview()
                    make.leading.trailing.equalToSuperview().inset(10)
                    make.top.bottom.equalToSuperview().inset(5)
                }
                bannerView.translatesAutoresizingMaskIntoConstraints = false
                bannerView.clipsToBounds = true
                bannerView.layer.cornerRadius = 3
            }
            return bannerCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let hintModel = dataSource[indexPath.row] as? HintViewModel {
            let vc = StoryboardScene.TheoryHintViewController.theoryHintViewController.instantiate()
            vc.content = hintModel.hintContent
            vc.questions = hintModel.questions
            guard let type = self.type else { return }
            vc.type = type
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let bannerView = dataSource[indexPath.row] as? GADBannerView {
            guard let isLoaded = loadStateForAds[bannerView] else { return UITableViewAutomaticDimension }
            return isLoaded ? adViewHeight : 0
        }
        return UITableViewAutomaticDimension
    }
}

// MARK: Bannber view delegate method.
extension ListHintController: GADBannerViewDelegate {
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        print("Failed to receive ad: \(error.localizedDescription)")
        preloadNextAd()
    }
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        loadStateForAds[bannerView] = true
        preloadNextAd()
    }
}
