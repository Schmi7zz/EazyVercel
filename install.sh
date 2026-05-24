#!/usr/bin/env bash
# =============================================================
#  Multi XHTTP Relay Installer — Schmi7zz
#  Ubuntu Server | VLESS+XHTTP Auto-Installer + Multi Relays on a Single VPS + Domain
# -------------------------------------------------------------
#  Copyright (C) 2025 Schmi7zz
#  Repository: https://github.com/schmi7zz/EazyVercel
#  Author:     @Schmi7zz (https://t.me/Schmitzws)
#
#  Licensed under the GNU General Public License v3.0 (GPL-3.0).
#  See LICENSE file for full terms.
#
#  Redistribution requires preserving this copyright notice and
#  the LICENSE file. Unauthorized removal of attribution is a
#  copyright violation and will result in a DMCA takedown.
# =============================================================
# Usage: bash <(curl -fsSL https://raw.githubusercontent.com/schmi7zz/EazyVercel/main/install.sh)

set -euo pipefail

REPO_URL="https://github.com/Schmi7zz/EazyVercel.git"
TARGET_DIR="/root/EazyVercel"
BRANCH="main"

C_CYAN="\033[1;36m"; C_GREEN="\033[1;32m"; C_YELLOW="\033[1;33m"
C_RED="\033[1;31m"; C_RESET="\033[0m"

info() { echo -e "${C_CYAN}➜${C_RESET} $*"; }
ok()   { echo -e "${C_GREEN}✔${C_RESET} $*"; }
warn() { echo -e "${C_YELLOW}⚠${C_RESET} $*"; }
fail() { echo -e "${C_RED}✘${C_RESET} $*"; exit 1; }

# ── must run as root ─────────────────────────────────────
if [[ $EUID -ne 0 ]]; then
  fail "Run as root (use: sudo bash <(curl ...))"
fi

# ── ensure git is installed ──────────────────────────────
if ! command -v git &>/dev/null; then
  info "Installing git..."
  apt-get update -qq
  apt-get install -y -qq git
  ok "git installed"
fi

# ── clone or update repo ─────────────────────────────────
if [[ -d "$TARGET_DIR/.git" ]]; then
  warn "Existing install found at $TARGET_DIR — updating..."
  git -C "$TARGET_DIR" fetch --depth=1 origin "$BRANCH"
  git -C "$TARGET_DIR" reset --hard "origin/$BRANCH"
  ok "Repo updated"
else
  if [[ -d "$TARGET_DIR" ]]; then
    warn "Directory exists but is not a git repo — removing..."
    rm -rf "$TARGET_DIR"
  fi
  info "Cloning $REPO_URL..."
  git clone --depth=1 --branch "$BRANCH" "$REPO_URL" "$TARGET_DIR"
  ok "Repo cloned to $TARGET_DIR"
fi

# ── run the installer ────────────────────────────────────
cd "$TARGET_DIR"
chmod +x Deploy-Ubuntu.sh
info "Launching Deploy-Ubuntu.sh..."
echo ""
exec bash Deploy-Ubuntu.sh "$@"
