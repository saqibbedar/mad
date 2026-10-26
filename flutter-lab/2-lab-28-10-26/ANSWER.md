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