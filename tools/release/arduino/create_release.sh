
echo "== copy files to work dir =="

# copy C++ files and update the C include path
cp ../../../cppsrc/*.cpp ./../../../../U8g2_Arduino/src/.
cp ../../../cppsrc/*.h ./../../../../U8g2_Arduino/src/.
sed -i 's|u8g2.h|clib/u8g2.h|g' ./../../../../U8g2_Arduino/src/U8g2lib.h
sed -i 's|u8x8.h|clib/u8x8.h|g' ./../../../../U8g2_Arduino/src/U8x8lib.h
# copy C files, exclude u8x8_d_stdio.c
cp ../../../csrc/*.c ./../../../../U8g2_Arduino/src/clib/.
cp ../../../csrc/*.h ./../../../../U8g2_Arduino/src/clib/.
rm ./../../../../U8g2_Arduino/src/clib/u8x8_d_stdio.c
# copy examples
mkdir ../../../../U8g2_Arduino/examples/u8g2_page_buffer/HelloWorld
cp ../../../sys/arduino/u8g2_page_buffer/HelloWorld/*.ino ../../../../U8g2_Arduino/examples/u8g2_page_buffer/HelloWorld/.

mkdir ../../../../U8g2_Arduino/examples/u8g2_full_buffer/HelloWorld
cp ../../../sys/arduino/u8g2_full_buffer/HelloWorld/*.ino ../../../../U8g2_Arduino/examples/u8g2_full_buffer/HelloWorld/.

mkdir ../../../../U8g2_Arduino/examples/u8x8/HelloWorld
cp ../../../sys/arduino/u8x8/HelloWorld/*.ino ../../../../U8g2_Arduino/examples/u8x8/HelloWorld/.

mkdir ../../../../U8g2_Arduino/examples/u8x8/GraphicsTest
cp ../../../sys/arduino/u8x8/GraphicsTest/*.ino ../../../../U8g2_Arduino/examples/u8x8/GraphicsTest/.

# copy other files
cp ../../../ChangeLog ./../../../../U8g2_Arduino/extras/.



pushd .
# goto the release project
cd ../../../../U8g2_Arduino

echo "== adding files to repo =="

# ensure that all example files are added to the repo
find . -name "*.ino" -exec git add {} \;

# ensure that all C/C++ files are added
cd src
git add *
cd clib
git add *.[hc]
cd ..
cd ..


ver=`../u8g2/tools/release/print_release.sh`

sed -i -e "s/version=.*/version=${ver}/" library.properties

# git commit -a -m `../u8g2/tools/release/print_release.sh`
# git push

cd ..

echo "== create local zip file =="
zip -q -r --exclude="*.git*" u8g2_arduino_${ver}.zip ./U8g2_Arduino

popd

echo now create a release in gitub for U8glib_Arduino, tag/name = ${ver}
# Relases in github:
# Tag: 1.02pre3
# Release  name: 1.02pre3

