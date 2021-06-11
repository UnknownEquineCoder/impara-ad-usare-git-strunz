import Foundation

extension LJM {
    /**
     Storage keeps track of all the data inside the App, making access straight-forward
     It is implemented using the Singleton Pattern
     */
    
    final class Storage: ObservableObject {
        
        @Published var user = FrozenUser(name: "", surname: "")
        
//        @AutoUpdate var strands: [Strand] = [] {
//            willSet {
//                objectWillChange.send()
//            }
//        }
        
        @AutoUpdate var challenges: [LearningPath] = [] {
            willSet {
                objectWillChange.send()
            }
        }
        
        @AutoUpdate var studentLearningObjectives: [LearningObjective] = [] {
            willSet {
                objectWillChange.send()
            }
        }
        
        @AutoUpdate var mapLearningObjectives: [LearningObjective] = [] {
            willSet {
                objectWillChange.send()
            }
        }
        
        @AutoUpdate var learningObjectives: [LearningObjective] = [] {
            willSet {
                objectWillChange.send()
            }
        }
        
        @AutoUpdate var learningPaths: [LearningPath] = [] {
            willSet {
                objectWillChange.send()
            }
        }
        
        /**
        @AutoUpdate var graphData: [UnrefinedGraphData] = [] {
            willSet {
                objectWillChange.send()
            }
        }
         */
        
        private init() { /* Business logic */ }
        
        // Singleton to avoid memory retain
        static var shared: Storage = { Storage() }()
    }
}
