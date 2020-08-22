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

    func getImage(with image: UIImageView, urlString: String) {
        guard let url = URL(string: urlString) else { return }
        image.af.setImage(withURL: url)
    }

}
