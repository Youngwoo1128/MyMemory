//
//  MyMemoryViewController.swift
//  MyMemory
//
//  Created by YoungWoo Song on 2021/09/08.
//

import UIKit

class MyMemoryViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension MyMemoryViewController {
    
    func alert(_message: String, completion: (()->Void)? = nil){
        
        // 메인 스레드에서 실행
        DispatchQueue.main.async {
            let alert = UIAlertController(title: nil, message: _message, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "확인", style: .cancel) { (_) in
                completion?()
                
            }
            alert.addAction(okAction)
            self.present(alert, animated: false)
        }
    }
}
