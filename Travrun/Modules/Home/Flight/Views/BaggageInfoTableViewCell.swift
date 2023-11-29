//
//  BaggageInfoTableViewCell.swift
//  Travrun
//
//  Created by MA1882 on 24/11/23.
//

import UIKit

class BaggageInfoTableViewCell: TableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: "BaggageInfoCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "cell")
        let layout = UICollectionViewFlowLayout()
        let width = collectionView.frame.width / 2
        layout.itemSize = CGSize(width: width, height: 143)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 6
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .clear
        collectionView.layer.cornerRadius = 4
        collectionView.clipsToBounds = true
        collectionView.showsHorizontalScrollIndicator = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension BaggageInfoTableViewCell{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? BaggageInfoCollectionViewCell {
            commonCell = cell
        }
        return commonCell
    }
}


