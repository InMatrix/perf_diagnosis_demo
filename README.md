# perf_diagnosis_demo

This repo collects examples of common performance pitfalls developers might 
run into for the purpose of demonstrating how to diagnose and resolve them.

## List of examples

## World Clock
**Problem code**: [clock_demo.dart](lib/clock_demo.dart)

**Explanation**: Because the whole screen is a single StatefulWidget, 
all the widgets get rebuilt whenever the text labels for the clocks get updated.  

**Solution**: Extract the text label for the clock into its own StatefulWidget to 
localize the rebuild. See the updated code in 
[clock_fix.dart](lib/optimized/clock_fix.dart).

## List

**Problem code**: [list_demo.dart](lib/list_demo.dart)

**Explanation**: A Column with hundreds of items is nested within a ListView, 
causing offscreen items to be built and drawn every time the user scrolls 
the screen.

**Solution**: Move the items from that single Column widget to the ListView, 
instead. See the updated code in [list_fix.dart](lib/optimized/list_fix.dart).

## Spinning Boxes

**Problem code**: [spinning_box_demo.dart](lib/spinning_box_demo.dart)

**Explanation**: The `AnimatedBuilder`'s `builder` function contains a subtree 
that does not depend on the animation, but it still gets rebuilt in every frame 
of the animation. 
Learn more from the [API doc](https://api.flutter.dev/flutter/widgets/AnimatedBuilder-class.html#performance-optimizations).

**Solution**: Extract the non-animation subtree into its own widget from 
the AnimatedBuilder. See the updated code in 
[spinning_box_fix.dart](lib/optimized/spinning_box_fix.dart).

## Scorecard

**Problem code**: [scorecard_demo.dart](lib/scorecard_demo.dart)

**Explanation**: Opacity animations are created by directly manipulating the 
`opacity` property of the `Opacity` widget, causing the widget itself and 
its subtree to rebuild in every frame. 
In addition, the Opacity widget is placed unnecessarily high in the tree. 
Learn more from the [API doc](https://api.flutter.dev/flutter/widgets/Opacity-class.html#performance-considerations-for-opacity-animation) of `Opacity`.

**Solution**: Use `AnimatedOpacity` instead. 
See the updated code in 
[scorecard_fix.dart](lib/optimized/scorecard_fix.dart).

