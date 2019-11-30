//
//  UIImageViewExtension.swift
//  Trakting
//
//  Created by Dyego Vieira de Paula on 26/11/19.
//  Copyright © 2019 Dyego Vieira de Paula. All rights reserved.
//

import Foundation
import Kingfisher
import TraktKit

struct TMDBHelper {
    struct Response: Decodable {
        var backdrop_path: String?
        var poster_path: String?
        var still_path: String?
    }
    
    enum Kind: String {
        case poster
        case backdrop
    }
}

extension UIImageView {
    func cancelSetImage() {
        kf.cancelDownloadTask()
    }
    
    func setImage(kind: TMDBHelper.Kind, show: TraktShow?, season: TraktSeason?, episode: TraktEpisode?) {
        // https://developers.themoviedb.org/3/tv/get-tv-images

        var urlPath = TMDBConstants.rootPath
        var defaultKey = ""
        
        if let show = show {
            let value = show.ids.tmdb ?? 0
            urlPath += "/tv/\(value)"
            defaultKey += "tv_\(value)_"
        }
        
        if let season = season {
            let value = season.number
            urlPath += "/season/\(value)"
            defaultKey += "season_\(value)_"
        }
        
        if let episode = episode {
            let value = episode.number
            urlPath += "/episode/\(value)"
            defaultKey += "episode_\(value)_"
        }
        
        urlPath += TMDBConstants.apiKey
        defaultKey += kind.rawValue
        
        image = Placeholder.default
        
        if let imagePath = UserDefaults.standard.string(forKey: defaultKey) {
            setImage(with: imagePath)
        } else {
            let url = URL(string: urlPath)!
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                DispatchQueue.main.async {
                    guard let data = data else { return }
                    do {
                        let decoder = JSONDecoder()
                        let json = try decoder.decode(TMDBHelper.Response.self, from: data)
                        var filePath: String!
                        
                        switch kind {
                        case .backdrop: filePath = json.backdrop_path ?? json.still_path ?? ""
                        case .poster: filePath = json.poster_path ?? ""
                        }
                        
                        let imagemUrlPath = TMDBConstants.imagemRootPath + filePath
                        UserDefaults.standard.set(imagemUrlPath, forKey: defaultKey)
                        self.setImage(with: imagemUrlPath)
                        
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            task.resume()
        }
    }
    
    func setImage(with urlPath: String?) {
        guard let key = urlPath?.split(separator: "?").first, let url = URL(string: urlPath ?? "") else {
            image = Placeholder.default
            return
        }
        
        let resource = ImageResource(downloadURL: url, cacheKey: String(key))
        kf.setImage(
            with: resource,
            placeholder: Placeholder.default,
            options: [.transition(.fade(0.2))]
        ) { _ in }
        //            [weak self] result in
        //            switch result {
        //            case .success:
        //                break
        //            case .failure(let error):
        //                print(error.localizedDescription)
        //            }
        //        }
    }
}
