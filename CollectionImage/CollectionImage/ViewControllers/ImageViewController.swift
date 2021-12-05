//
//  ImageViewController.swift
//  CollectionImage
//
//  Created by Никита Гуляев on 04.12.2021.
//

import UIKit


class ImageViewController: UIViewController {
    
    var images = [ImageData]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        showImage()
    }
    
//    MARK: - Private func
    
    private func showImage() {
        Task {
            do {
                images = try await NetworkService.shared.request()
                collectionView.reloadData()
            } catch {
                print(error)
            }
        }
    }
}

//  MARK: - UICollectionView Data Source

extension ImageViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCollectionViewCell
        
        let standardLink = "https://api.opendota.com"
        let completeLink = standardLink + images[indexPath.row].img
        
        cell.imageView.downloaded(from: completeLink)
        
        return cell
    }
    
    
}


