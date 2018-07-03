//
//  CustomMarkerXib.swift
//  mapsTestAPI
//
//  Created by Fabio Sousa da Silva on 29/06/2018.
//  Copyright © 2018 br.com.mapsTestAPI. All rights reserved.
//

import UIKit

class CustomMarkerXib: UIView {
    
    
    
    @IBOutlet weak var ghostBlueImage: UIImageView!
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var valor1Text: UILabel!
    @IBOutlet weak var valor2Text: UILabel!
    

    override init(frame: CGRect) {
        super.init(frame: frame)
//        commomInit()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        commomInit()
    }
    
    private func commomInit() {
        Bundle.main.loadNibNamed("CustomMarkerXib", owner: self, options: nil)

    }
    
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
