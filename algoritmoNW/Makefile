ANW: ANW.o
	gcc -m32 ANW.o -o ANW
	rm ANW.o
	clear && ./ANW

ANW.o: ANW.asm
	nasm -f elf32 ANW.asm
