
//
//  LPViewModule.m
//  artwallpapers
//
//  Created by Narek on 8/7/19.
//  Copyright © 2019 Narek Changlyan. All rights reserved.
//

#import "LPViewModule.h"
#import <React/RCTViewManager.h>

@interface RCT_EXTERN_MODULE(LPViewManager, RCTViewManager)
  RCT_EXPORT_VIEW_PROPERTY(imageUri, NSString);
  RCT_EXPORT_VIEW_PROPERTY(videoUri, NSString);
@end