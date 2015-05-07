//
//  ViewController.h
//  Test
//
//  Created by 田光鑫 on 15/4/14.
//  Copyright (c) 2015年 Wohai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController
{
    AVAsset *asset;
    AVPlayerItem *playerItem;
    AVPlayer *player;
}
@end

