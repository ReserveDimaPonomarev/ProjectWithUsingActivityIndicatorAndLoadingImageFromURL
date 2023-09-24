import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

class MyViewController:  UIViewController {
    
    private let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view?.backgroundColor = .white
        title = "FirstVC"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        initButton()
//        test()
    }
    
    private func test() {
        let queue = DispatchQueue(label: "despqueu", attributes: .concurrent)
        let workItem = DispatchWorkItem {
            print("test")
            print(Thread.current)
        }
        workItem.notify(queue: .main ) {
            print("somenotif")
            print(Thread.current)
        }
        queue.async(execute: workItem)
        
    }
    
    private func somef() {

        
    }

    private func initButton() {
        view.addSubview(button)
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        button.center = view.center
        button.setTitle("Button", for: .normal)
        button.backgroundColor = .green
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(tapButton), for: .touchDown)
    }
    
    @objc func tapButton() {
        navigationController?.pushViewController(secondVC, animated: true)
    }
}

class SecondViewController:  UIViewController {

    private let imageView = UIImageView()
    private let activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view?.backgroundColor = .white
        title = "SecondVC"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        initImage()
        initActivitIndicator()
        afterBlock1(secods: 0,dispatchQueue: .main, complition: url)
    }
    
    private func afterBlock1(secods: Int, dispatchQueue: DispatchQueue = DispatchQueue.global(), complition: @escaping()->()) {
        dispatchQueue.asyncAfter(deadline: .now() + .seconds(secods), execute: {
            complition()
        })
            
        }
    
    private func url (){
        let imageURl = URL(string: "https://www.worldometers.info/img/maps/france_physical_map.gif")!
        let dq = DispatchQueue.global()
        
        let dwi = DispatchWorkItem (qos: .background, block: {
            print(Thread.current)

            if let data = try? Data(contentsOf: imageURl) {
                self.imageView.image = UIImage(data: data)
                self.activityIndicator.stopAnimating()
            }
            
            print(Thread.current)
            })
        dq.sync(execute: dwi)
//                dwi.perform()
//        dwi.wait()
        print(1)
        print(Thread.current)
//        sleep(5)
        

        }
        
    
    
    private func initImage() {
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        imageView.center = view.center
        imageView.backgroundColor = .systemYellow
        view.addSubview(imageView)
        
    }
    private func initActivitIndicator() {
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }
}

let vc = MyViewController()
let navBar = UINavigationController(rootViewController: vc)

let secondVC = SecondViewController()
let secondNavBar = UINavigationController(rootViewController: secondVC)
navBar.view.frame = CGRect(x: 0, y: 0, width: 250, height: 450)

PlaygroundPage.current.liveView = navBar


