import Foundation
import SwiftUI

struct StartView: View {
    @State var selectedMenu: OutlineMenu = .compass
    
    // new data flow element
    @State var path : [learning_Path] = []
    @State var rubric : [rubric_Level] = []
    
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
                                        .frame(height: 50)
                                    if menu == self.selectedMenu {
                                        Rectangle()
                                            .foregroundColor(Color.secondary.opacity(0.1))
                                            .frame(height: 50)
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
            
            switch selectedMenu {
            case .compass:
                CompassView()
            case .journey:
                MyJourneyMainView(selectedMenu: $selectedMenu, path: $path)
            case .map:
                MapMainView(path: $path, rubric: $rubric)
            }
            
        }
        .onAppear(perform: {
            load_Learning_Rubric()
            load_Learning_Path()
        })
    }
    
    func load_Learning_Rubric(){
        
        var csvToStruct = [rubric_Level]()
        
        guard let filePath = Bundle.main.path(forResource: "Rubric_Level", ofType: "csv") else {
            rubric = []
            return
        }
        
        var data = ""
        do {
            data = try String(contentsOfFile: filePath)
        } catch {
            print(error)
            rubric = []
            return
        }
        
        var rows = data.components(separatedBy: "\n")
        
        rows.removeFirst()
        rows.removeLast()
        
        for row in rows {
            
            let csvColumns = row.components(separatedBy: ",")
            
            let LOsStruct = rubric_Level.init(raw: csvColumns)
            csvToStruct.append(LOsStruct)
            
        }
        
        rubric = csvToStruct
        
    }
    
    func load_Learning_Path(){
        var csvToStruct = [learning_Path]()
        
        guard let filePath = Bundle.main.path(forResource: "Learning_Paths", ofType: "csv") else {
            path = []
            return
        }
        
        var data = ""
        do {
            data = try String(contentsOfFile: filePath)
        } catch {
            print(error)
            path = []
            return
        }
        
        var rows = data.components(separatedBy: "\n")
        
        rows.removeFirst()
        rows.removeLast()
        
        for row in rows {
            
            let csvColumns = row.components(separatedBy: ",")
            
            let LOsStruct = learning_Path.init(raw: csvColumns)
            csvToStruct.append(LOsStruct)
        }
        path = csvToStruct
    }
}

