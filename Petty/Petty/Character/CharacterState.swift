import Foundation

enum CharacterState: String, CaseIterable {
    case idle
    case active
    case bored
    case dragging
    case poked
}

enum CharacterActivityKind {
    case none
    case typing
    case pointer
}
