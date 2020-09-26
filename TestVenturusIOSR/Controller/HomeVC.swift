//
//  HomeVC.swift
//  TestVenturusIOSR
//
//  Created by Guilherme Duarte on 23/09/20.
//  Copyright © 2020 Guilherme Duarte. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    //MARK: - Propreties
    
    lazy var viewModel = ListImagesViewModel()
    
    @IBOutlet weak var CollectionViewImages: UICollectionView!
    
    var refreshControl = UIRefreshControl()
    
    @IBOutlet weak var viewFail: UIView!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        configureUI()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width
        let screenHeight = screenRect.size.height
        
        addRefreshControl()
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: screenWidth - 40, height: screenHeight/3)
        
        CollectionViewImages.collectionViewLayout = layout
        
        viewModel.loadImgurl()
        viewModel.imgUrlInfosLoaded = imgUrlInfosLoaded
    }
    
    func addRefreshControl() {
        guard let customView = Bundle.main.loadNibNamed("CustomRefresh", owner: nil, options: nil) else {return}
        guard let refreshView = customView[0] as? UIView else {return}
        refreshView.tag = 12052018
        refreshView.frame = refreshControl.frame
        refreshControl.addSubview(refreshView)
        refreshControl.tintColor = UIColor.clear
        refreshControl.backgroundColor = UIColor.clear
        refreshControl.addTarget(self, action: #selector(refreshContent), for: .valueChanged)
        if #available(iOS 10.0, *) {
            CollectionViewImages.refreshControl = refreshControl
        } else {
            CollectionViewImages.addSubview(refreshControl)
        }
    }
    
    func imgUrlInfosLoaded(){
        CollectionViewImages.reloadData()
    }
    
    //MARK: - Actions
    
    @objc func refreshContent() {
        let refreshView = refreshControl.viewWithTag(12052018)
        UIView.animate(withDuration: 2.0, animations: ({
            for vm in (refreshView?.subviews)! {
                if let image = vm as? UIImageView {
                    image.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
                }
            }
        }))
        self.perform(#selector(endRefresh), with: nil, afterDelay: 1)
    }
    
    @objc func endRefresh() {
        refreshControl.endRefreshing()
        viewModel.loadImgurl()
    }
}

//MARK: - UICollectionViewDataSource
extension HomeVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = CollectionViewImages.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeCVC
        cell.configure(with: viewModel.viewModelFor(indexPath: indexPath))
        return cell
    }
}

//MARK: - UICollectionViewFlowLayout
extension HomeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width
        let screenHeight = screenRect.size.height
        return CGSize(width: screenWidth - 40, height: screenHeight/3)
    }
    
}

//MARK: - ListImagesViewModelDelegate
extension HomeVC: ListImagesViewModelDelegate {
    func returnResponse(result: Bool) {
        viewFail.isHidden = result
    }
}
