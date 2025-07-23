#!/usr/bin/env bash
set -euo pipefail

# Install and build Jekyll site, then deploy to gh-pages branch

# Configure bundler to install to vendor/bundle
bundle config set path 'vendor/bundle'
# Skip development gems (e.g., html-proofer) when installing
bundle config set without 'development'

bundle install --jobs 4 --retry 3

# Ensure UTF-8 locale for SCSS conversion
export LANG=en_US.UTF-8

# Build site into _site directory
bundle exec jekyll build

# Deploy built site to gh-pages branch via git subtree
git push origin "$(git subtree split --prefix _site HEAD)":gh-pages --force

echo "✔ Site built and deployed to gh-pages branch."
