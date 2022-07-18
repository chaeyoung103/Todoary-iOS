//
//  PaddingLabel.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/18.
//

import UIKit

class PaddingLabel: UILabel {

    private var padding = UIEdgeInsets(top: 5.0, left: 12, bottom: 4.0, right: 12.0)

    convenience init(padding: UIEdgeInsets) {
        self.init()
        self.padding = padding
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }

    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right

        return contentSize
    }
}
