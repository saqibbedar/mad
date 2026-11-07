# Lab: Team Board - Answers

**Student Name:** Saqib Bedar  
**Roll Number:** 04072313037  

---

## Part A: Numeric Answers

A1: 34
A2: 8
A3: 2
A4: 33

*(Derivations for automatic grading validation:)*
- *A1:* `stopAt = startSec + ticks * tick = 20 + (7 * 2) = 34`. Clock stops at 34.
- *A2:* Initial display (at 20s) is build 1, followed by 7 ticks (22s to 34s) = 8 total builds.
- *A3:* 2 taps on Sara without keys leaves the count of 2 at index 0 after Swap.
- *A4:* Leftover flex ratio is `1 / (1 + 2) = 33.33%`, rounded down to 33.

---

## Part B: Written Answers

**B1: Which of your classes are Stateless and which are Stateful, and why?**  
- **Stateless:** `LabApp`, `HomePage`, `SettingsCard`, `Probe`, `Welcome`, `SummaryRow`, `InfoPanel`, `ShareRow`, `InfoBox`, `StampStack`.  
  *Reason:* They are immutable UI configurations whose appearance depends only on constants or constructor parameters passed to them; they have no internal state that changes across rebuilds.
- **Stateful:** `Clock`, `Tile`, `SwapBoard`.  
  *Reason:* They maintain mutable state across user interactions and time (`Clock` holds `_seconds`, `_builds`, and a `Timer`; `Tile` holds `taps`; `SwapBoard` holds the mutable order of `tiles`) requiring persistent `State` objects and `setState()` calls.

**B2: Widget, Element, RenderObject: which one is rebuilt on every setState and which ones are kept? What did Probe show you?**  
- **Widget** is rebuilt (instantiated and thrown away) on every `setState`.
- **Element** and **RenderObject** are preserved and kept across rebuilds to retain tree identity, state, and rendering performance.
- **Probe demonstration:** On every tick, `identityHashCode(this)` (the Widget) produced a completely new hash code every second, while `identityHashCode(context)` (the Element) remained identical throughout all ticks.

**B3: Explain “constraints go down, sizes go up” using your Step 7 or Step 8 example.**  
In Flutter layout, parents pass geometric constraints down to their children, children determine their size within those constraints and report their size up to the parent, and the parent sets the child's position:
- *Step 7 Example:* In `SummaryRow`, a standard `Row` passes unbounded width (`maxWidth: infinity`) down, causing `Text` to never wrap and overflow the screen. When wrapped in `Expanded`, the `Row` measures remaining width and sends a bounded maximum width constraint down to `Expanded` and its child `Text`. Receiving a tight upper bound, the `Text` widget wraps its words onto multiple lines to fit inside.

---

## Step-by-Step Think Questions

### Step 1
**Q: Why do we start the Timer in `initState` and not inside `build`? What would happen to the speed of the clock if we started it in `build`?**  
**Ans:** `initState()` runs only once when the State is initialized, guaranteeing a single active Timer. If created in `build()`, every rebuild spawns a new timer. Because each timer tick calls `setState()`, timers would multiply exponentially, causing the clock to accelerate uncontrollably and creating a resource leak.

### Step 2
**Q: Why does `Builds` go up by one per second and not by two? What error would you see in the console if the widget left the screen and `_timer.cancel()` was missing from `dispose`?**  
**Ans:** 
- It increases by 1 per second because `Timer.periodic` fires once per second, triggering `setState()` once, which schedules a single rebuild.
- If not cancelled in `dispose()`, calling `setState()` on the unmounted widget throws `FlutterError: setState() called after dispose(): _ClockState#(lifecycle state: defunct, not mounted)`.

### Step 3
**Q: Which of the two, Widget or Element, is “cheap and thrown away” and which one keeps the State? Where is the third one, the RenderObject, and what is its job?**  
**Ans:** Widget is cheap and thrown away; Element stays and holds the State. The RenderObject lives in the Render Tree beneath the Element tree and handles sizing, layout constraints, hit testing, and painting.

### Step 4
**Q: You built `Tile` out of an `ElevatedButton` without writing `extends ElevatedButton`. What is this style called, and why does Flutter prefer it?**  
**Ans:** Composition over Inheritance. Flutter prefers composition because wrapping widgets into modular building blocks is flexible, avoids fragile base class hierarchies, and keeps widgets decoupled.

### Step 5
**Q: Without keys, why did the number stay at the left even though the label moved? Use the words `widget`, `Element` and `State` in your answer.**  
**Ans:** Without keys, Flutter identifies children solely by `runtimeType` and positional index. When the list is reversed, the incoming `Tile` **widget** at index 0 matches the existing **Element** at index 0. Flutter reuses that existing **Element** and retains its associated **State** (with `taps = 2`), while only updating the **widget** configuration with the new label.

### Step 6
**Q: In a Column, which axis is the main axis? Why does `crossAxisAlignment: CrossAxisAlignment.center` in a Column move the children left or right and not up or down?**  
**Ans:** In a Column, the main axis is vertical (top to bottom), and the cross axis is horizontal (left to right). Because `crossAxisAlignment` aligns along the cross axis, it moves children horizontally (left/center/right).

### Step 7
**Q: Why does wrapping a `Text` in `Expanded` make it wrap its words? Use the idea “constraints go down, sizes go up” from slide 13.**  
**Ans:** A `Row` gives children unbounded horizontal width constraints (`maxWidth: infinity`) by default. Wrapping in `Expanded` passes a finite, bounded width constraint down from the Row. Receiving this bounded constraint forces `Text` to wrap its words onto multiple lines.

### Step 8
**Q: What would change on the screen if you swapped `Expanded` and `Flexible` between the two buttons? Which one is “Flexible with fit: tight”?**  
**Ans:** `Expanded` is `Flexible` with `fit: FlexFit.tight`. If swapped, the `Exp` button (now loose) would shrink to its compact natural size, while the `Flex` button (now tight) would stretch to fill all 2/3 of the leftover row width.

### Step 9
**Q: Which one is inside the border, margin or padding? When would you use a plain `Padding` or `SizedBox` instead of a `Container`?**  
**Ans:** Padding is inside the border; margin is outside. Use a plain `Padding` when you only need inner whitespace around a child, and a plain `SizedBox` for fixed dimensions or spacers, to reduce render tree overhead and allow `const` constructors.

### Step 10
**Q: What decides the size of the Stack? What happens to the layout if the Icons come first and the grey Container last?**  
**Ans:** The size of a Stack is determined by its non-positioned children. If the Icons came first and the grey Container came last, the opaque Container would be painted on top of the Icons, obscuring them completely.