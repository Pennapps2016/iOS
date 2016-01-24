//
//  ViewController.swift
//  Lazar
//
//  Created by Gurnoor Singh on 1/22/16.
//  Copyright © 2016 Cyberician. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, QRCodeReaderViewControllerDelegate {
    
    
    lazy var reader: QRCodeReaderViewController = {
        let builder = QRCodeViewControllerBuilder { builder in
            builder.reader          = QRCodeReader(metadataObjectTypes: [AVMetadataObjectTypeQRCode])
            builder.showTorchButton = true
        }
        
        return QRCodeReaderViewController(builder: builder)
    }()
    var toPass: String!
     func scanAction(sender: AnyObject) {
        if QRCodeReader.supportsMetadataObjectTypes() {
            reader.modalPresentationStyle = .FormSheet
            reader.delegate               = self
            
            reader.completionBlock = { (result: QRCodeReaderResult?) in
                if let result = result {
                    print("Completion with result: \(result.value) of type \(result.metadataType)")
                    print("\(self.toPass)")
                    print("\(health)")
                    //let url = NSURL(string: "http://shootat.me/api/\(self.toPass!)/\(result.value)/\(health!)")
                    if self.toPass == nil {
                        self.toPass = "8";
                    }
                    let url = NSURL(string: "http://shootat.me/api/\(self.toPass!)/\(result.value)/\(health!)")
                    
                    let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
                        print(NSString(data: data!, encoding: NSUTF8StringEncoding))
                        //self.performSegueWithIdentifier("backToCamera", sender: self)
                        self.presentViewController(CameraView(), animated: true, completion: nil)
                        
                    }
                    //task.resume()
                    //view.hidden = true
                }
            }
            self.presentViewController(reader, animated: true, completion: nil)
            
            
            
        }
        else {
            let alert = UIAlertController(title: "Error", message: "Reader not supported by the current device", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
            
            presentViewController(alert, animated: true, completion: nil)
        }
    }
    override func viewDidAppear(animated: Bool) {
        scanAction(self)
    }
    // MARK: - QRCodeReader Delegate Methods
    
    func reader(reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        self.dismissViewControllerAnimated(true, completion: { [weak self] in
            let alert = UIAlertController(
                title: "QRCodeReader",
                message: String (format:"%@ (of type %@)", result.value, result.metadataType),
                preferredStyle: .Alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
            
            self?.presentViewController(alert, animated: true, completion: nil)
            })
    }
    override func viewDidLoad() {
        view.hidden = true
    }
    
    func readerDidCancel(reader: QRCodeReaderViewController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}


