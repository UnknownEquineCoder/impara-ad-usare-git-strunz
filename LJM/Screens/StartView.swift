import Foundation
import SwiftUI
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

struct StartView: View {
    
    @Binding var isLoading : Bool
    
    // core data elements
    @Environment(\.managedObjectContext)
    private var viewContext
    @FetchRequest(fetchRequest: EvaluatedObject.get_Evaluated_Object_List_Request(), animation: .default)
    private var objectives: FetchedResults<EvaluatedObject>
    
    @StateObject var totalNumberLearningObjectivesStore = TotalNumberOfLearningObjectivesStore()
    @StateObject var learningPathsStore = LearningPathStore()
    @StateObject var strandsStore = StrandsStore()
    @EnvironmentObject var learningObjectiveStore: LearningObjectivesStore
    let blank = false
    @State var selectedMenu: OutlineMenu = .compass
    @State var filter_Path = "None"
    
    @State private var showingAlertTest = false
    
    @State var testDataServer : User?
    
    func selectedView() -> AnyView {
        switch selectedMenu {
        case .compass:
            return AnyView(CompassView(path: $filter_Path))
        case .journey:
            return AnyView(MyJourneyMainView(selectedMenu: $selectedMenu))
        case .map:
            return AnyView(MapMainView())
        }
    }
    
    @ViewBuilder
    var body: some View {
        
        HSplitView {
            ZStack{
                Color.clear
                    .ignoresSafeArea()
                    .visualEffect(material: .sidebar)
                    .padding(.top, -50)
                    
                VStack(alignment: .leading) {
                    ForEach(OutlineMenu.allCases) { menu in
                        ZStack(alignment: .leading) {
                            OutlineRow(item: menu, selectedMenu: self.$selectedMenu)
                                .frame(height: 40)
                                .padding([.leading, .trailing], 10)
                            if menu == self.selectedMenu {
                                RoundedRectangle(cornerRadius: 8)
                                    .foregroundColor(Color.secondary.opacity(0.1))
                                    .frame(height: 40)
                                    .padding([.leading, .trailing], 10)
                            }
                        }
                    }
                    Spacer()
                    
//                    Text("Test server response")
//                        .onTapGesture {
//                            let semaphore = DispatchSemaphore (value: 0)
//
//                            let parameters = "{\n    \"username\": \"pippozzo\",\n    \"email\": \"me@me.com\"\n}"
//                            let postData = parameters.data(using: .utf8)
//
//                            var request = URLRequest(url: URL(string: "http://10.20.48.36:8080/users")!,timeoutInterval: Double.infinity)
//                            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//
//                            request.httpMethod = "POST"
//                            request.httpBody = postData
//
//                            let task = URLSession.shared.dataTask(with: request) { data, response, error in
//
//                                let decoder = JSONDecoder()
//
//                                guard let data = data, let userTest = try? decoder.decode(User.self, from: data) else {
//
//                                    print(String(describing: error))
//                                    semaphore.signal()
//
//                                    return
//                                }
//
//                                showingAlertTest = true
//
//                                testDataServer = userTest
//
//                                print(String(data: data, encoding: .utf8)!)
//                                semaphore.signal()
//                            }
//
//                            task.resume()
//                            semaphore.wait()
//                        }
//                        .alert(isPresented: $showingAlertTest) {
//                            Alert(
//                                title: Text("User data"),
//                                message: Text("id : \(testDataServer!._id)\n email : \(testDataServer!.email)\n username: \(testDataServer!.username)"),
//                                primaryButton: .default( Text("Thanks"), action: {
//
//                                }),
//                                secondaryButton: .default( Text("Cancel"), action: {
//
//                                })
//                            )
//                        }
//                        .padding()
                    Spacer()
                    StudentPictureView()
                }
            }
            .padding(.top, 20)
            .frame(width: 250)
            
            
            if isLoading {
                HStack{
                    Spacer()
                    VStack{
                        Spacer()
                        Text("Loading...")
                        Spacer()
                    }
                    Spacer()
                }
            } else {
                selectedView()
                    .environmentObject(totalNumberLearningObjectivesStore)
                    .environmentObject(learningPathsStore)
                    .environmentObject(strandsStore)
            }
        }
        .onTapGesture {
            NSApp.keyWindow?.makeFirstResponder(nil)
        }
        .onAppear(perform: {
            isLoading = true
            learningObjectiveStore.load_Test_Data() {
                DispatchQueue.main.async {
                    learningObjectiveStore.load_Status(objectives: objectives)
                    learningPathsStore.load_Learning_Path()
                    strandsStore.setupStrandsOnNativeFilter(learningObjectives: learningObjectiveStore.learningObjectives)
                    isLoading = false
                }
            }
        })
    }
}

struct User : Codable {
    let _id: String
    let email: String
    let username: String
}

extension View {
    func visualEffect(
        material: NSVisualEffectView.Material,
        blendingMode: NSVisualEffectView.BlendingMode = .behindWindow,
        emphasized: Bool = false
    ) -> some View {
        background(
            VisualEffectBackground(
                material: material,
                blendingMode: blendingMode,
                emphasized: emphasized
            )
        )
    }
}

struct VisualEffectBackground: NSViewRepresentable {
    private let material: NSVisualEffectView.Material
    private let blendingMode: NSVisualEffectView.BlendingMode
    private let isEmphasized: Bool
    
    fileprivate init(
        material: NSVisualEffectView.Material,
        blendingMode: NSVisualEffectView.BlendingMode,
        emphasized: Bool) {
        self.material = material
        self.blendingMode = blendingMode
        self.isEmphasized = emphasized
    }
    
    func makeNSView(context: Context) -> NSVisualEffectView {
        let view = NSVisualEffectView()
        
        // Not certain how necessary this is
        view.autoresizingMask = [.width, .height]
        
        return view
    }
    
    func updateNSView(_ nsView: NSVisualEffectView, context: Context) {
        nsView.material = material
        nsView.blendingMode = blendingMode
        nsView.isEmphasized = isEmphasized
    }
}
