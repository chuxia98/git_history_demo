//
//  RequestTimer.swift
//  GitHistory
//
//  Created by chenyh on 2020/12/27.
//

import UIKit

typealias CXHandlerBlock = (String) -> Void

class RequestTimer {
    static let shared = RequestTimer()
    
    var handler: CXHandlerBlock?
    
    func setup() {
        let timer = Timer.init(timeInterval: 5, target: self, selector: #selector(refreshTimer), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: .common)
    }
    
    @objc func refreshTimer() {
        CXNetwork.request(url: Api.target) { [weak self] (resopnse) in
            guard let wself = self else {
                return
            }
            if (resopnse.error != nil) {
                print("\(resopnse.error!)")
                wself.handlerBloc(message: resopnse.error!.description)
                return;
            }
            guard let data = resopnse.data as? [String: Any] else {
                print("data error")
                wself.handlerBloc(message: "data get failure")
                return;
            }
            wself.handlerBloc(message: data.description)
        }
    }
    
    func handlerBloc(message: String) {
        if (self.handler != nil) {
            self.handler!(message)
        }
    }
}
