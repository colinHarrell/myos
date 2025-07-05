
# MyOS

A simple hobby operating system written in C and x86 Assembly, designed for educational purposes. This project demonstrates the basics of booting into a kernel, setting up the VGA text buffer, and handling low-level control via custom OS code.

## 🧠 Project Overview

This OS does the following:
- Boots using a custom bootloader (`boot.asm`)
- Loads and executes a basic C kernel (`kernel.c`)
- Displays output using direct memory access to video RAM

## 🧰 Tools Required

Before you begin, make sure you have the following tools installed:

- **NASM** (Netwide Assembler): for assembling `boot.asm`
- **GCC** (or a cross-compiler like `i386-elf-gcc`): for compiling `kernel.c`
- **LD**: for linking with a custom linker script (`link.ld`)
- **QEMU**: to emulate and run the OS
- **Make**: for running build scripts

### 🔧 Install on Ubuntu/Debian

```bash
sudo apt update
sudo apt install build-essential qemu nasm
```

> Optional: For a more portable setup, consider using a cross-compiler (like `i386-elf-gcc`) for more accurate low-level builds.

---

## 🚀 How to Run the OS

1. **Clone the repository**

```bash
git clone https://github.com/colinHarrell/myos.git
cd myos
```

2. **Build the OS**

```bash
make
```

This will:
- Assemble the bootloader
- Compile the kernel
- Link everything into a flat binary (`os-image`)

3. **Run the OS in QEMU**

```bash
qemu-system-i386 -kernel os-image
```

You should see your custom OS output inside the QEMU window.

---

## 🧹 Clean Build Artifacts

```bash
make clean
```

This will remove the object files and the final `os-image`.

---

## 📁 File Structure

```
myos/
├── boot.asm       # Bootloader written in NASM x86 Assembly
├── kernel.c       # C kernel that runs after boot
├── link.ld        # Linker script for kernel layout
├── Makefile       # Build automation
└── os-image       # Final bootable binary (created after make)
```

---

## 📚 Resources for Learning

- [OSDev Wiki](https://wiki.osdev.org)
- [Writing a Simple Operating System](https://www.cs.bham.ac.uk/~exr/lectures/opsys/10_11/lectures/os-dev.pdf)
- [James Molloy's Kernel Development Tutorials](https://github.com/cfenollosa/os-tutorial)

---

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

---

## 🙋‍♂️ Author

**Colin Harrell**  
[GitHub Profile](https://github.com/colinHarrell)  
[LinkedIn](https://www.linkedin.com/in/colin-harrell-22999b31b/)
