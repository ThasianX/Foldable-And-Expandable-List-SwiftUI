// Kevin Li - 6:03 PM - 5/25/20

import SwiftUI

extension View {

    func exitOnDrag(
        if isSelected: Bool,
        onExit: @escaping () -> Void,
        isSimultaneous: Bool = false) -> some View {
        modifier(ExitDragGestureModifier(
            isSelected: isSelected,
            onExit: onExit,
            isSimultaneous: isSimultaneous))
    }
}

struct ExitDragGestureModifier: ViewModifier {
    @State var activeTranslation: CGSize = .zero

    let isSelected: Bool
    let onExit: () -> Void
    let isSimultaneous: Bool

    private var exitGestureIfSelected: some Gesture {
        return isSelected ? exitGesture : nil
    }

    private var exitGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                let height = value.translation.height
                let width = value.translation.width
                guard height > 0 && height < 100 else { return }
                guard width > 0 && width < 50 else { return }

                self.activeTranslation = value.translation
            }
            .onEnded { value in
                if self.activeTranslation.height > 50 || self.activeTranslation.width > 30 {
                    self.onExit()
                }
                self.resetActiveTranslation()
            }
    }

    private func resetActiveTranslation() {
        activeTranslation = .zero
    }

    func body(content: Content) -> some View {
        Group {
            if isSimultaneous {
                content
                    .scaleEffect(1 - ((activeTranslation.height + activeTranslation.width) / 1000))
                    .simultaneousGesture(exitGestureIfSelected)
            } else {
                content
                    .scaleEffect(1 - ((activeTranslation.height + activeTranslation.width) / 1000))
                    .gesture(exitGestureIfSelected)
            }
        }
    }
}
