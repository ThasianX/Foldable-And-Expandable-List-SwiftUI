// Kevin Li - 10:27 AM - 5/25/20

import SwiftUI

let screen = UIScreen.main.bounds
let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
let statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0

extension Color {

    static let blackPearl = Color("blackPearl")

}

struct VisitCellConstants {
    static let height: CGFloat = 130
    static let width: CGFloat = screen.width - 60

    static func height(if isSelected: Bool) -> CGFloat {
        // Extra +20 because clipShape does cut off a portion of the screen
        isSelected ? screen.height + 20 : height
    }

    static func maxWidth(if isSelected: Bool) -> CGFloat {
        isSelected ? .infinity : width
    }
}

fileprivate let listOffset: CGFloat = 95

struct VisitsListView: View {

    @State private var activeVisitIndex: Int = -1

    let visits: [Visit]

    private var isShowingVisit: Bool {
        activeVisitIndex != -1
    }

    var body: some View {
        ZStack(alignment: .top) {
            header
            visitsForDayList
                // Can't do VStack because it interfere with the expand animation so I have to do a ZStack with offset
                .offset(y: isShowingVisit ? 0 : listOffset)
        }
        .background(backgroundColor)
        .animation(.spring())
    }

    private var backgroundColor: some View {
        Color.blackPearl.saturation(1.5)
            .frame(height: screen.height + 20)
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
    }

}

private extension VisitsListView {

    private var header: some View {
        VStack {
            allVisitsText
            descriptionText
        }
        .foregroundColor(.white)
        .animation(nil)
        .padding(30)
    }

    private var allVisitsText: some View {
        Text("All Visits".uppercased())
            .font(.system(size: 22))
            .fontWeight(.bold)
            .tracking(2)
    }

    private var descriptionText: some View {
        Text("Demonstration of row folding and expanding".uppercased())
            .font(.caption)
    }

}

fileprivate let listTopPadding: CGFloat = 20

private extension VisitsListView {

    private var visitsForDayList: some View {
        ScrollView(.vertical, showsIndicators: false) {
            visitsForDayStack
                .frame(width: screen.width)
                .padding(.top, listTopPadding) // A bit of room between the label and list for the row to fold
                // Allows room to scroll up and fold rows. You will also notice that for smaller
                // lists(ones that don't fill up the entire screen height), this padding is
                // crucial because after the offset to the top of the screen,
                // the amount of clickable room is equal to the height of the list.
                // However, by adding the padding, it resolves that issue
                .padding(.bottom, 600)
        }
    }

    private var visitsForDayStack: some View {
        VStack(spacing: 2) {
            ForEach(0..<visits.count, id: \.self) { i in
                self.dynamicVisitRow(index: i)
                    // Because dynamic visit row is implicitly embedded inside a geometry reader
                    // through `expandableAndFoldable`, we need to explicity define the height and
                    // width of the row so the geometry reader can properly configure itself
                    .frame(height: VisitCellConstants.height)
                    .frame(maxWidth: VisitCellConstants.maxWidth(if: self.isShowingVisit))
            }
        }
    }

    private func dynamicVisitRow(index: Int) -> some View {
        visitDetailsView(index: index, visit: visits[index])
            // After offsetting, you'll notice that if you don't fade the non-expanded rows,
            // the rows after the expanded row will be stacked on top of the expanded row.
            // You can also apply other transformations like scaling or offsetting non-active
            // rows for cooler effects! Play around with it!
            .opacity(isNotActiveVisit(at: index) ? 0 : 1)
            .scaleEffect(isNotActiveVisit(at: index) ? 0.5 : 1)
            .offset(x: isNotActiveVisit(at: index) ? screen.width : 0)
            .expandableAndFoldable(
                rowHeight: VisitCellConstants.height,
                foldOffset: statusBarHeight + listOffset + listTopPadding,
                shouldFold: !isShowingVisit, // do not want to fold if a row is expanded
                isActiveIndex: isVisitIndexActive(at: index)) // used to determine which row should be expanded
    }

    private func visitDetailsView(index: Int, visit: Visit) -> some View {
        VisitDetailsView(selectedIndex: $activeVisitIndex, index: index, visit: visit)
    }

    private func isNotActiveVisit(at index: Int) -> Bool {
        isShowingVisit && !isVisitIndexActive(at: index)
    }

    private func isVisitIndexActive(at index: Int) -> Bool {
        index == activeVisitIndex
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        VisitsListView(visits: Visit.mocks)
    }
}

