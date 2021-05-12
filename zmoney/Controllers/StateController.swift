//
//  StateController.swift
//  zmoney
//
//  Created by Pavel Romanishkin on 12.05.21.
//

import UIKit

struct StateController {
    private var loadedView: UIView
    private var loadingView = LoadingView()
    private var emptyView = UIView()
    private var errorView = ErrorView()

    init(loadedView: UIView) {
        self.loadedView = loadedView

        self.loadedView.isHidden = true
        errorView.isHidden = true
        loadingView.isHidden = true
        emptyView.isHidden = true
    }

    enum State {
        case noData
        case loading
        case loaded
        case error(String)
    }

    var state: State = .noData {
        didSet {
            switch state {
            case .noData:
                addViewAndBringToFront(emptyView)
                loadedView.isHidden = true
                errorView.isHidden = true
                loadingView.isHidden = true
                emptyView.isHidden = false
            case .loading:
                addViewAndBringToFront(loadingView)
                loadedView.isHidden = true
                errorView.isHidden = true
                emptyView.isHidden = true
                loadingView.isHidden = false
            case .loaded:
                addViewAndBringToFront(loadedView)
                emptyView.isHidden = true
                loadingView.isHidden = true
                errorView.isHidden = true
                loadedView.isHidden = false
            case .error(let error):
                addViewAndBringToFront(errorView)
                errorView.errorLabel.text = error
                emptyView.isHidden = true
                loadedView.isHidden = true
                loadingView.isHidden = true
                errorView.isHidden = false
            }
        }
    }

    private func addViewAndBringToFront(_ view: UIView) {
        view.frame = loadedView.frame
        loadedView.superview?.addSubview(view)
        loadedView.superview?.bringSubviewToFront(view)
    }
}
