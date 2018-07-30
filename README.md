# perf_diagnosis_demo

This is a demo for diagnosing performance issues in Flutter code

## TODO
- [ ] Demonstrate using AnimatedOpacity or FadeTransition can avoid rebuilding their sub-trees.
    - [ ] Find out why the sub-tree still gets rebuilt at every frame 

- [ ] Use a widget that won't change its appearance when it gets rebuilt to avoid hinting what's 
      going on. 

## DONE
- [X] Demonstrate passing in non-animated widgets as a child into an AnimatedBuilder can avoid them
      to be rebuilt in every frame. 
- [X] Demonstrate animating Opacity directly can cause its entire subtree to rebuild. 
- [X] Demonstrate AnimatedBuilder rebuild all the underlying widgets 
      when they're not passed in via the `child` property without using the Opacity widget.
      