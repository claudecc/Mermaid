//
//  DifferenceListCell.swift
//  Mermaid
//
//  Created by caixiaodong on 2022/7/21.
//  Copyright © 2022 claudechoi. All rights reserved.
//

import UIKit

class DifferenceListCell: UITableViewCell {
    private lazy var contentLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        view.textColor = .orange
        return view
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initUI()
    }
    
    private func initUI() {
        contentView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { make in
            make.top.left.equalTo(16)
            make.right.bottom.equalTo(-16)
        }
    }
}
