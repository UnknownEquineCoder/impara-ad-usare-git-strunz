import SwiftUI
import CoreData
import SwiftKeychainWrapper
import UniformTypeIdentifiers

@main
struct LJMApp: App {
    
    @AppStorage("webview_error") var webViewError: String = ""
    
    @State var webViewGotError: Bool = false
    
    @State private var document: MessageDocument = MessageDocument(message: "Hello, World!")
    
    //for import and export files
    @State var importFile = false
    @State var exportFile = false
    @State private var toExport = Bundle.main.path(forResource: "file", ofType: "csv")
    let file_Name = "Personal_Data.csv"
    
    @StateObject var learningObjectiveStore = LearningObjectivesStore()
    @StateObject var totalNumberLearningObjectivesStore = TotalNumberOfLearningObjectivesStore()
    @StateObject var learningPathsStore = LearningPathStore()
    @StateObject var strandsStore = StrandsStore()
    
    //    let srtType = UTType(exportedAs: "com.company.srt-document", conformingTo: .commaSeparatedText)
    let srtType = UTType("com.exemple.LearningJourneyManager")!
    var body: some Scene {
        WindowGroup {
            // MainScreen used as a Splash screen -> redirect to Login view or Content view regarding the login status
            //            DocumentGroup(newDocument: DocDemoDocument()) { file in
            StartView()
            //            }
                .onAppear(perform: {
                    learningObjectiveStore.load_Test_Data() {
                        learningObjectiveStore.load_Status()
                        learningPathsStore.load_Learning_Path()
                        strandsStore.setupStrandsOnNativeFilter(learningObjectives: learningObjectiveStore.learningObjectives)
                    }
                    
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
                    allowedContentTypes: [srtType],
                    allowsMultipleSelection: false
                ) { result in
                    if case .success = result {
                        do {
                            learningObjectiveStore.isSavable = false
                            
                            guard let selectedFile: URL = try result.get().first else { return }
                            guard let message = String(data: try Data(contentsOf: selectedFile), encoding: .utf8) else { return }
                            let rows = message.components(separatedBy: "\n")
                            var learning_Objectives = learningObjectiveStore.learningObjectives
                            
                            for row in rows {
                                let row_Data = row.components(separatedBy: ",")
                                let index = learning_Objectives.firstIndex(where: {$0.ID == row_Data[0]}) ?? 0
                                
                                let eval_Date_Row = row_Data[2].components(separatedBy: "-")
                                let eval_score_Row = row_Data[1].components(separatedBy: "-")
                                
                                var converted_Eval_Date : [Date] = []
                                var converted_Eval_Score : [Int] = []
                                
                                for index in 0..<eval_score_Row.count {
                                    converted_Eval_Date.append(Date(timeIntervalSince1970: Double(eval_Date_Row[index])!))
                                    converted_Eval_Score.append(Int(eval_Date_Row[index])!)
                                }
                                
                                learning_Objectives[index].eval_date = converted_Eval_Date
                                learning_Objectives[index].eval_score = converted_Eval_Score
                                
                            }
                            
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
                .environmentObject(learningPathsStore)
                .environmentObject(strandsStore)
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
                    
                    var data_To_Save = ""
                    let evaluated_Learning_Objectives = learningObjectiveStore.learningObjectives.filter({$0.eval_score.count > 0})
                    
                    data_To_Save.append("ID,eval_score,eval_date\n")
                    
                    for learning_Objective in evaluated_Learning_Objectives {
                        data_To_Save.append("\(learning_Objective.ID),")
                        
                        for eval_Score_Index in 0..<learning_Objective.eval_score.count-1 {
                            data_To_Save.append("\(learning_Objective.eval_score[eval_Score_Index])-")
                        }
                        data_To_Save.append("\(learning_Objective.eval_score.last!),")
                        
                        for eval_Score_Index in 0..<learning_Objective.eval_date.count-1 {
                            data_To_Save.append("\(learning_Objective.eval_date[eval_Score_Index].timeIntervalSince1970)-")
                        }
                        data_To_Save.append("\(learning_Objective.eval_date.last!.timeIntervalSince1970)\n")
                        
                    }
                    
                    document.message = data_To_Save
                    
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

