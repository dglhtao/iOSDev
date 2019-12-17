//
//  SeeDrController.swift
//  DrPt
//
//  Created by 李海涛 on 2019/12/14.
//  Copyright © 2019 李海涛. All rights reserved.
//

import UIKit

class SeeDrController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    let pts = ["赵患者 2019-11-01","钱患者 2019-11-02","孙患者 2019-11-03","王患者 2019-11-20"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pts.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pts[row]
    }
}
