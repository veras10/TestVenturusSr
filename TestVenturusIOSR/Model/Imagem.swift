//
//  Imagem.swift
//  TestVenturusIOSR
//
//  Created by Guilherme Duarte on 23/09/20.
//  Copyright © 2020 Guilherme Duarte. All rights reserved.
//

import Foundation
import Alamofire

struct ImgUrlInfo: Codable {
    let data: [ImgUrlData]
}
struct ImgUrlData: Codable {
    let title: String
    let cover: String?
    let ups: Int
    let views: Int
    let comment_count: Int
}


// MARK: - Alamofire response handlers
extension DataRequest {
    @discardableResult
    func responseImgUrlInfo(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<ImgUrlInfo>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}
