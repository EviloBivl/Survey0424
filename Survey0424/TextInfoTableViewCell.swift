//
//  TextInfoTableViewCell.swift
//  Survey0424
//
//  Created by Paul Neuhold on 24.04.24.
//

import Foundation
import UIKit

class TextInfoTableViewCell: UITableViewCell {
    typealias Content = InfoTexts
    
    struct InfoTexts {
        let title: String
        let text: String
    }
    
    var content: Content? {
        didSet {
            infoTitle.text = content?.title
            infoText.text = content?.text
        }
    }
    
    let infoTitle: UILabel = {
        let label = UILabel()
        label.font = Styles.settingsTitleFont
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        label.minimumScaleFactor = 0.5
        
        return label
    }()
    
    let infoText: UILabel = {
        let label = UILabel()
        label.font = Styles.settingsTextFont
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(infoTitle)
        contentView.addSubview(infoText)
        self.backgroundColor = .systemBackground
        
        
        infoTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32).isActive = true
        infoTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32).isActive = true
        infoTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        infoTitle.bottomAnchor.constraint(equalTo: infoText.topAnchor, constant: -5).isActive = true
        
        infoText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32).isActive = true
        infoText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32).isActive = true
        infoText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
    }
}
