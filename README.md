<p>
  <a href="https://picocss.com" target="_blank">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/picocss/pico/HEAD/.github/logo-dark.svg">
      <source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/picocss/pico/HEAD/.github/logo-light.svg">
      <img alt="Pico CSS" src="https://raw.githubusercontent.com/picocss/pico/HEAD/.github/logo-light.svg" width="auto" height="60">
    </picture>
  </a>
</p>

## Modern CSS Framework

A fork of [PicoCSS](https://picocss.com) rebuilt with modern CSS features: `light-dark()`, `color-mix()`, CSS nesting, and cascade layers. No build step, no preprocessors.

**Key differences from upstream:**
- Automatic light/dark mode via `light-dark()` - no media queries needed
- Two-variable theming: set `--pico-primary` and `--pico-secondary`, everything else derives
- CSS nesting throughout for cleaner source
- Simplified: no 12-column grid utilities (use inline CSS)

## Quick Start

### CDN (recommended)

```html
<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/adonm/pico/css/pico.min.css">
```

### Local

Download and link:

```html
<link rel="stylesheet" href="css/pico.min.css">
```

### Minimal HTML

```html
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/adonm/pico/css/pico.min.css">
  </head>
  <body>
    <main class="container">
      <h1>Hello world</h1>
    </main>
  </body>
</html>
```

## Theming

Set two variables on `:root`:

```css
:root {
  --pico-primary: #0172ad;
  --pico-secondary: #646e82;
}
```

All colors (hover states, backgrounds, borders, etc.) derive automatically via `color-mix()`.

### Available Variables

| Variable | Purpose |
|----------|---------|
| `--pico-primary` | Brand/accent color |
| `--pico-secondary` | Neutral color (text, borders) |
| `--pico-border-radius` | Corner rounding (default: `0.25rem`) |
| `--pico-shadow` | Box shadow (set to `none` to disable) |

## Common Patterns

### Navigation

Simple nav with links:

```html
<nav>
  <ul>
    <li><strong>Brand</strong></li>
  </ul>
  <ul>
    <li><a href="#">Home</a></li>
    <li><a href="#">About</a></li>
    <li><a href="#">Contact</a></li>
  </ul>
</nav>
```

Dark nav on light page:

```html
<nav class="dark">
  <ul>
    <li><strong>Brand</strong></li>
  </ul>
  <ul>
    <li><a href="#">Home</a></li>
  </ul>
</nav>
```

### Forms

Basic form:

```html
<form>
  <label>Email <input type="email" placeholder="you@example.com"></label>
  <label>Password <input type="password"></label>
  <button>Sign In</button>
</form>
```

Form with validation:

```html
<form>
  <label>Email <input type="email" aria-invalid="false" value="user@example.com"></label>
  <small>Valid email address</small>
  <label>Password <input type="password" aria-invalid="true"></label>
  <small>Must be at least 8 characters</small>
  <button>Sign In</button>
</form>
```

Button group:

```html
<div role="group">
  <input type="search" placeholder="Search...">
  <button>Go</button>
</div>
```

### Cards

Basic card:

```html
<article>
  <header>Card Title</header>
  <p>Card content goes here.</p>
  <footer>
    <button>Save</button>
    <button class="secondary">Cancel</button>
  </footer>
</article>
```

Grid of cards:

```html
<div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 1rem">
  <article>Card 1</article>
  <article>Card 2</article>
  <article>Card 3</article>
</div>
```

### Tables

Striped table:

```html
<table class="striped">
  <thead>
    <tr><th>Name</th><th>Status</th></tr>
  </thead>
  <tbody>
    <tr><td>Alice</td><td><span class="tag success">Active</span></td></tr>
    <tr><td>Bob</td><td><span class="tag secondary">Inactive</span></td></tr>
  </tbody>
</table>
```

### Tags & Badges

```html
<span class="tag">Default</span>
<span class="tag primary">Primary</span>
<span class="tag secondary">Secondary</span>
<span class="tag success">Success</span>
<span class="tag warning">Warning</span>
<span class="tag error">Error</span>
```

### Accordion

```html
<details open>
  <summary>Open by default</summary>
  <p>Content shown when expanded.</p>
</details>
<details>
  <summary>Click to expand</summary>
  <p>Hidden content revealed on click.</p>
</details>
```

### Icons

Icons inherit text color and size. Use inline with buttons, links, etc:

```html
<button><span class="icon icon-plus"></span> Add</button>
<a href="#">Continue <span class="icon icon-arrow-right"></span></a>
```

Available icons:

| Category | Icons |
|----------|-------|
| **Navigation** | `arrow-right`, `arrow-left`, `arrow-up`, `arrow-down`, `chevron-right`, `chevron-left`, `chevron-up`, `chevron-down` |
| **Actions** | `plus`, `minus`, `x`, `check`, `edit`, `trash` |
| **UI** | `menu`, `more`, `search`, `filter` |
| **Status** | `info`, `warning`, `error`, `success` |
| **Common** | `user`, `settings`, `home`, `external` |
| **Theme** | `sun`, `moon`, `system` |

### Layout

Two-column layout:

```html
<div style="display: grid; grid-template-columns: 250px 1fr; gap: 2rem">
  <aside>Sidebar</aside>
  <main>Content</main>
</div>
```

Responsive grid:

```html
<div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 1rem">
  <div>Item 1</div>
  <div>Item 2</div>
  <div>Item 3</div>
</div>
```

## Light/Dark Mode

### Automatic (default)

Colors switch based on user's system preference. Works out of the box - no configuration needed.

### Force globally

```css
:root { color-scheme: light; }  /* force light mode */
:root { color-scheme: dark; }   /* force dark mode */
```

### Invert sections

Use `.light` or `.dark` classes to invert specific sections:

```html
<!-- Dark navbar on light page -->
<nav class="dark">
  <a href="#">Link</a>
</nav>

<!-- Light card on dark page -->
<article class="light">
  <p>This card is always light.</p>
</article>
```

## Escape Hatch

Isolate third-party widgets (maps, charts) from Pico styles:

```html
<div id="map" data-no-pico style="color-scheme: light; background: white"></div>
```

Apply `data-no-pico` and `color-scheme: light; background: white` directly to the widget element to prevent dark mode inheritance.

## Browser Support

Requires modern CSS:

| Feature | Chrome | Firefox | Safari |
|---------|--------|---------|--------|
| `light-dark()` | 123+ | 120+ | 17.2+ |
| CSS nesting | 120+ | 117+ | 17.2+ |
| Cascade layers | 99+ | 97+ | 15.4+ |

## Build

```bash
mise install      # Install tools
mise run build    # Build CSS
mise run watch    # Watch and rebuild
mise run check    # Lint, format, build
mise run dev      # Start dev server on port 3000
```

## License

MIT
