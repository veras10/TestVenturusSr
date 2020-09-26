//
//  HomeCollectionCellViewModel.swift
//  TestVenturusIOSR
//
//  Created by Guilherme Duarte on 23/09/20.
//  Copyright © 2020 Guilherme Duarte. All rights reserved.
//

import Foundation
import UIKit

struct HomeCollectionCellViewModel {
    
    private var imgUrlInfo: ImgUrlData
    
    init(imgUrlInfo: ImgUrlData) {
        self.imgUrlInfo = imgUrlInfo
    }
    
    var cover: URL? {
        let fileUrl =  URL(string: "https://i.imgur.com/\(imgUrlInfo.cover ?? "").jpg")
        return fileUrl
    }
    
    var up: String {
        return String(imgUrlInfo.ups)
    }
    
    var comments: String {
        return String(imgUrlInfo.comment_count)
    }
    
    var views: String {
        return String(imgUrlInfo.views)
    }
    
    var hideView: Bool {
        if imgUrlInfo.cover == "" || imgUrlInfo.cover == nil {
            return false
        } else {
            return true
        }
    }
}
