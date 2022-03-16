//
//  DetailViewController.swift
//  CryptoCurrencyApp
//
//  Created by Mücahit Eren Özkur on 16.03.2022.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var changeLabel: UILabel!
    @IBOutlet weak var highestPrice: UILabel!
    @IBOutlet weak var lowestPrice: UILabel!
    
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var highLowView: UIView!
    
    var cryptoModel: CryptoModel!
    var highest: Float?
    var lowest: Float?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\(cryptoModel.symbol) - \(cryptoModel.name)"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: "SparklinesTableViewCell", bundle: nil), forCellReuseIdentifier: "sparkCell")
        
        priceLabel.text = cryptoModel.price
        changeLabel.text = cryptoModel.change
        
        guard let change = changeLabel.text?.hasPrefix("-") else { return }
        if change { changeLabel.textColor = .systemRed }
        else { changeLabel.textColor = .systemGreen }
        
        priceView.layer.cornerRadius = 20
        highLowView.layer.cornerRadius = 20
        
        cryptoModel.sparkLines?.reverse()
        findHighestLowestPrices()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func findHighestLowestPrices() {
        highest = Float(cryptoModel.sparkLines![0])
        lowest = Float(cryptoModel.sparkLines![0])
        
        for i in 1 ..< cryptoModel.sparkLines!.count {
            if Float(cryptoModel.sparkLines![i])! > highest! {
                highest = Float(cryptoModel.sparkLines![i])
            }
            if Float(cryptoModel.sparkLines![i])! < lowest! {
                lowest = Float(cryptoModel.sparkLines![i])
            }
        }
        
        highestPrice.text = "High: \(highest?.description ?? "00")"
        highestPrice.textColor = .systemGreen
        lowestPrice.text = "Low: \(lowest?.description ?? "00")"
        lowestPrice.textColor = .systemRed
    }

}

extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptoModel.sparkLines!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "sparkCell", for: indexPath) as? SparklinesTableViewCell else {
            print("error")
            fatalError()
        }
        
        cell.layer.cornerRadius = 10
        cell.backgroundColor = .systemGray6
        cell.sparkLineLabel.text = "$" + cryptoModel.sparkLines![indexPath.row].components(separatedBy: ".")[0] + "." + cryptoModel.sparkLines![indexPath.row].components(separatedBy: ".")[1][0..<3]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
