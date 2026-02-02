# fish-aliases

Small, focused Fish shell helpers:

- `pnpm` workspace helpers (`pnf`, `pnx`, `pnc`) with `fzf` selection
- command-line prefix toggling + keybindings (`with_prefix`, `with_prefix_bind`)
- a ready-made proxychains keybind preset

## Requirements

- **Fish**: interactive shell
- **fzf**: used by `pnf` and `pnx`
- **jq**: used to extract the current package name in `_pnpm_get_projects`
- **pnpm**: required for workspace discovery and execution
- **find**: used by `pnc`
- **Nerd Font (optional)**: improves icons in `pnf` (``, `◆`, `★`)

## Installation

### Fisher (recommended)

```fish
fisher install pourdaavar/fish-aliases
```

### Oh My Fish

```fish
omf install https://github.com/pourdaavar/fish-aliases
```

### Manual

- copy `functions/*` → `~/.config/fish/functions/`
- copy `conf.d/*` → `~/.config/fish/conf.d/`
- copy `completions/*` → `~/.config/fish/completions/`
- restart Fish

## What’s included (by file)

### pnpm workspace helpers

- **`functions/_pnpm_get_projects.fish`**: lists workspace package names; marks the “current” one with `★`
- **`functions/pnf.fish`**: interactive “pnpm filter” runner (multi-select), runs `pnpm -F <pkg> ...`
- **`functions/pnx.fish`**: run arbitrary commands inside selected workspaces via `pnpm -F <pkg> exec -- ...`
- **`functions/pnc.fish`**: destructive cleanup, removes all `node_modules` recursively
- **`conf.d/pnpm_workspace.fish`**: interactive-only abbreviations for common `pnf` workflows

#### Commands

| Command       | Description                                                       |
| ------------- | ----------------------------------------------------------------- |
| `pnf <args…>` | pick one or more workspace packages and run `pnpm -F ... <args…>` |
| `pnx <cmd…>`  | pick workspaces and run `pnpm -F <pkg> exec -- <cmd…>`            |
| `pnc`         | remove all `node_modules` under the current directory             |

#### Abbreviations (interactive only)

Defined in `conf.d/pnpm_workspace.fish`:

- `pni` → `pnpm install`
- `pna` → `pnf add`
- `pnu` → `pnf remove`
- `pnd` → `pnf run dev`
- `pnb` → `pnf run build`
- `pnt` → `pnf test`

### Prefix toggling + key binding

- **`functions/with_prefix.fish`**: toggles a prefix on the current commandline (adds it if missing, removes it if already present)
- **`functions/with_prefix_bind.fish`**: binds a key sequence to `with_prefix "<prefix>"`
- **`completions/with_prefix_bind.fish`**: completions for `with_prefix_bind`

#### Usage

Toggle a prefix manually:

```fish
with_prefix "proxychains -q"
```

Bind a key (get the key sequence via `fish_key_reader`):

```fish
with_prefix_bind \e\[80\;2u "proxychains -q"
```

### Proxychains preset

- **`conf.d/proxychains_prefix.fish`**: sets up a keybind that toggles `proxychains -q` using `with_prefix_bind`

If you don’t like the default key sequence, edit `conf.d/proxychains_prefix.fish` and change the first argument.

## Notes / safety

- **`pnc` is destructive**: it runs `rm -rf` on every `node_modules` directory it finds under the current directory.
