//
// JSONFileDataProvider.swift
//
// WidgetKit, Copyright (c) 2018 M8 Labs (http://m8labs.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import Foundation

public class JSONFileDataProvider: BaseContentProvider {
    
    public private(set) var fileName: String
    
    public init(fileName: String) {
        self.fileName = fileName
        super.init()
        fetch()
    }
    
    public override func fetch() {
        guard let path = bundle.path(forResource: fileName, ofType: "json") else { return }
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else { return }
        guard let object = try? JSONSerialization.jsonObject(with: data as Data) else { return }
        if let arr = object as? [NSDictionary] {
            items = arr.map { return NSMutableDictionary(dictionary: $0) }
        } else if let dict = object as? NSDictionary {
            items = [NSMutableDictionary(dictionary: dict)]
        }
    }
}
