//
//  LPMethods.swift
//
//  Created by Narek on 8/7/19.
//  Copyright © 2019 Narek Changlyan. All rights reserved.
//
import Foundation
import UIKit
import Photos
import PhotosUI
import MobileCoreServices
import AVFoundation
import AVKit

@objc(LPMethods)
class LPMethods: NSObject {
  var res: LivePhoto.LivePhotoResources!
  
  static func requiresMainQueueSetup() -> Bool {
    return true
  }
  
  override init() {
    
  }
  
  func cleanupDocumentsDirectory() {
    
    var documentsURL: URL?
    
    do {
      documentsURL = try FileManager.default.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    }
    catch {
      print(error)
      return
    }
    
    if let documentsPath = documentsURL?.path {
      
      guard let en = FileManager.default.enumerator(atPath: documentsPath) else {
        return
      }
      
      while let file = en.nextObject() {
        guard let fileURLToDelete = documentsURL?.appendingPathComponent(file as! String) else {
          continue
        }
        if FileManager.default.fileExists(atPath: fileURLToDelete.path) {
          do {
            
            try FileManager.default.removeItem(atPath: fileURLToDelete.path)
            
          } catch _ as NSError {
          }
        }
      }
    }
  }
  
  func setLivePhotResource(lp: LivePhoto.LivePhotoResources) {
    self.res = lp;
    print("self.res")
    print(self.res)
  }
  
  @objc func saveLivePhotoToAlbum(_ callback: @escaping RCTResponseSenderBlock) -> Void {
    let LPController = LPViewController();
    LPController.saveLivePhotoToAlbum(callback);
  }
  
  @objc func stopAnimation() -> Void {
    let LPController = LPViewController();
    LPController.stopAnimation();
  }
  
  @objc func startAnimation() -> Void {
    let LPController = LPViewController();
    LPController.startAnimation();
  }
}