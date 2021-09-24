#!/bin/sh

cd $(realpath $(dirname "$0"))

build_dir="../build"
media_dir="../media"
src_dir="../src"
templates_dir="../templates"

generate_pdf() {
  echo "Generating $1.pdf."

  pandoc "$src_dir/$1.md" \
    --from=markdown \
    --to=pdf \
    --pdf-engine=context \
    --template="$templates_dir/template.tex" \
    --resource-path="$media_dir" \
    --output="$build_dir/$1/$1.pdf"
}

# When transfering files from the 'media' directory to the '$build_dir/$1'
# directory using the '--extract-media' option, Pandoc prepends
# '$build_dir/$1/' to any references to those media files within the output
# document. This is not required as the media and the output document will be
# output in the same directory. So, before outputting the document, 'sed' is
# used within 'generate_context' and 'generate_html' to correct that
# unnecessary reference adjustment.

generate_context() {
  echo "Generating $1.tex."

  output=$(
    pandoc "$src_dir/$1.md" \
      --from=markdown \
      --to=context \
      --standalone \
      --template="$templates_dir/template.tex" \
      --resource-path="$media_dir" \
      --extract-media="$build_dir/$1" |
    sed "s#$build_dir/$1/##g"
  )

  echo "$output" > "$build_dir/$1/$1.tex"
}

generate_html() {
  echo "Generating $1.html."

  output=$(
    pandoc "$src_dir/$1.md" \
      --from=markdown \
      --to=html \
      --standalone \
      --section-divs \
      --strip-comments \
      --email-obfuscation=references \
      --highlight-style=monochrome \
      --katex=https://cdn.jsdelivr.net/npm/katex@latest/dist/ \
      --template="$templates_dir/template.html" \
      --resource-path="$media_dir" \
      --extract-media="$build_dir/$1" |
    sed "s#$build_dir/$1/##g"
  )

  echo "$output" > "$build_dir/$1/$1.html"
}

generate_docx() {
  echo "Generating $1.docx."

  pandoc "$src_dir/$1.md" \
    --from=markdown \
    --to=docx \
    --highlight-style=monochrome \
    --resource-path="$media_dir" \
    --output="$build_dir/$1/$1.docx"
}

generate_odt() {
  echo "Generating $1.odt."

  pandoc "$src_dir/$1.md" \
    --from=markdown \
    --to=odt \
    --resource-path="$media_dir" \
    --output="$build_dir/$1/$1.odt"
}

generate_rtf() {
  echo "Generating $1.rtf."

  pandoc "$src_dir/$1.md" \
    --from=markdown \
    --to=rtf \
    --standalone \
    --resource-path="$media_dir" \
    --output="$build_dir/$1/$1.rtf"
}

generate_all() {
  generate_pdf "$1"
  generate_context "$1"
  generate_html "$1"
  generate_docx "$1"
  generate_odt "$1"
  generate_rtf "$1"
}

format="$1"
case "$format" in
  "")
    format="all"
  ;;
  "pdf"|"context"|"html"|"docx"|"odt"|"rtf"|"all")
    # Do nothing. A valid format was given.
  ;;
  *)
    echo "Error: First argument must be empty or one of 'pdf', 'context'," \
      "'html', 'docx', 'odt', 'rtf', or 'all'." >&2
    exit
  ;;
esac

# Remove the first argument from '$@' as it has already been handled and
# stored. Only leave the base names so they can be processed below.
shift

# For better portability, the base names are stored in a space separated string
# instead of an array.
base_names=""

# To handle file names with spaces, spaces are initially encoded as '<U+0020>'
# when they are stored and then converted back into spaces when used.
space_char="<U+0020>"

for base_name in "$@"; do
  if ! [ -r "$src_dir/$base_name.md" ]; then
    echo "Error: 'src/$base_name.md' is not readable." >&2
    exit
  fi

  base_names="$base_names $(echo "$base_name" | sed "s/ /$space_char/g")"
done

if [ -z "$base_names" ]; then
  for markdown_file in "$src_dir"/*.md; do
    markdown_file=$(echo "$markdown_file" | sed "s/ /$space_char/g")

    if [ $(basename "$markdown_file") = "sample.md" ]; then
      continue
    fi

    base_names="$base_names $(basename "$markdown_file" .md)"
  done
fi

for base_name in $base_names; do
  base_name=$(echo "$base_name" | sed "s/$space_char/ /g")

  output_dir="$build_dir/$base_name"
  if ! [ -d "$output_dir" ]; then
    echo "Creating $(echo "$output_dir" | cut -d "/" -f 2-3) directory."
    mkdir --parent "$output_dir"
  fi

  "generate_$format" "$base_name"
done
