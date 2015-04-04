//
//  DefaultCDStackTests.swift
//  SugarRecord
//
//  Created by Pedro Piñera Buendía on 27/09/14.
//  Copyright (c) 2014 SugarRecord. All rights reserved.
//

import UIKit
import XCTest
import CoreData

class DefaultCDStackTests: XCTestCase
{

    var stack: DefaultCDStack? = nil
    
    override func setUp()
    {
        super.setUp()
        let bundle: NSBundle = NSBundle(forClass: CoreDataObjectTests.classForCoder())
        let modelPath: NSString = bundle.pathForResource("TestsDataModel", ofType: "momd")!
        let model: NSManagedObjectModel = NSManagedObjectModel(contentsOfURL: NSURL(fileURLWithPath: modelPath)!)!
        stack = DefaultCDStack(databaseName: "TestDB.sqlite", model: model, automigrating: true)
        SugarRecord.addStack(stack!)
    }
    
    override func tearDown() {
        SugarRecord.cleanup()
        SugarRecord.removeAllStacks()
        SugarRecord.removeDatabase()
        super.tearDown()
    }

    func testThatTheRootSavingContextIsSavedInApplicationWillTerminate()
    {
        class MockCDStack: DefaultCDStack
        {
            var savedChangesInRootSavingContext: Bool = false
            override func saveChanges() {
                savedChangesInRootSavingContext = true
            }
        }
        let context: MockCDStack = MockCDStack(databaseName: "test", automigrating: false)
        context.applicationWillTerminate()
        XCTAssertTrue(context.savedChangesInRootSavingContext, "Root saving context should be saved when application will terminate")
        context.removeDatabase()
    }
    
    func testThatTheRootSavingContextIsSavedInApplicationWillResignActive()
    {
        class MockCDStack: DefaultCDStack
        {
            var savedChangesInRootSavingContext: Bool = false
            override func saveChanges() {
                savedChangesInRootSavingContext = true
            }
        }
        let context: MockCDStack = MockCDStack(databaseName: "test", automigrating: false)
        context.applicationWillResignActive()
        XCTAssertTrue(context.savedChangesInRootSavingContext, "Root saving context should be saved when application will resign active")
        context.removeDatabase()
    }
    
    func testInitializeOfComponents()
    {
        class MockCDStack: DefaultCDStack
        {
            var pscCreated: Bool = false
            var databaseAdded: Bool = false
            var rootSavingContextCreated: Bool = false
            var mainContextAdded: Bool = false
            
            override func createPersistentStoreCoordinator() -> NSPersistentStoreCoordinator {
                pscCreated = true
                return NSPersistentStoreCoordinator()
            }
            
            override func addDatabase(completionClosure: CompletionClosure) {
                databaseAdded = true
                completionClosure(error: nil)
            }
            
            override func createRootSavingContext(persistentStoreCoordinator: NSPersistentStoreCoordinator?) -> NSManagedObjectContext {
                rootSavingContextCreated = true
                return NSManagedObjectContext()
            }
            
            override func createMainContext(parentContext: NSManagedObjectContext?) -> NSManagedObjectContext {
                mainContextAdded = true
                return NSManagedObjectContext()
            }
        }
        
        let stack: MockCDStack = MockCDStack(databaseName: "test", automigrating: false)
        stack.initialize()
        XCTAssertTrue(stack.pscCreated, "Should initialize the persistent store coordinator")
        XCTAssertTrue(stack.databaseAdded, "Should add the database")
        XCTAssertTrue(stack.rootSavingContextCreated, "Should create the root saving context")
        XCTAssertTrue(stack.mainContextAdded, "Should add a main context")
        XCTAssertTrue(stack.stackInitialized, "Stack should be set as initialized")
        stack.removeDatabase()
    }
    
    func testBackgroundContextShouldHaveTheRootSavingContextAsParent()
    {
        XCTAssertEqual((stack!.backgroundContext() as SugarRecordCDContext).contextCD.parentContext!, stack!.rootSavingContext!, "The private context should have the root saving context as parent")
    }
    
    func testMainContextShouldHaveTheRootSavingContextAsParent()
    {
        XCTAssertEqual(stack!.mainContext!.parentContext!, stack!.rootSavingContext!, "Main saving context should have the root saving context as parent")
    }
    
    func testRootSavingContextShouldHaveThePersistentStoreCoordinatorAsParent()
    {
        XCTAssertEqual(stack!.rootSavingContext!.persistentStoreCoordinator!, stack!.persistentStoreCoordinator!, "Root saving context should have the PSC as parent")
    }
    
    func testBackgroundContextConcurrencyType()
    {
        XCTAssertEqual(stack!.rootSavingContext!.concurrencyType, NSManagedObjectContextConcurrencyType.PrivateQueueConcurrencyType, "The concurrency type should be PrivateQueueConcurrencyType")
    }
    
    func testMainContextConcurrencyType()
    {
        XCTAssertEqual(stack!.mainContext!.concurrencyType, NSManagedObjectContextConcurrencyType.MainQueueConcurrencyType, "The concurrency type should be MainQueueConcurrencyType")
    }
    
    func testRootSavingContextConcurrencyType()
    {
        XCTAssertEqual((stack!.backgroundContext() as SugarRecordCDContext).contextCD.concurrencyType, NSManagedObjectContextConcurrencyType.ConfinementConcurrencyType, "The concurrency type should be MainQueueConcurrencyType")
    }
    
    func testIfTheAutoSavingClosureIsCalledDependingOnTheAutoSavingProperty()
    {
        class MockDefaultStack: DefaultCDStack
        {
            var autoSavingClosureCalled: Bool = true
            override func autoSavingClosure() -> () -> ()
            {
                return { [weak self] (notification) -> Void in
                    self!.autoSavingClosureCalled = true
                }
            }
        }
        let mockStack: MockDefaultStack = MockDefaultStack(databaseName: "test", automigrating: false)
        mockStack.initialize()
        mockStack.autoSaving = true
        XCTAssertTrue(mockStack.autoSavingClosureCalled, "The AutoSavingClosure should be called if the autosaving is enabled")
        mockStack.autoSavingClosureCalled = false
        mockStack.autoSaving = false
        XCTAssertFalse(mockStack.autoSavingClosureCalled, "The AutoSavingClosure shouldn't be called if the autosaving is disabled")
    }
}
