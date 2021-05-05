import Foundation

extension LJM {
    /**
     Storage keeps track of all the data inside the App, making access straight-forward
     It is implemented using the Singleton Pattern
     */
    final class Storage: ObservableObject {
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
