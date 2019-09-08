//
//  LPViewModule.h
//
//  Created by Narek on 8/7/19.
//  Copyright © 2019 Narek Changlyan. All rights reserved.
//

#import <React/RCTViewManager.h>

NS_ASSUME_NONNULL_BEGIN

@interface LPViewModule : RCTViewManager
  @property (nonatomic, assign) NSString *imageUri;
  @property (nonatomic, assign) NSString *videoUri;
@end

NS_ASSUME_NONNULL_END