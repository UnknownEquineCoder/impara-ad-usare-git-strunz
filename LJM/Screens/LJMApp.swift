import SwiftUI
import CoreData
import SwiftKeychainWrapper
import UniformTypeIdentifiers

@main
struct LJMApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    // instantiating the controller for core data
    let persistenceController = PersistenceController.shared
    
    @StateObject var learningObjectiveStore = LearningObjectivesStore()
    
    //for import and export files
    @State var importFile = false
    @State var exportFile = false
    @State private var document: MessageDocument = MessageDocument(message: "Hello, World!")
    
    @State var isLoading = false
    @State var isSavable = true
    @State private var showingAlertImport = false
    
    @State private var is_Import_Deleted = false
    
    var dateFormatter : DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MMM/yyyy"
        return dateFormatter
    }()
    
    //    let srtType = UTType(exportedAs: "com.company.srt-document", conformingTo: .commaSeparatedText)
    let srtType = UTType("com.exemple.LearningJourneyManager")!
    let semaphore = DispatchSemaphore(value: 1)
    let dispatchGroup = DispatchGroup()
    
    var body: some Scene {
        WindowGroup {
            StartView(isLoading: $isLoading)
                .alert(isPresented: $showingAlertImport) {
                    Alert(
                        title: isSavable ? Text("Importing this file will overwrite your old data. \n\n Do you want to proceed?") : Text("Importing this file will only display the new data. \n\n Any changes will not be saved."),
                        message: isSavable ? Text("You can not undo this action.") : nil,
                        primaryButton: .default( Text("Import"), action: {
                            is_Import_Deleted = false
                            dispatchGroup.leave()
                        }),
                        secondaryButton: .default( Text("Cancel"), action: {
                            is_Import_Deleted = true
                            dispatchGroup.leave()
                        })
                    )
                }
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .frame(minWidth: (NSScreen.screenWidth! * 0.94) > 1279 ? NSScreen.screenWidth! * 0.94 : 1279 , maxWidth: nil, minHeight: NSScreen.screenHeight! * 0.8, maxHeight: nil, alignment: .center)
                .fileExporter(
                    isPresented: $exportFile,
                    document: document,
                    contentType: srtType,
                    defaultFilename: "LJM export - \(dateFormatter.string(from: Date()))"
                ) { result in
                    if case .success = result {
                        // Handle success.
                    } else {
                        // Handle failure.
                    }
                }
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .fileExporter(
                    isPresented: $exportFile,
                    document: document,
                    contentType: srtType,
                    defaultFilename: "LJM export - \(dateFormatter.string(from: Date()))"
                ) { result in
                    if case .success = result {
                        // Handle success.
                    } else {
                        // Handle failure.
                    }
                }
                .fileImporter(
                    isPresented: $importFile,
                    allowedContentTypes: [srtType],
                    allowsMultipleSelection: false
                ) { result in
                    
                    if case .success = result {
                        showingAlertImport.toggle()
                        dispatchGroup.enter()
                        
                        dispatchGroup.notify(queue: .main) {
                            
                            if is_Import_Deleted {
                                return
                            }
                            
                            do {
                                isLoading = true
                                
                                learningObjectiveStore.isSavable = self.isSavable
                                guard let selectedFile: URL = try result.get().first else { return }
                                
                                guard let message = String(data: try Data(contentsOf: selectedFile), encoding: .utf8) else { return }
                                var rows = message.components(separatedBy: "\n")
                                let learning_Objectives = learningObjectiveStore.learningObjectives
                                
                                rows.removeFirst()
                                rows.removeLast()
                                
                                learningObjectiveStore.reset_Evaluated {
                                    
                                    if isSavable {
                                        // this part of the code will be lounched for override on cloudkit
                                        persistenceController.override_Data(rows: rows)
                                    }
                                    
                                    // this part of the code will put the datas visible in that moment
                                    for row in rows {
                                        
                                        let row_Data = row.components(separatedBy: ",")
                                        
                                        let eval_Date_Row = row_Data[2].components(separatedBy: "-")
                                        let eval_score_Row = row_Data[1].components(separatedBy: "-")
                                        
                                        var converted_Eval_Date : [Date] = []
                                        var converted_Eval_Score : [Int] = []
                                        
                                        for index in 0..<eval_score_Row.count {
                                            converted_Eval_Date.append(Date(timeIntervalSince1970: Double(eval_Date_Row[index])!))
                                            converted_Eval_Score.append(Int(eval_score_Row[index])!)
                                        }
                                        
                                        let index = learning_Objectives.firstIndex(where: {$0.ID == row_Data[0]}) ?? 0
                                        
                                        learningObjectiveStore.evaluate_Object(index: index, evaluations: converted_Eval_Score, dates: converted_Eval_Date)
                                    }
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) {
                                    isLoading = false
                                }
                                
                            } catch {
                                let nsError = error as NSError
                                fatalError("File Import Error \(nsError), \(nsError.userInfo)")
                            }
                        }
                        
                    } else {
                        print("File Import Failed")
                    }
                }
                .environmentObject(learningObjectiveStore)
        }
        .windowStyle(.hiddenTitleBar)
        .windowStyle(HiddenTitleBarWindowStyle())
        .handlesExternalEvents(matching: Set(arrayLiteral: "*"))
            .commands(content: {
                CommandGroup(after: .importExport, addition: {
                    
                    // to import files
                    Button(action: {
                        isSavable = true
                        importFile.toggle()
                    }) {
                        Text("Import File")
                    }
                    
                    Button {
                        isSavable = false
                        importFile.toggle()
                    } label: {
                        Text("Import File (Read Only)")
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

class AppDelegate: NSObject, NSApplicationDelegate {
    
    @AppStorage("fullScreen") var fullScreen: Bool = FullScreenSettings.fullScreen
        
    func applicationDidFinishLaunching(_ notification: Notification) {
        print("Info from `applicationDidFinishLaunching(_:): Finished launching…")
        let _ = NSApplication.shared.windows.map { $0.tabbingMode = .disallowed }
        
        NotificationCenter.default.addObserver(forName: NSWindow.willEnterFullScreenNotification, object: nil, queue: OperationQueue.main, using: { note in
            print("Entered Fullscreen")
            self.fullScreen = true
        })

        NotificationCenter.default.addObserver(forName: NSWindow.willExitFullScreenNotification, object: nil, queue: OperationQueue.main, using: { note in
            print("Exited Fullscreen")
            self.fullScreen = false
        })
        
        
        DispatchQueue.global(qos: .background).async {
            DropboxManager.instance.checkForUploadUserData()
        }
    }
}

enum FullScreenSettings {
    static let fullScreen = false
}
