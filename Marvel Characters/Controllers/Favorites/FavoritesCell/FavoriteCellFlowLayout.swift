    //
    //  FavoriteCellFlowLayout.swift
    //  Marvel Characters
    //
    //  Created by BERAT ALTUNTAŞ on 26.04.2022.
    //

import UIKit

class FavoriteCellFlowLayout: UICollectionViewFlowLayout {
    var sutunSayisi: Int
    var yukseklikOranı: CGFloat = (3.0 / 1.5)
    
    init(sutunSayisi:Int, minSutunAraligi:CGFloat = 15, minSatirAraligi:CGFloat = 15) {
        
        self.sutunSayisi = sutunSayisi
        super.init()
        minimumInteritemSpacing = minSutunAraligi
        minimumLineSpacing = minSatirAraligi
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepare() {
        super.prepare()
        
        guard let collView = collectionView else{return}
        
        let araliklar = collView.safeAreaInsets.left + collView.safeAreaInsets.right + minimumInteritemSpacing * CGFloat(sutunSayisi - 1)
        
        let elemanGenisligi = ((collView.bounds.size.width - araliklar) / CGFloat(sutunSayisi)).rounded(.down)
        let elemanYuksekligi = elemanGenisligi * yukseklikOranı
        
        itemSize = CGSize(width: elemanGenisligi, height: elemanYuksekligi)
        
    }
    
}
