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

//struct DocDemoDocument: FileDocument {
//    var text: String
//
//    init(text: String = "Hello, world!") {
//        self.text = text
//    }
//
//    static var readableContentTypes: [UTType] { [.commaSeparatedText] }
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

