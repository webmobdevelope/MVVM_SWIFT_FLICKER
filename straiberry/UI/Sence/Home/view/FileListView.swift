//
//  FileListView.swift
//  straiberry
//
//  Created by Behnam on 20.06.22.
//

import Foundation
import UIKit
class FileListView:UIView{
    
    var photoListData:PhotoList?=nil
    var photoList:UICollectionView = {
        let view=UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    func layout(){
        addSubview(photoList)
        NSLayoutConstraint.activate([
            photoList.topAnchor.constraint(equalTo: topAnchor,constant: 10),
            photoList.leftAnchor.constraint(equalTo: leftAnchor,constant: 10),
            photoList.rightAnchor.constraint(equalTo: rightAnchor,constant: -10),
            photoList.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        
        photoList.dataSource = self
        photoList.delegate = self
        photoList.register(MyCell.self, forCellWithReuseIdentifier: "mcells")
    }
    func setPhotoListData(data:PhotoList){
        self.photoListData=data
        photoList.reloadData()
    }
}
extension FileListView:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoListData?.photos?.photo?.count ?? 0;
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let nbCol:CGFloat = 2.2
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(nbCol - 1))
        let size = (collectionView.bounds.width - totalSpace) / CGFloat(nbCol)
        return CGSize(width: size, height: size)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {

        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mcells", for: indexPath)

        if cell is MyCell {
            let mcell=(cell as! MyCell)
            mcell.backView.text = photoListData?.photos?.photo?[indexPath.row].title ?? "noTitle"
            
            
            mcell.frontView.image=nil
            mcell.frontView.tag=NetworkImageMannager.getNextTag()
            if let photo=photoListData?.photos?.photo?[indexPath.row]{
                NetworkImageMannager.setImageViewFromUrl(imageView:  mcell.frontView, url:"https://farm\(photo.farm!).staticflickr.com/\(photo.server!)/\(photo.id!)_\(photo.secret!).jpg" ,tag:  mcell.frontView.tag)
            }
            
            mcell.layout()
        }
        return cell
    }
}
extension FileListView:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            guard let cell = collectionView.cellForItem(at: indexPath) as? MyCell else {
                return
            }
            // if you have the current cell then flip
            cell.flip()
            // you can save it for reflip on didscroll
    }
}
class MyCell:UICollectionViewCell {
    var frontView:UIImageView = {
        let view=UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        
        return view
    }()
    var backView:UITextView = {
        let view=UITextView()
        view.isEditable=false
        view.isUserInteractionEnabled=false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden=true
        view.backgroundColor = .gray
        
        return view
    }()
    var isLayouted=false
    func layout(){
        if(isLayouted){
            return
        }
        contentView.addSubview(frontView)
        contentView.addSubview(backView)
        NSLayoutConstraint.activate([
            frontView.topAnchor.constraint(equalTo: contentView.topAnchor),
            frontView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            frontView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            frontView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            backView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            backView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
            isLayouted=true
    }
    func flip() {
            let flipSide: UIView.AnimationOptions = frontView.isHidden ? .transitionFlipFromLeft : .transitionFlipFromRight
            UIView.transition(with: self.contentView, duration: 0.3, options: flipSide, animations: { [weak self]  () -> Void in
                self?.frontView.isHidden = !(self?.frontView.isHidden ?? true)
                self?.backView.isHidden = !(self?.backView.isHidden ?? false)
            }, completion: nil)
        }
}
