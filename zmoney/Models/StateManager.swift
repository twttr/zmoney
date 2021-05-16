//
//  StateController.swift
//  zmoney
//
//  Created by Pavel Romanishkin on 12.05.21.
//

import UIKit

protocol ErrorPresentable: UIView {
    var errorText: String? { get set }
}

protocol StateApplicable {
    associatedtype State

    func apply(state: State)
}

protocol StateHolder {
    associatedtype State

    var state: State { get set }
}

struct StateManager: StateHolder, StateApplicable {
    enum State {
        case noData
        case loading
        case loaded
        case error(String)
    }

    var state: State = .noData {
        didSet {
            self.apply(state: state)
        }
    }

    private var loadedView: UIView
    private var rootView: UIView
    private var loadingView: UIView
    private var emptyView: UIView
    private var errorView: ErrorPresentable

    init(
        rootView: UIView,
        loadedView: UIView,
        loadingView: UIView = LoadingView(),
        emptyView: UIView = UIView(),
        errorView: ErrorPresentable = ErrorView()
    ) {
        self.rootView = rootView
        self.loadedView = loadedView
        self.loadingView = loadingView
        self.emptyView = emptyView
        self.errorView = errorView

        self.state = .noData
    }

    // MARK: StateApplicable

    func apply(state: State) {
        hideAllViews()

        switch state {
        case .noData:
            addViewAndBringToFront(emptyView)
        case .loading:
            addViewAndBringToFront(loadingView)
        case .loaded:
            addViewAndBringToFront(loadedView)
        case .error(let error):
            addViewAndBringToFront(errorView)
            errorView.errorText = error
        }
    }

    private func addViewAndBringToFront(_ view: UIView) {
        view.frame = loadedView.bounds
        rootView.addSubview(view)
        rootView.bringSubviewToFront(view)
        view.isHidden = false
    }

    private func hideAllViews() {
        loadedView.isHidden = true
        loadingView.isHidden = true
        emptyView.isHidden = true
        errorView.isHidden = false
    }
}
