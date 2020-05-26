// Kevin Li - 10:27 AM - 5/25/20

import SwiftUI

let screen = UIScreen.main.bounds

extension Color {

    static let blackPearl = Color("blackPearl")

}

struct VisitCellConstants {
    static let height: CGFloat = 80
    static let width: CGFloat = screen.width - 60

    static func height(if isSelected: Bool) -> CGFloat {
        // Extra +20 because clipShape does cut off a portion of the screen
        isSelected ? screen.height+20 : height
    }

    static func maxWidth(if isSelected: Bool) -> CGFloat {
        isSelected ? .infinity : width
    }
}

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
                .offset(y: !isShowingVisit ? 95 : 0)
        }
        .background(backgroundColor)
        .animation(.spring())
    }

    private var backgroundColor: some View {
        Color.blackPearl.saturation(1.5)
            .frame(height: screen.height + 50)
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

private extension VisitsListView {

    private var visitsForDayList: some View {
        ScrollView(.vertical) {
            visitsForDayStack
                .frame(width: screen.width)
                .padding(.top, 20) // A bit of room between the label and list for the row to fold
                .padding(.bottom, 600) // Allows room to scroll up and fold rows
        }
    }

    private var visitsForDayStack: some View {
        VStack(spacing: 2) {
            ForEach(0..<visits.count, id: \.self) { i in
                self.dynamicVisitRow(index: i)
                    .frame(height: VisitCellConstants.height)
                    .frame(maxWidth: VisitCellConstants.maxWidth(if: self.isShowingVisit))
            }
        }
    }

    private func dynamicVisitRow(index: Int) -> some View {
        visitDetailsView(index: index, visit: visits[index])
            .opacity(isNotActiveVisit(at: index) ? 0 : 1)
            .expandableAndFoldable(
                foldOffset: 160,
                shouldFold: !isShowingVisit,
                isActiveIndex: isVisitIndexActive(at: index))
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

