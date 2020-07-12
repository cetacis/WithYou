//
//  TagContent.swift
//  WithYou
//
//  Created by kelo on 2020/4/14.
//  Copyright © 2020 邓萌达. All rights reserved.
//

import Foundation
import SwiftUI


struct TagContent: View {
    var TagName: String
    var isFriend: Bool
    var taskid: Int
    var body: some View {
        TaskDetail(taskid: taskid, isFriend: isFriend, isFinished: User.TogetherTasks[taskid].IsFinished)
    }
}
