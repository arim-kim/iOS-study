//
//  ViewController.swift
//  umc5_timer
//
//  Created by 김아림 on 2022/11/05.
//

import UIKit
import SafariServices

//doSomething
class ViewController: UIViewController {

    @IBOutlet weak var status_timeContainer: UIView!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var stopBtn: UIButton!
    @IBOutlet weak var resetBtn: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var timeLable: UILabel!
    @IBOutlet weak var musicBtn: UIButton!
    @IBOutlet weak var succeedCountLabel: UILabel!
    @IBOutlet var viewTapGestureReco: UITapGestureRecognizer!
    
    var studyDuration = 2
    var breakTimeDuration = 2
    var colorIndex = 0
    var colors : [UIColor] = [UIColor.systemBlue, UIColor.systemPink]

    var timer : Timer?
    var count : Int = 0
    var succeedTitle = "succeed Count : "
    let userDefaults = UserDefaults.standard

    
    override func viewDidLoad() {
        super.viewDidLoad()
        count = userDefaults.integer(forKey: "count")
        succeedCountLabel.text = succeedTitle + String(count)
        print("count : \(count)")
        // Do any additional setup after loading the view.
        
        DispatchQueue.global().async {
            for i in (0...100) {
//                print(i)
                sleep(1)
            }
        }
        
        viewTapGestureReco.addTarget(self, action: #selector(viewDidTap))
    }
    
    @objc func viewDidTap() {
        UIView.animate(withDuration: 1,
                       animations:{
            self.colorIndex += 1
            self.musicBtn.tintColor = self.colors[self.colorIndex%2]
            self.view.layoutIfNeeded()
        }
        )
    }
    
    
    @IBAction func timerRunClicked(_ sender: Any) {
        
        if(timer != nil && (timer!.isValid)) {
            return
        }
        
        var minutes = self.studyDuration / 60
        var seconds = self.studyDuration % 60
        
        self.statusLabel.text = "studying"
        self.timeLable.text = "\(minutes) : \(seconds)"
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (t) in
            self.studyDuration -= 1
            
            minutes = self.studyDuration / 60
            seconds = self.studyDuration % 60
            
            if self.studyDuration > 0 {
                self.timeLable.text = "\(minutes) : \(seconds)"
            }else {
                
            
                self.breakTimeDuration -= 1
                self.timeLable.text = "10:00"
                self.statusLabel.text = "break time"
                
                minutes = self.breakTimeDuration / 60
                seconds = self.breakTimeDuration % 60
                
                self.timeLable.text = "\(minutes) : \(seconds)"
                
                if (self.breakTimeDuration == 0) {
                    // 공부 시간 달성시
                    self.count += 1
                    self.userDefaults.set(self.count, forKey: "count")
                    self.succeedCountLabel.text = self.succeedTitle + String(self.count)
                    print("count : \(self.count)")
                    self.resetTime()
                    
                    // animation1 -> 성공시 succeed Time label 반짝 반짝
                    let opacityKeyframe = CAKeyframeAnimation(keyPath: "opacity")
                    opacityKeyframe.values = [0.2, 0.5, 0.2, 1.0]
                    opacityKeyframe.keyTimes = [0, 0.3, 0.6, 1]
                    opacityKeyframe.duration = 1
                    self.succeedCountLabel.layer.add(opacityKeyframe, forKey: "opacityKeyframe")
                    
                    
                }
            }
            
        })
    }
    
    @IBAction func stopBtnClicked(_ sender: Any) {
        if(!(timer != nil && (timer!.isValid))) {
            return
        }else {
            self.timer?.invalidate()
        }
    }
    
    @IBAction func resetBtnClicked(_ sender: Any) {
        self.resetTime()
        
        let colorKeyframe = CAKeyframeAnimation(keyPath: "backgroundColor")
        colorKeyframe.values = [UIColor.systemMint.cgColor, UIColor.white.cgColor]
        colorKeyframe.keyTimes = [0.5, 1]
        colorKeyframe.duration = 1
       
        self.view.layer.add(colorKeyframe, forKey: "colorKeyframe")
        self.status_timeContainer.layer.add(colorKeyframe, forKey: "colorKeyframe")
        
    }
    
    
    func resetTime() {
        self.timer?.invalidate()
        timer = nil
        self.statusLabel.text = "ready"
        self.breakTimeDuration = 2
        self.studyDuration = 2
        
        self.timeLable.text = "00:02"


    }
    
    func stopTimer() {
        self.timer!.invalidate()
    }
    
    
    @IBAction func musicBtnClicked(_ sender: UIButton) {
        let url = NSURL(string: "https://www.youtube.com/watch?v=R5nt_sChOKk")
        let youtubeView : SFSafariViewController =
        SFSafariViewController(url: url as! URL)
        self.present(youtubeView, animated: true)
        
    }
    
}




