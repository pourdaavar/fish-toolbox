# fish-toolbox

A focused set of Fish shell utilities for pnpm workspace management, command prefix toggling, and keybindings.

---

## Features

- **pnpm workspace helpers** (`pnf`, `pnx`, `pnc`) with `fzf` selection
- **Command prefix toggling** via `with_prefix` and `with_prefix_bind`
- **Ready-made keybind presets** for `sudo` and `proxychains`

---

## Requirements

- **Fish shell** (interactive)
- **fzf** — interactive selection for `pnf` and `pnx`
- **jq** — package name extraction in `_pnpm_get_projects`
- **pnpm** — workspace discovery and execution
- **find** — used by `pnc` for recursive cleanup
- **Nerd Font** (optional) — improves icons in `pnf`

---

## Installation

### Fisher (recommended)

```fish
fisher install pourdaavar/fish-toolbox
```

### Oh My Fish

```fish
omf install https://github.com/pourdaavar/fish-toolbox
```

### Manual

```fish
cp -r functions/* ~/.config/fish/functions/
cp -r conf.d/* ~/.config/fish/conf.d/
cp -r completions/* ~/.config/fish/completions/
```

Restart Fish or run `exec fish`.

---

## pnpm Workspace Helpers

| Command       | Description                                                       |
| ------------- | ----------------------------------------------------------------- |
| `pnf <args…>` | Pick one or more workspace packages and run `pnpm -F ... <args…>` |
| `pnx <cmd…>`  | Pick workspaces and run `pnpm -F <pkg> exec -- <cmd…>`            |
| `pnc`         | Remove all `node_modules` under the current directory             |

### Interactive abbreviations

- `pni` → `pnpm install`
- `pna` → `pnf add`
- `pnu` → `pnf remove`
- `pnd` → `pnf run dev`
- `pnb` → `pnf run build`
- `pnt` → `pnf test`

### Files

- `_pnpm_get_projects.fish` — lists workspace packages (marks current with ★)
- `pnf.fish` — interactive `pnpm filter` runner (multi-select)
- `pnx.fish` — run commands in selected workspaces
- `pnc.fish` — recursive `node_modules` cleanup
- `conf.d/pnpm_workspace.fish` — abbreviations (interactive only)

---

## Command Prefix Toggling

Toggle a prefix (e.g. `sudo`, `proxychains -q`) at the start of the current command line.

### Manual toggle

```fish
with_prefix "proxychains -q"
```

### Bind a key sequence

Use `fish_key_reader` to discover key sequences:

```fish
with_prefix_bind \c\eP "proxychains -q"   # Ctrl+Alt+P
```

### Presets (conf.d)

| File                      | Key binding    | Prefix           |
| ------------------------- | -------------- | ---------------- |
| `proxychains_prefix.fish` | `Ctrl+P`       | `proxychains -q` |
| `sudo_prefix.fish`        | `Ctrl+Shift+S` | `sudo`           |

Edit the `bind` line in each file to change the key sequence.

### Files

- `with_prefix.fish` — toggles prefix on the current command line
- `with_prefix_bind.fish` — binds a key to `with_prefix <prefix>`
- `completions/with_prefix_bind.fish` — tab completions

---

## Safety

- **`pnc` is destructive** — runs `rm -rf` on every `node_modules` under the current directory. Use with care.
- Verify key sequences with `fish_key_reader` before binding.
- Prefer `Ctrl+Alt` over `Ctrl+Shift` for portability across terminals.

---

## Custom bindings

```fish
# Toggle sudo
with_prefix_bind \cs "sudo"

# Toggle proxychains
with_prefix_bind \c\eE "proxychains -q"

# Toggle environment variable
with_prefix_bind \c\eH "env HTTP_PROXY=127.0.0.1:7890"
```
