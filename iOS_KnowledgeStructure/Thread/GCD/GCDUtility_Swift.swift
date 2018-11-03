//
//  GCDUtility_Swift.swift
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2018/10/31.
//  Copyright © 2018年 zhf. All rights reserved.
//

import UIKit
import Foundation

class GCDUtility_Swift {
    
    //单例
    //异步主线程
    func ayn_main() {
        DispatchQueue.main.async {
            
        }
    }
    
    //延时执行
    func after() {
        DispatchQueue.global().asyncAfter(wallDeadline: DispatchWallTime.now()+1.0) {
            
        }
    }
    
    //定时器
    func gcd_timer() {
        var timeCount = 60
        // 在global线程里创建一个时间源
        let timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
        // 设定这个时间源是每秒循环一次，立即开始
        timer.schedule(deadline: .now(), repeating: .seconds(1))
        // 设定时间源的触发事件
        timer.setEventHandler(handler: {
            // 每秒计时一次
            timeCount = timeCount - 1
            // 时间到了取消时间源
            if timeCount <= 0 {
                timer.cancel()
            }
            // 返回主线程处理一些事件，更新UI等等
            DispatchQueue.main.async {
                print("-------%d",timeCount);
            }
        })
        // 启动时间源
        timer.resume()
    }
    
    var second = 60
    var timer : Timer?
    // 2.开始计时
    func startTimer() {
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updataSecond), userInfo: nil, repeats: true)
        //调用fire()会立即启动计时器
        timer!.fire()
    }
    
    // 3.定时操作
    @objc func updataSecond() {
        if second>1 {
            //.........
            second -= 1
        }else {
            stopTimer()
        }
    }
    // 4.停止计时
    func stopTimer() {
        if timer != nil {
            timer!.invalidate() //销毁timer
            timer = nil
        }
    }
    
    //异步任务组
    func group() {
        let gourp = DispatchGroup()
        let queue = DispatchQueue(label: "queue1")
        queue.async(group: gourp, execute: DispatchWorkItem(block: {
            print("queue1")
        }))
        
        let queue2 = DispatchQueue(label: "queue2")
        queue.async(group: gourp, execute: DispatchWorkItem(block: {
            print("queues2")
        }))
        
        gourp.notify(queue: DispatchQueue.main, work: DispatchWorkItem(block: {
            print("over...")
        }))
        
        //等group中d的所有任务都执行完成，才继续执行下面的任务
        gourp.wait()
        //收到所有任务执行完成的回调
        //gourp.notify
        
    }
    
    //信号量（深层异步任务同步）
    func semaphore() {
        let semaphore = DispatchSemaphore(value: 0)
        //信号量加一
        semaphore.signal()
        // 信号量减一
        semaphore.wait()
    }
    
}

//单例
//三种单例方法
class Single1 {
    static let single = Single1()
}

let single2 = Single2()
class Single2 {
    class func shareSingle2() -> Single2 {
        return single2
    }
}

class Single3 {
    static var singleObj: Single3 {
        struct SingleObj {
            static let single = Single3()
        }
        return SingleObj.single
    }
}
