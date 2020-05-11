//
//  ViewController.swift
//  HealthKit Steps Reader Sample
//
//  Created by Appcelerator Developer on 11/5/20.
//  Copyright © 2020 Appcelerator Developer. All rights reserved.
//

import UIKit
import HealthKit

class ViewController: UIViewController {

    @IBAction func onTestClick() {
        print("Test button clicked")
        
        let hkManager = HealthKitManager()
        hkManager.authorizeHealthKit { (authorized, error) in
            // First ensure that the authorisation was successful
            guard authorized else {
              let baseMessage = "HealthKit Authorization Failed"
                  
              if let error = error {
                print("\(baseMessage). Reason: \(error.localizedDescription)")
              } else {
                print(baseMessage)
              }
                  
              return
            }
                
            print("HealthKit Successfully Authorized.")
            
            // Now read the steps data
            guard let heightSampleType = HKSampleType.quantityType(forIdentifier: .stepCount) else {
              print("StepCount Sample Type is no longer available in HealthKit")
              return
            }
            
            hkManager.getMostRecentSample(for: heightSampleType) { (steps, error) in
                guard error == nil else {
                    print("Error: \(error)")
                    return
                }
                
                let result = steps!
                print("Result: \(result.quantity), \(result.startDate)")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}
