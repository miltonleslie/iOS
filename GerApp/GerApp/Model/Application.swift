//
//  Application.swift
//  GerApp
//
//  Created by Milton Leslie Sobrinho de Souza Sanches on 09/11/21.
//

import UIKit

class Application {
    
    var id_application: String!
    var app_name: String!
    var action_date: String!
    var action_time: String!
    var action_difference: String!
    var action_seconds: String!
    var user_id: String!
    var user_name: String!
    var last_message: String!
    var status: String!

    init(id_application: String, app_name: String, action_date: String,  action_time: String, action_difference: String, action_seconds: String, user_id: String, user_name: String, last_message: String, status: String) {
        self.id_application = id_application
        self.app_name = app_name
        self.action_date = action_date
        self.action_time = action_time
        self.action_difference = action_difference
        self.action_seconds = action_seconds
        self.user_id = user_id
        self.user_name = user_name
        self.last_message = last_message
        self.status = status
    }
    
}
