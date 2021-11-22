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
        HStack(spacing: 0) {
            VStack {
                VStack {
                    StudentPictureView(size: 85)
                        .padding(.trailing)
                    
                    
                    ScrollView(showsIndicators: false) {
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
                        .padding(.top, 32)
                        .frame(width: 300)
                    }
                }
            }.background(Color.primary.opacity(0.1))
            
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
        .onAppear(perform: {
            
            learningObjectiveStore.load_Test_Data() {
                
                PersistenceController.shared.fetched_Learning_Objectives = objectives
                learningObjectiveStore.load_Status(objectives: objectives)
                learningPathsStore.load_Learning_Path()
                strandsStore.setupStrandsOnNativeFilter(learningObjectives: learningObjectiveStore.learningObjectives)
                
                if learningObjectiveStore.learningObjectives.filter({$0.eval_score.count>0}).count == 0 {
                    withAnimation {
                        isLoading = true
                    }
                    
                    timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { timer in
                        update_Store()
                        runCount+=1
                        if runCount == 50 {
                            withAnimation {
                                isLoading = false
                            }
                            timer.invalidate()
                        }
                    }
                }
                
                
            }
        })
    }
    
    @State var temp_Array : [CD_Evaluated_Object] = []
    @State var jumpedTime = 0
    
    func update_Store() {
        
        let context = PersistenceController.container.newBackgroundContext()
        var items : [EvaluatedObject] = []
        var usable_Items : [CD_Evaluated_Object] = []
        
        do{
            try items = context.fetch(EvaluatedObject.get_Evaluated_Object_List_Request())
        } catch {
            print("error : \(error)")
        }
        
        for item in items {
            usable_Items.append(CD_Evaluated_Object(id: item.id ?? "ND", eval_Date: item.eval_Dates as! [Date], eval_Score: item.eval_Scores as! [Int]))
        }
        
        for objective_To_Add in usable_Items {
            let possible_Index = learningObjectiveStore.learningObjectives.firstIndex(where: {$0.ID == objective_To_Add.id})
            
            if let index = possible_Index{
                learningObjectiveStore.learningObjectives[index].eval_date = objective_To_Add.eval_Date
                learningObjectiveStore.learningObjectives[index].eval_score = objective_To_Add.eval_Score
            }
        }
        
        if temp_Array.count > 0 {
            if temp_Array ==  usable_Items{
                if jumpedTime == 3 {
                    timer?.invalidate()
                    isLoading = false
                    // TODO implement the name update here
                } else {
                    jumpedTime+=1
                }
            } else {
                jumpedTime = 0
            }
        }
        
        temp_Array = usable_Items
        
        //        }
    }
    
}
