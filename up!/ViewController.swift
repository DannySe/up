//
//  ViewController.swift
//  up!
//
//  Created by Seledtsova, Daria on 07.09.18.
//  Copyright © 2018 dm-tech. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    private var motionManager: CMMotionManager!
    private var upView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        showUp()
        setupCoreMotion()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupCoreMotion() {
        motionManager = CMMotionManager()
        motionManager.deviceMotionUpdateInterval = 0.05
        startAsyncDeviceMotionUpdates()
    }
    
    fileprivate func startAsyncDeviceMotionUpdates() {
        motionManager.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler: {
            (deviceMotion, error) -> Void in
            if(error == nil) {
                self.handleDeviceMotionUpdates(deviceMotion)
            } else {
                // handle error
            }
        })
    }
    
    fileprivate func handleDeviceMotionUpdates(_ deviceMotion: CMDeviceMotion?) {
        if let gravity = deviceMotion?.gravity {
            let rotationDegrees = atan2(gravity.x, gravity.y) - Double.pi
            rotate(with: rotationDegrees)
        }
    }
    
    func showUp() {
        let screenSize: CGRect = UIScreen.main.bounds

        upView = UIImageView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
        upView.image = #imageLiteral(resourceName: "bloons")
        upView.contentMode = .scaleAspectFit
        
        self.view.addSubview(upView)
    }
    
    func rotate(with degrees: Double) {
        upView.transform = CGAffineTransform(rotationAngle: CGFloat(degrees))
    }

}

