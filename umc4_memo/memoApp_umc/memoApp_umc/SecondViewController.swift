//
//  SecondViewController.swift
//  memoApp_umc
//
//  Created by 김아림 on 2022/10/31.
//

import UIKit

class SecondViewController: UIViewController {
   

    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var contentField: UITextView!
    var addData : addDataProtocol?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.contentField.layer.borderWidth = 0.3
        self.contentField.layer.borderColor = UIColor.gray.cgColor
        self.contentField.layer.cornerRadius = 7.5

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtnDidTap(_ sender: Any) {
        
        let title = titleField.text!
        let content = contentField.text!
        var foreMemo = " "
        if (content.count < 15) {
            foreMemo = content
        } else {
            foreMemo = content.prefix(14) + "..."
        }
        var formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        var current_date_string = formatter.string(from: Date())
        
        addData?.getData(thumbImage: UIImage(named: ""), title: title, foreMemo: foreMemo, modifiedData: current_date_string)
        // dismiss = view 가 닫힘 -> 부모 뷰로 돌아감.
        dismiss(animated: true)
    }
    
}
