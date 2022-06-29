//
//  WelcomeVC.swift
//  Spotify Clone
//
//  Created by HAMZA on 25/6/2022.
//

import UIKit

class WelcomeVC: UIViewController {

    private let signInBtn: UIButton = {
       let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Sign In with Spotify", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Spotify"
        view.backgroundColor = .systemGreen
        view.addSubview(signInBtn)
        signInBtn.addTarget(self, action: #selector(signInClicked), for: .touchUpInside)
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        signInBtn.frame = CGRect(x: 20,
                                 y: view.height-50-view.safeAreaInsets.bottom,
                                 width: view.width-40,
                                 height: 50)
    }

    @objc func signInClicked() {
        let vc = AuthVC()
        vc.completionHandler = { [weak self] success in
            DispatchQueue.main.async {
                self?.handleSignIn(success: success)
            }
            
        }
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func handleSignIn(success: Bool) {
        // Log user or error
        
        guard success else {
            
            let alert = UIAlertController(title: "Wrong", message: "Something went wrong with signing in", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true)
            return
            
        }
        
        let mainAppTabBarVC = TabBarVC()
        mainAppTabBarVC.modalPresentationStyle = .fullScreen
        present(mainAppTabBarVC, animated: true)
        
    }
    
}
