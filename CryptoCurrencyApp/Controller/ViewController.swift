//
//  ViewController.swift
//  CryptoCurrencyApp
//
//  Created by Mücahit Eren Özkur on 15.03.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionFlowLayout: UICollectionViewFlowLayout!
    
    var cryptos = [CryptoModel](){
        didSet {
            DispatchQueue.main.async {
                print(self.cryptos.count)
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        getAllData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    private func getAllData () {
        CryptoRequest.shared.getAllData { result in
            switch result {
            case .success(let cryptoss):
                self.cryptos = cryptoss.compactMap({
                    CryptoModel(symbol: $0.symbol, name: $0.name, iconURL: URL(string: $0.iconURL.replacingOccurrences(of: "svg", with: "png")), price: "$\($0.price.components(separatedBy: ".")[0]).\($0.price.components(separatedBy: ".")[1][0..<3])", change: $0.change + "%", sparkLines: $0.sparkline)
                })
            break
            case .failure(let error):
                print(error)
            break
            }
        }
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cryptos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cryptoCell", for: indexPath) as? CryptoCollectionViewCell else {
            print("error")
            fatalError()
        }
        cell.configure(with: cryptos[indexPath.row])
        cell.layer.cornerRadius = 10
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("yes")
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        let crypto = cryptos
        vc.cryptoModel = crypto[indexPath.row]
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


