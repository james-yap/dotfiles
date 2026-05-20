# Custom shell functions

# fm - ranger file manager with smart cd-on-exit
fm() {
  if ! command -v ranger >/dev/null 2>&1; then
    echo "Error: ranger is not installed" >&2
    return 1
  fi

  local tempfile
  tempfile="$(mktemp -t ranger-choosedir.XXXXXX)"

  ranger --choosedir="$tempfile" "$PWD"

  if [[ -s "$tempfile" ]]; then
    local chosen_dir
    chosen_dir="$(<"$tempfile")"

    if [[ "$chosen_dir" != "$PWD" ]]; then
      if command -v z >/dev/null 2>&1; then
        z "$chosen_dir"
      else
        cd "$chosen_dir"
      fi
    fi
  fi

  rm -f "$tempfile"
}
