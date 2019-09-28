//
//  ProfileViewController.swift
//  climate
//
//  Created by Roland Michelberger on 28.09.19.
//  Copyright © 2019 hack zurich. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet private weak var trainLabel: UILabel!
    @IBOutlet private weak var bikeLabel: UILabel!
    @IBOutlet private weak var walkLabel: UILabel!
    @IBOutlet private weak var totalLabel: UILabel!

    @IBOutlet private weak var trainButton: UIButton!
    @IBOutlet private weak var bikeButton: UIButton!
    @IBOutlet private weak var walkButton: UIButton!
    @IBOutlet private weak var totalButton: UIButton!
    
    @IBOutlet private weak var bikeStackView: UIStackView!
    @IBOutlet private weak var totalStackView: UIStackView!
    @IBOutlet private weak var walkStackView: UIStackView!
    @IBOutlet private weak var trainStackView: UIStackView!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let points = Points.shared
        show(points: points)
        
//        walkButton.tintColor = .greenSea
//        trainButton.tintColor = .carrot
//        bikeButton.tintColor = .oceanBlue
//        totalButton.tintColor = .black
//
//        walkLabel.textColor = .greenSea
//        trainLabel.textColor = .carrot
//        bikeLabel.textColor = .oceanBlue
//        totalLabel.textColor = .black
        
        let alpha: CGFloat = 0.9
        bikeStackView.addBackground(color: UIColor.oceanBlue.withAlphaComponent(alpha))
        totalStackView.addBackground(color: UIColor.pomegranate.withAlphaComponent(alpha))
        trainStackView.addBackground(color: UIColor.carrot.withAlphaComponent(alpha))
        walkStackView.addBackground(color: UIColor.greenSea.withAlphaComponent(alpha))

        
        title = "Profile"
        
    }
    
    @IBAction func share() {
        let text = "I have saved 168.4kg CO2 and collected \(Points.shared.totalPoints) 🐧!\nWhat about you?\n\n#climateChange #impact #getItDone #hackzurich #saveThePenguines #pingo\n\n🌳🌱"
        
        // set up activity view controller
        let textToShare = [text]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        
        // present the view controller
        present(activityViewController, animated: true, completion: nil)
    }
    
    func show(points: Points) {
        show(points: points.trainPoints, on: trainLabel)
        show(points: points.bikePoints, on: bikeLabel)
        show(points: points.walkPoints, on: walkLabel)
        show(points: points.trainPoints, on: trainLabel)
        show(points: points.totalPoints, on: totalLabel)
    }
    
    func show(points: Double, on label: UILabel) {
        label.text = "\(points) 🐧"
    }

    @IBAction func clicked(button: UIButton) {
        
        let discount: Discount
        
        switch button {
        case trainButton:
            print("train")
            discount = Discount.trainDiscount
        case walkButton:
            print("walk")
            discount = Discount.healthInsuranceDiscount
        case bikeButton:
            print("bike")
            discount = Discount.bikeDiscount
        default:
            print("total")
            discount = Discount.carInsuranceDiscount

        }
        
        guard let discountViewController = storyboard?.instantiateViewController(withIdentifier: "DiscountViewController") as? DiscountViewController else {
            return
        }
        
        discountViewController.discount = discount
        
        show(discountViewController, sender: nil)
        
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
