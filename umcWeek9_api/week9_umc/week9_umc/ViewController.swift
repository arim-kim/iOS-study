//
//  ViewController.swift
//  week9_umc
//
//  Created by 김아림 on 2022/11/26.
//

import UIKit
import Alamofire
import KakaoSDKAuth
import KakaoSDKUser

class ViewController: UIViewController {
    
  let url = "https://api.odcloud.kr/api/3044613/v1/uddi:9f161532-9fd2-4f9f-bbcc-a3f68f8bc921?page=1&perPage=10&serviceKey=wvsOJdt5hE3oUtkau0i2clkQ%2BPsUqV6dIdzPKZMitAKPGsRkC1FsxmEWvTrqDfscnebApKgEHbGfh7AkyFIeJA%3D%3D"
    
 
    let service_key = "wvsOJdt5hE3oUtkau0i2clkQ%2BPsUqV6dIdzPKZMitAKPGsRkC1FsxmEWvTrqDfscnebApKgEHbGfh7AkyFIeJA%3D%3D"

    let name = "서귀포 도립해양공원"

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        }
    
    
        
    @IBAction func onKakaoTalkLoginBtnTouched(_ sender: Any) {

        if (UserApi.isKakaoTalkLoginAvailable()) {
            // 카카오톡 로그인. api 호출 결과를 클로저로 전달.
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    // 예외 처리 (로그인 취소 등)
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")
                   // do something
                    _ = oauthToken
                   // 어세스토큰
                   let accessToken = oauthToken?.accessToken
                }
            }
        }else {
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
               if let error = error {
                 print(error)
               }
               else {
                print("loginWithKakaoAccount() success.")
                
                //do something
                _ = oauthToken
               }
            }
        }
        
        
    }
}


extension ViewController {
    func fetchData()
    {
        AF.request(url,
                   method: .get,
                   encoding: URLEncoding.default,
                   headers: nil)
            .responseJSON { response in
                
            /** 서버로부터 받은 데이터 활용 */
                
            switch response.result {
            case .success(_):
                guard let data = response.data else {return}
                
                do {
                    let decoder = JSONDecoder()
                    let jsonObj = try decoder.decode(DataModel.self, from: data)
                    print(jsonObj.data[0])
                    print(jsonObj)
                    break;
                }catch {
                    print("error")
                }
            case .failure(_):
                print("failed")
                break;
            }
    }
        
    }
}

