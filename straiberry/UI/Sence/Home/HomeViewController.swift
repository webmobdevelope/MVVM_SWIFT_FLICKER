//
//  HomeViewController.swift
//  straiberry
//
//  Created by Behnam on 20.06.22.
//

import Foundation
import UIKit
class HomeViewController:UIViewController {
    var viewModel:HomeViewModel?=nil
    var coordinator:HomeCoordinator?=nil
    var baseView:FileListView={
        let view = FileListView()
        view.translatesAutoresizingMaskIntoConstraints=false
        return view
    }()
    override func viewDidLoad() {
        
        view.addSubview(baseView)
        NSLayoutConstraint.activate([
            baseView.topAnchor.constraint(equalTo: view.topAnchor),
            baseView.leftAnchor.constraint(equalTo: view.leftAnchor),
            baseView.rightAnchor.constraint(equalTo: view.rightAnchor),
            baseView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        baseView.layout()
        
        viewModel?.homeViewModelDelegate=self
        viewModel?.getPhotoList(photoText: "baby")
    }

}
extension HomeViewController:HomeViewModelDelegate{
    func onPhotoListLoad(photoList: PhotoList) {
        baseView.setPhotoListData(data: photoList)
    }
    
    func onErrorHappend(errorMassage: String) {
        print(errorMassage)
    }
    
    
}
