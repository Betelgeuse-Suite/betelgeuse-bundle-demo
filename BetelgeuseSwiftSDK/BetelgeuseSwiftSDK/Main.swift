//
//  Main.swift
//  BetelgeuseSwiftSDK
//
//  Created by gabriel troia on 10/3/17.
//  Copyright © 2017 Betelgeuse. All rights reserved.
//

import Foundation

public class BetelgeuseSwiftSDK {

    public init() {
        if let m = BetelgeuseSwiftSDK.loadJson() {
            print("The Model() is \(m.nested.nested.file.value)")
        }
    }

    private static func loadJson() -> Model? {
        let fileName = "Data"

        let podBundle = Bundle(for: BetelgeuseSwiftSDK.self as AnyClass)

        if let bundleURL = podBundle.url(forResource: "BetelgeuseSwiftSDKData", withExtension: "bundle") {
            if let bundle = Bundle(url: bundleURL) {
                if let path = bundle.path(forResource: fileName, ofType: "json") {
                    if let jsonData = try? NSData(
                        contentsOfFile: path,
                        options: NSData.ReadingOptions.mappedIfSafe
                        ) {
                        if let jsonResult: NSDictionary = try? JSONSerialization.jsonObject(
                            with: jsonData as Data,
                            options: JSONSerialization.ReadingOptions.mutableContainers
                            ) as! NSDictionary {

                            print(jsonResult)
                            return Model(jsonResult)
                        }
                    }
                }
            }
        } else {
            print("Path \(fileName) not found")
        }

        return nil
    }
}
