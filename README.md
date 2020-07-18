# Foldable And Expandable List SwiftUI

This project is a demonstration of how to add simultaneous animations of folding and expanding cells while scrolling. In the project, I put a lot of comments explaining the code behind this. It's by no means perfect and it is my hope that others in the community can perfect the animations I've laid out. 

This project is inspired by [TimePage](https://us.moleskine.com/timepage/p0486) and is part of a larger repository of elegant demonstrations like this: [TimePage Clone](https://github.com/ThasianX/TimePage-Clone). 

Also, make sure to check out [TimePrints](https://github.com/ThasianX/TimePrints), an app that I'm almost done working on that utilizes this foldable scrolling animations as well as other slick SwiftUI animations.

**The animation is actually much smoother if you run it yourself**
<p align="center"><img src="https://github.com/ThasianX/GIFs/blob/master/Foldable-And-Expandable-List/demo.gif" height="800"/></p>

## How this works
Basically the [`ExpandAndFoldModifier`](https://github.com/ThasianX/Foldable-And-Expandable-List-SwiftUI/blob/master/FoldableScrolling/View%2BExpandableAndFoldable.swift) is applied to every row in the list, wrapping each row in a `GeometryReader` which tells the compiler information about the `minY` position of the row. This will be crucial later on for determining when the row should be folded and the expanding animation's offset. It looks like this:
```
struct ExpandAndFoldModifier: ViewModifier {

  func body(content: Content) -> some View {
      GeometryReader { geometry in
          content
              .modifier(self.makeNestedModifier(withMinY: geometry.frame(in: .global).minY))
      }
  }

  private func makeNestedModifier(withMinY minY: CGFloat) -> _ExpandAndFoldModifier {
      _ExpandAndFoldModifier(
      rowHeight: rowHeight, // height of the row to be folded
      foldOffset: foldOffset, // y coordinate at which to start folding
      minY: minY, // the current y coordinate of the row
      shouldFold: shouldFold, // shouldn't fold when expanded
      isActiveIndex: isActiveIndex) // if the row is active, we want to expand it by offsetting it from it's current position to the top of the screen
  }
  
}
```
In order to reduce duplication of calling `geometry.frame(in: .global).minY`, a nested modifier is created which accepts `minY` as a parameter. 

The body of the nested modifier looks like this: 
```
func body(content: Content) -> some View {
    content
        .offset(y: isActiveIndex ? topOfScreen : 0)
        .rotation3DEffect(rotationAngle, axis: (x: -200, y: 0, z: 0), anchor: .bottom)
        .opacity(opacity)
}
```

### There are 3 components here:

**Offset**:

If the row has just been tapped, `isActiveIndex` should be true and the row expands through animating the offset from its current position(`y=minY`) to the top of the screen(`y=0`). That offset is just `-minY`, which is exactly what the `topOfScreen` variable value is. The other rows that aren't active remain where they are.

**Rotation**: 

If you look at gif, you'll notice that the rows are being folded into the back of the screen: this is a result of anchoring the `rotation3DEffect` to the bottom of the row and setting the rotation axis to `x=-200`. The `x axis` is the horizontal axis of the screen: +x folds towards the front of the screen, -x folds into the back of the screen, as shown in the gif. The number inside the `x` doesn't matter as long as it's negative(this however isn't the case if when y or z have values because then, the x value plays a more significant role in the axis). Play around with the values to understand).

The most important part of this is the `rotationAngle`. Here's the code:
```
private var rotationAngle: Angle {
    guard shouldFold && shouldStartFolding else { return .degrees(0) }
    return .degrees(-foldDegree) // negative because we want to fold inward
}

private var shouldStartFolding: Bool {
    minY < foldOffset
}

private var foldDegree: Double {
    // When the minY of the provided cell is equal to the foldOffset, the
    // fold degree should be 0 and as such, the fold delta is 1.
    // fold degree becomes 90 when fold delta becomes 0, which is when
    // the cell is completely folded
    guard foldDelta >= 0 else { return 90 }
    return 90 - (90 * foldDelta)
}

private var foldDelta: Double {
    Double((rowHeight + (minY - foldOffset)) / rowHeight)
}
```
The `rotationAngle` is `0 degrees` when either `shouldFold` is false(this is false only when a row is expanded) or the current `minY` position of the row is above `foldOffset` position. If these 2 checks pass, this means that the row is within fold range and thus the `foldDegree` can be calculated through `foldDegree = 90 - (90 * foldDelta)`. When `minY` is equal to the `foldOffset`, the fold degree should be 0 and as such, the fold delta is 1. `foldDegree` becomes 90 when `foldDelta` becomes 0, which is when the cell is completely folded .

`foldDelta` was derived through 2 sources of truth. When `minY` is greater than or equal to `foldOffset`, there shouldn't be any fold. This is accounted for in the `rotationAngle`'s `guard`. When `minY` is less than or equal to `foldOffset - rowHeight`, the `foldDegree` should be capped at 90 degrees, meaning that the row is folded. This is accounted for in `foldDegree`'s `guard`. 

**Opacity**:

The code for this is pretty simple and straightforward:
```
private var opacity: Double {
    guard shouldFold && shouldStartFolding && (foldDelta >= 0) else { return 1 }
    // 0.4 padding because we don't want the cell to fully fade when it's folded
    return foldDelta + 0.4
}
```
The only case that is of concern is when the row is being folded. The opacity is made to be linearly proportional to `foldDelta` because as the row is folded more, `foldDelta` approaches 0, signifying a dim in opacity for the folded row. 

## Contributing
- If you find a bug, or would like to suggest a new feature or enhancement, feel free to [file an issue](https://github.com/ThasianX/Foldable-Scrolling-Animation-SwiftUI/issues/new/choose).

## Resources
- [Meng To's Peek Scrolling Video](https://youtu.be/onc2xwzjggU)
- [Meng To's SwiftUI Course](https://designcode.io/swiftui?promo=learnswiftui)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
