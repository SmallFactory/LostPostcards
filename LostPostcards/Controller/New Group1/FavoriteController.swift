//
//  FavoriteController.swift
//  LostPostcards
//
//  Created by Small Factory Studios on 9/9/17.
//  Copyright © 2017 Small Factory Studios. All rights reserved.
//

import UIKit
import SnapKit

class FavoriteController: UICollectionViewController {
    
    private let bg: UIView = {
        let view = UIView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
        
    }
    
    func createUI(){
        view.addSubview(bg)
        bg.backgroundColor = SFSStyles.color.hillary.value
        
        bg.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
    }
    
}

