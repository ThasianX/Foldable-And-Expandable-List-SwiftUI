// Kevin Li - 7:37 PM - 5/25/20

import SwiftUI

extension View {

    func expandableAndFoldable(
        rowHeight: CGFloat,
        foldOffset: CGFloat,
        shouldFold: Bool,
        isActiveIndex: Bool) -> some View {
        modifier(ExpandAndFoldModifier(
            rowHeight: rowHeight,
            foldOffset: foldOffset,
            shouldFold: shouldFold,
            isActiveIndex: isActiveIndex))
    }

}

struct ExpandAndFoldModifier: ViewModifier {

    let rowHeight: CGFloat
    let foldOffset: CGFloat
    let shouldFold: Bool
    let isActiveIndex: Bool

    func body(content: Content) -> some View {
        GeometryReader { geometry in
            content
                .modifier(self.makeNestedModifier(withMinY: geometry.frame(in: .global).minY))
        }
    }

    private func makeNestedModifier(withMinY minY: CGFloat) -> _ExpandAndFoldModifier {
        _ExpandAndFoldModifier(rowHeight: rowHeight, foldOffset: foldOffset, minY: minY, shouldFold: shouldFold, isActiveIndex: isActiveIndex)
    }

}

private struct _ExpandAndFoldModifier: ViewModifier {

    let rowHeight: CGFloat // height of the row to be folded
    let foldOffset: CGFloat // y coordinate at which to start folding
    let minY: CGFloat // the current y coordinate of the row
    let shouldFold: Bool // shouldn't fold when expanded
    let isActiveIndex: Bool // if the row is active, we want to expand it by offsetting it from it's current position to the top of the screen

    func body(content: Content) -> some View {
        content
            .offset(y: isActiveIndex ? topOfScreen : 0)
            .rotation3DEffect(rotationAngle, axis: (x: -200, y: 0, z: 0), anchor: .bottom)
            .opacity(opacity)
    }

    private var topOfScreen: CGFloat {
        -minY
    }

    private var shouldStartFolding: Bool {
        minY < foldOffset
    }

    private var rotationAngle: Angle {
        guard shouldFold && shouldStartFolding else { return .degrees(0) }
        return .degrees(-foldDegree) // negative because we want to fold inward
    }

    private var foldDegree: Double {
        // When the minY of the provided cell is equal to the foldOffset, the
        // fold degree should be 0 and as such, the fold delta is 1.
        // fold degree becomes 90 when fold delta becomes 0, which is when
        // the cell is completely folded
        guard foldDelta >= 0 else { return 90 }
        return 90 - (90 * foldDelta)
    }

    private var opacity: Double {
        guard shouldFold && shouldStartFolding && (foldDelta >= 0) else { return 1 }
        // 0.4 padding because we don't want the cell to fully fade when it's folded
        return foldDelta + 0.4
    }

    private var foldDelta: Double {
        Double((rowHeight + (minY - foldOffset)) / rowHeight)
    }
    
}
