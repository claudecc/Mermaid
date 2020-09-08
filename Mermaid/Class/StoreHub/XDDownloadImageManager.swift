//
//  XDDownloadImageManager.swift
//  SwiftLearning
//
//  Created by caixiaodong on 2020/5/9.
//  Copyright © 2020 蔡晓东. All rights reserved.
//

/*
 Question
 
 1. Download 3 images with multithreading technique, AFTER we get ALL 3 images, then print a log to say “we've got all 3 images”.
 Please describe your logic with the specific technique you want to use at least, giving an executable sample with your code implementation will be impressive!
 (PS: Implement this in at least two ways, one of which must use a Handler for synchronization! And RXJava is not allowed!)
 */

/*
 I implement it in two ways.
 
 1.
 I use URLSessionDataTask with a complete block
 
 1.1
 It's asynchronous.
 
 1.2
 It's synchronous.
 
 2.
 I use URLSessionDataTask again, but I implement delegate to append data.
 
 In these ways, I use memory cache and disk store.
 
 I use image url as a memory key, and I use md5 of image url as a file key.
 
 I use OperationQueue and DispatchSemaphore to control thread.
 
 I thought to add a decode image function, but in this demo it's unused, so I didn't do it.
 
 */

import UIKit
import Foundation
import CommonCrypto.CommonDigest

fileprivate let enbleLog = false

fileprivate let image1Url = "http://static01.jingqiusports.com/jingqiusports_prod/article-images/202005071628122280.jpg"

fileprivate let image2Url = "http://static01.jingqiusports.com/jingqiusports_prod/article-images/202004241511178003.jpg"

fileprivate let image3Url = "http://static01.jingqiusports.com/jingqiusports_prod/article-images/202005061810237575.jpg"

typealias XDDownloadThreeImageComplete = (_ images:Array<UIImage?>) -> Void;
typealias XDDownloadImageComplete = (_ image:UIImage?) -> Void;

class XDDownloadImageManager: NSObject,URLSessionDelegate,URLSessionDataDelegate {
    
    static let shareManager = XDDownloadImageManager()
    
    let cache = NSCache<AnyObject,AnyObject>()
    
    let downloadCache = NSCache<AnyObject,AnyObject>()
    
    class func test() {
        
        self.testWayOneAsync()
//        self.testWayTwo()
    }
    
    // 1.1 way-1 sync
    class func testWayOneAsync() {
        self.shareManager.downloadThreeImagesAsync { (array) in
            if enbleLog {
                print("finished")
            }
        }
    }
    // 1.2 way-1 async
    class func testWayOneSync() {
        OperationQueue().addOperation {
            self.shareManager.downloadThreeImagesSync()
        }
    }
    
    // 2.   way-2
    class func testWayTwo() {
        self.shareManager.downloadThreeImagesTwo { (array) in
            if enbleLog {
                print("finished")
            }
        }
    }
    
    func downloadThreeImagesAsync(_ completion:@escaping XDDownloadThreeImageComplete) {
        
        let queue = OperationQueue()
        queue.name = "downloadThreeImagesAsyncQueue"
        
        var image1:UIImage?
        var image2:UIImage?
        var image3:UIImage?
        
        let operation = BlockOperation()
        operation.addExecutionBlock {
            let semaphore = DispatchSemaphore(value: 0)
            self.downloadImage(image1Url) { (image) in
                image1 = image
                semaphore.signal()
            }
            semaphore.wait()
        }
        operation.addExecutionBlock {
            let semaphore = DispatchSemaphore(value: 0)
            self.downloadImage(image2Url) { (image) in
                image2 = image
                semaphore.signal()
            }
            semaphore.wait()
        }
        operation.addExecutionBlock {
            let semaphore = DispatchSemaphore(value: 0)
            self.downloadImage(image3Url) { (image) in
                image3 = image
                semaphore.signal()
            }
            semaphore.wait()
        }
        operation.completionBlock = {
            if image1 != nil && image2 != nil && image3 != nil {
                print("we've got all 3 images")
            }
            DispatchQueue.main.async {
                completion([image1,image2,image3])
            }
        }
        queue.addOperation(operation)
        
    }
    
    /** It will block current thread */
    func downloadThreeImagesSync() {
        
        if Thread.isMainThread {
            if enbleLog {
                print("it's in main thread")
            }
            return
        }
        
        let semaphore = DispatchSemaphore(value: 0)
        self.downloadThreeImagesAsync { (array) in
            semaphore.signal()
        }
        semaphore.wait()
        
    }
    
    func downloadImage(_ imageUrl:String?, _ completion:@escaping XDDownloadImageComplete) {
        
        if self.isUrlEmpty(imageUrl) {
            if enbleLog {
                print("there's a problem with url")
            }
            DispatchQueue.main.async {
                completion(nil)
            }
            return
        }
        
        let image = self.getCacheImage(imageUrl!)
        if image != nil {
            DispatchQueue.main.async {
                completion(image!)
            }
            return
        }
        
        let api = URL(string: imageUrl!)
        let request = URLRequest(url: api!, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 10)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            var downloadImage:UIImage?
            
            if data == nil {
                if enbleLog {
                    print("there's a problem in download with url-\(imageUrl!)")
                }
            } else {
                downloadImage = UIImage(data: data!)
                if downloadImage != nil {
                    if enbleLog {
                        print("download successed with url-\(imageUrl!)")
                    }
                    
                    self.storeInMemory(data!, imageUrl!)
                    self.storeInDisk(data!, imageUrl!)
                    
                } else {
                    if enbleLog {
                        print("there's a problem in download with url-\(imageUrl!)")
                    }
                }
                
            }
            
            DispatchQueue.main.async {
                completion(downloadImage)
            }
            
        }
        task.resume()
        
    }
    
    func downloadThreeImagesTwo(_ completion:@escaping XDDownloadThreeImageComplete) {
        
        let queue = OperationQueue()
        queue.name = "downloadThreeImagesTwo"
        
        var image1:UIImage?
        var image2:UIImage?
        var image3:UIImage?
        
        let operation = BlockOperation()
        operation.addExecutionBlock {
            let semaphore = DispatchSemaphore(value: 0)
            self.downloadImageTwo(image1Url) { (image) in
                image1 = image
                semaphore.signal()
            }
            semaphore.wait()
        }
        operation.addExecutionBlock {
            let semaphore = DispatchSemaphore(value: 0)
            self.downloadImageTwo(image2Url) { (image) in
                image2 = image
                semaphore.signal()
            }
            semaphore.wait()
        }
        operation.addExecutionBlock {
            let semaphore = DispatchSemaphore(value: 0)
            self.downloadImageTwo(image3Url) { (image) in
                image3 = image
                semaphore.signal()
            }
            semaphore.wait()
        }
        operation.completionBlock = {
            if image1 != nil && image2 != nil && image3 != nil {
                print("we've got all 3 images")
            }
            DispatchQueue.main.async {
                completion([image1,image2,image3])
            }
        }
        queue.addOperation(operation)
    }
    
    func downloadImageTwo(_ imageUrl:String?, _ completion:@escaping XDDownloadImageComplete) {
        
        if self.isUrlEmpty(imageUrl) {
            if enbleLog {
                print("there's a problem with url")
            }
            DispatchQueue.main.async {
                completion(nil)
            }
            return
        }
        
        let image = self.getCacheImage(imageUrl!)
        if image != nil {
            DispatchQueue.main.async {
                completion(image!)
            }
            return
        }
        
        let model = XDDownloadModel()
        model.key = imageUrl!
        model.completion = completion
        self.downloadCache.setObject(model as AnyObject, forKey: imageUrl as AnyObject)
        
        let api = URL(string: imageUrl!)
        
        let request = URLRequest(url: api!, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 10)
        
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue())
        session.dataTask(with: request).resume()
        
    }
    
}

// URLSessionDelegate
extension XDDownloadImageManager {
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(.performDefaultHandling,nil)
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        let key = dataTask.originalRequest?.url?.absoluteString
        let model = self.downloadCache.object(forKey: key as AnyObject) as? XDDownloadModel
        if model?.data == nil {
            model?.data = data
        } else {
            model?.data?.append(data)
        }
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        let key = task.originalRequest?.url?.absoluteString
        let model = self.downloadCache.object(forKey: key as AnyObject) as? XDDownloadModel
        if error != nil {
            model?.completion!(nil)
        } else {
            var downloadImage:UIImage?
            if model?.data != nil {
                downloadImage = UIImage(data: model!.data!)
            }
            if downloadImage != nil {
                if enbleLog {
                    print("download successed with url-\(key!)")
                }
                
                self.storeInMemory(model!.data!, key!)
                self.storeInDisk(model!.data!, key!)
                
            } else {
                if enbleLog {
                    print("there's a problem in download with url-\(key!)")
                }
            }
            model?.completion!(downloadImage)
        }
        self.downloadCache.removeObject(forKey: key as AnyObject)
    }
    
}

// prive func
extension XDDownloadImageManager {
    
    fileprivate func getCacheImage(_ key:String) -> UIImage? {
        var image:UIImage?
        
        image = self.getMemoryImage(key)
        if image != nil {
            if enbleLog {
                print("image is exist in Memory with url-\(key)")
            }
            return image
        }
        
        image = self.getDiskImage(key)
        if image != nil {
            if enbleLog {
                print("image is exist in Disk with url-\(key)")
            }
            return image
        }
        
        return image
    }
    
    fileprivate func getMemoryImage(_ key:String) -> UIImage? {
        var image:UIImage?
        let memoryData = self.cache.object(forKey: key as AnyObject) as? Data
        if memoryData != nil {
            image = UIImage(data: memoryData!)
        }
        return image
    }
    
    fileprivate func getDiskImage(_ key:String) -> UIImage? {
        var image:UIImage?
        
        let filePath = self.getImagePath(key)
        do {
            let diskData = try Data(contentsOf: URL(fileURLWithPath: filePath))
            image = UIImage(data: diskData)
            self.storeInMemory(diskData, key)
        } catch {
            
        }
        
        return image
    }
    
    fileprivate func storeInMemory(_ data:Data, _ key:String) {
        self.cache.setObject(data as AnyObject, forKey: key as AnyObject)
    }
    
    fileprivate func storeInDisk(_ data:Data, _ key:String) {
        let filePath = self.getImagePath(key)
        do {
            try data.write(to: URL(fileURLWithPath: filePath), options: .atomicWrite)
        } catch {
            if enbleLog {
                print("there's a problem in storing with url-\(key)")
            }
        }
    }
    
    fileprivate func getFoldPath() -> String {
        let home = NSHomeDirectory()
        let documentsPath = home + "/Documents/"
        return documentsPath
    }
    
    fileprivate func getImagePath(_ key:String) -> String {
        let documentsPath = self.getFoldPath()
        let imagePath = documentsPath + key.md5()
        return imagePath
    }
    
    fileprivate func isUrlEmpty(_ url:String?) -> Bool {
        if url == nil {
            return true
        }
        if url?.isEmpty == true {
            return true
        }
        if URL(string: url!) == nil {
            return true
        }
        return false
    }
    
}

extension String {
    func md5() -> String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deinitialize(count: digestLen)
        
        return String(format: hash as String)
    }
}

class XDDownloadModel : NSObject {
    
    var key:String?
    
    var data:Data?
    
    var completion:XDDownloadImageComplete?
    
}
