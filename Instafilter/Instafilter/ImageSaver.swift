//
//  ImageSaver.swift
//  Instafilter
//
//  Created by Gucci on 2023/06/15.
//

import UIKit

class ImageSaver: NSObject {
    var onFinished: ((Result<(), Error>) -> Void)?

    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }

    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            onFinished?(.failure(error))
        } else {
            onFinished?(.success(()))
        }
    }
}
