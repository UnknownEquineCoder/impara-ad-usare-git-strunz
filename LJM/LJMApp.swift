import SwiftUI
import CoreData
import SwiftKeychainWrapper
import UniformTypeIdentifiers

@main
struct LJMApp: App {
        
    @AppStorage("log_Status") var status = true
    
    @AppStorage("webview_error") var webViewError: String = ""
    
    @StateObject var user = FrozenUser(name: "", surname: "")
    
    @State var webViewGotError: Bool = false
    
    //for import and export files
    @State var importFile = false
    @State var exportFile = false
    @State private var toExport = Bundle.main.path(forResource: "file", ofType: "csv")
    let fileName = "message.txt"
    
    var body: some Scene {
        WindowGroup {
            //     ContentView()
            
            //     LoginView()
            
            // MainScreen used as a Splash screen -> redirect to Login view or Content view regarding the login status
            MainScreen().onAppear { status = true }
            .environmentObject(user)
            .fileExporter(
                isPresented: $exportFile,
                document: Doc(url: "Documents/\(fileName)" ),
                contentType: .plainText,
                defaultFilename: "Random",
                onCompletion: { res in
                    do{
                        let fileURL = try res.get()
                        print(fileURL)
                    } catch {
                        print("can not save the document ")
                    }
                })
            .fileImporter(
                isPresented: $importFile,
                allowedContentTypes: [.image],
                allowsMultipleSelection: false
            ) { result in
                if case .success = result {
                    do {
                        let audioURL: URL = try result.get().first!
                        print(audioURL)
                    } catch {
                        let nsError = error as NSError
                        fatalError("File Import Error \(nsError), \(nsError.userInfo)")
                    }
                } else {
                    print("File Import Failed")
                }
            }
        }
        
        
        WindowGroup("LoginPage") {
            WebviewLogin(url: "https://ljm-dev-01.fed.it.iosda.org/api/auth/saml/login", error: $webViewGotError)
                .environmentObject(user)
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
                    let str = "Test Message"
                    let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(fileName)
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
    
    func export_CSV(){
        
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
        let file = try! FileWrapper(url: URL(fileURLWithPath: url), options: .immediate)
        
        return file
    }
}
