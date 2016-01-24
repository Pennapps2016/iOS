//
//  View2.swift
//  SnapchatCamera
//
//  Created by Gurnoor Singh on 1/23/16.
//  Copyright (c) 2015 Cyberician. All rights reserved.
//

import UIKit
import AVFoundation

class CameraView : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, AVCaptureMetadataOutputObjectsDelegate{
    var toPass: String!
    var captureSession : AVCaptureSession?
    var stillImageOutput : AVCaptureStillImageOutput?
    var previewLayer : AVCaptureVideoPreviewLayer?
    @IBOutlet var cameraView: UIView!
    var vwQRCode:UIView?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupReplicatorLayers()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        previewLayer?.frame = cameraView.bounds
    }
    
    func setupReplicatorLayers() {
        // Session
        let session: AVCaptureSession = AVCaptureSession()
        // Capture device
        // Device input
        var captureDevice: AVCaptureDevice;
        var input :AVCaptureInput = AVCaptureDeviceInput()
        do {
            captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
            input = try AVCaptureDeviceInput(device: captureDevice)
            // Do the rest of your work...
        } catch let error as NSError {
            // Handle any errors
            print(error)
        }
        if session.canAddInput(input) {
            session.addInput(input)
        }
        // Preview
        let previewLayer: AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = .None
        previewLayer.frame = CGRectMake(0.0, 0.0, self.view.bounds.size.width, self.view.bounds.size.height)
        let replicatorInstances: Int = 2
        let replicatorViewHeight: CGFloat = CGFloat(Int(self.view.bounds.size.height) / replicatorInstances)
        // Note: 64.0 is to account for the status bar and navigation bar
        //Create the replicator layer
        let replicatorLayer: CAReplicatorLayer = CAReplicatorLayer.init()
        replicatorLayer.frame = CGRectMake(0, 0.0, self.view.bounds.size.width, replicatorViewHeight)
        replicatorLayer.instanceCount = replicatorInstances
        replicatorLayer.instanceTransform = CATransform3DMakeTranslation(0.0, replicatorViewHeight, 0.0)
        replicatorLayer.addSublayer(previewLayer)
        self.view.layer.addSublayer(replicatorLayer)
        session.startRunning()
    }
    
    
    
}