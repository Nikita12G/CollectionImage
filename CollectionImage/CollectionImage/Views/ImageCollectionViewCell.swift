//
//  ImageCollectionViewCell.swift
//  CollectionImage
//
//  Created by Никита Гуляев on 04.12.2021.
//

import UIKit

protocol ImageCollectionViewCellDelegate: AnyObject {
    func delete(cell: ImageCollectionViewCell)
}

class ImageCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: ImageCollectionViewCellDelegate?

    @IBOutlet weak var imageView: CharacterImage!

    @IBAction func deleteButtonDidTap(_ sender: Any) {
        delegate?.delete(cell: self )
    }
}
