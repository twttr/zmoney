//
//  LoadingView.swift
//  zmoney
//
//  Created by Pavel Romanishkin on 13.05.21.
//

import UIKit

class LoadingView: UIView {
    @IBOutlet var loadingView: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)

        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        commonInit()
    }

    private func commonInit() {
        Bundle.main.loadNibNamed(Constants.Views.loadingView, owner: self, options: nil)
        addSubview(loadingView)
        loadingView.frame = self.bounds
    }
}
