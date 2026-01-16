# Wakana's language testing results:
------------------------------------


This documents a comparative experiment measuring the **minimum achievable binary size** for multiple programming languages using a basic, simple `hello world` program.

The goal is **not performance**, feature completeness, or ergonomics.  
The goal is to answer a very specific question:

> *How small can a real, runnable Linux ELF executable be when written in different languages, once all reasonable size optimizations are applied?*

This is a study in **compiler philosophy**, **runtime overhead**, and **defaults**.

---

## Scope & Non-Goals

### What this *is*
- Size-focused benchmarking
- Real Linux ELF executables (Not just 'dud' bins) 
- Aggressive but realistic optimization :3
- Comparison of language *floors*, not averages

### What this *is not*
- A performance benchmark
- A test of language expressiveness
- A “which language is best” ranking
- A fair fight for large applications

Hello world is intentionally used because it **maximizes runtime and toolchain overhead relative to user code**. If a language is bloated, this exposes it immediately.

---

## Baseline

---

# ASM
- Size: 8.7kb
- File: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), statically linked, not stripped
- Time: 0.002s

# C
- Size: 15kb
- File: ELF 64-bit LSB pie executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, BuildID[sha1]=64063f10c432b94f955dff84677014f60f81f57c, for GNU/Linux 4.4.0, not stripped
- Time: 0.029s

# C++
- Size: 15kb
- File: ELF 64-bit LSB pie executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, BuildID[sha1]=d0e863ef3ae14a590ba3ebe269a73387dfb74b37, for GNU/Linux 4.4.0, not stripped
- Time: 0.279s

# Go
- Size: 2.2mb
- File: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), statically linked, BuildID[sha1]=e41f1d65741313a995e750ac35c5efb15b20e4ce, with debug_info, not stripped
- Time: 0.059s

# Nim
- Size: 100kb 
- File: ELF 64-bit LSB pie executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, BuildID[sha1]=18552650b9d06b8a011ba2545076978a122f8c28, for GNU/Linux 4.4.0, not stripped
- Time 0.257s

# Rust
- Size: 438kb
- File: ELF 64-bit LSB pie executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, for GNU/Linux 4.4.0, BuildID[sha1]=04a9a79e82837e810708976655ce6510907a007b, not stripped
- Time: 0.050s

# Zig
- Size: 7.0mb
- File: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), statically linked, with debug_info, not stripped
- Time: 0.313s

---

## Heavy optimization

---

# ASM
- Size: 8.0kb
- File: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), statically linked, no section header
- Time: 0.002s

# C
- Size: 12kb
- File: ELF 64-bit LSB pie executable, x86-64, version 1 (SYSV), BuildID[sha1]=2a9ea06105fe63f0df3b8a6c4718b3b54f630914, for GNU/Linux 4.4.0, dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, no section header
- Time: 0.051s

# C++
- Size: 12kb
- File: ELF 64-bit LSB pie executable, x86-64, version 1 (SYSV), BuildID[sha1]=6021b9965cc81bf3444d8e11e49e67a8767c650f, for GNU/Linux 4.4.0, dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, no section header
- Time: 0.309s

# Go
- Size: 1.4mb
- File: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), statically linked, too large section header offset 1499136
- Time: 0.093s

# Nim
- Size: 16kb
- File: ELF 64-bit LSB pie executable, x86-64, version 1 (SYSV), BuildID[sha1]=4628c33b9145f513de4eaaae59bf351feecc0d80, for GNU/Linux 4.4.0, dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, no section header
- Time: 0.509s

# Rust
- Size: 294kb
- File: ELF 64-bit LSB pie executable, x86-64, version 1 (SYSV), for GNU/Linux 4.4.0, BuildID[sha1]=2cd1c73ebb63447e16e9f7db6e7ce6ff857a94ab, dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, no section header
- Time: 6.133s

# Zig
- Size: 8.4kb
- File: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), statically linked, no section header
- Time: 1.688s

---

## Hardware this was made on:

NASM        =>      3.01 (2025-10-13)
GCC/G++     =>      15.2.1 (2025-11-12)
Binutils    =>      2.45.1
Go          =>      go1.25.6 
Nim         =>      2.0.8 (2024-09-08)
Rustc       =>      1.92.0 (2025-12-08)
Zig         =>      0.15.2

## Reproducibility

This repository includes:

Source files for each language

Build commands used

Result logs

Tool versions (where applicable)

Results should be reproducible on most Linux systems.

## License

This repository is provided for educational and research purposes.
No claims are made about suitability for production use.