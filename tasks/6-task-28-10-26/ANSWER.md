# Lab: Team Board - Answers

**Student Name:** Saqib Bedar  
**Roll Number:** 04072313037  

---

## Step 1

**Q: Why do we start the Timer in `initState` and not inside `build`? What would happen to the speed of the clock if we started it in `build`?**  
**Ans:** `initState()` is called exactly once when the `State` object is initialized, guaranteeing a single active `Timer`. If created inside `build()`, every widget rebuild would spawn a new periodic timer. Since each timer tick triggers `setState()` (which invokes `build()`), timers would accumulate exponentially, causing the clock to speed up uncontrollably and creating a massive resource/memory leak.