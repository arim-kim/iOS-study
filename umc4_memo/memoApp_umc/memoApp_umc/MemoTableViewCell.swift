//
//  MemoTableViewCell.swift
//  memoApp_umc
//
//  Created by 김아림 on 2022/10/31.
//

import UIKit

class MemoTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var tumbImage: UIImageView!
    @IBOutlet weak var modifiedDateLabel: UILabel!
    @IBOutlet weak var foreMemo: UILabel!
    @IBOutlet weak var memoTitle: UILabel!

    
    //viewDidLoad() -와 유사한 lifecycle method처럼 기능
    override func awakeFromNib() {
        super.awakeFromNib()
        tumbImage.layer.cornerRadius = 17.5
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func prepareForReuse() {
        self.backgroundColor = .white
        super.prepareForReuse()
    }
}
