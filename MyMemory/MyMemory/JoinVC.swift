//
//  JoinVC.swift
//  MyMemory
//
//  Created by YoungWoo Song on 2021/09/08.
//

import UIKit
import Alamofire

class JoinVC : UIViewController, UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    
    @IBOutlet weak var profile: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    var fieldAccount: UITextField!
    var fieldPassworld: UITextField!
    var fieldName: UITextField!
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        //프로필 이미지 원형으로 설정
        self.profile.layer.cornerRadius = self.profile.frame.width / 2
        self.profile.layer.masksToBounds = true
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tappedProfile(_:)))
        self.profile.addGestureRecognizer(gesture)
        self.view.bringSubviewToFront(self.indicatorView)
    }
    
    @objc
    func tappedProfile(_ sender: Any) {
        let msg = "프로필 이미지를 읽어올 곳을 선택하세요."
        
        let sheet = UIAlertController(title: msg, message: nil, preferredStyle: .actionSheet)
        
        sheet.addAction(UIAlertAction(title: "취소", style: .cancel))
        sheet.addAction(UIAlertAction(title:"저장된 앨범", style: .default){ (_) in
            selectLibrary(src: .savedPhotosAlbum) //저장된 앨범에서 이미지 선택하기
        })
        sheet.addAction(UIAlertAction(title: "포토 라이브러리", style: .default){ (_) in
            selectLibrary(src: .photoLibrary) //포토 라이브러리 이미지 선택하기
        })
        sheet.addAction(UIAlertAction(title: "카메라", style: .default){ (_) in
            selectLibrary(src: .camera) // 카메라에서 이미지 촬영하기
        })
        
        self.present(sheet, animated: false)
        
        func selectLibrary(src: UIImagePickerController.SourceType){
            if UIImagePickerController.isSourceTypeAvailable(src) {
                let picker = UIImagePickerController()
                picker.delegate = self
                picker.allowsEditing = true
                
                self.present(picker, animated: false)
            }else {
                
            }
        }
    }
   
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            self.profile.image = image
        }
        self.dismiss(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        let tfFrame = CGRect(x: 20, y: 0, width: cell.bounds.width - 20, height: 37)
        
        switch indexPath.row {
        case 0:
            self.fieldAccount = UITextField(frame: tfFrame)
            self.fieldAccount.placeholder = "계정(이메일)"
            self.fieldAccount.borderStyle = .none
            self.fieldAccount.autocapitalizationType = .none
            self.fieldAccount.font = UIFont.systemFont(ofSize: 14)
            cell.addSubview(self.fieldAccount)
        
        case 1:
            self.fieldPassworld = UITextField(frame: tfFrame)
            self.fieldPassworld.placeholder = "비밀번호"
            self.fieldPassworld.borderStyle = .none
            self.fieldPassworld.isSecureTextEntry = true
            self.fieldPassworld.font = UIFont.systemFont(ofSize: 14)
            cell.addSubview(self.fieldPassworld)
    
        case 2:
            self.fieldName = UITextField(frame: tfFrame)
            self.fieldName.placeholder = "이름"
            self.fieldName.borderStyle = .none
            self.fieldName.font = UIFont.systemFont(ofSize: 14)
            cell.addSubview(self.fieldName)
        default:
            ()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
   
    
    @IBAction func submit(_ sender: Any) {
        
        self.indicatorView.startAnimating()
        
        // 1. 전달할 값 준비
        // 1-1. 이미지를 Base64  인코딩 처리
        let profile = self.profile.image!.pngData()?.base64EncodedString()
        
        let param : Parameters = [
            "account"   : self.fieldAccount.text!,
            "password"  : self.fieldName.text!,
            "name"      : self.fieldName.text!,
            "profile_image" : profile!
        ]
        
        // 2. API 호출
        let url = "http://swiftapi.rubypaper.co.kr:2029/userAccount/join"
        let cell = Alamofire.request(url, method: .post, parameters: param, encoding: JSONEncoding.default)
        
        // 3. 서버 응답값 처리
        cell.responseJSON{ res in
            
            self.indicatorView.stopAnimating()
            
            // 3-1. JSON 형식으로 값이 제대로 전달되었는지 확인
            guard let jsonObject = res.result.value as? [String : Any] else {
                self.alert(_message: "서버 호출 과정에서 오류가 발생했습니다.")
                return
            }
            
            // 3-2. 응답 코드 확인, 0이면 성공
            let resultCode = jsonObject["result_code"] as! Int
            if resultCode == 0{
                self.alert(_message: "가입이 완료되었습니다.")
            }else {
                let errorMsg = jsonObject["error_msg"] as! String
                self.alert(_message: "오류발생 : \(errorMsg)")
            }
        }
    }
}

extension JoinVC{
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
