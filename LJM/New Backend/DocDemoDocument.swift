//
//  DocDemoDocument.swift
//  LJM
//
//  Created by denys pashkov on 22/10/21.
//

import SwiftUI
import UniformTypeIdentifiers

extension UTType {
    static var exampleText: UTType {
        UTType(importedAs: "com.exemple.LearningJourneyManager")
    }
}

import SwiftUI
import UniformTypeIdentifiers

struct MessageDocument: FileDocument {
    
    static var readableContentTypes: [UTType] { [UTType(importedAs: "com.exemple.LearningJourneyManager"),.commaSeparatedText] }
    
    var message: String

    init(message: String) {
        self.message = message
    }

    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents,
              let string = String(data: data, encoding: .utf8)
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        message = string
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        return FileWrapper(regularFileWithContents: message.data(using: .utf8)!)
    }
    
}


//final class ChecklistDocument: ReferenceFileDocument {
//
//    typealias Snapshot = String
//
//    @Published var checklist: String
//
//    // Define the document type this app is able to load.
//    /// - Tag: ContentType
//    static var readableContentTypes: [UTType] { [UTType(importedAs: "com.exemple.LearningJourneyManager"),.commaSeparatedText] }
//
//    /// - Tag: Snapshot
//    func snapshot(contentType: UTType) throws -> String {
//        checklist // Make a copy.
//    }
//
//    init() {
//        checklist = "something"
//    }
//
//    // Load a file's contents into the document.
//    /// - Tag: DocumentInit
//    init(configuration: ReadConfiguration) throws {
//
////        print("##### something \(configuration)")
////
////        guard let data = configuration.file.regularFileContents
////        else {
////            print("####### error :(")
////            throw CocoaError(.fileReadCorruptFile)
////        }
////        print("########## No error")
//        self.checklist = "try JSONDecoder().decode(String.self, from: data)"
//    }
//
//    /// Saves the document's data to a file.
//    /// - Tag: FileWrapper
//    func fileWrapper(snapshot: String, configuration: WriteConfiguration) throws -> FileWrapper {
//        print("###########")
//        return FileWrapper(regularFileWithContents: checklist.data(using: .utf8)!)
////        let data = try JSONEncoder().encode(snapshot)
////        let fileWrapper = FileWrapper(regularFileWithContents: data)
////        return fileWrapper
//    }
//}
//
//struct DocumentTestDocument: FileDocument {
//    var text: String
//
//    init(text: String = "Hello, world!") {
//        self.text = text
//    }
//
//    static var readableContentTypes: [UTType] { [.exampleText] }
//
//    init(configuration: ReadConfiguration) throws {
//        guard let data = configuration.file.regularFileContents,
//              let string = String(data: data, encoding: .utf8)
//        else {
//            throw CocoaError(.fileReadCorruptFile)
//        }
//        text = string
//    }
//
//    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
//        let data = text.data(using: .utf8)!
//        return .init(regularFileWithContents: data)
//    }
//}
//
