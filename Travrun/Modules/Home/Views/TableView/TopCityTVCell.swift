//
//  TopCityTVCell.swift
//  BabSafar
//
//  Created by MA673 on 19/07/22.
//

import UIKit

class TopCityTVCell: TableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var citysCV: UICollectionView!
    
    var topHotelsImages = ["banner1", "banner2", "banner1", "banner2"]
    var popularDestinationsImages = ["banner3", "banner4", "banner3", "banner4"]
    var topHotels = ["Dubai", "Riyadh", "Dubai", "Riyadh"]
    var popularDestinations = ["Dubai", "Kuwait", "Dubai", "Kuwait"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func updateUI() {
        titlelbl.text = cellInfo?.title
        citysCV.reloadData()
        
    }
    
    
    func setupUI() {
        
        holderView.backgroundColor = .WhiteColor
        setuplabels(lbl: titlelbl, text: "", textcolor: .AppLabelColor, font: UIFont.latoSemiBold(size: 18), align: .left)
        setupCV()
        
    }
    
    func setupCV() {
        let nib = UINib(nibName: "TopCityCVCell", bundle: nil)
        citysCV.register(nib, forCellWithReuseIdentifier: "cell")
        citysCV.delegate = self
        citysCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 190, height: 190)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 6
        layout.minimumLineSpacing = 6
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        citysCV.collectionViewLayout = layout
        citysCV.backgroundColor = .clear
        citysCV.layer.cornerRadius = 4
        citysCV.clipsToBounds = true
        citysCV.showsHorizontalScrollIndicator = false
    }
    
    
    
}


extension TopCityTVCell:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return popularDestinations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? TopCityCVCell {
            cell.cityImage.image = UIImage(named: popularDestinationsImages[indexPath.row])
            cell.cityNamelbl.text = popularDestinations[indexPath.row]
            commonCell = cell
        }
        return commonCell
    }
    
}

