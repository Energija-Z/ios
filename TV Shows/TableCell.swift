//
//  TableCell.swift
//  TV Shows
//
//  Created by infinum on 30/07/2021.
//

import Foundation
import UIKit

final class TableCell: UITableViewCell {

    @IBOutlet public weak var thumbnailImageView: UIImageView!
    @IBOutlet public weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        thumbnailImageView.image = nil
        titleLabel.text = nil
    }

    func showLabel(with text: String){
        titleLabel.text = text
    }
}

extension TableCell {
    func configure(with item: TVShowItem) {
        //thumbnailImageView.image = item.image ?? UIImage(named: "icImagePlaceholder")
        titleLabel.text = item.name
    }
}

private extension TableCell {
    func setupUI() {
        //thumbnailImageView.layer.cornerRadius = 20
        //thumbnailImageView.layer.masksToBounds = true
    }
}
