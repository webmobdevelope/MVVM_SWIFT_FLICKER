//
//  HomeViewModel.swift
//  straiberry
//
//  Created by Behnam on 20.06.22.
//

import Foundation
class HomeViewModel{
    var homeViewModelDelegate:HomeViewModelDelegate?=nil
    func getPhotoList(photoText:String){
        NetworkManager.shared.call(type: .getPhotoList,params: ["text":photoText], callback: {
            item in
            do{
            var photoList:PhotoList=try PhotoList(data: item)
                self.homeViewModelDelegate?.onPhotoListLoad(photoList: photoList)
            }catch {
                self.homeViewModelDelegate?.onErrorHappend(errorMassage: "error parsing data")
            }
        }, fallback: {
            item in
            self.homeViewModelDelegate?.onErrorHappend(errorMassage: item)
        })
    }
}
protocol HomeViewModelDelegate{
    func onPhotoListLoad(photoList:PhotoList)
    func onErrorHappend(errorMassage:String)
}
