//
//  Notification.swift
//  GerApp
//
//  Created by Milton Leslie Sobrinho de Souza Sanches on 10/11/21.
//

import UIKit

class Notification {
    
    var id_notifications: String!
    var id_application: String!
    var action_date: String!
    var action_time: String!
    var action_difference: String!
    var action_seconds: String!
    var user_id: String!
    var user_name: String!
    var message: String!
    var status: String!
    var checked: String!

    init(id_notifications: String, id_application: String, action_date: String,  action_time: String, action_difference: String, action_seconds: String, user_id: String, user_name: String, message: String, status: String, checked: String) {
        self.id_notifications = id_notifications
        self.id_application = id_application
        self.action_date = action_date
        self.action_time = action_time
        self.action_difference = action_difference
        self.action_seconds = action_seconds
        self.user_id = user_id
        self.user_name = user_name
        self.message = message
        self.status = status
        self.checked = checked
    }
    
}

