//
//  DiscountViewController.swift
//  climate
//
//  Created by Roland Michelberger on 28.09.19.
//  Copyright © 2019 hack zurich. All rights reserved.
//

import UIKit

class DiscountViewController: UIViewController {

    var discount: Discount?
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var logoImageView: UIImageView!
    @IBOutlet private weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = discount?.image
        textView.text = discount?.text
        logoImageView.image = discount?.logo

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
