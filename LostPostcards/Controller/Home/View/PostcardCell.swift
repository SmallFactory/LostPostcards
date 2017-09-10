//
//  HomePostCell.swift
//  LostPostcards
//
//  Created by Small Factory Studios on 9/9/17.
//  Copyright © 2017 Small Factory Studios. All rights reserved.
//

import UIKit

class PostcardCell: UICollectionViewCell {
    
    private let postcardImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Username"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    var postcard: Postcard? {
        didSet {
            guard let postcardImageUrl = postcard?.imageUrl else { return }
            postcardImageView.loadImage(urlString: postcardImageUrl)
//            titleLabel.text = postcard.title
//            setupAttributeCaption()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(postcardImageView)
        
        postcardImageView.snp.makeConstraints { make in
            make.top.equalTo(8)
            make.leading.trailing.equalTo(0)
            make.height.equalTo(postcardImageView.snp.width)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder) has not been implemented")
    }
    
    
    
}
