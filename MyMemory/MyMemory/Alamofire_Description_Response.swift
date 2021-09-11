//
//  Alamofire_Description_Response.swift
//  MyMemory
//
//  Created by YoungWoo Song on 2021/09/07.
//

import Foundation
import Alamofire

// Alamofire는 서버의 응답 메시지 처리를 지원하기 위해 다음과 같은 응답처리 메소드를 제공함

// response() : 응답 메시지에 특별한 처리를 하지 않음. 기본 형태이지만 URLSession 객체를 직접 사용하는것과 별반 차이가 없으므로 특별한 경우가 아니라면 사용되지 않음
// responseString() : 응답 메시지의 본문을 문자열로 처리한 후 전달함
// responseJSON() : 응답 메시지의 본문을 JSON 객체로 변환하여 전달함
// responseData() : 응답 메시지의 본문을 바이너리 데이터로 변환하여 전달함

// Alamofire는 비동기 기반으로 네트워크 응답을 처리하기 때문에 응답 메시지를 response 메소드의 결과값으로 받환받을 수는 없음
// 그에 대한 대안으로 우리는 서버로 부터 응답이 도착했을 떄 실행할 클로저로 미리 작성하여 위 메소드의 인자값으로 넣어주어야 함
// 일종의 콜백함수 같은거

// Alamofire는 서버에서 응답이 도착하면 이를 DataResponse 타입의 객체로 처리한 다음
// 이를 클로저의 매개변수에 답아 호출함
// 말이 쥰내 어렵다 코드 써보자
//let url = "http://swiftapi.rubypaper.co.kr:2029/practice/currentTime"
//Alamofire.request(url).responseString(){ response in
//    print("성공여부 : \(response.result.isSuccess)")
//    print("결과값 : \(response.result.value!)")
//}
