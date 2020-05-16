//
//  LPView.swift
//  artwallpapers
//
//  Created by Narek on 8/7/19.
//  Copyright © 2019 Narek Chang. All rights reserved.
//

import Foundation
import UIKit
import Photos
import PhotosUI
import MobileCoreServices
import AVFoundation
import AVKit
import AudioToolbox

var res: LivePhoto.LivePhotoResources!
var liveView = PHLivePhotoView();
let vibrate = UIImpactFeedbackGenerator(style: .light);

@objc(LPViewController)
class LPViewController: NSObject {
  @objc func saveLivePhotoToAlbum(_ callback: @escaping RCTResponseSenderBlock) -> Void {
    guard let resources = res else {
      return
    }
    LivePhoto.saveToLibrary(resources as LivePhoto.LivePhotoResources, completion: { (success) in
      var resultsDict: [String: Bool];
      
      if success {
        resultsDict = [
          "success" : true
        ];
      }
      else {
        resultsDict = [
          "success" : false
        ];
      }
      
      callback([NSNull(), resultsDict])
    })
  }
  
  @objc func startAnimation() -> Void {
    liveView.startPlayback(with: .hint);
    DispatchQueue.main.async {
      vibrate.impactOccurred();
    }
  }
  
  @objc func stopAnimation() -> Void {
    liveView.stopPlayback();
  }
}

@objc(LPView)
class LPView: UIView {
  static func requiresMainQueueSetup() -> Bool {
    return true
  }
  
  var progressView = UIProgressView();
  
  private var _videoUri = ""
  private var _imageUri = ""
  
  override init(frame: CGRect) {
    let bounds = UIScreen.main.bounds
    let w = bounds.size.width
    let h = bounds.size.height
    
    self.progressView.frame = CGRect(x: (w/2 - 40), y: (h/2 - 20), width: 80, height: 40);
    self.progressView.progressViewStyle = UIProgressViewStyle.bar;
//    self.progressView.reactZIndex = 999;
    self.progressView.tintColor = UIColor.white;
    
    let rect = CGRect(x: 0, y: 0, width: w, height: h)
    liveView = PHLivePhotoView(frame: rect)
    liveView.alpha = 0.0;
    liveView.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.0);
    
    vibrate.prepare();
    
    super.init(frame: frame);
    self.addSubview(self.progressView)
    self.addSubview(liveView);
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
  }
  
  func assembleLivePhoto() {
    let ik = URL(fileURLWithPath: self._imageUri);
    let vk = URL(fileURLWithPath: self._videoUri);
    
    LivePhoto.generate(from: ik, videoURL: vk, progress: { (percent) in
      DispatchQueue.main.async {
        self.progressView.progress = Float(percent);
      }
    }) { (livePhoto, resources) in
      liveView.livePhoto = livePhoto
      liveView.alpha = 1.0;
      
      self.progressView.isHidden = true;
      
      liveView.startPlayback(with: .hint)
      DispatchQueue.main.async {
        vibrate.impactOccurred();
      }
      
      res = resources;
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  @objc
  var imageUri: NSString? {
    set {
      if newValue != nil {
        self._imageUri = newValue! as String;
        
        if(self._videoUri != "") {
          self.assembleLivePhoto();
        }
      }
    }
    get {
      return nil;
    }
  }
  
  @objc
  var videoUri: NSString? {
    set {
      if newValue != nil {
        self._videoUri = newValue! as String;
        
        if(self._imageUri != "") {
          self.assembleLivePhoto();
        }
      }
    }
    get {
      return nil;
    }
  }
}
