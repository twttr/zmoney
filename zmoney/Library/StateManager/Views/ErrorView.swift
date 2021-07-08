//
//  ErrorView.swift
//  zmoney
//
//  Created by Pavel Romanishkin on 12.05.21.
//

import UIKit

class ErrorView: UIView, ErrorPresentable {
    @IBOutlet private var errorView: UIView!
    @IBOutlet weak private var errorLabel: UILabel!
    var errorText: String? {
        didSet {
            errorLabel.text = errorText
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        commonInit()
    }

    private func commonInit() {
        Bundle.main.loadNibNamed(Constants.Views.errorView, owner: self, options: nil)
        addSubview(errorView)
        errorView.frame = self.bounds
    }
}
