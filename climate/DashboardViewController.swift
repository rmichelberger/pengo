//
//  DashboardViewController.swift
//  climate
//
//  Created by Roland Michelberger on 28.09.19.
//  Copyright © 2019 hack zurich. All rights reserved.
//

import UIKit

struct Score {
    let name: String
    let co2Saving: Double
}

class DashboardViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!

    private var scores = [Score]()
    
    private let groupsScore = [Score(name: "HackZurich", co2Saving: 610.2),
    Score(name: "Save the penguins", co2Saving: 1640.6),
    Score(name: "ETH alumni", co2Saving: 210.7),
    Score(name: "FC Zürich fans", co2Saving: 110.4),
    Score(name: "SAC", co2Saving: 2140.4),
    Score(name: "HELSANA", co2Saving: 810.4),
    Score(name: "randstad", co2Saving: 730.4),
    Score(name: "Credit Suisse", co2Saving: 440.6)]

    private let citiesScore = [Score(name: "Zürich", co2Saving: 1640.6),
                                Score(name: "Bern", co2Saving: 1640.6),
                                Score(name: "Luzern", co2Saving: 1640.6),
                                Score(name: "Zug", co2Saving: 1640.6),
                                Score(name: "Lugano", co2Saving: 1640.6),
                                Score(name: "Locarno", co2Saving: 1640.6),
                                Score(name: "Lausanne", co2Saving: 1640.6),
                                Score(name: "Geneva", co2Saving: 1640.6),
                                Score(name: "Schaffhausen", co2Saving: 1640.6),
                                Score(name: "Basel", co2Saving: 1640.6)]

    private let countriesScore = [Score(name: "Switzerland 🇨🇭", co2Saving: 1640.6),
                                Score(name: "Germany 🇩🇪", co2Saving: 1640.6),
                                Score(name: "Hungary 🇭🇺", co2Saving: 1640.6),
                                Score(name: "Israel 🇮🇱", co2Saving: 1640.6),
                                Score(name: "Spain 🇪🇸", co2Saving: 1640.6),
                                Score(name: "France 🇫🇷", co2Saving: 1640.6),
                                Score(name: "Sweden 🇸🇪", co2Saving: 1640.6),
                                Score(name: "Norway 🇳🇴", co2Saving: 1640.6),
                                Score(name: "Italy 🇮🇹", co2Saving: 1640.6)]

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        scores = groupsScore.sorted(by: { return $0.co2Saving > $1.co2Saving })
    }
    
    @IBAction func changed(segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 1:
            scores = citiesScore
        case 2:
            scores = countriesScore
        default:
            scores = groupsScore
        }
        scores = scores.sorted(by: {return $0.co2Saving > $1.co2Saving})
        tableView.reloadData()
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

extension DashboardViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let score = scores[indexPath.row]
        
        cell.textLabel?.text = score.name
        let co2Saving = MassFormatter().string(fromValue: score.co2Saving, unit: .kilogram)
        cell.detailTextLabel?.text = "Saved CO2: \(co2Saving)"
        
        return cell
    }
}
