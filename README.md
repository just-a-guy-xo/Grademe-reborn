# 42_EXAM SIMULATION 🎓
### Practice the Piscine exam environment from home.
This is the reborn version of the old Grademe project. This version focuses on the piscine part alone.
Maintained by **just-a-guy**.

---

## Requirements

To run this project, you need the `readline` development headers. Install them with your package manager if they are not already present.

### Debian-based distributions (Ubuntu, Kali, ...)

```bash
sudo apt update && sudo apt install libreadline-dev
```

### Red Hat-based distributions (Fedora, CentOS, ...)

```bash
sudo dnf update && sudo dnf install readline-devel ncurses-devel
```
---

## Getting started

```bash
git clone https://github.com/just-a-guy-xo/Grademe-reborn.git
cd Grademe-reborn
make launch
```

---

## Latest changes

- Focused exclusively on the Piscine exams (Student menu removed).
- Settings simplified to the two useful options: replay solved exercises and enable cheat commands.
- `grademe` now prints the waiting message only once while the grader runs.
- Telemetry hooks remain disabled—no data leaves your machine.

---

## Feature highlights

- Randomised Piscine subjects for every level.
- Built-in wait timers between grademe requests to mimic the real exam.
- Automatic grading, even without an internet connection.
- Tracebacks saved after each failure so you can review what happened.
- Infinite-loop detection for supported exercises.

---

## Scoring model

- Each successful exercise grants **10 points**.
- Reaching **100 points** (ten successes) finishes the exam.
- Some screens still reference “levels,” but scoring is points-based.

---

## Windows users

This project targets Linux/macOS tooling (bash, gcc, readline). On Windows, use **WSL2 (Ubuntu recommended)** for the best experience.

---

## Cheat commands

```
remove_grade_time  -> Skip the waiting period between grademe attempts
grade now          -> Trigger immediate grading (VIP mode is enabled by default)
new_ex             -> Draw a different exercise at the same level
force_success      -> Mark the current exercise as passed (cheat)
```

---

## Privacy

No telemetry or personal data is collected. Environment variables that previously supplied usernames are no longer used by the tooling.

---

## Contributing

If you discover an issue or have an improvement in mind, open an issue or submit a pull request. Collaboration keeps the practice arena sharp for everyone.
