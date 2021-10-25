import SwiftUI
import CoreData
import SwiftKeychainWrapper
import UniformTypeIdentifiers

@main
struct LJMApp: App {
        
    @AppStorage("log_Status") var status = true
    
    @AppStorage("webview_error") var webViewError: String = ""
        
    @State var webViewGotError: Bool = false
    
    @State private var document: MessageDocument = MessageDocument(message: "Hello, World!")
    
    //for import and export files
    @State var importFile = false
    @State var exportFile = false
    @State private var toExport = Bundle.main.path(forResource: "file", ofType: "csv")
    let file_Name = "Personal_Data.csv"
    
    @State var rubric : [rubric_Level] = []
    
    let singleton = singleton_Shared.shared
    
    @StateObject var learningObjectiveStore = LearningObjectivesStore()
    @StateObject var totalNumberLearningObjectivesStore = TotalNumberOfLearningObjectivesStore()
    
//    let srtType = UTType(exportedAs: "com.company.srt-document", conformingTo: .commaSeparatedText)
    let srtType = UTType("com.exemple.LearningJourneyManager")!
    var body: some Scene {
        WindowGroup {
            // MainScreen used as a Splash screen -> redirect to Login view or Content view regarding the login status
//            DocumentGroup(newDocument: DocDemoDocument()) { file in
                StartView()
//            }
                .onAppear(perform: {
                    learningObjectiveStore.load_Test_Data()
                })
            
                .fileExporter(
                    isPresented: $exportFile,
                    document: document,
                    contentType: srtType,
                    defaultFilename: "Message"
                ) { result in
                    if case .success = result {
                        // Handle success.
                    } else {
                        // Handle failure.
                    }
                }
//            .fileExporter(
//                isPresented: $exportFile,
//                document: Doc(url: "Documents/\(file_Name)" ),
//                contentType: srtType,
//                defaultFilename: "\(file_Name)",
//                onCompletion: {
//                    res in
//                    do{
//                        let fileURL = try res.get()
//                        print(fileURL)
//                    } catch {
//                        print("can not save the document ")
//                    }
//                })
            
            .fileImporter(
                isPresented: $importFile,
                allowedContentTypes: [.plainText],
                allowsMultipleSelection: false
            ) { result in
                if case .success = result {
                    do {
                        let fileURL: URL = try result.get()[0]
                        let file = try String(contentsOf: fileURL)
                        let lines = file.split(separator: "\n", omittingEmptySubsequences: false)
                        
                    } catch {
                        let nsError = error as NSError
                        fatalError("File Import Error \(nsError), \(nsError.userInfo)")
                    }
                } else {
                    print("File Import Failed")
                }
            }
            .environmentObject(learningObjectiveStore)
            .environmentObject(totalNumberLearningObjectivesStore)
        }
        
        
        WindowGroup("LoginPage") {
            WebviewLogin(url: "https://ljm-dev-01.fed.it.iosda.org/api/auth/saml/login", error: $webViewGotError)
                .alert(isPresented: $webViewGotError, content: {
                    Alert(title: Text("Error"), message: Text(webViewError))
                })
        }
        .handlesExternalEvents(matching: Set(arrayLiteral: "*"))
        .commands(content: {
            CommandGroup(after: .appInfo, addition: {
                
                // to import files
                Button(action: {
                    importFile.toggle()
                    }) {
                    Text("Import File")
                }
                
                // to export files
                Button(action: {
                    //write on the file here
                    let str = "Test,Message,something \n hello,there,folks"
                    let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(file_Name)
                    do {
                        try str.write(to: url, atomically: true, encoding: .utf8)
//                        let input = try String(contentsOf: url)
//                        print("@@@@@@@@@@@@@@ \(input)")
                    } catch {
                        print("@@@@@@@@@@@@@@@@@@@@@ \(error.localizedDescription)")
                    }
                    exportFile.toggle()
                }) {
                    Text("Export File")
                }
            })
        })
    }
}

struct Doc : FileDocument {
    var url : String
    
    static var readableContentTypes: [UTType]{[.plainText]}
    
    init(url : String) {
        self.url = url
    }
    
    init(configuration: ReadConfiguration) throws {
        url = ""
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let file = try FileWrapper(url: URL(fileURLWithPath: url), options: .immediate)
        
        return file
    }
}

