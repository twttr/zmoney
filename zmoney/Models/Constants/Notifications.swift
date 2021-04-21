//
//  Notifications.swift
//  zmoney
//
//  Created by Pavel Romanishkin on 20.04.21.
//

import Foundation

public enum ZMoneyNotifications {
  public static let tokenUpdated = "ZMoney.tokenUpdated"
}

extension Notification.Name {
  public static let zMoneyConfigUpdated = Notification.Name(rawValue: ZMoneyNotifications.tokenUpdated)
}
