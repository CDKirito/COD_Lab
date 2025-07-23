L0: # Randomly initialize GPR
    lui         x0, 0xF431C
    addi        x0, x0, 0xFFFFFA02
    lui         x1, 0xE1970
    addi        x1, x1, 0x5E0
    lui         x2, 0x169FC
    addi        x2, x2, 0x670
    lui         x3, 0x87FF0
    addi        x3, x3, 0x371
    lui         x4, 0x1176C
    addi        x4, x4, 0x1E5
    lui         x5, 0x44498
    addi        x5, x5, 0x780
    lui         x6, 0x6D5E2
    addi        x6, x6, 0xFFFFFDD4
    lui         x7, 0xB893E
    addi        x7, x7, 0xFFFFF8E5
    lui         x8, 0x4AF11
    addi        x8, x8, 0xFFFFFCD3
    lui         x9, 0x8759
    addi        x9, x9, 0x2A1
    lui         x10, 0x6E44F
    addi        x10, x10, 0x4D7
    lui         x11, 0x50FFC
    addi        x11, x11, 0x4A0
    lui         x12, 0xEFF9D
    addi        x12, x12, 0x77B
    lui         x13, 0x956A7
    addi        x13, x13, 0xFFFFF923
    lui         x14, 0x59909
    addi        x14, x14, 0x678
    lui         x15, 0xAAAC7
    addi        x15, x15, 0x752
    lui         x16, 0xC027
    addi        x16, x16, 0xFFFFFFAC
    lui         x17, 0x1FB1B
    addi        x17, x17, 0xFFFFFDD0
    lui         x18, 0x8365
    addi        x18, x18, 0x29F
    lui         x19, 0x62767
    addi        x19, x19, 0xE0
    lui         x20, 0x36526
    addi        x20, x20, 0xFFFFFF0C
    lui         x21, 0x608E8
    addi        x21, x21, 0xFFFFFB70
    lui         x22, 0xCC102
    addi        x22, x22, 0x388
    lui         x23, 0x6949D
    addi        x23, x23, 0x126
    lui         x24, 0xE3F07
    addi        x24, x24, 0xFFFFFF5E
    lui         x25, 0x6546F
    addi        x25, x25, 0x347
    lui         x26, 0x1F316
    addi        x26, x26, 0xFFFFF93E
    lui         x27, 0x57D18
    addi        x27, x27, 0xFFFFFBDB
    lui         x28, 0x37DB
    addi        x28, x28, 0x1C6
    lui         x29, 0x374CA
    addi        x29, x29, 0xFFFFF9E6
    lui         x30, 0xC2103
    addi        x30, x30, 0xFFFFFAC2
    lui         x31, 0xBD8CC
    addi        x31, x31, 0xFFFFFC37
L1: # Test 0-0: add
    add         x13, x4, x8
    lui         x8, 0x5C67D
    addi        x8, x8, 0xFFFFFEB8
L2: # Test 0-1: add
    add         x31, x4, x6
    lui         x2, 0x7ED4E
    addi        x2, x2, 0xFFFFFFB9
L3: # Test 0-2: add
    add         x30, x1, x11
    lui         x18, 0x3296D
    addi        x18, x18, 0xFFFFFA80
L4: # Test 0-3: add
    add         x4, x19, x15
    lui         x5, 0xD22F
    addi        x5, x5, 0xFFFFF832
L5: # Test 0-4: add
    add         x10, x11, x29
    lui         x23, 0x884C6
    addi        x23, x23, 0xFFFFFE86
L6: # Test 1-0: sub
    sub         x26, x20, x26
    lui         x5, 0x17210
    addi        x5, x5, 0x5CE
L7: # Test 1-1: sub
    sub         x18, x4, x21
    lui         x6, 0xAC947
    addi        x6, x6, 0xFFFFFCC2
L8: # Test 1-2: sub
    sub         x13, x4, x9
    lui         x23, 0x4AD5
    addi        x23, x23, 0x591
L9: # Test 1-3: sub
    sub         x31, x2, x16
    lui         x9, 0x72D27
    addi        x9, x9, 0xD
L10: # Test 1-4: sub
    sub         x29, x13, x17
    lui         x15, 0xE4FBA
    addi        x15, x15, 0x7C1
L11: # Test 2-0: sll
    sll         x20, x14, x28
    lui         x31, 0x6425A
    addi        x31, x31, 0xFFFFFE00
L12: # Test 2-1: sll
    sll         x0, x23, x7
    lui         x4, 0x0
    addi        x4, x4, 0x0
L13: # Test 2-2: sll
    sll         x14, x28, x24
    lui         x5, 0x80000
    addi        x5, x5, 0x0
L14: # Test 2-3: sll
    sll         x0, x10, x18
    lui         x5, 0x0
    addi        x5, x5, 0x0
L15: # Test 2-4: sll
    sll         x28, x24, x19
    lui         x20, 0xE3F07
    addi        x20, x20, 0xFFFFFF5E
L16: # Test 3-0: srl
    srl         x8, x19, x19
    lui         x13, 0x62767
    addi        x13, x13, 0xE0
L17: # Test 3-1: srl
    srl         x26, x30, x7
    lui         x20, 0x194B
    addi        x20, x20, 0x654
L18: # Test 3-2: srl
    srl         x16, x15, x24
    lui         x8, 0x0
    addi        x8, x8, 0x3
L19: # Test 3-3: srl
    srl         x18, x17, x2
    lui         x25, 0x0
    addi        x25, x25, 0xF
L20: # Test 3-4: srl
    srl         x12, x14, x27
    lui         x10, 0x0
    addi        x10, x10, 0x10
L21: # Test 4-0: sra
    sra         x16, x17, x17
    lui         x9, 0x2
    addi        x9, x9, 0xFFFFFFB1
L22: # Test 4-1: sra
    sra         x0, x15, x29
    lui         x7, 0x0
    addi        x7, x7, 0x0
L23: # Test 4-2: sra
    sra         x28, x21, x3
    lui         x13, 0x3
    addi        x13, x13, 0x47
L24: # Test 4-3: sra
    sra         x27, x31, x24
    lui         x6, 0x0
    addi        x6, x6, 0x1
L25: # Test 4-4: sra
    sra         x26, x14, x29
    lui         x21, 0xC0000
    addi        x21, x21, 0x0
L26: # Test 5-0: slt
    slt         x12, x9, x2
    lui         x11, 0x0
    addi        x11, x11, 0x1
L27: # Test 5-1: slt
    slt         x12, x28, x12
    lui         x10, 0x0
    addi        x10, x10, 0x0
L28: # Test 5-2: slt
    slt         x31, x11, x29
    lui         x18, 0x0
    addi        x18, x18, 0x0
L29: # Test 5-3: slt
    slt         x29, x11, x8
    lui         x15, 0x0
    addi        x15, x15, 0x1
L30: # Test 5-4: slt
    slt         x21, x23, x13
    lui         x8, 0x0
    addi        x8, x8, 0x0
L31: # Test 6-0: sltu
    sltu        x0, x13, x11
    lui         x7, 0x0
    addi        x7, x7, 0x0
L32: # Test 6-1: sltu
    sltu        x28, x25, x19
    lui         x13, 0x0
    addi        x13, x13, 0x1
L33: # Test 6-2: sltu
    sltu        x3, x2, x28
    lui         x16, 0x0
    addi        x16, x16, 0x0
L34: # Test 6-3: sltu
    sltu        x5, x2, x9
    lui         x7, 0x0
    addi        x7, x7, 0x0
L35: # Test 6-4: sltu
    sltu        x24, x5, x0
    lui         x17, 0x0
    addi        x17, x17, 0x0
L36: # Test 7-0: and
    and         x26, x19, x1
    lui         x4, 0x60160
    addi        x4, x4, 0xE0
L37: # Test 7-1: and
    and         x30, x31, x12
    lui         x15, 0x0
    addi        x15, x15, 0x0
L38: # Test 7-2: and
    and         x8, x21, x23
    lui         x21, 0x0
    addi        x21, x21, 0x0
L39: # Test 7-3: and
    and         x24, x20, x23
    lui         x16, 0x841
    addi        x16, x16, 0x410
L40: # Test 7-4: and
    and         x2, x25, x17
    lui         x4, 0x0
    addi        x4, x4, 0x0
L41: # Test 8-0: or
    or          x24, x22, x26
    lui         x27, 0xEC162
    addi        x27, x27, 0x3E8
L42: # Test 8-1: or
    or          x30, x24, x9
    lui         x29, 0xEC164
    addi        x29, x29, 0xFFFFFFF9
L43: # Test 8-2: or
    or          x22, x30, x29
    lui         x26, 0xEC164
    addi        x26, x26, 0xFFFFFFF9
L44: # Test 8-3: or
    or          x28, x8, x18
    lui         x7, 0x0
    addi        x7, x7, 0x0
L45: # Test 8-4: or
    or          x31, x31, x20
    lui         x7, 0x194B
    addi        x7, x7, 0x654
L46: # Test 9-0: xor
    xor         x27, x30, x12
    lui         x28, 0xEC164
    addi        x28, x28, 0xFFFFFFF9
L47: # Test 9-1: xor
    xor         x11, x13, x0
    lui         x22, 0x0
    addi        x22, x22, 0x1
L48: # Test 9-2: xor
    xor         x12, x28, x6
    lui         x10, 0xEC164
    addi        x10, x10, 0xFFFFFFF8
L49: # Test 9-3: xor
    xor         x0, x24, x0
    lui         x26, 0x0
    addi        x26, x26, 0x0
L50: # Test 9-4: xor
    xor         x29, x1, x9
    lui         x24, 0xE1972
    addi        x24, x24, 0xFFFFFA51
L51: # Test 10-0: addi
    addi        x0, x23, 0xFFFFFD35
    lui         x15, 0x0
    addi        x15, x15, 0x0
L52: # Test 10-1: addi
    addi        x12, x2, 0xFFFFFE1B
    lui         x15, 0x0
    addi        x15, x15, 0xFFFFFE1B
L53: # Test 10-2: addi
    addi        x24, x31, 0x425
    lui         x31, 0x194C
    addi        x31, x31, 0xFFFFFA79
L54: # Test 10-3: addi
    addi        x31, x12, 0xFFFFFFCB
    lui         x15, 0x0
    addi        x15, x15, 0xFFFFFDE6
L55: # Test 10-4: addi
    addi        x14, x13, 0x616
    lui         x15, 0x0
    addi        x15, x15, 0x617
L56: # Test 11-0: slli
    slli        x2, x20, 0xE
    lui         x13, 0x2D950
    addi        x13, x13, 0x0
L57: # Test 11-1: slli
    slli        x7, x10, 0x4
    lui         x17, 0xC1640
    addi        x17, x17, 0xFFFFFF80
L58: # Test 11-2: slli
    slli        x30, x6, 0x2
    lui         x2, 0x0
    addi        x2, x2, 0x4
L59: # Test 11-3: slli
    slli        x19, x8, 0x1D
    lui         x22, 0x0
    addi        x22, x22, 0x0
L60: # Test 11-4: slli
    slli        x29, x18, 0x10
    lui         x28, 0x0
    addi        x28, x28, 0x0
L61: # Test 12-0: srli
    srli        x19, x2, 0x17
    lui         x25, 0x0
    addi        x25, x25, 0x0
L62: # Test 12-1: srli
    srli        x7, x28, 0xE
    lui         x30, 0x0
    addi        x30, x30, 0x0
L63: # Test 12-2: srli
    srli        x4, x6, 0x17
    lui         x23, 0x0
    addi        x23, x23, 0x0
L64: # Test 12-3: srli
    srli        x8, x2, 0xB
    lui         x13, 0x0
    addi        x13, x13, 0x0
L65: # Test 12-4: srli
    srli        x0, x30, 0x11
    lui         x14, 0x0
    addi        x14, x14, 0x0
L66: # Test 13-0: srai
    srai        x29, x25, 0x19
    lui         x6, 0x0
    addi        x6, x6, 0x0
L67: # Test 13-1: srai
    srai        x25, x11, 0x1A
    lui         x27, 0x0
    addi        x27, x27, 0x0
L68: # Test 13-2: srai
    srai        x31, x4, 0x11
    lui         x26, 0x0
    addi        x26, x26, 0x0
L69: # Test 13-3: srai
    srai        x19, x21, 0xE
    lui         x21, 0x0
    addi        x21, x21, 0x0
L70: # Test 13-4: srai
    srai        x26, x31, 0x16
    lui         x28, 0x0
    addi        x28, x28, 0x0
L71: # Test 14-0: slti
    slti        x23, x27, 0x1BF
    lui         x21, 0x0
    addi        x21, x21, 0x1
L72: # Test 14-1: slti
    slti        x1, x9, 0x70F
    lui         x9, 0x0
    addi        x9, x9, 0x0
L73: # Test 14-2: slti
    slti        x22, x23, 0xFFFFFC7B
    lui         x28, 0x0
    addi        x28, x28, 0x0
L74: # Test 14-3: slti
    slti        x21, x24, 0xFFFFFC56
    lui         x8, 0x0
    addi        x8, x8, 0x0
L75: # Test 14-4: slti
    slti        x6, x19, 0x19B
    lui         x5, 0x0
    addi        x5, x5, 0x1
L76: # Test 15-0: sltiu
    sltiu       x31, x23, 0xFFFFFA95
    lui         x2, 0x0
    addi        x2, x2, 0x1
L77: # Test 15-1: sltiu
    sltiu       x20, x28, 0x203
    lui         x6, 0x0
    addi        x6, x6, 0x1
L78: # Test 15-2: sltiu
    sltiu       x16, x16, 0xFFFFF805
    lui         x15, 0x0
    addi        x15, x15, 0x1
L79: # Test 15-3: sltiu
    sltiu       x21, x5, 0x13A
    lui         x3, 0x0
    addi        x3, x3, 0x1
L80: # Test 15-4: sltiu
    sltiu       x17, x12, 0xFFFFFB33
    lui         x18, 0x0
    addi        x18, x18, 0x0
L81: # Test 16-0: andi
    andi        x31, x10, 0x4C
    lui         x22, 0x0
    addi        x22, x22, 0x48
L82: # Test 16-1: andi
    andi        x27, x6, 0xFFFFFAC6
    lui         x2, 0x0
    addi        x2, x2, 0x0
L83: # Test 16-2: andi
    andi        x7, x28, 0x2B4
    lui         x18, 0x0
    addi        x18, x18, 0x0
L84: # Test 16-3: andi
    andi        x11, x23, 0x791
    lui         x3, 0x0
    addi        x3, x3, 0x1
L85: # Test 16-4: andi
    andi        x7, x13, 0x184
    lui         x18, 0x0
    addi        x18, x18, 0x0
L86: # Test 17-0: ori
    ori         x16, x0, 0xFFFFF848
    lui         x27, 0x0
    addi        x27, x27, 0xFFFFF848
L87: # Test 17-1: ori
    ori         x21, x15, 0xFFFFFE29
    lui         x4, 0x0
    addi        x4, x4, 0xFFFFFE29
L88: # Test 17-2: ori
    ori         x13, x23, 0x31B
    lui         x2, 0x0
    addi        x2, x2, 0x31B
L89: # Test 17-3: ori
    ori         x11, x0, 0xFFFFFF33
    lui         x16, 0x0
    addi        x16, x16, 0xFFFFFF33
L90: # Test 17-4: ori
    ori         x24, x31, 0xFFFFF810
    lui         x25, 0x0
    addi        x25, x25, 0xFFFFF858
L91: # Test 18-0: xori
    xori        x8, x23, 0x744
    lui         x25, 0x0
    addi        x25, x25, 0x745
L92: # Test 18-1: xori
    xori        x2, x21, 0xFFFFF865
    lui         x11, 0x0
    addi        x11, x11, 0x64C
L93: # Test 18-2: xori
    xori        x17, x10, 0x511
    lui         x12, 0xEC164
    addi        x12, x12, 0xFFFFFAE9
L94: # Test 18-3: xori
    xori        x8, x15, 0x330
    lui         x17, 0x0
    addi        x17, x17, 0x331
L95: # Test 18-4: xori
    xori        x20, x16, 0x165
    lui         x5, 0x0
    addi        x5, x5, 0xFFFFFE56
L96: # Test 19-0: lui
    lui         x22, 0xAC7BB
    lui         x25, 0xAC7BB
    addi        x25, x25, 0x0
L97: # Test 19-1: lui
    lui         x10, 0x9AF2A
    lui         x8, 0x9AF2A
    addi        x8, x8, 0x0
L98: # Test 19-2: lui
    lui         x10, 0x25111
    lui         x15, 0x25111
    addi        x15, x15, 0x0
L99: # Test 19-3: lui
    lui         x11, 0x38AF4
    lui         x16, 0x38AF4
    addi        x16, x16, 0x0
L100: # Test 19-4: lui
    lui         x28, 0x580D6
    lui         x11, 0x580D6
    addi        x11, x11, 0x0
L101: # Test 20-0: auipc
    auipc       x7, 0xAA5F
    lui         x1, 0xAE60
    addi        x1, x1, 0xFFFFF8D0
L102: # Test 20-1: auipc
    auipc       x13, 0x6A3FD
    lui         x4, 0x6A7FE
    addi        x4, x4, 0xFFFFF8E4
L103: # Test 20-2: auipc
    auipc       x4, 0x7A531
    lui         x20, 0x7A932
    addi        x20, x20, 0xFFFFF8F8
L104: # Test 20-3: auipc
    auipc       x19, 0x22CC
    lui         x29, 0x26CD
    addi        x29, x29, 0xFFFFF90C
L105: # Test 20-4: auipc
    auipc       x10, 0x4A150
    lui         x27, 0x4A551
    addi        x27, x27, 0xFFFFF920
win: # Win label
    ebreak
