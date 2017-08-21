#!/bin/sh
CP="lib/*:classes"
SP=src/java/

/bin/rm -f nxt.jar
/bin/rm -f nxtservice.jar
/bin/rm -rf classes
/bin/mkdir -p classes/
/bin/rm -rf addons/classes
/bin/mkdir -p addons/classes/

echo "compiling gd premium core..."
find src/java/nxt/ -name "*.java" > sources.tmp
javac -encoding utf8 -sourcepath "${SP}" -classpath "${CP}" -d classes/ @sources.tmp || exit 1
echo "gd premium core class files compiled successfully"

find addons/src/ -name "*.java" > addons.tmp
if [ -s addons.tmp ]; then
    echo "compiling add-ons..."
    javac -encoding utf8 -sourcepath "${SP}:addons/src" -classpath "${CP}:addons/classes:addons/lib/*" -d addons/classes @addons.tmp || exit 1
    echo "add-ons compiled successfully"
    rm -f addons.tmp
else
    echo "no add-ons to compile"
    rm -f addons.tmp
fi

echo "compilation done"
