L0: # Randomly initialize GPR
    lui         x0, 0x5F14E
    addi        x0, x0, 0x479
    lui         x1, 0xC45DE
    addi        x1, x1, 0xFFFFFA5A
    lui         x2, 0xF74E4
    addi        x2, x2, 0xFFFFF962
    lui         x3, 0xB75B2
    addi        x3, x3, 0xDC
    lui         x4, 0xD1AA3
    addi        x4, x4, 0x286
    lui         x5, 0x6124A
    addi        x5, x5, 0x6BA
    lui         x6, 0xB4E8D
    addi        x6, x6, 0xFFFFF862
    lui         x7, 0xACA74
    addi        x7, x7, 0xFFFFFCA6
    lui         x8, 0xE1CC
    addi        x8, x8, 0x53D
    lui         x9, 0x13B7E
    addi        x9, x9, 0xFFFFFEAC
    lui         x10, 0x33E2D
    addi        x10, x10, 0x763
    lui         x11, 0x2A6A5
    addi        x11, x11, 0xFFFFFFB5
    lui         x12, 0x97B99
    addi        x12, x12, 0x1E5
    lui         x13, 0x18244
    addi        x13, x13, 0x523
    lui         x14, 0xADEDA
    addi        x14, x14, 0x3A
    lui         x15, 0xF9259
    addi        x15, x15, 0x2F7
    lui         x16, 0xD9BD8
    addi        x16, x16, 0xFFFFFC06
    lui         x17, 0xAABE5
    addi        x17, x17, 0xFFFFFE16
    lui         x18, 0xA9D3C
    addi        x18, x18, 0xFFFFFF71
    lui         x19, 0x7D86A
    addi        x19, x19, 0xFFFFF87E
    lui         x20, 0xDAAB8
    addi        x20, x20, 0xFFFFFA4C
    lui         x21, 0xBB4CE
    addi        x21, x21, 0xFFFFFDBD
    lui         x22, 0x3EB2C
    addi        x22, x22, 0xFFFFF9EC
    lui         x23, 0x6E0D1
    addi        x23, x23, 0xFFFFFE11
    lui         x24, 0x2261D
    addi        x24, x24, 0xFFFFF93C
    lui         x25, 0xD2CB4
    addi        x25, x25, 0xFFFFFDB7
    lui         x26, 0xCCCB4
    addi        x26, x26, 0x440
    lui         x27, 0x46216
    addi        x27, x27, 0x1A5
    lui         x28, 0x63EFD
    addi        x28, x28, 0xFFFFFC71
    lui         x29, 0x9F276
    addi        x29, x29, 0xFFFFFE69
    lui         x30, 0x39206
    addi        x30, x30, 0xFFFFFF7F
    lui         x31, 0x20BD8
    addi        x31, x31, 0xFFFFFDAD
L1: # Test 0-0: add
    add         x11, x7, x7
    lui         x27, 0x594E8
    addi        x27, x27, 0xFFFFF94C
L2: # Test 0-1: add
    add         x7, x25, x4
    lui         x16, 0xA4757
    addi        x16, x16, 0x3D
L3: # Test 0-2: add
    add         x20, x12, x11
    lui         x11, 0xF1081
    addi        x11, x11, 0xFFFFFB31
L4: # Test 0-3: add
    add         x19, x22, x21
    lui         x3, 0xF9FF9
    addi        x3, x3, 0x7A9
L5: # Test 0-4: add
    add         x15, x11, x25
    lui         x9, 0xC3D35
    addi        x9, x9, 0xFFFFF8E8
L6: # Test 0-5: add
    add         x0, x11, x2
    lui         x13, 0x0
    addi        x13, x13, 0x0
L7: # Test 0-6: add
    add         x0, x2, x27
    lui         x5, 0x0
    addi        x5, x5, 0x0
L8: # Test 0-7: add
    add         x27, x10, x25
    lui         x5, 0x6AE1
    addi        x5, x5, 0x51A
L9: # Test 0-8: add
    add         x27, x10, x18
    lui         x13, 0xDDB69
    addi        x13, x13, 0x6D4
L10: # Test 0-9: add
    add         x9, x15, x9
    lui         x29, 0x87A69
    addi        x29, x29, 0x1D0
L11: # Test 1-0: sub
    sub         x21, x27, x31
    lui         x26, 0xBCF92
    addi        x26, x26, 0xFFFFF927
L12: # Test 1-1: sub
    sub         x0, x25, x24
    lui         x11, 0x0
    addi        x11, x11, 0x0
L13: # Test 1-2: sub
    sub         x6, x21, x18
    lui         x10, 0x13256
    addi        x10, x10, 0xFFFFF9B6
L14: # Test 1-3: sub
    sub         x20, x22, x1
    lui         x3, 0x7A54E
    addi        x3, x3, 0xFFFFFF92
L15: # Test 1-4: sub
    sub         x30, x30, x31
    lui         x5, 0x1862E
    addi        x5, x5, 0x1D2
L16: # Test 1-5: sub
    sub         x20, x29, x11
    lui         x17, 0x87A69
    addi        x17, x17, 0x1D0
L17: # Test 1-6: sub
    sub         x20, x1, x10
    lui         x12, 0xB1388
    addi        x12, x12, 0xA4
L18: # Test 1-7: sub
    sub         x5, x11, x13
    lui         x2, 0x22497
    addi        x2, x2, 0xFFFFF92C
L19: # Test 1-8: sub
    sub         x29, x17, x27
    lui         x9, 0xA9F00
    addi        x9, x9, 0xFFFFFAFC
L20: # Test 1-9: sub
    sub         x29, x10, x25
    lui         x28, 0x405A2
    addi        x28, x28, 0xFFFFFBFF
L21: # Test 2-0: sll
    sll         x25, x15, x22
    lui         x16, 0x348E8
    addi        x16, x16, 0x0
L22: # Test 2-1: sll
    sll         x2, x2, x13
    lui         x18, 0x92C00
    addi        x18, x18, 0x0
L23: # Test 2-2: sll
    sll         x11, x0, x5
    lui         x12, 0x0
    addi        x12, x12, 0x0
L24: # Test 2-3: sll
    sll         x19, x7, x21
    lui         x27, 0x3AB82
    addi        x27, x27, 0xFFFFFE80
L25: # Test 2-4: sll
    sll         x18, x31, x31
    lui         x11, 0xAFB5A
    addi        x11, x11, 0x0
L26: # Test 2-5: sll
    sll         x15, x23, x11
    lui         x7, 0x6E0D1
    addi        x7, x7, 0xFFFFFE11
L27: # Test 2-6: sll
    sll         x15, x22, x21
    lui         x13, 0x595CF
    addi        x13, x13, 0x600
L28: # Test 2-7: sll
    sll         x23, x28, x22
    lui         x24, 0xA1BFF
    addi        x24, x24, 0x0
L29: # Test 2-8: sll
    sll         x28, x31, x22
    lui         x13, 0xD7DAD
    addi        x13, x13, 0x0
L30: # Test 2-9: sll
    sll         x2, x12, x26
    lui         x25, 0x0
    addi        x25, x25, 0x0
L31: # Test 3-0: srl
    srl         x10, x11, x1
    lui         x8, 0x0
    addi        x8, x8, 0x2B
L32: # Test 3-1: srl
    srl         x12, x10, x4
    lui         x18, 0x0
    addi        x18, x18, 0x0
L33: # Test 3-2: srl
    srl         x21, x15, x21
    lui         x6, 0xB2C
    addi        x6, x6, 0xFFFFF9EC
L34: # Test 3-3: srl
    srl         x17, x30, x17
    lui         x15, 0x2
    addi        x15, x15, 0xFFFFF862
L35: # Test 3-4: srl
    srl         x30, x25, x14
    lui         x8, 0x0
    addi        x8, x8, 0x0
L36: # Test 3-5: srl
    srl         x24, x16, x14
    lui         x3, 0x0
    addi        x3, x3, 0xD
L37: # Test 3-6: srl
    srl         x11, x17, x1
    lui         x15, 0x0
    addi        x15, x15, 0x0
L38: # Test 3-7: srl
    srl         x13, x16, x16
    lui         x10, 0x348E8
    addi        x10, x10, 0x0
L39: # Test 3-8: srl
    srl         x2, x2, x16
    lui         x15, 0x0
    addi        x15, x15, 0x0
L40: # Test 3-9: srl
    srl         x5, x3, x28
    lui         x22, 0x0
    addi        x22, x22, 0xD
L41: # Test 4-0: sra
    sra         x28, x27, x7
    lui         x7, 0x2
    addi        x7, x7, 0xFFFFFD5C
L42: # Test 4-1: sra
    sra         x23, x20, x7
    lui         x9, 0x0
    addi        x9, x9, 0xFFFFFFFB
L43: # Test 4-2: sra
    sra         x15, x4, x11
    lui         x3, 0xD1AA3
    addi        x3, x3, 0x286
L44: # Test 4-3: sra
    sra         x25, x22, x24
    lui         x14, 0x0
    addi        x14, x14, 0x0
L45: # Test 4-4: sra
    sra         x17, x5, x9
    lui         x14, 0x0
    addi        x14, x14, 0x0
L46: # Test 4-5: sra
    sra         x7, x4, x15
    lui         x24, 0xFF46B
    addi        x24, x24, 0xFFFFF8CA
L47: # Test 4-6: sra
    sra         x5, x20, x5
    lui         x12, 0xFFFD9
    addi        x12, x12, 0xFFFFF9C4
L48: # Test 4-7: sra
    sra         x1, x9, x11
    lui         x21, 0x0
    addi        x21, x21, 0xFFFFFFFB
L49: # Test 4-8: sra
    sra         x21, x20, x22
    lui         x19, 0xFFFD9
    addi        x19, x19, 0xFFFFF9C4
L50: # Test 4-9: sra
    sra         x31, x29, x30
    lui         x4, 0x405A2
    addi        x4, x4, 0xFFFFFBFF
L51: # Test 5-0: slt
    slt         x20, x13, x30
    lui         x14, 0x0
    addi        x14, x14, 0x0
L52: # Test 5-1: slt
    slt         x8, x21, x7
    lui         x11, 0x0
    addi        x11, x11, 0x0
L53: # Test 5-2: slt
    slt         x13, x25, x6
    lui         x9, 0x0
    addi        x9, x9, 0x1
L54: # Test 5-3: slt
    slt         x11, x20, x18
    lui         x16, 0x0
    addi        x16, x16, 0x0
L55: # Test 5-4: slt
    slt         x15, x23, x10
    lui         x9, 0x0
    addi        x9, x9, 0x1
L56: # Test 5-5: slt
    slt         x23, x23, x29
    lui         x8, 0x0
    addi        x8, x8, 0x1
L57: # Test 5-6: slt
    slt         x12, x15, x16
    lui         x21, 0x0
    addi        x21, x21, 0x0
L58: # Test 5-7: slt
    slt         x5, x11, x18
    lui         x20, 0x0
    addi        x20, x20, 0x0
L59: # Test 5-8: slt
    slt         x13, x30, x0
    lui         x16, 0x0
    addi        x16, x16, 0x0
L60: # Test 5-9: slt
    slt         x25, x12, x23
    lui         x2, 0x0
    addi        x2, x2, 0x1
L61: # Test 6-0: sltu
    sltu        x13, x14, x19
    lui         x14, 0x0
    addi        x14, x14, 0x1
L62: # Test 6-1: sltu
    sltu        x21, x4, x22
    lui         x30, 0x0
    addi        x30, x30, 0x0
L63: # Test 6-2: sltu
    sltu        x2, x14, x2
    lui         x20, 0x0
    addi        x20, x20, 0x0
L64: # Test 6-3: sltu
    sltu        x24, x9, x8
    lui         x6, 0x0
    addi        x6, x6, 0x0
L65: # Test 6-4: sltu
    sltu        x28, x7, x10
    lui         x24, 0x0
    addi        x24, x24, 0x0
L66: # Test 6-5: sltu
    sltu        x25, x17, x29
    lui         x10, 0x0
    addi        x10, x10, 0x1
L67: # Test 6-6: sltu
    sltu        x29, x10, x9
    lui         x17, 0x0
    addi        x17, x17, 0x0
L68: # Test 6-7: sltu
    sltu        x13, x15, x16
    lui         x25, 0x0
    addi        x25, x25, 0x0
L69: # Test 6-8: sltu
    sltu        x20, x29, x3
    lui         x1, 0x0
    addi        x1, x1, 0x1
L70: # Test 6-9: sltu
    sltu        x10, x31, x1
    lui         x4, 0x0
    addi        x4, x4, 0x0
L71: # Test 7-0: and
    and         x4, x7, x20
    lui         x31, 0x0
    addi        x31, x31, 0x0
L72: # Test 7-1: and
    and         x12, x10, x24
    lui         x13, 0x0
    addi        x13, x13, 0x0
L73: # Test 7-2: and
    and         x2, x21, x27
    lui         x19, 0x0
    addi        x19, x19, 0x0
L74: # Test 7-3: and
    and         x7, x29, x18
    lui         x19, 0x0
    addi        x19, x19, 0x0
L75: # Test 7-4: and
    and         x11, x30, x18
    lui         x14, 0x0
    addi        x14, x14, 0x0
L76: # Test 7-5: and
    and         x2, x18, x1
    lui         x19, 0x0
    addi        x19, x19, 0x0
L77: # Test 7-6: and
    and         x3, x2, x8
    lui         x24, 0x0
    addi        x24, x24, 0x0
L78: # Test 7-7: and
    and         x5, x29, x12
    lui         x9, 0x0
    addi        x9, x9, 0x0
L79: # Test 7-8: and
    and         x22, x7, x0
    lui         x4, 0x0
    addi        x4, x4, 0x0
L80: # Test 7-9: and
    and         x21, x10, x1
    lui         x26, 0x0
    addi        x26, x26, 0x0
L81: # Test 8-0: or
    or          x14, x1, x5
    lui         x18, 0x0
    addi        x18, x18, 0x1
L82: # Test 8-1: or
    or          x6, x21, x14
    lui         x28, 0x0
    addi        x28, x28, 0x1
L83: # Test 8-2: or
    or          x21, x13, x4
    lui         x31, 0x0
    addi        x31, x31, 0x0
L84: # Test 8-3: or
    or          x0, x15, x11
    lui         x15, 0x0
    addi        x15, x15, 0x0
L85: # Test 8-4: or
    or          x27, x4, x22
    lui         x6, 0x0
    addi        x6, x6, 0x0
L86: # Test 8-5: or
    or          x11, x18, x24
    lui         x23, 0x0
    addi        x23, x23, 0x1
L87: # Test 8-6: or
    or          x6, x7, x19
    lui         x19, 0x0
    addi        x19, x19, 0x0
L88: # Test 8-7: or
    or          x10, x20, x29
    lui         x8, 0x0
    addi        x8, x8, 0x1
L89: # Test 8-8: or
    or          x16, x9, x25
    lui         x21, 0x0
    addi        x21, x21, 0x0
L90: # Test 8-9: or
    or          x27, x3, x6
    lui         x14, 0x0
    addi        x14, x14, 0x0
L91: # Test 9-0: xor
    xor         x16, x20, x7
    lui         x12, 0x0
    addi        x12, x12, 0x1
L92: # Test 9-1: xor
    xor         x27, x9, x19
    lui         x17, 0x0
    addi        x17, x17, 0x0
L93: # Test 9-2: xor
    xor         x8, x8, x10
    lui         x17, 0x0
    addi        x17, x17, 0x0
L94: # Test 9-3: xor
    xor         x9, x2, x4
    lui         x7, 0x0
    addi        x7, x7, 0x0
L95: # Test 9-4: xor
    xor         x3, x21, x8
    lui         x22, 0x0
    addi        x22, x22, 0x0
L96: # Test 9-5: xor
    xor         x26, x1, x11
    lui         x7, 0x0
    addi        x7, x7, 0x0
L97: # Test 9-6: xor
    xor         x29, x22, x22
    lui         x7, 0x0
    addi        x7, x7, 0x0
L98: # Test 9-7: xor
    xor         x9, x23, x1
    lui         x17, 0x0
    addi        x17, x17, 0x0
L99: # Test 9-8: xor
    xor         x4, x18, x0
    lui         x28, 0x0
    addi        x28, x28, 0x1
L100: # Test 9-9: xor
    xor         x4, x21, x8
    lui         x24, 0x0
    addi        x24, x24, 0x0
L101: # Test 10-0: addi
    addi        x21, x15, 0xFFFFFF7B
    lui         x6, 0x0
    addi        x6, x6, 0xFFFFFF7B
L102: # Test 10-1: addi
    addi        x26, x27, 0xFFFFFA7A
    lui         x16, 0x0
    addi        x16, x16, 0xFFFFFA7A
L103: # Test 10-2: addi
    addi        x0, x5, 0x156
    lui         x9, 0x0
    addi        x9, x9, 0x0
L104: # Test 10-3: addi
    addi        x13, x2, 0xFFFFFE34
    lui         x4, 0x0
    addi        x4, x4, 0xFFFFFE34
L105: # Test 10-4: addi
    addi        x29, x0, 0x45E
    lui         x22, 0x0
    addi        x22, x22, 0x45E
L106: # Test 10-5: addi
    addi        x31, x8, 0xFFFFF870
    lui         x18, 0x0
    addi        x18, x18, 0xFFFFF870
L107: # Test 10-6: addi
    addi        x7, x21, 0x4DB
    lui         x31, 0x0
    addi        x31, x31, 0x456
L108: # Test 10-7: addi
    addi        x15, x7, 0x55B
    lui         x1, 0x1
    addi        x1, x1, 0xFFFFF9B1
L109: # Test 10-8: addi
    addi        x19, x30, 0xFFFFFFA4
    lui         x18, 0x0
    addi        x18, x18, 0xFFFFFFA4
L110: # Test 10-9: addi
    addi        x3, x29, 0xFFFFFAD2
    lui         x24, 0x0
    addi        x24, x24, 0xFFFFFF30
L111: # Test 11-0: slli
    slli        x20, x2, 0xF
    lui         x29, 0x0
    addi        x29, x29, 0x0
L112: # Test 11-1: slli
    slli        x16, x5, 0x9
    lui         x19, 0x0
    addi        x19, x19, 0x0
L113: # Test 11-2: slli
    slli        x6, x1, 0x11
    lui         x19, 0x13620
    addi        x19, x19, 0x0
L114: # Test 11-3: slli
    slli        x11, x5, 0x0
    lui         x26, 0x0
    addi        x26, x26, 0x0
L115: # Test 11-4: slli
    slli        x18, x18, 0x7
    lui         x31, 0xFFFFD
    addi        x31, x31, 0x200
L116: # Test 11-5: slli
    slli        x7, x4, 0x6
    lui         x23, 0xFFFF9
    addi        x23, x23, 0xFFFFFD00
L117: # Test 11-6: slli
    slli        x16, x9, 0xC
    lui         x30, 0x0
    addi        x30, x30, 0x0
L118: # Test 11-7: slli
    slli        x4, x23, 0x4
    lui         x9, 0xFFF8D
    addi        x9, x9, 0x0
L119: # Test 11-8: slli
    slli        x31, x20, 0x1C
    lui         x17, 0x0
    addi        x17, x17, 0x0
L120: # Test 11-9: slli
    slli        x5, x18, 0xE
    lui         x4, 0xF4800
    addi        x4, x4, 0x0
L121: # Test 12-0: srli
    srli        x8, x24, 0x1B
    lui         x21, 0x0
    addi        x21, x21, 0x1F
L122: # Test 12-1: srli
    srli        x29, x0, 0x9
    lui         x12, 0x0
    addi        x12, x12, 0x0
L123: # Test 12-2: srli
    srli        x26, x30, 0x1D
    lui         x22, 0x0
    addi        x22, x22, 0x0
L124: # Test 12-3: srli
    srli        x24, x2, 0x2
    lui         x2, 0x0
    addi        x2, x2, 0x0
L125: # Test 12-4: srli
    srli        x13, x30, 0x2
    lui         x17, 0x0
    addi        x17, x17, 0x0
L126: # Test 12-5: srli
    srli        x6, x15, 0xC
    lui         x20, 0x0
    addi        x20, x20, 0x0
L127: # Test 12-6: srli
    srli        x6, x6, 0x1B
    lui         x27, 0x0
    addi        x27, x27, 0x0
L128: # Test 12-7: srli
    srli        x30, x18, 0x1E
    lui         x2, 0x0
    addi        x2, x2, 0x3
L129: # Test 12-8: srli
    srli        x3, x26, 0x7
    lui         x17, 0x0
    addi        x17, x17, 0x0
L130: # Test 12-9: srli
    srli        x17, x5, 0x5
    lui         x20, 0x7A40
    addi        x20, x20, 0x0
L131: # Test 13-0: srai
    srai        x14, x30, 0x13
    lui         x12, 0x0
    addi        x12, x12, 0x0
L132: # Test 13-1: srai
    srai        x16, x20, 0xE
    lui         x19, 0x2
    addi        x19, x19, 0xFFFFFE90
L133: # Test 13-2: srai
    srai        x29, x28, 0x1F
    lui         x18, 0x0
    addi        x18, x18, 0x0
L134: # Test 13-3: srai
    srai        x18, x28, 0x1F
    lui         x2, 0x0
    addi        x2, x2, 0x0
L135: # Test 13-4: srai
    srai        x20, x27, 0x1C
    lui         x23, 0x0
    addi        x23, x23, 0x0
L136: # Test 13-5: srai
    srai        x2, x24, 0x15
    lui         x18, 0x0
    addi        x18, x18, 0x0
L137: # Test 13-6: srai
    srai        x24, x18, 0x0
    lui         x30, 0x0
    addi        x30, x30, 0x0
L138: # Test 13-7: srai
    srai        x30, x25, 0x0
    lui         x16, 0x0
    addi        x16, x16, 0x0
L139: # Test 13-8: srai
    srai        x9, x5, 0xC
    lui         x24, 0xFFFF5
    addi        x24, x24, 0xFFFFF800
L140: # Test 13-9: srai
    srai        x9, x27, 0x1F
    lui         x4, 0x0
    addi        x4, x4, 0x0
L141: # Test 14-0: slti
    slti        x9, x14, 0x677
    lui         x24, 0x0
    addi        x24, x24, 0x1
L142: # Test 14-1: slti
    slti        x22, x29, 0xFFFFFD63
    lui         x2, 0x0
    addi        x2, x2, 0x0
L143: # Test 14-2: slti
    slti        x21, x15, 0xFFFFF874
    lui         x17, 0x0
    addi        x17, x17, 0x0
L144: # Test 14-3: slti
    slti        x11, x19, 0x7ED
    lui         x23, 0x0
    addi        x23, x23, 0x0
L145: # Test 14-4: slti
    slti        x11, x6, 0xFFFFFB64
    lui         x28, 0x0
    addi        x28, x28, 0x0
L146: # Test 14-5: slti
    slti        x13, x5, 0x5DA
    lui         x14, 0x0
    addi        x14, x14, 0x1
L147: # Test 14-6: slti
    slti        x2, x29, 0x62F
    lui         x13, 0x0
    addi        x13, x13, 0x1
L148: # Test 14-7: slti
    slti        x9, x6, 0xFFFFFE29
    lui         x26, 0x0
    addi        x26, x26, 0x0
L149: # Test 14-8: slti
    slti        x20, x29, 0x1B5
    lui         x22, 0x0
    addi        x22, x22, 0x1
L150: # Test 14-9: slti
    slti        x17, x21, 0xFFFFFBE3
    lui         x12, 0x0
    addi        x12, x12, 0x0
L151: # Test 15-0: sltiu
    sltiu       x9, x15, 0x37B
    lui         x31, 0x0
    addi        x31, x31, 0x0
L152: # Test 15-1: sltiu
    sltiu       x11, x30, 0xFFFFF836
    lui         x13, 0x0
    addi        x13, x13, 0x1
L153: # Test 15-2: sltiu
    sltiu       x6, x7, 0x341
    lui         x26, 0x0
    addi        x26, x26, 0x0
L154: # Test 15-3: sltiu
    sltiu       x11, x7, 0x531
    lui         x6, 0x0
    addi        x6, x6, 0x0
L155: # Test 15-4: sltiu
    sltiu       x11, x3, 0x5F8
    lui         x25, 0x0
    addi        x25, x25, 0x1
L156: # Test 15-5: sltiu
    sltiu       x28, x16, 0xFFFFF9D2
    lui         x3, 0x0
    addi        x3, x3, 0x1
L157: # Test 15-6: sltiu
    sltiu       x9, x23, 0x79
    lui         x7, 0x0
    addi        x7, x7, 0x1
L158: # Test 15-7: sltiu
    sltiu       x19, x9, 0xFFFFFF57
    lui         x29, 0x0
    addi        x29, x29, 0x1
L159: # Test 15-8: sltiu
    sltiu       x26, x4, 0x6B7
    lui         x11, 0x0
    addi        x11, x11, 0x1
L160: # Test 15-9: sltiu
    sltiu       x21, x24, 0x31E
    lui         x28, 0x0
    addi        x28, x28, 0x1
L161: # Test 16-0: andi
    andi        x7, x5, 0x17F
    lui         x9, 0x0
    addi        x9, x9, 0x0
L162: # Test 16-1: andi
    andi        x27, x1, 0x42C
    lui         x30, 0x0
    addi        x30, x30, 0x20
L163: # Test 16-2: andi
    andi        x20, x14, 0x7F2
    lui         x29, 0x0
    addi        x29, x29, 0x0
L164: # Test 16-3: andi
    andi        x10, x18, 0x340
    lui         x23, 0x0
    addi        x23, x23, 0x0
L165: # Test 16-4: andi
    andi        x16, x10, 0xFFFFFFDB
    lui         x31, 0x0
    addi        x31, x31, 0x0
L166: # Test 16-5: andi
    andi        x22, x15, 0x463
    lui         x23, 0x0
    addi        x23, x23, 0x21
L167: # Test 16-6: andi
    andi        x19, x15, 0xFFFFFB82
    lui         x23, 0x1
    addi        x23, x23, 0xFFFFF980
L168: # Test 16-7: andi
    andi        x30, x17, 0x7FE
    lui         x25, 0x0
    addi        x25, x25, 0x0
L169: # Test 16-8: andi
    andi        x30, x7, 0xFFFFFC17
    lui         x15, 0x0
    addi        x15, x15, 0x0
L170: # Test 16-9: andi
    andi        x22, x30, 0xFFFFFE1B
    lui         x5, 0x0
    addi        x5, x5, 0x0
L171: # Test 17-0: ori
    ori         x14, x17, 0xFFFFFDB1
    lui         x4, 0x0
    addi        x4, x4, 0xFFFFFDB1
L172: # Test 17-1: ori
    ori         x9, x20, 0x2F
    lui         x22, 0x0
    addi        x22, x22, 0x2F
L173: # Test 17-2: ori
    ori         x23, x5, 0x6EF
    lui         x3, 0x0
    addi        x3, x3, 0x6EF
L174: # Test 17-3: ori
    ori         x8, x19, 0xFFFFFB59
    lui         x28, 0x0
    addi        x28, x28, 0xFFFFFBD9
L175: # Test 17-4: ori
    ori         x8, x28, 0xFFFFFB03
    lui         x26, 0x0
    addi        x26, x26, 0xFFFFFBDB
L176: # Test 17-5: ori
    ori         x4, x23, 0xFFFFF9EA
    lui         x31, 0x0
    addi        x31, x31, 0xFFFFFFEF
L177: # Test 17-6: ori
    ori         x1, x16, 0xFFFFFDB2
    lui         x3, 0x0
    addi        x3, x3, 0xFFFFFDB2
L178: # Test 17-7: ori
    ori         x29, x26, 0xFFFFFB2E
    lui         x16, 0x0
    addi        x16, x16, 0xFFFFFBFF
L179: # Test 17-8: ori
    ori         x5, x13, 0x635
    lui         x19, 0x0
    addi        x19, x19, 0x635
L180: # Test 17-9: ori
    ori         x12, x22, 0xFFFFFE1F
    lui         x17, 0x0
    addi        x17, x17, 0xFFFFFE3F
FL0: # Fail label chain
L181: # Test 18-0: xori
    xori        x10, x22, 0xFFFFFB44
    lui         x21, 0x0
    addi        x21, x21, 0xFFFFFB6B
L182: # Test 18-1: xori
    xori        x21, x18, 0xFFFFFE8E
    lui         x10, 0x0
    addi        x10, x10, 0xFFFFFE8E
L183: # Test 18-2: xori
    xori        x24, x11, 0x601
    lui         x15, 0x0
    addi        x15, x15, 0x600
L184: # Test 18-3: xori
    xori        x16, x2, 0xFFFFF836
    lui         x2, 0x0
    addi        x2, x2, 0xFFFFF837
L185: # Test 18-4: xori
    xori        x26, x21, 0xFFFFFA07
    lui         x23, 0x0
    addi        x23, x23, 0x489
L186: # Test 18-5: xori
    xori        x20, x15, 0xFFFFFEC4
    lui         x21, 0x0
    addi        x21, x21, 0xFFFFF8C4
L187: # Test 18-6: xori
    xori        x24, x19, 0xFFFFFDD7
    lui         x23, 0x0
    addi        x23, x23, 0xFFFFFBE2
L188: # Test 18-7: xori
    xori        x31, x19, 0xFFFFFE60
    lui         x28, 0x0
    addi        x28, x28, 0xFFFFF855
L189: # Test 18-8: xori
    xori        x28, x23, 0xFFFFFBD2
    lui         x17, 0x0
    addi        x17, x17, 0x30
L190: # Test 18-9: xori
    xori        x11, x5, 0xFFFFFE9B
    lui         x22, 0x0
    addi        x22, x22, 0xFFFFF8AE
L191: # Test 19-0: lui
    lui         x19, 0xE12B5
    lui         x29, 0xE12B5
    addi        x29, x29, 0x0
L192: # Test 19-1: lui
    lui         x14, 0xD8456
    lui         x22, 0xD8456
    addi        x22, x22, 0x0
L193: # Test 19-2: lui
    lui         x13, 0xD67FC
    lui         x21, 0xD67FC
    addi        x21, x21, 0x0
L194: # Test 19-3: lui
    lui         x6, 0xA7A77
    lui         x29, 0xA7A77
    addi        x29, x29, 0x0
L195: # Test 19-4: lui
    lui         x0, 0x5E028
    lui         x21, 0x0
    addi        x21, x21, 0x0
L196: # Test 19-5: lui
    lui         x15, 0xA68D1
    lui         x27, 0xA68D1
    addi        x27, x27, 0x0
L197: # Test 19-6: lui
    lui         x2, 0xD2FEF
    lui         x23, 0xD2FEF
    addi        x23, x23, 0x0
L198: # Test 19-7: lui
    lui         x13, 0xA356
    lui         x20, 0xA356
    addi        x20, x20, 0x0
L199: # Test 19-8: lui
    lui         x13, 0xEFE96
    lui         x14, 0xEFE96
    addi        x14, x14, 0x0
L200: # Test 19-9: lui
    lui         x19, 0x736B5
    lui         x21, 0x736B5
    addi        x21, x21, 0x0
L201: # Test 20-0: auipc
    auipc       x16, 0x96A44
    lui         x24, 0x96E45
    addi        x24, x24, 0xA4
L202: # Test 20-1: auipc
    auipc       x7, 0xE445E
    lui         x25, 0xE485F
    addi        x25, x25, 0xB8
L203: # Test 20-2: auipc
    auipc       x3, 0x32BAE
    lui         x25, 0x32FAF
    addi        x25, x25, 0xCC
L204: # Test 20-3: auipc
    auipc       x30, 0xA8E2D
    lui         x25, 0xA922E
    addi        x25, x25, 0xE0
L205: # Test 20-4: auipc
    auipc       x15, 0x63704
    lui         x24, 0x63B05
    addi        x24, x24, 0xF4
L206: # Test 20-5: auipc
    auipc       x14, 0xC563F
    lui         x25, 0xC5A40
    addi        x25, x25, 0x108
L207: # Test 20-6: auipc
    auipc       x10, 0xDFDB3
    lui         x19, 0xE01B4
    addi        x19, x19, 0x11C
L208: # Test 20-7: auipc
    auipc       x8, 0x59B1
    lui         x26, 0x5DB2
    addi        x26, x26, 0x130
L209: # Test 20-8: auipc
    auipc       x2, 0xB5938
    lui         x19, 0xB5D39
    addi        x19, x19, 0x144
L210: # Test 20-9: auipc
    auipc       x11, 0x2676C
    lui         x31, 0x26B6D
    addi        x31, x31, 0x158
win: # Win label
    ebreak
