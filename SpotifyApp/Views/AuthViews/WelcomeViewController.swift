//
//  WelcomeViewController.swift
//  SpotifyApp
//
//  Created by A Mairam on 2/1/24.
//

import UIKit

class WelcomeViewController: UIViewController {

    private let signInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("Sign in", for: .normal)
        button.setTitleColor(.white, for: .normal)

        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Sporify"
        view.backgroundColor = .systemGreen
        view.addSubview(signInButton)
        
        NSLayoutConstraint.activate([
            signInButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInButton.widthAnchor.constraint(equalToConstant: 100),
            signInButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)

    }

    
    @objc func didTapSignIn() {
        let vc = AuthViewController()
        vc.completionHandler = { [weak self] success in
            DispatchQueue.main.async {
                self?.handleSignIn(success: success)
            }
        }
        
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }

    private func handleSignIn(success: Bool ){

        guard success else {
            let alert = UIAlertController(
                title: "Oops",
                message: "Something went wrong signing in.",
                preferredStyle: .alert
            )

            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true)
            return
        }
        
        let serchVC = TabBarController()
        navigationController?.setViewControllers([serchVC], animated: true)

    }
   
}
