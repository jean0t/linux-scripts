#!/usr/bin/env bash


################################################# HEADER
# Author: Joao Mauricio (Jean0t)
# Github: github.com/jean0t
#
# created in 21 February 2025 16:44
#
# purpose: set up git easily
#
#################################################


################################################# WHAT IT DOES
#
# How it actually work?
# It will set up the name, email,
# core editor and main branch
# (instead of the default master)
#
#################################################


################################################# START


# Git exists in the system? if not, leave immediately
(command -v git 1>/dev/null 2>&1) || { echo 'git not found, please install.' ; exit 1 ; }

# Collecting user info
printf "%s" "User: "
read USER
printf "%s" "Email: "
read EMAIL
printf "%s" "Editor [vim,emacs,nano]: "
read EDITOR

# main is the default branch in github
# which I consider the default VCS
BRANCH='main'


# Now the magic happens
git config --global user.name "$USER"
git config --global user.email "$EMAIL"
git config --global core.editor "$EDITOR"
git config --global init.defaultBranch "$BRANCH"


#################################################
