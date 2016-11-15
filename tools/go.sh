#!/bin/bash
set -euo pipefail
cd "`dirname "$0"`"
pushd ..
7z x java-model.7z -y
popd
dmd -debug -unittest java_to_d.d
rm java_to_d.o*
mkdir -p ../model
mkdir -p ../docs
./java_to_d

pushd ../model
for f in move player_context world ; do
	# preserve line endings (http://stackoverflow.com/a/10934047)
	patch --binary $f.d ../tools/$f.d.diff
done
popd

pushd ..
for f in model/*.d ; do
	dmd -o- -c -D -Dddocs $f
done
popd
