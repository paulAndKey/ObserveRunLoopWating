//
//  CFRunLoopTool.swift
//  ObserveRunLoopWating
//
//  Created by dbl on 2020/3/8.
//  Copyright © 2020 dbl. All rights reserved.
//
import Foundation

typealias Task = () -> ()
class CFRunLoopTool: NSObject {
    static let ShareInstance = CFRunLoopTool()
    
    private var timer: Timer?
    var taskArray = [Any]()
    var callTask: Task?
    
    func addTask(task: @escaping Task) {
        taskArray.append(task)
    }
    
    private override init() {
        super.init()
        self.timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(startTimer), userInfo: nil, repeats: true)
        observeRunLoopWating()
    }
    
    func observeRunLoopWating() {
        
        let observer = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, CFRunLoopActivity.beforeWaiting.rawValue, true, 0) { (observer, activity) in
            //监听到即将休眠的时候 就要处理我们的任务了
            print(observer, activity)
//            if self.taskArray.count == 0 { return }
//            self.callTask = self.taskArray.first as? Task
//            self.callTask!()
//            self.taskArray.remove(at: 0)
        }
        CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, CFRunLoopMode.defaultMode)
    }
    
    @objc func startTimer() {
        //开启定时器就行 什么都不做
    }
}

