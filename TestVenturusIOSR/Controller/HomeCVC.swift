//
//  HomeCVC.swift
//  TestVenturusIOSR
//
//  Created by Guilherme Duarte on 23/09/20.
//  Copyright © 2020 Guilherme Duarte. All rights reserved.
//

import UIKit
import SDWebImage

class HomeCVC: UICollectionViewCell {
    
    //MARK: - Propreties
    
    @IBOutlet weak var viewLikes: UIView!
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var upLabel: UILabel!
    
    @IBOutlet weak var commentsLabel: UILabel!
    
    @IBOutlet weak var viewsLabel: UILabel!
    
    @IBOutlet weak var viewNoImage: UIView!
    
    //MARK: - Lifecycle
    
    override func awakeFromNib() {
        
        image.layer.cornerRadius = 6
        image.clipsToBounds = true
        
        viewLikes.layer.cornerRadius = 6
        
        viewNoImage.layer.cornerRadius = 6
        
        viewLikes.layer.shadowColor = UIColor.black.cgColor
        viewLikes.layer.shadowOpacity = 0.5
        viewLikes.layer.shouldRasterize = true
        viewLikes.layer.shadowRadius = 6
        viewLikes.layer.rasterizationScale = UIScreen.main.scale
    }
    
    //MARK: - Helpers
    
    func configure(with viewModel: HomeCollectionCellViewModel) {

        upLabel.text = viewModel.up
        
        viewsLabel.text = viewModel.views
        
        commentsLabel.text = viewModel.comments
        
        viewNoImage.isHidden = viewModel.hideView
        
        image.sd_imageIndicator = SDWebImageActivityIndicator.gray

        image.sd_setImage(with: viewModel
            .cover, completed: nil)
        
    }
}
