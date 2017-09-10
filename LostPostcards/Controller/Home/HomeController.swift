//
//  HomeController.swift
//  LostPostcards
//
//  Created by Small Factory Studios on 9/9/17.
//  Copyright © 2017 Small Factory Studios. All rights reserved.
//

import UIKit
import SnapKit

class HomeController: UICollectionViewController {
    
    let postCardCellId = "postCardCellId"
    let postCards = [Postcard]()
    
    private let bg: UIView = {
        let view = UIView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .white
        collectionView?.register(PostcardCell.self, forCellWithReuseIdentifier: postCardCellId)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        
        collectionView?.refreshControl = refreshControl
        
        setupNavigationItems()
        
        fetchAllPosts()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postCards.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: postCardCellId, for: indexPath) as! PostcardCell
        cell.postcard = postCards[indexPath.item]
        
        return cell
    }
    
    private func setupNavigationItems() {
//        navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "logo2"))
//        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "camera3").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleCamera))
    }
    
    @objc func handleUpdateFeed() {
        handleRefresh()
    }
    
    @objc func handleRefresh() {
        postCards.removeAll()
        fetchAllPostcards()
    }
    
    private func fetchAllPostcards() {
        fetchPostcards()
//        fetchFollowingUserIds()
    }
    
//    private func fetchFollowingUserIds() {
//        guard let uid = Auth.auth().currentUser?.uid else { return }
//        Database.database().reference().child("following").child(uid).observeSingleEvent(of: .value, with: { snapshot in
//
//            guard let userIdsDictionary = snapshot.value as? [String: Any] else { return }
//
//            userIdsDictionary.forEach({ (key, value) in
//                Database.fetchUserWithUID(uid: key, completion: { user in
//                    self.fetchPostsWithUser(user: user)
//                })
//            })
//
//
//        }) { error in
//            print("failed to fetch user IDs : ", error)
//        }
//    }
    
    private func fetchPostcards() {
        let ref = Database.database().reference().child("postcards")
        
        ref.observeSingleEvent(of: .value) { snapshot in
            self.collectionView?.refreshControl?.endRefreshing()
            
            guard let dictionaries = snapshot.value as? [String: Any] else { return }
            
            dictionaries.forEach({ (key, value) in
                guard let dictionary = value as? [String: Any] else { return }
                
                let postcard     = Post(user: user, dictionary: dictionary)
                self.posts.append(post)
            })
            
            self.posts.sort(by: { (p1, p2) -> Bool in
                return p1.creationDate.compare(p2.creationDate) == .orderedDescending
            })
            self.collectionView?.reloadData()
            
        
    }
//
//    private func fetchPostcards() {
//        guard let uid = Auth.auth().currentUser?.uid else { return }
//
//        Database.fetchUserWithUID(uid: uid) { user in
//            self.fetchPostsWithUser(user: user)
//        }
//    }
    
    private func fetchPostsWithUser(user: User) {
        
        let ref = Database.database().reference().child("posts").child(user.uid)
        
        ref.observeSingleEvent(of: .value) { snapshot in
            self.collectionView?.refreshControl?.endRefreshing()
            
            guard let dictionaries = snapshot.value as? [String: Any] else { return }
            
            dictionaries.forEach({ (key, value) in
                guard let dictionary = value as? [String: Any] else { return }
                
                let post = Post(user: user, dictionary: dictionary)
                self.posts.append(post)
            })
            
            self.posts.sort(by: { (p1, p2) -> Bool in
                return p1.creationDate.compare(p2.creationDate) == .orderedDescending
            })
            self.collectionView?.reloadData()
        }
    }
    
}

extension HomeController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height:CGFloat = 40 + 8 + 8 //username and userprofile imageview
        height += view.frame.width
        height += 50 // add for bottom row of buttons
        height += 68 // for label spacing
        return(CGSize(width: view.frame.width, height: height))
    }
}
