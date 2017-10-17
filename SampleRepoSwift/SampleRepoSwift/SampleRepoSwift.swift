//
//  File.swift
//  BetelgeuseSampleRepo1
//
//  Created by gabriel troia on 10/7/17.
//  Copyright © 2017 Betelgeuse. All rights reserved.
//

import Foundation
import BetelgeuseSwiftClient

public class SampleRepoSwift {

    private static var betelgeuseInstance: Betelgeuse?

    private static func getBetelgeuseInstance() -> Betelgeuse? {
        if let instance = SampleRepoSwift.betelgeuseInstance {
            return instance
        }

        print("get betelgeuse")
        let localBundle = Bundle(for: SampleRepoSwift.self as AnyClass)

        let bgPlist = localBundle.bundleURL.appendingPathComponent("Betelgeuse.plist")
        guard var CONFIG = NSMutableDictionary(contentsOf: bgPlist) else {
            print("Betelgeuse.plist not found at \(bgPlist.absoluteString)")
            return nil
        }

        if let bundleURL = localBundle.url(forResource: "SampleRepoSwiftDataBundle", withExtension: "bundle") {

            let REPO_NAME = CONFIG["REPO_NAME"] as! String
            let ENDPOINT_URL = CONFIG["ENDPOINT_URL"] as! String
//            let CURRENT_DATA_VERSION = CONFIG["CURRENT_DATA_VERSION"] as! String
            let CURRENT_SCHEMA_VERSION = CONFIG["CURRENT_SCHEMA_VERSION"] as! String

            SampleRepoSwift.betelgeuseInstance = Betelgeuse(
                repoName: REPO_NAME,
                localDataBundleUrl: bundleURL,
                localFileName: "Data",
                localFileExtension: "json",
                remoteDataBaseUrl: URL(string: ENDPOINT_URL)!,
                remoteDataPath: ".bin/Data.json",
                versionsRegisterUrl: URL(string: "\(ENDPOINT_URL)/master/versions.json")!,
                currentSchemaVersion: CURRENT_SCHEMA_VERSION,
                updateDataVersion: { (newVersion: String) in
//                    CONFIG["CURRENT_DATA_VERSION"] = newVersion
//                    CONFIG.write(to: bgPlist)

                    CONFIG.setValue(newVersion, forKey: "CURRENT_DATA_VERSION")
                    print("nx \(CONFIG)")

                    let x: NSDictionary = ["test": 2]
                    print("bgplist \(bgPlist)")
                    x.write(to: bgPlist, atomically: true)
                    print("update to data version: \(newVersion)")
                }
            )

            return SampleRepoSwift.betelgeuseInstance
        }
        else {
            print("Betelgeuse Error: Can't find bundle url")
        }

        return nil
    }

    public static func getBetelgeuseModel() -> Model? {
        print("get betelgeuse model")
        if let instance = SampleRepoSwift.getBetelgeuseInstance() {
            print("get betelgeuse model instance")
            if let data = instance.getModel() {
                return Model(data)
            }
        }

        return nil
    }
}
