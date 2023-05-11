//
//  ImageLoader.swift
//  middleTestTask
//
//  Created by Dmytro Vakulinsky on 11.05.2023.
//

import SwiftUI

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    
    func loadImage(from url: URL) {
        ImageDownloader.shared.getImage(with: url) { [weak self] image in
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }
}

class ImageDownloader {
    static let shared = ImageDownloader()
    
    private var cache: [String: UIImage] = [:]
    private var tasks: [String: URLSessionTask] = [:]
    
    func getImage(with url: URL, completion: @escaping (UIImage?) -> Void) {
        let identifier = url.absoluteString
        
        if let image = cache[identifier] {
            completion(image)
        } else if let task = tasks[identifier] {
            task.cancel()
            tasks[identifier] = nil
        }
        
        let sessionTask = URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let data = data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            
            self?.cache[identifier] = image
            completion(image)
        }
        
        tasks[identifier] = sessionTask
        sessionTask.resume()
    }
}
