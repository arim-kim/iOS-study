//
//  ViewController.swift
//  umc_1stWeek
//
//  Created by 김아림 on 2022/09/19.
//

import UIKit

class ViewController: UIViewController {

    // 속성값 접근이 가능함
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var redView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
        
    
    // 이벤트가 발생되었을때 실행시킬 함수 코드
    @IBAction func profileButtonDidtap(_ sender: Any) {
        print("버튼이 터치되었음")
        todayLabel.text = "버튼 클릭"
    }
    

}

