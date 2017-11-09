SET selectedFormat=%2

IF "%selectedFormat%"=="" (SET selectedFormat=vdi)

qemu-img convert -f raw -O %selectedFormat% %1.bin %1.%selectedFormat%