//
//  NetworkImageMannager.swift
//  straiberry
//
//  Created by Behnam on 20.06.22.
//


import Foundation
import Kingfisher
import UIKit

class NetworkImageMannager{
    static var tag=0
    static func getNextTag() -> Int{
        tag=tag+1
        if(tag>10000){
            tag=1
        }
        return tag
    }
    static let noneimage=UIImage()
   
    public static let STOP_LOADING=555
    static func setImageViewFromUrl(imageView:UIImageView,url:String,tag:Int = -1,notFoundImageName:String="imgnotfound",notFoundImage:UIImage = noneimage,setbg:Bool=true,retry:Int64=1,tint:UIColor=UIColor.clear){
        if url.starts(with: "local://"){
            let icon_name=url.replacingOccurrences(of: "local://", with: "")
            if let a = UIImage(named: icon_name) {
                imageView.image = a
            }
            return
        }

            if imageView.tag == STOP_LOADING{
                return
            }
        DispatchQueue.main.async {
            if url != "" {
                let processor = DownsamplingImageProcessor(size: imageView.bounds.size)
                
                imageView.kf.indicatorType = .activity
                imageView.kf.setImage(
                    with: URL(string:url),
                    placeholder: UIImage(named: ""),
                    options: [
                        .processor(processor),
                        .scaleFactor(UIScreen.main.scale),
                        .transition(.fade(1)),
                        .cacheOriginalImage
                    ], completionHandler:
                        {
                            result in
                            if(imageView.tag != tag ){
                                return
                            }
                            switch result {
                            case .success(let value):

                                if tint != UIColor.clear{
                                    if #available(iOS 13.0, *) {
                                        
                                        imageView.image = value.image.withTintColor(tint)
                                    } else {
                                        imageView.image = value.image.withRenderingMode(.alwaysTemplate)
                                    }
                                }
                                if setbg {
                                    
//                                    imageView.backgroundColor = value.image.getPixelColor(pos: CGPoint(x: 1, y: 1))//getPixelColorAtPoint(point: CGPoint(x: 2, y: 2),sourceView: imageView)
//
                                }
                                print("Task done for: \(value.source.url?.absoluteString ?? "")")
                            case .failure( let error):
                                print("downloadImage:\(error)")
                                if imageView.tag == STOP_LOADING {
                                    return
                                }
                                if(retry < 4){
                                    Timer.scheduledTimer(withTimeInterval: 2.0*Double(retry), repeats: false) { timer in
                                        setImageViewFromUrl(imageView: imageView,url:url, tag:tag,notFoundImageName: notFoundImageName,notFoundImage: noneimage,setbg: setbg,retry: retry+1)
                                    }
                                }
                                
                                if notFoundImage != noneimage {
                                    imageView.image=notFoundImage
                                }
                                else{
                                    imageView.image=UIImage.init(named: notFoundImageName)
                                }
                            }
                        })
            }
        }
    }
}
