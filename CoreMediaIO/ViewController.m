//
//  ViewController.m
//  CoreMediaIO
//
//  Created by An Le Phu Nguyen on 9/9/16.
//  Copyright © 2016 An Le Phu Nguyen. All rights reserved.
//

#import "ViewController.h"

void EnableDALDevices()
{
    CMIOObjectPropertyAddress prop = {
        kCMIOHardwarePropertyAllowScreenCaptureDevices,
        kCMIOObjectPropertyScopeGlobal,
        kCMIOObjectPropertyElementMaster
    };
    UInt32 allow = 1;
    CMIOObjectSetPropertyData(kCMIOObjectSystemObject,
                              &prop, 0, NULL,
                              sizeof(allow), &allow );
}

void start() {
    EnableDALDevices();
}

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    start();
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
}

- (void) startStream:(NSString *)deviceName withView:(NSView *)view andSession:(AVCaptureSession *)captureSession{
    BOOL found;
    while(!found) {
        NSArray* devs = [AVCaptureDevice devices];
        for(AVCaptureDevice* device in devs) {
            if ([[device localizedName] isEqualToString:deviceName]) {
                found = YES;
                
                
                NSError *deviceError;
                AVCaptureDeviceInput *inputDevice;
                AVCaptureVideoDataOutput *outputDevice;
                AVCaptureVideoPreviewLayer* captureVideoPreviewLayer;
                
                captureSession = [[AVCaptureSession alloc] init];
                captureSession.sessionPreset = AVCaptureSessionPresetMedium;
                
                outputDevice = [[AVCaptureVideoDataOutput alloc] init];
                [outputDevice setSampleBufferDelegate:self queue:dispatch_get_main_queue()];

                inputDevice = [AVCaptureDeviceInput deviceInputWithDevice:device error:&deviceError];
                
                [captureSession addInput:inputDevice];
                [captureSession addOutput:outputDevice];
                
                // make preview layer and add so that camera's view is displayed on screen
                captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:captureSession];
                [captureVideoPreviewLayer setBackgroundColor:[[NSColor yellowColor] CGColor]];
                captureVideoPreviewLayer.frame = view.bounds;
                
                [view setWantsLayer:YES];
                [view.layer addSublayer: captureVideoPreviewLayer];
                [captureSession startRunning];
            }
        }
    }
}

- (IBAction)stopiPad:(id)sender {
    [self.captureSessioniPad stopRunning];
}

- (IBAction)stopiPhone:(id)sender {
    [self.captureSessioniPhone stopRunning];
}

- (IBAction)playiPad:(id)sender {
    [self startStream:@"iPad" withView:self.cameraViewiPad andSession:self.captureSessioniPad];
}

- (IBAction)playiPhone:(id)sender {
    [self startStream:@"iPhone 5" withView:self.cameraViewiPhone andSession:self.captureSessioniPhone];
}
@end
