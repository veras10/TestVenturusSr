//
//  ListImagesViewModel.swift
//  TestVenturusIOSR
//
//  Created by Guilherme Duarte on 23/09/20.
//  Copyright © 2020 Guilherme Duarte. All rights reserved.
//

import Foundation

protocol ListImagesViewModelDelegate {
    func returnResponse(result: Bool)
}

class ListImagesViewModel {
    
    var delegate: ListImagesViewModelDelegate?
    
    private var imgUrlInfos: [ImgUrlData] = [] {
        didSet {
            imgUrlInfosLoaded?()
        }
    }
    var imgUrlInfosLoaded: (()->Void)?
    
    var count: Int{
        return imgUrlInfos.count
    }
    
    func loadImgurl() {
        DataService.shared.getInfo { (ImgsData, error) in
            if error != nil {
                self.delegate?.returnResponse(result: false)
            } else {
                if let ImgsData = ImgsData {
                    self.imgUrlInfos = ImgsData.data
                    self.delegate?.returnResponse(result: true)
                }
            }
        }
    }
    
    func getImgurat(indexPath: IndexPath) -> ImgUrlData {
        return imgUrlInfos[indexPath.row]
    }
    
    func viewModelFor(indexPath: IndexPath) -> HomeCollectionCellViewModel {
        let imgUrlInfo = getImgurat(indexPath: indexPath)
        return HomeCollectionCellViewModel(imgUrlInfo: imgUrlInfo)
    }
}
