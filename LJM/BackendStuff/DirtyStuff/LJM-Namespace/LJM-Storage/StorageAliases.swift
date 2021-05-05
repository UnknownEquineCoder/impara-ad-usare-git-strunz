import Foundation

extension LJM.Storage {
    public typealias FilterPredicate<T> = (T, T) -> (Bool)
    public typealias PickledPredicate<T> = (FilterPredicate<T>, T)
}
