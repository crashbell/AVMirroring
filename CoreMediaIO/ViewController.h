//
//  ViewController.h
//  CoreMediaIO
//
//  Created by An Le Phu Nguyen on 9/9/16.
//  Copyright © 2016 An Le Phu Nguyen. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <CoreMediaIO/CMIOHardware.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : NSViewController <AVCaptureVideoDataOutputSampleBufferDelegate> {
    
}

@property (weak) IBOutlet NSView *cameraViewiPad;
@property (weak) IBOutlet NSView *cameraViewiPhone;
@property (nonatomic, strong) AVCaptureSession* captureSessioniPad;
@property (nonatomic, strong) AVCaptureSession* captureSessioniPhone;
@end

