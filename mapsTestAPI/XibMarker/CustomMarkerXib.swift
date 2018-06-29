//
//  CustomMarkerXib.swift
//  mapsTestAPI
//
//  Created by Fabio Sousa da Silva on 29/06/2018.
//  Copyright © 2018 br.com.mapsTestAPI. All rights reserved.
//

import UIKit

protocol  MapMarkerDelegate: class {
    func didTapInfoButton(data: NSDictionary)
}

class CustomMarkerXib: UIView {
    
    @IBOutlet weak var ghostBlueImage: UIImageView!
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var valor1Text: UILabel!
    @IBOutlet weak var valor2Text: UILabel!
    
    weak var delegate: MapMarkerDelegate?
    var spotData: NSDictionary?
    
    @IBAction func redButton(_ sender: Any) {
            delegate?.didTapInfoButton(data: spotData!)

    }
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "CustomMarkerXib", bundle: nil).instantiate(withOwner: self, options: nil).first as! UIView
    }
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
