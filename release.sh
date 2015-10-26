mkdir -p releases

cp mruby/build/i386-apple-darwin14/bin/pdfq releases/pdfq-i386-apple-darwin14
cp mruby/build/i686-pc-linux-gnu/bin/pdfq releases/pdfq-i686-pc-linux-gnu
cp mruby/build/i686-w64-mingw32/bin/pdfq.exe releases/pdfq-i686-w64-mingw32.exe
cp mruby/build/x86_64-apple-darwin14/bin/pdfq releases/pdfq-x86_64-apple-darwin14
cp mruby/build/x86_64-pc-linux-gnu/bin/pdfq releases/pdfq-x86_64-pc-linux-gnu
cp mruby/build/x86_64-w64-mingw32/bin/pdfq.exe releases/pdfq-x86_64-w64-mingw32.exe

chmod +x releases/pdfq-i386-apple-darwin14
chmod +x releases/pdfq-i686-pc-linux-gnu
chmod +x releases/pdfq-i686-w64-mingw32.exe
chmod +x releases/pdfq-x86_64-apple-darwin14
chmod +x releases/pdfq-x86_64-pc-linux-gnu
chmod +x releases/pdfq-x86_64-w64-mingw32.exe
