//
//  GetRepositoryImageManager.swift
//  iOSEngineerCodeCheck
//
//  Created by Tatsuya Amida on 2020/08/18.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import Foundation
import AlamofireImage

class GetRepositoriesImageManager {
    
    func getImage(vc1: ViewController, vc2: ViewController2) {
        guard let selectedIndex = vc1.idx else { return }
        let repo = vc1.repo[selectedIndex]
        
        if let owner = repo["owner"] as? [String: Any] {
            if let imageURL = owner["avatar_url"] as? String {
                if let url = URL(string: imageURL) {
                    vc2.ImgView.af.setImage(withURL: url)
                }
            }
        }
    }
    
}
