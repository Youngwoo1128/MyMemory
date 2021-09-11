//
//  ViewController.swift
//  MyMemory
//
//  Created by YoungWoo Song on 2021/09/07.
//


//Alamofire_Description.swift 고고씽 
import UIKit
import Alamofire


class ViewController: UIViewController {
    
    @IBOutlet weak var aaa: UILabel!
    @IBOutlet weak var goToMemory: UIButton!
    
    let currentTime = "http://swiftapi.rubypaper.co.kr:2029/practice/currentTime"
    let echo = "http://swiftapi.rubypaper.co.kr:2029/practice/echo"
    
    let param : Parameters = [
        "userId" : "sqlpro",
        "name" : "영우"
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //get
//        Alamofire.request(currentTime).responseString() { response in
//            print("성공여부 : \(response.result.isSuccess)")
//            print("결과값 : \(response.result.value!)")
//            self.aaa.text = "\(response.result.value!)"
//        }
        
        //post
        let alamo = Alamofire.request(echo, method: .post, parameters: param, encoding: URLEncoding.httpBody)

        alamo.responseJSON() { response in

            print("JSON = \(response.result.value!)")
            if let jsonObject = response.result.value as? [String : Any]{

                print("userId = \(jsonObject["userId"]!)")
                print("name = \(jsonObject["name"]!)")
            }
        }
        
        goToMemory.addTarget(self, action: #selector(goToMemoryViewController), for: .touchUpInside)
    }
    
    @objc
    func goToMemoryViewController() {
        let memoryViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MemoryViewController")
        
        memoryViewController.modalPresentationStyle = .fullScreen
        
        present(memoryViewController, animated: true, completion: nil)
        
    }


}

