//
//  Alamofire_Description.swift
//  MyMemory
//
//  Created by YoungWoo Song on 2021/09/07.
//

import Foundation
import Alamofire

//1. Alamofire로 api 호출하는법
// Alamofire.request("www.naver.com")
// 이게끝임
// 매우 간단함
// 통신 메소드는 어떻게 정하냐고?
// 일단 Alamofire의 기본 메소드는 GET

// 2. POST로 하고싶으면 ???
// Alamofire.request("호출URL", method: .post)
// 이렇게 하면 됨
// 이렇게 하면 HTTPMethod 열거형 객체에 정의 되어있음

// 3. 전달 해야할 값이 있을 경우엔 세번째 매개변수인 parameters를 사용하면됨
// 이 변수는 키&값 형식인 딕셔너리 타입을 기반으로 함

let param : Parameters = [
    "userId" : "pine951128",
    "name" : "송영우"
]
// Alamofire.request("호출URL", method: .post, parameters: param)

// 4. 만약 전달하는 값에 특수문자나 한글 등이 포함되어 있을 경우, 서버에서 잘못 받아들이지 않도록 인코딩 과정을 거쳐야 하는데, 이때 request 메[소드의 네번째 매개변수 encoding을 쓰면 됨
// Alamofire.request("호출URL", method: .post, parameters: param, encoding: URLEncoding.httpBody)

// 5. 매개변수 encoding 은 프로토콜인 ParamteterEncoding 타입으로, 이 프로토콜을 구현한 열거형이나 구조체, 또는 클래스 객체를 인자값으로 입력 받을수 있음
// 대표적으로 사용되는 것이 URLEncoding 구조체로, 이 구조체에는 3가지 타입이 정적변수로 선언되어 있음
// 1).methodDependent : 메소드에 따라 인코딩 타입이 자동으로 결정됨 get방식이면 쿼리 스트링으로 post면 httpBody로
// 2).queryString : get 전송에서 사용되는 쿼리스트링 형식으로 인코딩
// 3).httpBody : post 전송에서 사용되는 http body로 인코딩 - ContentType 헤더에는 자동으로 'application/x-www-form-urlencoded;charset=utf-8' 로 설정이됨

// 6. JSON 방식으로 값을 전송해야할때는 인코딩 타입으로 URLEncoding 대신 JSONEncoding 을 사용해야함

//Alamofire.request("호출URL", method: .post, parameters: param, encoding: JSONEncoding.default)
// 이렇게 하면 Content-Type 헤더에 application/json 값이 자동으로 설정됨
// 이처럼 Alamofire에서 인코딩 타입을 변경하면 그에 대한 헤더는 자동으로 설정되기 때문에 직접 설정하지 않아도 됨
// 같은 맥락에서 Content-Length 헤더 역시 입력된 파라미터 인자값과 인코딩 설정을 참고하여 Alamofire 라이브러리가 자동으로 계산되므로 우리가 설정해 줄 필요는 없음

// 7. HTTP 메세지에 별도의 헤더를 추가하고 싫을 경우에는 headers 매개변수를 사용하면 됨
// 이 매개변수의 타입은 HTTPHeaders로 딕셔너리 형태를 따르기 때문에 키&값 형태로 헤더를 구성하여 매개변수의 인자값으로 넣으면 Alamofire는 이를 HTTP 메시지의 헤더로 설정함
// 다음은 기본 인증과 요청할 데이터 타입을 설정하는 헤더를 HTTP 요청 메시지에 추가하는 구문

let headers: HTTPHeaders = [
    "Authorization" : "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
    "Accept" : "application/json"
]
//Alamofire.request("호출URL", method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers)
// 여기서 질문 그럼 get 방식일땐?
// get은 값을 받아오는거라 인코딩은 따로 필요없어 보임 추후 염두해두고 공부해보자
