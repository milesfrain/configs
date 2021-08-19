#!/usr/bin/env python3

import sys

num = int(sys.argv[1])
print(num)
print(hex(num))
print(bin(num))

bits = []

i = 0;
while num:
    if num % 2 == 1:
        bits.append(i)
    num //= 2
    i += 1

bits.reverse()
print(bits)
