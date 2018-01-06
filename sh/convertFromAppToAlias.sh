#! /bin/sh -x

echo \# alias for app > ~/.zshrc.app
find /Applications -name "*.app" -print0 | xargs -0 -I{} makeAppAlias {} >> ~/.zshrc.app
