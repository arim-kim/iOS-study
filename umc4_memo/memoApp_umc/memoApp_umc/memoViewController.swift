//
//  memoViewController.swift
//  memoApp_umc
//
//  Created by 김아림 on 2022/10/31.
//

import UIKit
import Lottie

protocol addDataProtocol {
    func getData(thumbImage : UIImage?, title : String, foreMemo : String, modifiedData : String)
}

class memoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, addDataProtocol {
    
    var memoData : [memoDataModel] = [
    memoDataModel (tumbImage: UIImage(named: ""), memoTitle: "오늘 일기", modifiedDate: "2022-11-01 12:23:33", foreMemo: "오늘 일기내용"),
    memoDataModel (tumbImage: UIImage(named: ""), memoTitle: "오늘 일기", modifiedDate: "2022-11-01 12:23:33", foreMemo: "오늘 일기내용"),
    memoDataModel (tumbImage: UIImage(named: ""), memoTitle: "오늘 일기", modifiedDate: "2022-11-01 12:23:33", foreMemo: "오늘 일기내용"),
    memoDataModel (tumbImage: UIImage(named: ""), memoTitle: "오늘 일기", modifiedDate: "2022-11-01 12:23:33", foreMemo: "오늘 일기내용"),
    memoDataModel (tumbImage: UIImage(named: ""), memoTitle: "오늘 일기", modifiedDate: "2022-11-01 12:23:33", foreMemo: "오늘 일기내용"),
    memoDataModel (tumbImage: UIImage(named: ""), memoTitle: "오늘 일기", modifiedDate: "2022-11-01 12:23:33", foreMemo: "오늘 일기내용"),
    memoDataModel (tumbImage: UIImage(named: ""), memoTitle: "오늘 일기", modifiedDate: "2022-11-01 12:23:33", foreMemo: "오늘 일기내용"),
    memoDataModel (tumbImage: UIImage(named: ""), memoTitle: "오늘 일기", modifiedDate: "2022-11-01 12:23:33", foreMemo: "오늘 일기내용"),
    memoDataModel (tumbImage: UIImage(named: ""), memoTitle: "오늘 일기", modifiedDate: "2022-11-01 12:23:33", foreMemo: "오늘 일기내용"),
    memoDataModel (tumbImage: UIImage(named: ""), memoTitle: "오늘 일기", modifiedDate: "2022-11-01 12:23:33", foreMemo: "오늘 일기내용")
    ]
    
    var colorData : [UIColor] = [
        UIColor.lightGray, UIColor.systemBlue, UIColor.systemGreen, UIColor.systemPink]
    
    var latestMemoColor : UIColor = UIColor.gray
    
    func getData(thumbImage: UIImage?, title: String, foreMemo: String, modifiedData: String) {
        var new : memoDataModel =   memoDataModel (tumbImage: thumbImage, memoTitle: title, modifiedDate: modifiedData, foreMemo: foreMemo)
        memoData.insert(new, at: 0)
        print("new add")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //한 섹션에 들어갈 행의 개수 = 셀의 개수
        print(memoData.count)
        return memoData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MemoTableViewCell", for: indexPath) as? MemoTableViewCell else {return UITableViewCell()}
        
        cell.tumbImage.image = memoData[indexPath.row].tumbImage
        cell.memoTitle.text = memoData[indexPath.row].memoTitle
        cell.foreMemo.text = memoData[indexPath.row].foreMemo
        cell.modifiedDateLabel.text = memoData[indexPath.row].modifiedDate
        
        if indexPath.row == 0 {
            cell.backgroundColor = latestMemoColor
        }
                
        return cell
    }
    
    
    @IBOutlet weak var memoTableView: UITableView!
    
    let refreshControl = UIRefreshControl()
    
    lazy var lottieView : AnimationView = {
        let animationView : AnimationView = .init(name: "refresh_indicator")
        animationView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        let centerX = UIScreen.main.bounds.width/2
        animationView.center = CGPoint(x: centerX, y: 40)
        animationView.contentMode = .scaleAspectFit
        animationView.stop()
        animationView.isHidden = true
        return animationView
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        memoTableView.delegate = self
        memoTableView.dataSource = self
        initRefreshControl()
        print("this page opened")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        memoTableView.reloadData()
    }
    
    func initRefreshControl(){#imageLiteral(resourceName: "스크린샷 2022-11-05 오후 1.51.22.png")
        refreshControl.addSubview(lottieView)
        refreshControl.tintColor = .clear // 기존 default indicator를 지우는 것
        memoTableView.refreshControl = refreshControl
        // action 부여
        refreshControl.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }
    
    @objc func handleRefreshControl() {
        print("새로고침")
        latestMemoColor = colorData[Int.random(in: 0..<colorData.count)]
        lottieView.isHidden = false
        lottieView.play()
        // 새로고침 하면서 딜레이 되도록 함
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.memoTableView.reloadData()
            self.lottieView.isHidden = true
            self.lottieView.stop()
            self.memoTableView.refreshControl?.endRefreshing()
        }
    }
    
    
    @IBAction func addBtnDidTap(_ sender: Any) {
        
        guard let SecondViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController else {return}
                
        SecondViewController.addData = self
        SecondViewController.modalPresentationStyle = .fullScreen
        present(SecondViewController, animated: true)
        
    }
}

struct memoDataModel {
    let tumbImage : UIImage?
    let memoTitle : String
    let modifiedDate : String
    let foreMemo : String
}
