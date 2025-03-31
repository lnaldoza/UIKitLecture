//
//  FieldTableViewCell.swift
//  UIKitLectures
//
//  Created by Leinard Naldoza on 3/31/25.
//

import UIKit

class FieldTableViewCell: UITableViewCell {
    
    var textField: UITextField!
    
    var filedModel: FieldModel? {
        didSet {
            textField.placeholder = filedModel?.hint
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc func textChange(){
        filedModel?.value = textField.text ?? ""
    }
}
