//
//  TableListCardCell.swift
//  Mermaid
//
//  Created by caixiaodong on 2022/7/27.
//  Copyright © 2022 claudechoi. All rights reserved.
//

import UIKit

class TableListCardCell: UITableViewCell {
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        view.textColor = .orange
        view.numberOfLines = 0
        return view
    }()
    private lazy var contentLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        view.textColor = .orange
        view.numberOfLines = 0
        return view
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupUI()
    }
    
    private func setupUI() {
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.green.cgColor
        [titleLabel, contentLabel].forEach({ contentView.addSubview($0) })
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(16)
            make.left.equalTo(16)
            make.right.lessThanOrEqualTo(-16)
        }
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(6)
            make.left.equalTo(titleLabel)
            make.right.lessThanOrEqualTo(-16)
            make.bottom.equalTo(-16)
        }
    }
    
    func update(model: TableListCardModel) {
        titleLabel.text = model.title
        contentLabel.text = model.des
    }
}
