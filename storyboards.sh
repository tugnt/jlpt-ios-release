#/bin/bash
type swiftgen >/dev/null 2>&1 || { echo >&2 "I require swiftgen but it's not installed. Aborting."; exit 0; }
SCRIPT_DIR="${BASH_SOURCE[0]}" echo $SCRIPT_DIR
while [ -h "$SCRIPT_DIR" ]; do  DIR="$( cd -P "$( dirname "$SCRIPT_DIR" )" && pwd )" SCRIPT_DIR="$(readlink "$SCRIPT_DIR")" [[ $SCRIPT_DIR != /* ]] && SCRIPT_DIR="$DIR/$SCRIPT_DIR"  done DIR="$( cd -P "$( dirname "$SCRIPT_DIR" )" && pwd )"
SOURCES_DIR="/Users/TungNguyen/Workspace/jlpt-ios-release/Source" STORYBOARDS_DIR="/Users/TungNguyen/Workspace/jlpt-ios-release/Base.lproj"
echo $(ls "$STORYBOARDS_DIR")
swiftgen storyboards --output "$SOURCES_DIR/UIStoryboard.swift"  --sceneEnumName Scene --segueEnumName Segue "$STORYBOARDS_DIR"

