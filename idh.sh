#!/bin/env bash

# Simple bash version of IDH
VERSION="2.3.0"

get_user_info() {
  local user=${1:-}

  if [ -n "$user" ]; then
    if ! id "$user" &>/dev/null; then
      echo "Error: User '$user' not found" >&2
      exit 1
    fi
    USERNAME=$(id -un "$user")
    USER_ID=$(id -u "$user")
    PRIMARY_GROUP=$(id -gn "$user")
    PRIMARY_GID=$(id -g "$user")

    # Get groups with their GIDs
    GROUPS_WITH_GIDS=$(id -Gn "$user" | tr ' ' '\n' | while read -r group; do
      gid=$(getent group "$group" | cut -d: -f3)
      echo "$group:$gid"
    done | sort)

    HOME_DIR=$(eval echo "~$user")
    USER_SHELL=$(getent passwd "$user" | cut -d: -f7)
  else
    USERNAME=$(id -un)
    USER_ID=$(id -u)
    PRIMARY_GROUP=$(id -gn)
    PRIMARY_GID=$(id -g)

    # Get groups with their GIDs
    GROUPS_WITH_GIDS=$(id -Gn | tr ' ' '\n' | while read -r group; do
      gid=$(getent group "$group" | cut -d: -f3)
      echo "$group:$gid"
    done | sort)

    HOME_DIR=$HOME
    USER_SHELL=$SHELL
  fi
}

show_simple_table() {
  get_user_info "$1"

  echo "=================================================="
  echo "🔐 User Identity Information"
  echo "=================================================="
  printf "%-18s: %s\n" "👤 Username" "$USERNAME"
  printf "%-18s: %s\n" "🆔 User ID" "$USER_ID"
  printf "%-18s: %s\n" "👥 Primary Group" "$PRIMARY_GROUP ($PRIMARY_GID)"
  echo "--------------------------------------------------"
  printf "%-18s:\n" "📂 Groups"
  echo "$GROUPS_WITH_GIDS" | while IFS=':' read -r group gid; do
    printf "  %-25s (GID: %s)\n" "$group" "$gid"
  done
  echo "--------------------------------------------------"
  printf "%-18s: %s\n" "🏠 Home Directory" "$HOME_DIR"
  printf "%-18s: %s\n" "🐚 Shell" "$USER_SHELL"
  echo "--------------------------------------------------"

  if [ "$USER_ID" -eq 0 ]; then
    printf "%-18s: ⚠️  ROOT USER - Full System Access\n" "🔒 Security Status"
  else
    printf "%-18s: ✅ Regular User\n" "🔒 Security Status"
  fi
  echo "=================================================="
}

show_groups_only() {
  get_user_info "$1"

  echo "Group membership for $USERNAME:"
  echo "=============================="
  echo "$GROUPS_WITH_GIDS" | while IFS=':' read -r group gid; do
    printf "%-20s (GID: %s)\n" "$group" "$gid"
  done
}

# Main execution
case "${1:-}" in
-h | --help)
  echo "IDH Simple - Identity Helper v$VERSION"
  echo "Usage: $0 [USERNAME] [-g|--groups]"
  ;;
-g | --groups)
  show_groups_only "${2:-}"
  ;;
-u | --user)
  show_simple_table "$2"
  ;;
*)
  if [ -n "$1" ] && [ "${1:0:1}" != "-" ]; then
    show_simple_table "$1"
  else
    show_simple_table
  fi
  ;;
esac
