# Lab: Team Board - Answers

**Student Name:** Saqib Bedar  
**Roll Number:** 04072313037  

---

## Step 1

**Q: Why do we start the Timer in `initState` and not inside `build`? What would happen to the speed of the clock if we started it in `build`?**  
**Ans:** `initState()` is called exactly once when the `State` object is initialized, guaranteeing a single active `Timer`. If created inside `build()`, every widget rebuild would spawn a new periodic timer. Since each timer tick triggers `setState()` (which invokes `build()`), timers would accumulate exponentially, causing the clock to speed up uncontrollably and creating a massive resource/memory leak.

## Step 2

**Q: Why does `Builds` go up by one per second and not by two? What error would you see in the console if the widget left the screen and `_timer.cancel()` was missing from `dispose`?**  
**Ans:** 
- It increases by 1 per second because `Timer.periodic` triggers once every second, calling `setState()` once, which schedules and executes exactly one rebuild frame.
- If `_timer.cancel()` is omitted and the widget is unmounted, calling `setState()` on the defunct state triggers:  
  `FlutterError: setState() called after dispose(): _ClockState#(lifecycle state: defunct, not mounted)`.

*(Note for wrap-up: **A2: 8** — 1 initial build + 7 ticks = 8 total builds)*

## Step 3

**Q: Which of the two, Widget or Element, is “cheap and thrown away” and which one keeps the State? Where is the third one, the RenderObject, and what is its job?**  
**Ans:** 
- **Widget** is the lightweight, immutable configuration that is cheap and thrown away (re-instantiated) on every rebuild.
- **Element** is the persistent tree node that manages the lifecycle, acts as `BuildContext`, and holds the `State`.
- **RenderObject** lives in the Render Tree beneath the Element tree. Its job is computing layout constraints/geometry, hit testing, and painting actual pixels onto the screen canvas.

## Step 4

**Q: You built `Tile` out of an `ElevatedButton` without writing `extends ElevatedButton`. What is this style called, and why does Flutter prefer it?**  
**Ans:** This is called **Composition over Inheritance**. Flutter strongly prefers composition because wrapping existing widgets inside new widgets creates flexible, loosely coupled, and reusable UI components. It avoids deep, brittle class inheritance trees, prevents the "fragile base class" problem, and keeps widgets as lightweight declarative configurations.

## Step 5

**Q: Without keys, why did the number stay at the left even though the label moved? Use the words `widget`, `Element` and `State` in your answer.**  
**Ans:** Without keys, Flutter identifies child elements solely by their `runtimeType` and positional index. When the list is reversed, the incoming `Tile` **widget** at index 0 matches the existing **Element** at index 0. Flutter reuses that existing **Element** and retains its associated **State** (which preserves the tap count of 2), while merely updating the **widget** configuration with the new label (`Maya: 2`). With `ValueKey`, Flutter matches **Elements** by key, ensuring that the **State** moves along with its corresponding **widget**.

*(Note for wrap-up: **A3: 2**)*

## Step 6

**Q: In a Column, which axis is the main axis? Why does `crossAxisAlignment: CrossAxisAlignment.center` in a Column move the children left or right and not up or down?**  
**Ans:** In a `Column`, the main axis is the **vertical axis** (top to bottom), and the cross axis is the **horizontal axis** (left to right). Because `crossAxisAlignment` governs positioning along the cross axis, setting it to `center` aligns children horizontally across the width of the column (left/right) rather than vertically (up/down).

## Step 7

**Q: Why does wrapping a `Text` in `Expanded` make it wrap its words? Use the idea “constraints go down, sizes go up” from slide 13.**  
**Ans:** Under Flutter's rule of *"constraints go down, sizes go up"*, a `Row` gives its children unbounded horizontal constraints (`maxWidth: infinity`) by default. Because the width is unconstrained, `Text` attempts to place all words on a single horizontal line, overflowing the screen. Wrapping `Text` in `Expanded` forces the `Row` to calculate the available remaining width and send a **bounded constraint** down to each child. When `Text` receives a finite maximum width constraint, its layout engine wraps the words onto multiple lines to stay within bounds.

## Step 8

**Q: What would change on the screen if you swapped `Expanded` and `Flexible` between the two buttons? Which one is “Flexible with fit: tight”?**  
**Ans:** 
- **`Expanded`** is internally a `Flexible` with `fit: FlexFit.tight`, whereas standard `Flexible` has `fit: FlexFit.loose`.
- If swapped, the `Exp` button (now `FlexFit.loose`) would shrink to its compact natural width rather than stretching, while the `Flex` button (now `FlexFit.tight`) would stretch to consume all 2/3 of the remaining leftover row width.

*(Note for wrap-up: **A4: 33** — `1 / (1 + 2) = 33.33%`, rounded down to 33)*

## Step 9

**Q: Which one is inside the border, margin or padding? When would you use a plain `Padding` or `SizedBox` instead of a `Container`?**  
**Ans:** 
- **Padding** is inside the border (between the border and the inner child); **margin** is outside the border (between the border and neighboring widgets).
- `Container` is a heavy composite widget. You should use a plain `Padding` when you only need inner whitespace around a child, and a plain `SizedBox` when you only need fixed dimensions or an empty spacer between children. Single-purpose widgets avoid overhead in the render tree and allow `const` optimizations.