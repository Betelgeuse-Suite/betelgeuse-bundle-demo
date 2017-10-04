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
        print("Betelgeuse Swift SDK works")

        let fileManager = FileManager.default

//        print(fileManager.currentDirectoryPath)

//        let bundle = Bundle(for: BetelgeuseSwiftSDK.self as AnyClass)

//        if let path = bundle.path(forResource: "BetelgeuseSwiftSDK/.bin/Data", ofType: "json") {
//            print("yeep")
//        } else {
//            print("noop")
//        }


        if let m = BetelgeuseSwiftSDK.loadJson() {
            print("The Model() is \(m.index)")
        }

    }

    private static func loadJson() -> Model? {
        let fileName = "Data"

        let bundle = Bundle(for: BetelgeuseSwiftSDK.self as AnyClass)
        print("bundle path: \(bundle.bundleURL)")

        if let path = bundle.path(forResource: fileName, ofType: "json") {
            print("found")
            do {
                let jsonData = try NSData(contentsOfFile: path, options: NSData.ReadingOptions.mappedIfSafe)
                do {
                    let jsonResult: NSDictionary = try JSONSerialization.jsonObject(with: jsonData as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary

//                    print(jsonResult)
                    return Model(jsonResult)
                } catch {}
            } catch {}
        } else {
            print("Path \(fileName) not found")
        }

        return nil
    }
}
