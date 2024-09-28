all:
	nasm -felf64 practice.asm -o practice.e
	gcc-13 -g -c practice.c -o practice.o -fno-stack-protector
	gcc-13 -g practice.o vector.o practice.e -no-pie -fno-stack-protector
