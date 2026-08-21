#!/usr/bin/env bash

set -euo pipefail

backup_root="/mnt/Old/backups/imperative"
backup_date="$(date +%F)"
backup_path="$backup_root/$backup_date"
retention_count=7
source_directories=(
  "/home/repinek/.ssh"
  "/home/repinek/.gnupg"
)

find_previous_backup() {
  find "$backup_root" \
    -mindepth 1 \
    -maxdepth 1 \
    -type d \
    -name '????-??-??' \
    -printf '%f\n' \
    | sort \
    | tail -n 1
}

backup_directory() {
  local source_path="$1"
  local source_name
  local -a rsync_options=(-aHAX --delete)

  source_name="$(basename "$source_path")"

  if [ -n "$previous_backup" ] && [ -d "$backup_root/$previous_backup/$source_name" ]; then
    rsync_options+=("--link-dest=../$previous_backup/$source_name")
  fi

  rsync "${rsync_options[@]}" "$source_path/" "$backup_path/$source_name/"
}

remove_expired_backups() {
  local -a backups
  local backup_index

  mapfile -t backups < <(
    find "$backup_root" \
      -mindepth 1 \
      -maxdepth 1 \
      -type d \
      -name '????-??-??' \
      -printf '%f\n' \
      | sort -r
  )

  for ((backup_index = retention_count; backup_index < ${#backups[@]}; backup_index++)); do
    rm -rf -- "$backup_root/${backups[$backup_index]}"
  done
}

install -d -m 0700 "$backup_root"
previous_backup="$(find_previous_backup)"
install -d -m 0700 "$backup_path"

for source_directory in "${source_directories[@]}"; do
  backup_directory "$source_directory"
done

remove_expired_backups
