//
//  XDLog.swift
//  Mermaid
//
//  Created by caixiaodong on 2022/7/22.
//  Copyright © 2022 claudechoi. All rights reserved.
//

import Foundation

extension XDLog {
    enum `Type` {
        case debug
    }
}

class XDLog {
    static func log(type: [`Type`] = [.debug],
                    file: String = #file,
                    function: String = #function,
                    line: Int = #line) {
        log("", type: type, file: file, function: function, line: line)
    }
    
    static func log<T>(_ closure: @autoclosure () -> T,
                       type: [`Type`] = [.debug],
                       file: String = #file,
                       function: String = #function,
                       line: Int = #line) {
        var fileName = URL(fileURLWithPath: file).lastPathComponent
        if let name = fileName.components(separatedBy: ".").first {
            fileName = name
        }
        let queue = Thread.isMainThread ? "UI" : "BG"
        let functionName = function.flattenFunctionParameter()
        if type.contains(.debug) {
            let time = Date()
            let instance = closure()
            print("[\(queue)] \(time) \(fileName) \(functionName)() [\(line)]: \(instance)")
        }
    }
}

extension String {
    func flattenFunctionParameter() -> String {
        guard !self.isEmpty else {
            return self
        }
        do {
            let pattern = "\\([^>]*\\)|\\r|&[a-z]*[ ;]?"
            let regular = try NSRegularExpression(pattern: pattern, options: .allowCommentsAndWhitespace)
            return regular.stringByReplacingMatches(in: self, options: .reportProgress, range: NSRange(location: 0, length: self.count), withTemplate: "")
        } catch {
            return self
        }
    }
}
