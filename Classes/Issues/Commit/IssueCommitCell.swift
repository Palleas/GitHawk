//
//  IssueCommitCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/26/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

protocol IssueCommitCellDelegate: class {
    func didTapAvatar(cell: IssueCommitCell)
}

final class IssueCommitCell: UICollectionViewCell {

    weak var delegate: IssueCommitCellDelegate? = nil

    private let commitImageView = UIImageView(image: UIImage(named: "git-commit-small")?.withRenderingMode(.alwaysTemplate))
    private let avatarImageView = UIImageView()
    private let messageLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        commitImageView.contentMode = .scaleAspectFit
        commitImageView.tintColor = Styles.Colors.Gray.light.color
        contentView.addSubview(commitImageView)
        commitImageView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(Styles.Sizes.eventGutter)
            make.size.equalTo(Styles.Sizes.icon)
        }

        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.backgroundColor = Styles.Colors.Gray.lighter.color
        avatarImageView.layer.cornerRadius = Styles.Sizes.avatarCornerRadius
        avatarImageView.layer.borderColor = Styles.Colors.Gray.light.color.cgColor
        avatarImageView.layer.borderWidth = 1.0 / UIScreen.main.scale
        avatarImageView.clipsToBounds = true
        avatarImageView.isUserInteractionEnabled = true
        avatarImageView.addGestureRecognizer(UITapGestureRecognizer(
            target: self,
            action: #selector(IssueCommitCell.onAvatar))
        )
        contentView.addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(commitImageView.snp.right).offset(Styles.Sizes.columnSpacing)
            make.size.equalTo(Styles.Sizes.icon)
        }

        messageLabel.backgroundColor = .clear
        messageLabel.font = Styles.Fonts.secondaryCode
        messageLabel.textColor = Styles.Colors.Gray.medium.color
        contentView.addSubview(messageLabel)
        messageLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(avatarImageView.snp.right).offset(Styles.Sizes.columnSpacing)
            make.right.lessThanOrEqualTo(contentView).offset(-Styles.Sizes.eventGutter)
        }

        // always collapse and truncate
        messageLabel.lineBreakMode = .byTruncatingMiddle
        messageLabel.setContentCompressionResistancePriority(UILayoutPriorityDefaultLow, for: .horizontal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public API

    func configure(_ model: IssueCommitModel) {
        avatarImageView.sd_setImage(with: model.avatarURL)
        messageLabel.text = model.message
    }

    // MARK: Private API

    func onAvatar() {
        delegate?.didTapAvatar(cell: self)
    }

}
