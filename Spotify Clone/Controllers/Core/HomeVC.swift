//
//  ViewController.swift
//  Spotify Clone
//
//  Created by HAMZA on 25/6/2022.
//

import UIKit

class HomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Browse"
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(settingClicked))
        
        fetchData()
    }

    private func fetchData() {
        ApiManager.shared.getRecommendedGenres { result in
            switch result {
            case .success(let model):
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    

    
    @objc private func settingClicked() {
        let vc = SettingsVC()
        vc.title = "Setting"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }

}

