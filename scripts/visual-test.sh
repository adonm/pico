#!/bin/bash
# Visual regression test using Playwright screenshots + opencode + Kimi k2.5
# Usage: ./scripts/visual-test.sh [url]
#   url - defaults to local file server (run `python -m http.server` first)

set -e

URL="${1:-http://localhost:8000/index.html}"
OUTPUT_DIR="test/screenshots"

echo "=== Visual Test for 12-Column Grid ==="
echo "URL: $URL"
echo ""

mkdir -p "$OUTPUT_DIR"

echo "Step 1: Capturing screenshots with Playwright..."

npx playwright screenshot \
  --viewport-size=375,667 \
  --full-page \
  "$URL" \
  "$OUTPUT_DIR/mobile.png" 2>/dev/null && echo "  ✓ Mobile (375px)"

npx playwright screenshot \
  --viewport-size=768,1024 \
  --full-page \
  "$URL" \
  "$OUTPUT_DIR/tablet.png" 2>/dev/null && echo "  ✓ Tablet (768px)"

npx playwright screenshot \
  --viewport-size=1280,720 \
  --full-page \
  "$URL" \
  "$OUTPUT_DIR/desktop.png" 2>/dev/null && echo "  ✓ Desktop (1280px)"

echo ""
echo "Step 2: Analyzing screenshots with Kimi k2.5..."
echo ""

opencode run -m kimi-for-coding/k2p5 "
You are a visual QA tester for a CSS grid system. 

Analyze these screenshots from the demo page and verify each test case:

## Screenshots to analyze:
- $OUTPUT_DIR/mobile.png (375px width)
- $OUTPUT_DIR/tablet.png (768px width) 
- $OUTPUT_DIR/desktop.png (1280px width)

## Test Cases to verify:

### Test 1: Auto-fit Grid (no col-* classes)
- Mobile (375px): EXPECTED - single column stacked (auto-fit only activates at 768px+)
- Tablet/Desktop (768px+): EXPECTED - three equal-width items side-by-side

### Test 2-5: 12-column layouts (col-6, col-4, col-3, col-8)
These should work at ALL viewport sizes because 12-column mode activates when col-* classes are present:
- Mobile, Tablet, Desktop: EXPECTED - column spans should be proportional (e.g., col-6 = 50%, col-4 = 33%)

### Test 6: Responsive col-6 col-md-4
- Mobile: EXPECTED - 50% width (2 per row, 3rd wraps to next row)
- Tablet/Desktop: EXPECTED - 33% width (3 per row)

### Test 7: Responsive col-12 col-md-6
- Mobile: EXPECTED - 100% width (stacked, one per row)
- Tablet/Desktop: EXPECTED - 50% width (2 per row)

### Test 8: Overflow col-8 + col-8 (exceeds 12 columns)
- All viewports: EXPECTED - second item wraps to next row

## Validation:
For each test, report PASS or FAIL with notes. If all tests pass, output: '✅ All visual tests passed'"
