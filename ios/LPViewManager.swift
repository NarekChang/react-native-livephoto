//
//  LPViewManager.swift
//
//  Created by Narek on 8/7/19.
//  Copyright © 2019 Narek Changlyan. All rights reserved.
//
import Foundation

@objc(LPViewManager)
class LPViewManager : RCTViewManager {
  override func view() -> UIView! {
    return LPView();
  }
}