//
//  CollectListCardCell.swift
//  Mermaid
//
//  Created by caixiaodong on 2022/7/21.
//  Copyright © 2022 claudechoi. All rights reserved.
//

import UIKit

class CollectListCardCell: UICollectionViewCell {
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        view.textColor = .orange
        view.numberOfLines = 0
        return view
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    private func initUI() {
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.red.cgColor
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.left.equalTo(16)
            make.right.lessThanOrEqualTo(-16)
            make.bottom.equalTo(-16)
        }
    }
    
    func update(model: CollectCardModel) {
        titleLabel.text = model.title
    }
}
