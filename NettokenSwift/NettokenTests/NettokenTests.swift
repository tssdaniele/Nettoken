//
//  NettokenTests.swift
//  NettokenTests
//
//  Created by Daniele Tassone on 07/02/2023.
//

import XCTest
import SwiftUI

@testable import Nettoken

final class NettokenTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testStubsNotEmpty() throws {
        let nettokeVM = NettokenViewModelMock()
        XCTAssertFalse(nettokeVM.model.groups.isEmpty)
        nettokeVM.model.groups.forEach {
            XCTAssertFalse($0.credentials.isEmpty)
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
