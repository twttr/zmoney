//
//  ErrorView.swift
//  zmoney
//
//  Created by Pavel Romanishkin on 12.05.21.
//

import UIKit

class ErrorView: UIView {
    @IBOutlet var errorView: UIView!
    @IBOutlet weak var errorLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)

        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        commonInit()
    }

    private func commonInit() {
        Bundle.main.loadNibNamed("ErrorView", owner: self, options: nil)
        addSubview(errorView)
        errorView.frame = self.bounds
    }
}
