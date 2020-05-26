// Kevin Li - 5:59 PM - 5/25/20

import SwiftUI

struct VisitDetailsView: View {

    @Binding var selectedIndex: Int

    let index: Int
    let visit: Visit

    private var isSelected: Bool {
        selectedIndex == index
    }

    var body: some View {
        visitDetailsView
            .animation(.spring())
            .padding(.top, isSelected ? 80 : 12)
            .padding(.horizontal, isSelected ? 0 : 40)
            .frame(height: VisitCellConstants.height(if: isSelected))
            .frame(maxWidth: VisitCellConstants.maxWidth(if: isSelected))
            .edgesIgnoringSafeArea(.all)
            .background(Color.blackPearl)
            .clipShape(RoundedRectangle(cornerRadius: isSelected ? 30 : 10, style: .continuous))
            .animation(.easeInOut) // we want an easeInOut to be applied to the expanding animation
            .onTapGesture(perform: setSelectedVisitIndex)
            .exitOnDrag(if: isSelected, onExit: unselectRow, isSimultaneous: true) // simultaneous because there's a scrollview embedded inside
    }

    private func setSelectedVisitIndex() {
        selectedIndex = index
    }

    private func unselectRow() {
        selectedIndex = -1
    }
}

private extension VisitDetailsView {

    private var visitDetailsView: some View {
        VStack(spacing: 2) {
            header
                .padding(.bottom, isSelected ? 10 : 0)
                .padding(.horizontal, isSelected ? 30 : 0)
            coreDetailsView
            notesIfSelected
                .padding(.bottom, 100)
            Spacer()
        }
        .foregroundColor(.white)
    }
    
    private var header: some View {
        HStack {
            backButton
                .opacity(isSelected ? 1 : 0)
            Spacer()
            locationNameText
            Spacer()
        }
    }

    private var backButton: some View {
        Button(action: unselectRow) {
            backButtonImage
        }
    }

    private var backButtonImage: Image {
        Image(systemName: "arrow.left")
    }

    private var locationNameText: some View {
        Text(visit.locationName)
            .font(isSelected ? .system(size: 22) : .headline)
            .fontWeight(isSelected ? .bold : .regular)
            .lineLimit(isSelected ? nil : 1)
            .multilineTextAlignment(.center)
             // Never want to animate the text because you'll get ...s during the animation
            .animation(nil)
    }

    private var coreDetailsView: some View {
        Group {
            visitDurationText
            fullMonthWithDayOfWeekTextIfSelected
                .padding(.top, isSelected ? 8 : 0)
                .padding(.bottom, isSelected ? 10 : 0)
            locationTagView
                .padding(.top, 6)
                .padding(.bottom, isSelected ? 20 : 4)
        }
    }

    private var visitDurationText: some View {
        Text(visit.duration)
            .font(isSelected ? .system(size: 18) : .system(size: 10))
            .tracking(isSelected ? 2 : 0)
            .animation(nil)
    }

    private var fullMonthWithDayOfWeekTextIfSelected: some View {
        Group {
            if isSelected {
                fullMonthWithDayOfWeekText
            }
        }
    }

    private var fullMonthWithDayOfWeekText: some View {
        Text(visit.arrivalDate.fullMonthWithDayOfWeek.uppercased())
            .font(.caption)
    }

    private var locationTagView: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(visit.tagColor)
            .frame(width: 30, height: 5)
    }

    private var notesIfSelected: some View {
        Group {
            if isSelected {
                visitNotesTextView
                    .padding(.horizontal)
            }
        }
    }

    private var visitNotesTextView: some View {
        GeometryReader { geometry in
            ScrollView(.vertical, showsIndicators: true) {
                Text(self.visit.notes)
                    .fixedSize(horizontal: false, vertical: true)
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)
                    .frame(width: geometry.size.width)
            }
        }
    }
    
}

struct VisitDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VisitDetailsView(selectedIndex: .constant(1), index: 0, visit: .mock)
            VisitDetailsView(selectedIndex: .constant(1), index: 1, visit: .mock)
        }
    }
}
