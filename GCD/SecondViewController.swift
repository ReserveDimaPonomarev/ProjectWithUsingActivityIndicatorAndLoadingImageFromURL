//
//  SecondViewController.swift
//  GCD
//
//  Created by Дмитрий Пономарев on 17.02.2023.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    fileprivate var imageURL: URL?
    fileprivate var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImage()
        delay(3) {
            self.alertLogin()
        }
    }
    
    fileprivate func delay(_ delay: Int, clouser: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
            clouser()
        }
    }
    
    fileprivate func alertLogin () {
        let ac = UIAlertController(title: "зарегестрированы?", message: "Введите ваш логин и пароль", preferredStyle: .alert)
        let ok = UIAlertAction(title: "ok", style: .default)
        let cancel = UIAlertAction(title: "cancel", style: .cancel)
        ac.addAction(ok)
        ac.addAction(cancel)
        ac.addTextField { (userNameTF:UITextField) in
            userNameTF.placeholder = "Введите имя"
        }
        ac.addTextField { (userPasswordTF:UITextField) in
            userPasswordTF.placeholder = "Введите пароль"
            userPasswordTF.isSecureTextEntry = true
        }
        present(ac, animated: true)
    }
    fileprivate func fetchImage() {
        imageURL = URL(string: "https://interier-foto.ru/wp-content/uploads/krasivye-foto-vysokogo-razresheniya-2.jpg")
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        DispatchQueue.global(qos: .utility).async {
            guard let url = self.imageURL, let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: imageData)
            }
            
        }
        
    }
}
