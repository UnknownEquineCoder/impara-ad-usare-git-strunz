import Foundation
import SwiftUI

struct StartView: View {
    
    @Binding var isLoading : Bool
    
    // core data elements
    @Environment(\.managedObjectContext) private var viewContext
    @State var timer: Timer?
    @State var runCount = 0
    
    //    @FetchRequest(
    //        sortDescriptors: [],
    //        animation: .default)
    @FetchRequest(fetchRequest: EvaluatedObject.get_Evaluated_Object_List_Request(), animation: .default)
    private var objectives: FetchedResults<EvaluatedObject>
    
    @State var selectedMenu: OutlineMenu = .compass
    
    @StateObject var totalNumberLearningObjectivesStore = TotalNumberOfLearningObjectivesStore()
    @StateObject var learningPathsStore = LearningPathStore()
    @StateObject var strandsStore = StrandsStore()
    
    @EnvironmentObject var learningObjectiveStore: LearningObjectivesStore
    
    @State var filter_Path = "None"
    
    @ViewBuilder
    var body: some View {
        
        NavigationView {
            VStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        ForEach(OutlineMenu.allCases) { menu in
                            ZStack(alignment: .leading) {
                                OutlineRow(item: menu, selectedMenu: self.$selectedMenu)
                                    .frame(height: 54).padding([.leading, .trailing], 10)
                                if menu == self.selectedMenu {
                                    RoundedRectangle(cornerRadius: 8)
                                        .foregroundColor(Color.secondary.opacity(0.1))
                                        .frame(height: 54)
                                        .padding([.leading, .trailing], 10)
                                }
                            }
                        }
                    }
                
                Spacer()
                StudentPictureView()
            }
            
            .frame(minWidth: 300, idealWidth: nil, maxWidth: 350, minHeight: nil, idealHeight: nil, maxHeight: nil, alignment:.center)

            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {

                        // IT will switch the presence of the sidebar
                        NSApp.sendAction(#selector(NSSplitViewController.toggleSidebar(_:)), to: nil, from: nil)
                    } label: {
                        Image(systemName: "sidebar.left")
                    }
                }
            }
                    
            // View connected to the sidebar
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
                switch selectedMenu {
                case .compass:
                    CompassView(path: $filter_Path)
                        .environmentObject(totalNumberLearningObjectivesStore)
                        .environmentObject(learningPathsStore)
                        .environmentObject(strandsStore)
                case .journey:
                    MyJourneyMainView(selectedMenu: $selectedMenu)
                        .environmentObject(totalNumberLearningObjectivesStore)
                        .environmentObject(learningPathsStore)
                        .environmentObject(strandsStore)
                case .map:
                    MapMainView()
                        .environmentObject(totalNumberLearningObjectivesStore)
                        .environmentObject(learningPathsStore)
                        .environmentObject(strandsStore)
                }
            }
                
        }
        .navigationViewStyle(.automatic)

//        .introspectSplitViewController { controller in
//            // some examples
//            controller.preferredSupplementaryColumnWidthFraction = 3
//            controller.preferredPrimaryColumnWidth = 180
//            controller.preferredDisplayMode = .twoBesideSecondary
//            controller.presentsWithGesture = false
//      }
        .onTapGesture {
            NSApp.keyWindow?.makeFirstResponder(nil)
        }
        .onAppear(perform: {

            learningObjectiveStore.load_Test_Data() {
                
                learningObjectiveStore.load_Status(objectives: objectives)
                learningPathsStore.load_Learning_Path()
                strandsStore.setupStrandsOnNativeFilter(learningObjectives: learningObjectiveStore.learningObjectives)
                
//                if learningObjectiveStore.learningObjectives.filter({$0.eval_score.count>0}).count == 0 {
//                    withAnimation {
//                        isLoading = true
//                    }
//
////                    timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { timer in
////                        update_Store()
////                        runCount+=1
////                        if runCount == 50 {
////                            withAnimation {
////                                isLoading = false
////                            }
////                            timer.invalidate()
////                        }
////                    }
//                }
                
                
            }
        })
    }
    
//    @State var temp_Array : [CD_Evaluated_Object] = []
//    @State var jumpedTime = 0
    
//    func update_Store() {
//
//        let context = PersistenceController.shared.container.newBackgroundContext()
////        PersistenceController.container.newBackgroundContext()
//        var items : [EvaluatedObject] = []
//        var usable_Items : [CD_Evaluated_Object] = []
//
//        do{
//            try items = context.fetch(EvaluatedObject.get_Evaluated_Object_List_Request())
//        } catch {
//            print("error : \(error)")
//        }
//
//        for item in items {
//            usable_Items.append(CD_Evaluated_Object(id: item.id ?? "ND", eval_Date: item.eval_Dates as! [Date], eval_Score: item.eval_Scores as! [Int]))
//        }
//
//        for objective_To_Add in usable_Items {
//            let possible_Index = learningObjectiveStore.learningObjectives.firstIndex(where: {$0.ID == objective_To_Add.id})
//
//            if let index = possible_Index{
//                learningObjectiveStore.learningObjectives[index].eval_date = objective_To_Add.eval_Date
//                learningObjectiveStore.learningObjectives[index].eval_score = objective_To_Add.eval_Score
//            }
//        }
//
//        if temp_Array.count > 0 {
//            if temp_Array ==  usable_Items{
//                if jumpedTime == 3 {
//                    timer?.invalidate()
//                    isLoading = false
//                    // TODO implement the name update here
//                } else {
//                    jumpedTime+=1
//                }
//            } else {
//                jumpedTime = 0
//            }
//        }
//
//        temp_Array = usable_Items
//
//        //        }
//    }
    
}
