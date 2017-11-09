nasm %1.asm -f bin -o %1.bin
if %errorlevel% neq 0 exit /b %errorlevel%  
qemu-system-i386 -drive format=raw,file=%1.bin