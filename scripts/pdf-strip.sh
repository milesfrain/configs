#!/usr/bin/env bash
set -xeo pipefail

if [[ -z "${1:-}" ]]; then
  echo "Usage: pdf-strip.sh <file.pdf>" >&2
  exit 1
fi

if [[ ! -f "$1" ]]; then
  echo "Error: file not found: $1" >&2
  exit 1
fi

if [[ "$1" != *.pdf ]]; then
  echo "Error: not a .pdf file: $1" >&2
  exit 1
fi

in=$(realpath "$1")
dir=$(dirname "$in")
pre=$(basename "$in" .pdf)

# gs-orig tends to be a bit smaller
gs -dBATCH -dNOPAUSE -sDEVICE=pdfwrite -sOutputFile="$dir/$pre-gs-orig.pdf" "$in"
gs -dBATCH -dNOPAUSE -sDEVICE=pdfwrite -dFILTERIMAGE -sOutputFile="$dir/$pre-gs-no-image.pdf" "$in"
gs -dBATCH -dNOPAUSE -sDEVICE=pdfwrite -dFILTERIMAGE -dFILTERVECTOR -sOutputFile="$dir/$pre-gs-no-image-no-vec.pdf" "$in"

# Note that these strip titles
pdftops "$dir/$pre-gs-no-image.pdf" - | pv | ps2pdf - "$dir/$pre-gs-no-image-ps.pdf"
pdftops "$dir/$pre-gs-no-image-no-vec.pdf" - | pv | ps2pdf - "$dir/$pre-gs-no-image-no-vec-ps.pdf"
# this is often slow and increases size
# pdftops "$in" - | pv | ps2pdf - "$dir/$pre-ps.pdf"
