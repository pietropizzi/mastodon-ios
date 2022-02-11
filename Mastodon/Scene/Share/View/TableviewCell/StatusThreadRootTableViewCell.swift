//
//  StatusThreadRootTableViewCell.swift
//  Mastodon
//
//  Created by MainasuK on 2022-1-17.
//

import os.log
import UIKit
import Combine
import MastodonAsset
import MastodonLocalization
import MastodonUI

final class StatusThreadRootTableViewCell: UITableViewCell {
    
    static let marginForRegularHorizontalSizeClass: CGFloat = 64
    
    let logger = Logger(subsystem: "StatusThreadRootTableViewCell", category: "View")
        
    weak var delegate: StatusTableViewCellDelegate?
    var disposeBag = Set<AnyCancellable>()

    let statusView = StatusView()
    let separatorLine = UIView.separatorLine
    
    var containerViewLeadingLayoutConstraint: NSLayoutConstraint!
    var containerViewTrailingLayoutConstraint: NSLayoutConstraint!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        disposeBag.removeAll()
        statusView.prepareForReuse()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        _init()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        _init()
    }
    
    deinit {
        os_log(.info, log: .debug, "%{public}s[%{public}ld], %{public}s", ((#file as NSString).lastPathComponent), #line, #function)
    }
    
}

extension StatusThreadRootTableViewCell {
    
    private func _init() {
        selectionStyle = .none
        
        statusView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(statusView)
        setupContainerViewMarginConstraints()
        updateContainerViewMarginConstraints()
        NSLayoutConstraint.activate([
            statusView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            containerViewLeadingLayoutConstraint,
            containerViewTrailingLayoutConstraint,
            statusView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        statusView.setup(style: .plain)
        
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(separatorLine)
        NSLayoutConstraint.activate([
            separatorLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            separatorLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            separatorLine.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            separatorLine.heightAnchor.constraint(equalToConstant: UIView.separatorLineHeight(of: contentView)).priority(.required - 1),
        ])
        
        statusView.delegate = self
        
        // a11y
        statusView.contentMetaText.textView.isSelectable = true
        statusView.contentMetaText.textView.isAccessibilityElement = false
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        updateContainerViewMarginConstraints()
    }
    
}

extension StatusThreadRootTableViewCell: AdaptiveContainerMarginTableViewCell {
    var containerView: StatusView {
        statusView
    }
}


// MARK: - StatusViewContainerTableViewCell
extension StatusThreadRootTableViewCell: StatusViewContainerTableViewCell { }

// MARK: - StatusViewDelegate
extension StatusThreadRootTableViewCell: StatusViewDelegate { }