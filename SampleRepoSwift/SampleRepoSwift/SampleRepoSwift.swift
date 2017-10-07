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

    // MAYBE PLIST VALUES?
    private static let ENDPOINT_URL = "rawgit.com/GabrielCTroia/beetlejuice-sample-repo1/master/"
    private static let CURRENT_VERSION = "0.0.1"

    private static var betelgeuseInstance: Betelgeuse?

    private static func getBetelgeuseInstance() -> Betelgeuse? {
        if let instance = SampleRepoSwift.betelgeuseInstance {
            return instance
        }

        let localBundle = Bundle(for: SampleRepoSwift.self as AnyClass)

        if let bundleURL = localBundle.url(forResource: "SampleRepoSwiftDataBundle", withExtension: "bundle") {
            SampleRepoSwift.betelgeuseInstance = Betelgeuse(
                localDataBundleUrl: bundleURL,
                localFileName: "Data",
                localFileExtension: "json",
                remoteDataUrl: URL(string: "\(ENDPOINT_URL)/.bin/Data.json")!,
                versionsRegisterUrl: URL(string: "\(ENDPOINT_URL)/versions.json")!,
                currentVersion: CURRENT_VERSION
            )

            return SampleRepoSwift.betelgeuseInstance
        }
        else {
            print("Betelgeuse Error: Can't find bundle url")
        }

        return nil
    }

    public static func getBetelgeuseModel() -> Model? {
        if let instance = SampleRepoSwift.getBetelgeuseInstance() {
            if let data = instance.getModel() {
                return Model(data)
            }
        }

        return nil
    }
}
