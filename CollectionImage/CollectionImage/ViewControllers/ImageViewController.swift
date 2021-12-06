//
//  ImageViewController.swift
//  CollectionImage
//
//  Created by Никита Гуляев on 04.12.2021.
//

import UIKit


class ImageViewController: UIViewController {
    
    private var images = [ImageData]()
    private let standardLink = "https://api.opendota.com"
    
    var refreshControl: UIRefreshControl{
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.refreshControl = refreshControl
        navigationItem()
        networkService()
        }
    
    
//    MARK: - Private func
    
    private func networkService() {
        Task {
            do {
                images = try await NetworkService.shared.request()
                collectionView.reloadData()
            } catch {
                print(error)
            }
        }
    }
    
    private func navigationItem() {
        navigationItem.title = "Dota 2 heroes"
        navigationItem.rightBarButtonItem = editButtonItem
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @objc private func refresh(sender: UIRefreshControl) {
        sender.endRefreshing()
        networkService()
        collectionView.reloadData()
    }
}

//    MARK: - UICollectionView Data Source

extension ImageViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCollectionViewCell
        
        let completeLink = standardLink + images[indexPath.row].img
        cell.imageView.fetchImage(from: completeLink)
        cell.backgroundColor = .darkGray
        cell.delegate = self
        return cell
    }
    
}
//    MARK: - UICollectionView Delegate Flow Layout

extension ImageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = UIScreen.main.bounds.width - 10
        let height = width
        
        return CGSize(width: width, height: height)
    }
}
//    MARK: - UICollectionView Delegate

extension ImageViewController: ImageCollectionViewCellDelegate {
    func delete(cell: ImageCollectionViewCell) {
        if let indexPath = collectionView.indexPath(for: cell) {
            images.remove(at: indexPath.item)
            collectionView.deleteItems(at: [indexPath ])
        }
    }
    
}
