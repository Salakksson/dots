#!/bin/sh

rm -fr ./.config/emacs/*
git submodule update --init ./.config/emacs
