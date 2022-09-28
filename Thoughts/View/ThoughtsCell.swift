//
//  ThoughtsCell.swift
//  Thoughts
//
//  Created by Hilmy Veradin on 26/04/22.
//

import Foundation
import UIKit

class ThoughtsCell: UITableViewCell, ProgrammaticView {
    
    // MARK: - Properties
    lazy var thoughtsTitle: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .justified
        lbl.numberOfLines = 0
        return lbl
    }()
    
    lazy var thoughtsDesc: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .justified
        lbl.numberOfLines = 0
        return lbl
    }()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    func setupView() {
        addSubview(thoughtsTitle)
        thoughtsTitle.anchor(top: topAnchor, paddingTop: 5,
                             bottom: nil, paddingBottom: 0,
                             left: leftAnchor, paddingLeft: 8,
                             right: rightAnchor, paddingRight: 8,
                             width: 0, height: 0,
                             centerX: nil, centerY: nil,
                             enableInsets: false)
        
        addSubview(thoughtsDesc)
        thoughtsDesc.anchor(top: thoughtsTitle.bottomAnchor, paddingTop: 5,
                            bottom: bottomAnchor, paddingBottom: 5,
                            left: leftAnchor, paddingLeft: 8,
                            right: rightAnchor, paddingRight: 8,
                            width: 0, height: 0,
                            centerX: nil, centerY: nil,
                            enableInsets: false)
    }
    
}
