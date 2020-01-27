//
//  GalleryViewController.swift
//  FontAwesomeDemo
//
//  Created by Soheil Novinfard on 25/01/2020.
//

import UIKit
import FontAwesome

class GalleryViewController: UIViewController {
	@IBOutlet weak var iconCollectionView: UICollectionView!

	let fontStyle: FontAwesomeStyle = .solid
	lazy var fontList = FontAwesome.fontList(style: self.fontStyle)

    override func viewDidLoad() {
        super.viewDidLoad()
		self.iconCollectionView.delegate = self
		self.iconCollectionView.dataSource = self
    }
}

extension GalleryViewController: UICollectionViewDelegate {

}

extension GalleryViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return fontList.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = self.iconCollectionView.dequeueReusableCell(withReuseIdentifier: "gallery", for: indexPath) as! GalleryCell

		let fontItem = self.fontList[indexPath.row]

		cell.iconView.image = UIImage.fontAwesomeIcon(
			name: fontItem,
			style: self.fontStyle,
			textColor: .black,
			size: CGSize(width: 35, height: 35)
		)
		cell.titleLabel.text = fontItem.rawValue

		return cell
	}


}
