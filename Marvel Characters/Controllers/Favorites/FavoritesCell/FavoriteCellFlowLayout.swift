//
//  FavoriteCellFlowLayout.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 26.04.2022.
//

import UIKit

class FavoriteCellFlowLayout: UICollectionViewFlowLayout {
	var columnCount: Int
	var heightRatio: CGFloat = (3.0 / 1.5)
	
	init(ColumnCount:Int, MinColumnSpace:CGFloat = 15, MinRowSpace:CGFloat = 15) {
		
		self.columnCount = ColumnCount
		super.init()
		minimumInteritemSpacing = MinColumnSpace
		minimumLineSpacing = MinRowSpace
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func prepare() {
		super.prepare()
		
		guard let collView = collectionView else{return}
		
		let spaces = collView.safeAreaInsets.left + collView.safeAreaInsets.right + minimumInteritemSpacing * CGFloat(columnCount - 1)
		
		let itemWidth = ((collView.bounds.size.width - spaces) / CGFloat(columnCount)).rounded(.down)
		let itemHeight = itemWidth * heightRatio
		
		itemSize = CGSize(width: itemWidth, height: itemHeight)
	}
}
