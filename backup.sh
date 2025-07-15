#!/bin/bash
set -e
cd "$(dirname "$(realpath "$0")")"

echo "updating repos"
cp -f repo.pkgs repo.pkgs.old 2>/dev/null || true
cp -f aur.pkgs aur.pkgs.old 2>/dev/null || true

pacman -Qent | awk '{print $1}' > repo.pkgs
pacman -Qem | awk '{print $1}' > aur.pkgs

print_side_by_side_table() {
	echo "+----------------------+----------------------+"
	echo "| Repo Changes         | AUR Changes          |"
	echo "+----------------------+----------------------+"
	paste \
		<(diff --unchanged-line-format= --old-line-format='- %L' --new-line-format='+ %L' repo.pkgs.old repo.pkgs || true) \
		<(diff --unchanged-line-format= --old-line-format='- %L' --new-line-format='+ %L' aur.pkgs.old aur.pkgs || true) |
	awk -F'\t' '{ printf "| %-20s | %-20s |\n", $1, $2 }'
	echo "+----------------------+----------------------+"
}

print_side_by_side_table
