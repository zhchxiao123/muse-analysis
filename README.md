# Muse 10.0 (Meta Endo/Hatch) reverse-engineering reports

Static analysis of the macOS `Muse-10.0.dmg` (bundle id `com.meta.endo`), produced with
[REA](https://github.com/morluto/rea) and Ghidra 12.1.4. No runtime observation.

- `index.html` — landing page
- `architecture.html` — infrastructure, data flow, networking, local↔VM linkage, capabilities
- `design.html` — sessions (main chat / threads / side chats), event stream, runtime, approvals,
  filesystem, library, memory, shared agents and peers

Served with GitHub Pages from the `main` branch root (`.nojekyll` present).
