# perf_diagnosis_demo

This is a demo for diagnosing performance issues in Flutter code

## TODO
- [ ] Demonstrate using AnimatedOpacity or FadeTransition can avoid rebuilding their sub-trees.
- [ ] Demonstrate AnimatedBuilder rebuild all the underlying widgets 
      when they're not passed in via the `child` property without using the Opacity widget.
      
## DONE
- [X] Demonstrate animating Opacity directly can cause its entire subtree to rebuild. 