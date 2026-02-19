# AGENTS.md

Guidance for AI coding agents working in this repository.

## Project Overview

This is a **modern CSS framework** - a drop-in replacement for PicoCSS built with an [oat.ink](https://oat.ink) philosophy: no build step required, easy to read and maintain, very modern/concise CSS. We follow [grugbrain.dev](https://grugbrain.dev) principles: keep things simple, avoid over-engineering, prefer readability over cleverness.

**Core Philosophy:**
- Pure CSS, no preprocessors (SCSS is NOT used in this fork)
- CSS Cascade Layers for architecture
- CSS Custom Properties (variables) for theming
- `light-dark()` for automatic light/dark mode switching
- `color-mix()` for derived colors - no JavaScript color manipulation
- CSS nesting to reduce selector repetition
- Semantic HTML first, minimal classes
- Users control mode via `color-scheme: light` or `color-scheme: dark`
- Two-variable theming: just set `--pico-primary` and `--pico-secondary`

## Tooling

**All tools are managed via [mise](https://mise.jdx.dev)** - do NOT use npx, npm, or direct binary calls. Mise ensures consistent versions.

```bash
mise install          # Install required tools (node, biome)
mise run build        # Concatenate CSS files + minify
mise run watch        # Watch css/src/ and rebuild on changes
mise run check        # Lint + format all HTML/CSS + build (run before commits)
mise run dev          # Start dev server on port 3000
mise run clean        # Remove built CSS files
mise run size         # Show bundle sizes
```

**No tests exist** - this is a CSS-only project.

## CSS Architecture

The CSS is built from 9 source files in `css/src/`, concatenated in this order:

1. `layers.css` - Defines `@layer` order
2. `reset.css` - CSS custom properties, base resets
3. `theme.css` - Color theming using `light-dark()`, semantic colors
4. `layout.css` - Container, basic grid, structural layout
5. `content.css` - Typography, links, tables, code blocks
6. `forms.css` - All form elements (inputs, selects, checkboxes, etc.)
7. `buttons.css` - Button styles and variants
8. `components.css` - Cards, modals, accordions, dropdowns, etc.
9. `utilities.css` - Accessibility helpers, reduced motion

**Layer order** (lowest to highest priority):
`reset → theme → layout → content → forms → buttons → components → utilities`

## Code Style

### CSS Formatting

- **Indentation:** Tabs (1 tab per level)
- **Properties:** One per line, alphabetically sorted within logical groups
- **Selectors:** Use `:where()` for zero-specificity selectors
- **Nesting:** Use CSS native nesting (`&`) to reduce repetition
- **Comments:** Block comments for sections, keep them brief

```css
/* Good */
@layer buttons {
	button {
		padding: 0.5rem 1rem;
		border: none;
		background: var(--pico-primary);
		color: white;

		&:hover {
			background: var(--pico-primary-hover);
		}
	}
}
```

### CSS Custom Properties

- **Naming:** `--pico-{component}-{variant}-{property}`
- **Examples:** `--pico-primary`, `--pico-primary-hover`, `--pico-form-element-border-color`
- Define at `:root` or `:host` level
- Use semantic names, not visual descriptions

### Color System

- **Source variables (user sets these on `:root`):**
  - `--pico-primary` - Brand/accent color
  - `--pico-secondary` - Neutral color (text, borders)
- **Semantic colors:** `--pico-success`, `--pico-warning`, `--pico-error`
- **Light/Dark mode:** Use `light-dark()` function for all colors
- **Derived colors:** Use `color-mix(in srgb, ...)` - see `theme.css`
- **Derived colors are defined on `*`** (not `:root`) so `color-scheme` can be overridden per-element for forced light/dark sections

```css
/* Color with light/dark variants */
--pico-primary: light-dark(#0074d9, #3a8fd9);

/* Derived hover color */
--pico-primary-hover: color-mix(in srgb, var(--pico-primary), black 12%);
```

### Modern CSS Features to Use

- `:where()` and `:is()` for selector grouping
- `:has()` for parent selection
- `@layer` for cascade control
- `@container` for container queries (when needed)
- `light-dark()` for light/dark mode colors
- `color-mix()` for derived colors
- `oklch()` for color manipulation (when needed)
- CSS Grid for layouts (write inline, no utility classes)
- CSS nesting (`&`) to reduce repetition
- `gap` instead of margins for spacing

### What to Avoid

- **No SCSS/SASS** - This fork uses pure CSS only
- **No `!important`** unless absolutely necessary
- **No inline SVG** - Use CSS variables with data URIs
- **No JavaScript for styling** - CSS-only solutions
- **No grid utility classes** - Write inline grid CSS instead
- **No `.light`/`.dark` classes** - Use `color-scheme` property
- **Avoid fixed pixel values** - Use `rem` or custom properties

## File Organization

```
css/
├── src/              # Source files (EDIT THESE)
│   ├── layers.css
│   ├── reset.css
│   ├── theme.css
│   ├── layout.css
│   ├── content.css
│   ├── forms.css
│   ├── buttons.css
│   ├── components.css
│   └── utilities.css
├── pico.css          # Built concatenated file (DO NOT EDIT)
└── pico.min.css      # Minified production file (DO NOT EDIT)

theme.html            # Theme builder tool
biome.json            # Linter/formatter config
.mise.toml            # Build tasks
```

## Making Changes

1. **Edit source files only** - never edit `css/pico.css` or `css/pico.min.css`
2. **Run `mise run check`** before committing to lint, format, and build
3. **Test in theme.html** - open via `mise run dev` then `http://localhost:3000/theme.html`
4. **Test both light and dark modes** - toggle in theme builder

## Common Tasks

### Adding a new CSS variable

1. **Source variables** (values users override): define in `reset.css` under `:root, :host`
2. **Derived colors** (using `light-dark()`): define in `theme.css` under `*, *::before, *::after`
3. The browser automatically picks the correct color based on each element's `color-scheme`

### Adding a new component

1. Add styles to `components.css` inside `@layer components { ... }`
2. Use semantic HTML elements where possible
3. Keep class names minimal - prefer `.secondary`, `.outline`, etc.
4. Use `light-dark()` for colors to support both modes

### Theming

Users customize by setting just two variables:

```html
<style>
  :root {
    --pico-primary: #0172ad;
    --pico-secondary: #646e82;
  }
</style>
```

All other colors derive automatically via `color-mix()`.

### Forcing Light/Dark Mode

Users force a specific mode by setting `color-scheme`:

```html
<!-- Force light mode on an element -->
<div style="color-scheme: light">Always light</div>

<!-- Force dark mode on an element -->
<div style="color-scheme: dark">Always dark</div>

<!-- Force light mode globally -->
:root { color-scheme: light; }
```

For inverted sections (e.g., dark navbar on light page), use the `.light` and `.dark` utility classes which set both `color-scheme` and `background-color`:

```html
<!-- Dark navbar on light page -->
<nav class="dark">...</nav>

<!-- Light card on dark page -->
<article class="light">...</article>
```

### Icons

Icons use `mask-image` to inherit text color via `currentColor`. Use `.icon` with a specific icon class:

```html
<button><span class="icon icon-plus"></span> Add</button>
<a href="#">Continue <span class="icon icon-arrow-right"></span></a>
```

Icons inherit font size (1em) and color from their parent.

**Available:** `arrow-right`, `arrow-left`, `arrow-up`, `arrow-down`, `chevron-right`, `chevron-left`, `chevron-up`, `chevron-down`, `plus`, `minus`, `x`, `check`, `edit`, `trash`, `menu`, `more`, `search`, `filter`, `info`, `warning`, `error`, `success`, `user`, `settings`, `home`, `external`, `sun`, `moon`, `system`

## Accessibility

The framework supports `prefers-contrast: more` media query for users who need higher contrast. This is handled automatically in `theme.css`.

## Color Palette

Available as dropdown options in theme.html:
- **Vibrants:** Red, Pink, Fuchsia, Purple, Violet, Indigo, Blue, Azure, Cyan, Jade, Green, Lime, Yellow, Amber, Pumpkin, Orange
- **Neutrals:** Sand, Grey, Zinc, Slate

## Before Committing

Run `mise run check` (lints, formats, and builds all files).

Then open `theme.html` via `mise run dev` and verify:
- Light mode looks correct
- Dark mode looks correct
- Color swatches update properly
- Generated code is correct
