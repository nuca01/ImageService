// The Swift Programming Language
// https://docs.swift.org/swift-book
#if canImport(UIKit)

import UIKit

public class ImageService {
    public static var imageService = ImageService()
    private init(){}
    public func loadImageFromURL(_ urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            //თუ ვერ შექიმნა ვაწოდებთ ნილს
            completion(nil)
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            //ერორზე ან მონაცემთა არ ქონაზე შემოწმება
            guard error == nil, let data = data else {
                print("Error fetching image:", error?.localizedDescription ?? "Unknown error")
                completion(nil)
                return
            }
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                completion(nil)
            }
        }.resume()
    }
}

#endif
