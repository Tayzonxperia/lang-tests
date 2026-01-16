#!/bin/bash

FILENAME="test"

CFLAGS="-Os -fno-asynchronous-unwind-tables -fno-stack-protector \
-fno-ident -ffunction-sections -fdata-sections -flto"
CXXFLAGS="-Os -fno-asynchronous-unwind-tables -fno-stack-protector \
-fno-ident -ffunction-sections -fdata-sections -flto -fno-rtti -fno-exceptions"
LDFLAGS="-Wl,--gc-sections"
GOFLAGS="-ldflags=-s -w"
NIMFLAGS="-d:release -d:lto -d:strip --threads:off --opt:size -x:off --panics:on"
RUSTFLAGS=(
    -C opt-level=z 
    -C strip=symbols 
    -C panic=abort 
    -C codegen-units=1
    -C lto=yes 
    -C link-arg="-Wl,--gc-sections,-s,-w")
ZIGFLAGS="-O ReleaseSmall -dynamic -fstrip -fsingle-threaded -fno-stack-protector"


run_asm() {
    local TIME_1=$(time nasm -f elf64 $FILENAME$ext) 
    local TIME_2=$(ld -s $FILENAME.o -o $FILENAME)
}

run_c() {
    local TIME=$(time gcc $CFLAGS $FILENAME$ext -o $FILENAME)
}

run_cxx() {
    local TIME=$(time g++ $CXXFLAGS $FILENAME$ext -o $FILENAME)
}

run_go() {
    local TIME=$(time go build $GOFLAGS $FILENAME$ext)
}


run_nim() {
    local TIME=$(time nim c $NIMFLAGS --passC:"$CFLAGS" --passL:"$LDFLAGS" $FILENAME$ext)
}

run_rs() {
    local TIME=$(time rustc "${RUSTFLAGS[@]}" $FILENAME$ext)
}

run_zig() {
    local TIME=$(time zig build-exe $ZIGFLAGS $FILENAME$ext)
}

main() {
echo """Choose language to test:
--------------------------------
1. asm (ASM)
2. c (C)
3. cxx (C++)
4. go (Go)
5. nim (Nim)
6. rs (Rust)
7. zig (Zig)
--------------------------------"""
echo "\n"

read -p "<Input> " INPUT

case $INPUT in

    "1")
    ext=".asm"
    run_asm
    ;;

    "2")
    ext=".c"
    run_c
    ;;
    
    "3")
    ext=".cxx"
    run_cxx
    ;;

    "4")
    ext=".go"
    run_go
    ;;

    "5")
    ext=".nim"
    run_nim
    ;;

    "6")
    ext=".rs"
    run_rs
    ;;

    "7")
    ext=".zig"
    run_zig
    ;;

    *)
    echo "No matched language, aborting"
    exit 0

esac

echo "Stripping file..."; [ -f $FILENAME ]  && sstrip -z $FILENAME
echo ""
}

main