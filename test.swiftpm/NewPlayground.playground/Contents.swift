import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true





let dispQueue = DispatchQueue(label: "ji", attributes: .concurrent)
let dispGroupRed = DispatchGroup()
let dispGroupBlack = DispatchGroup()

//func makeImage(url: [String], imagesViews: [UIImageView], dispQueue: DispatchQueue) {
//    dispGroupRed.enter()
//    dispQueue.async(group: dispGroupRed) {
//        for i in 0...1 {
//            let URL = URL(string: url[i])
//            if let data = try? Data(contentsOf: URL!) {
//                DispatchQueue.main.async {
//                    imagesViews[i].image = UIImage(data: data)
//                    view.addSubview(imagesViews[i])
//                }
//            }
//        }
//    }
//    dispGroupRed.leave()
//    dispGroupBlack.enter()
//    dispQueue.async(group: dispGroupRed) {
//        for i in 2...3 {
//            let URL = URL(string: url[i])
//            if let data = try? Data(contentsOf: URL!) {
//                DispatchQueue.main.async {
//                    imagesViews[i].image = UIImage(data: data)
//                    view.addSubview(imagesViews[i])
//                }
//            }
//        }
//    }
//    dispGroupBlack.leave()
//    print("ji")
    
//}

//makeImage(url: URLsArray, imagesViews: arraimageview, dispQueue: .global())
let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
PlaygroundPage.current.liveView = view
view.backgroundColor = .brown

class Oper: Operation {
    
    let operationQueue = OperationQueue()
    var arraimageview = [UIImageView]()
    func vie() {
        view.backgroundColor = .gray
    }
    func addarray() {
        view.backgroundColor = .blue

//        PlaygroundPage.current.liveView = view

        arraimageview.append(UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50)))
        arraimageview.append(UIImageView(frame: CGRect(x: 50, y: 0, width: 50, height: 50)))
        arraimageview.append(UIImageView(frame: CGRect(x: 0, y: 50, width: 50, height: 50)))
        arraimageview.append(UIImageView(frame: CGRect(x: 50, y: 50, width: 50, height: 50)))

    }
    
    var imar = [UIImage]()
    
    let URLsArray = ["https://upload.wikimedia.org/wikipedia/commons/thumb/c/c4/Satellite_image_of_France_in_August_2002.jpg/1200px-Satellite_image_of_France_in_August_2002.jpg", "https://www.lulu-berlu.com/upload/image/play-big-2000---ref5932-bakery--konditorei---p-image-316985-grande.jpg", "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7e/Electricity_in_France.svg/800px-Electricity_in_France.svg.png", "https://cdn.britannica.com/97/184197-050-BB640A1E/World-Data-ethnic-composition-pie-chart-France.jpg"]
    
    
    
    //let operation2 = BlockOperation {
    //    for i in 0...1 {
    //        arraimageview[i].image = imar[i]
    //        view.addSubview(arraimageview[i])
    //    }
    //}
    func new() {
        addarray()
        
        operationQueue.addOperation { [self] in

            for i in URLsArray.indices {
                let URL = URL(string: URLsArray[i])
                if let data = try? Data(contentsOf: URL!) {
                    imar.append(UIImage(data: data)!)
                }
            }
        }
        
        operationQueue.waitUntilAllOperationsAreFinished()
        
        operationQueue.addOperation { [self] in
            for i in arraimageview.indices {
                arraimageview[i].image = imar[i]
            }
            
            //let operation = BlockOperation {
            //    for i in 0...3 {
            //        print(Thread.current)
            //        let URL = URL(string: URLsArray[i])
            //        if let data = try? Data(contentsOf: URL!) {
            //            imar.append(UIImage(data: data)!)
            //            arraimageview[i].image = UIImage(data: data)
            //            view.addSubview(arraimageview[i])
        }
        operationQueue.waitUntilAllOperationsAreFinished()
        sleep(2)
        for each in arraimageview {
            each.backgroundColor = .gray
            view.addSubview(each)
            arraimageview
        }

        operationQueue.waitUntilAllOperationsAreFinished()
        sleep(2)
        operationQueue.addOperation {
            print("allFinished")
        }
    }
    
    
}
//    operation.cancel()
//    operationQueue.addOperation(operation2)

//operationQueue.addOperation(operation)
//operation.start()
//operation2.start()

let se = Oper()
se.new()


