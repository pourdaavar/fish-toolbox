# pnpm-workspace.fish 🚀

A professional Fish shell plugin for managing `pnpm` workspaces with `fzf` interactivity.

## 📋 Requirements

- **[fzf](https://github.com/junegunn/fzf)**: Command-line fuzzy finder.
- **[jq](https://stedolan.github.io/jq/)**: JSON processor.
- **[Nerd Fonts](https://www.nerdfonts.com/)**: Required for icons (, ◆, ★). Ensure your terminal emulator uses a Nerd Font (e.g., _JetBrainsMono Nerd Font_).

---

## 📦 Installation

### Using [Fisher](https://github.com/jorgebucaran/fisher) (Recommended)

Add this to your `~/.config/fish/fish_plugins` or run:

```fish
fisher install pourdaavar/fish-aliases

```

### Using [Oh My Fish](https://github.com/oh-my-fish/oh-my-fish)

```fish
omf install https://github.com/pourdaavar/fish-aliases

```

### Manual Installation

Copy the files into your fish config:

1. Place files in `~/.config/fish/functions/` and `~/.config/fish/conf.d/`.
2. Restart your shell.

---

## ✨ Features

- **Themed UI**: Custom double-border interface with high-contrast colors.
- **Context Aware**: Automatically detects if you are inside a sub-project and marks it with `★`.
- **Live Command Preview**: Real-time visualization of the final command including all selected filters.
- **Multi-select**: Use `Tab` to select multiple workspaces for batch operations.

---

## 🛠 Commands & Abbreviations

| Command     | Description                                                                    |
| ----------- | ------------------------------------------------------------------------------ |
| `pnf <cmd>` | Interactively select workspace(s) and run `pnpm -F <pkg> <cmd>`                |
| `pnx <cmd>` | Run raw shell commands (e.g., `ls`, `touch`) inside selected workspace folders |
| `pnc`       | **Deep Clean**: Recursively removes all `node_modules` in the entire workspace |

### Built-in Abbreviations

- `pna` → `pnf add`
- `pnu` → `pnf remove`
- `pnd` → `pnf run dev`
- `pnb` → `pnf run build`

---

## 🖥 Preview in Action

When you type `pna -D tailwindcss`, the preview pane will show:

> `pnpm -F @scope/app -F @scope/ui add -D tailwindcss`
