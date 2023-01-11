//
//  ViewController.swift
//  memoApp_umc
//
//  Created by 김아림 on 2022/10/31.
//

import UIKit


class ViewController: UIViewController {
    
    

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func buttonDidTap(_ sender: Any) {
        
        guard let memoViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "memoViewController") as? memoViewController else {return}
        
        memoViewController.modalPresentationStyle = .fullScreen

        present(memoViewController, animated: true)
    }
    
}

