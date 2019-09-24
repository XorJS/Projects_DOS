Title 3d_Teapot
.286

;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
;- Programmer Par : Jean-Sebastien Royer [99]                                -
;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

MyStack Segment Para Stack 'STACK'
        Db 100h dup(?)
MyStack Ends

 Nbr_Vertives Equ 530

Data Segment Dword Public 'Data'
  Counter Dd 0FFFFFFFFh      ; Counter
  Screen  Dw 0000h           ; Segment de 65536 octets   
  Key_Table Db 128 Dup (1)   ; Table du Keyboard
  Jsr_Logo Db  03Fh,0FFh,0FFh,000h,0FFh,03Fh,0FFh,000h,07Fh,0FFh,0FFh,000h
           Db  040h,07Fh,0C0h,040h,0FFh,0C0h,000h,040h,03Fh,0C0h,0FFh,080h
           Db  080h,0FFh,080h,0C0h,03Fh,0FFh,07Fh,080h,07Fh,0FFh,040h,0C0h
           Db  040h,03Fh,000h,040h,080h,000h,0FFh,0C0h,0FFh,000h,0BFh,080h
           Db  0FFh,0FFh,080h,000h,0BFh,0FFh,0BFh,040h,0FFh,00Fh,0FFh,000h
Even
Teapot_2d Dw 1060 Dup (0)             ; (Y),(X)
Teapot_Coords   Dw    70 ,   0 ,  60  ;   xXx yYy zZz  530 Vertices
                Dw    69 ,   0 ,  64  ;  -=-=-=-=-=-=-=-=-=-=-=-=-=-
                Dw    70 ,   0 ,  65  ;  Coordonnees de la Cafetiere
                Dw    72 ,   0 ,  64  ;  de 3D MAX 2.x
                Dw    75 ,   0 ,  60  ;  -=-=-=-=-=-=-=-=-=-=-=-=-=-
                Dw    65 , -27 ,  60  
                Dw    64 , -27 ,  64  
                Dw    65 , -28 ,  65  
                Dw    67 , -28 ,  64  
                Dw    69 , -29 ,  60  
                Dw    50 , -50 ,  60  
                Dw    49 , -49 ,  64
                Dw    50 , -50 ,  65
                Dw    51 , -51 ,  64
                Dw    53 , -53 ,  60
                Dw    27 , -65 ,  60
                Dw    27 , -64 ,  64
                Dw    28 , -65 ,  65
                Dw    28 , -67 ,  64
                Dw    29 , -69 ,  60
                Dw     0 , -70 ,  60
                Dw     0 , -69 ,  64
                Dw     0 , -70 ,  65
                Dw     0 , -72 ,  64
                Dw     0 , -75 ,  60
                Dw   -29 , -65 ,  60
                Dw   -28 , -64 ,  64
                Dw   -28 , -65 ,  65
                Dw   -28 , -67 ,  64
                Dw   -29 , -69 ,  60
                Dw   -51 , -50 ,  60
                Dw   -50 , -49 ,  64
                Dw   -50 , -50 ,  65
                Dw   -51 , -51 ,  64
                Dw   -53 , -53 ,  60
                Dw   -65 , -27 ,  60
                Dw   -64 , -27 ,  64
                Dw   -65 , -28 ,  65
                Dw   -67 , -28 ,  64
                Dw   -69 , -29 ,  60
                Dw   -70 ,   0 ,  60
                Dw   -69 ,   0 ,  64
                Dw   -70 ,   0 ,  65
                Dw   -72 ,   0 ,  64
                Dw   -75 ,   0 ,  60
                Dw   -65 ,  27 ,  60
                Dw   -64 ,  27 ,  64
                Dw   -65 ,  28 ,  65
                Dw   -67 ,  28 ,  64
                Dw   -69 ,  29 ,  60
                Dw   -50 ,  50 ,  60
                Dw   -49 ,  49 ,  64
                Dw   -50 ,  50 ,  65
                Dw   -51 ,  51 ,  64
                Dw   -53 ,  53 ,  60
                Dw   -27 ,  65 ,  60
                Dw   -27 ,  64 ,  64
                Dw   -28 ,  65 ,  65
                Dw   -28 ,  67 ,  64
                Dw   -29 ,  69 ,  60
                Dw     0 ,  70 ,  60
                Dw     0 ,  69 ,  64
                Dw     0 ,  70 ,  65
                Dw     0 ,  72 ,  64
                Dw     0 ,  75 ,  60
                Dw    27 ,  65 ,  60
                Dw    27 ,  64 ,  64
                Dw    28 ,  65 ,  65
                Dw    28 ,  67 ,  64
                Dw    29 ,  69 ,  60
                Dw    50 ,  50 ,  60
                Dw    49 ,  49 ,  64
                Dw    50 ,  50 ,  65
                Dw    51 ,  51 ,  64
                Dw    53 ,  53 ,  60
                Dw    65 ,  27 ,  60
                Dw    64 ,  27 ,  64
                Dw    65 ,  28 ,  65
                Dw    67 ,  28 ,  64
                Dw    69 ,  29 ,  60
                Dw    84 ,   0 ,  40
                Dw    92 ,   0 ,  21
                Dw    98 ,   0 ,   3
                Dw   100 ,   0 , -15
                Dw    78 , -33 ,  40
                Dw    85 , -36 ,  21
                Dw    90 , -38 ,   3
                Dw    92 , -39 , -15
                Dw    60 , -60 ,  40
                Dw    65 , -65 ,  21
                Dw    69 , -69 ,   3
                Dw    71 , -71 , -15
                Dw    33 , -78 ,  40
                Dw    36 , -85 ,  21
                Dw    38 , -90 ,   3
                Dw    39 , -92 , -15
                Dw     0 , -84 ,  40
                Dw     0 , -92 ,  21
                Dw     0 , -98 ,   3
                Dw     0 ,-100 , -15
                Dw   -33 , -78 ,  40
                Dw   -36 , -85 ,  21
                Dw   -38 , -90 ,   3
                Dw   -39 , -92 , -15
                Dw   -60 , -60 ,  40
                Dw   -65 , -65 ,  21
                Dw   -69 , -69 ,   3
                Dw   -71 , -71 , -15
                Dw   -78 , -33 ,  40
                Dw   -85 , -36 ,  21
                Dw   -90 , -38 ,   3
                Dw   -92 , -39 , -15
                Dw   -84 ,   0 ,  40
                Dw   -92 ,   0 ,  21
                Dw   -98 ,   0 ,   3
                Dw  -100 ,   0 , -15
                Dw   -78 ,  33 ,  40
                Dw   -85 ,  36 ,  21
                Dw   -90 ,  38 ,   3
                Dw   -92 ,  39 , -15
                Dw   -60 ,  60 ,  40
                Dw   -65 ,  65 ,  21
                Dw   -69 ,  69 ,   3
                Dw   -71 ,  71 , -15
                Dw   -33 ,  78 ,  40
                Dw   -36 ,  85 ,  21
                Dw   -38 ,  90 ,   3
                Dw   -39 ,  92 , -15
                Dw     0 ,  84 ,  40
                Dw     0 ,  92 ,  21
                Dw     0 ,  98 ,   3
                Dw     0 , 100 , -15
                Dw    33 ,  78 ,  40
                Dw    36 ,  85 ,  21
                Dw    38 ,  90 ,   3
                Dw    39 ,  92 , -15
                Dw    60 ,  60 ,  40
                Dw    65 ,  65 ,  21
                Dw    69 ,  69 ,   3
                Dw    71 ,  71 , -15
                Dw    78 ,  33 ,  40
                Dw    85 ,  36 ,  21
                Dw    90 ,  38 ,   3
                Dw    92 ,  39 , -15
                Dw    96 ,   0 , -30
                Dw    88 ,   0 , -41
                Dw    79 ,   0 , -48
                Dw    75 ,   0 , -53
                Dw    89 , -38 , -30
                Dw    81 , -34 , -41
                Dw    73 , -31 , -48
                Dw    69 , -29 , -53
                Dw    68 , -68 , -30
                Dw    62 , -62 , -41
                Dw    56 , -56 , -48
                Dw    53 , -53 , -53
                Dw    38 , -89 , -30
                Dw    34 , -81 , -41
                Dw    31 , -73 , -48
                Dw    29 , -69 , -53
                Dw     0 , -96 , -30
                Dw     0 , -88 , -41
                Dw     0 , -79 , -48
                Dw     0 , -75 , -53
                Dw   -38 , -89 , -30
                Dw   -34 , -81 , -41
                Dw   -31 , -73 , -48
                Dw   -29 , -69 , -53
                Dw   -68 , -68 , -30
                Dw   -62 , -62 , -41
                Dw   -56 , -56 , -48
                Dw   -53 , -53 , -53
                Dw   -89 , -38 , -30
                Dw   -81 , -34 , -41
                Dw   -73 , -31 , -48
                Dw   -69 , -29 , -53
                Dw   -96 ,   0 , -30
                Dw   -88 ,   0 , -41
                Dw   -79 ,   0 , -48
                Dw   -75 ,   0 , -53
                Dw   -89 ,  38 , -30
                Dw   -81 ,  34 , -41
                Dw   -73 ,  31 , -48
                Dw   -69 ,  29 , -53
                Dw   -68 ,  68 , -30
                Dw   -62 ,  62 , -41
                Dw   -56 ,  56 , -48
                Dw   -53 ,  53 , -53
                Dw   -38 ,  89 , -30
                Dw   -34 ,  81 , -41
                Dw   -31 ,  73 , -48
                Dw   -29 ,  69 , -53
                Dw     0 ,  96 , -30
                Dw     0 ,  88 , -41
                Dw     0 ,  79 , -48
                Dw     0 ,  75 , -53
                Dw    38 ,  89 , -30
                Dw    34 ,  81 , -41
                Dw    31 ,  73 , -48
                Dw    29 ,  69 , -53
                Dw    68 ,  68 , -30
                Dw    62 ,  62 , -41
                Dw    56 ,  56 , -48
                Dw    53 ,  53 , -53
                Dw    89 ,  38 , -30
                Dw    81 ,  34 , -41
                Dw    73 ,  31 , -48
                Dw    69 ,  29 , -53
                Dw    73 ,   0 , -55
                Dw    64 ,   0 , -58
                Dw    42 ,   0 , -59
                Dw     0 ,   0 , -60
                Dw    68 , -29 , -55
                Dw    59 , -25 , -58
                Dw    39 , -16 , -59
                Dw    52 , -52 , -55
                Dw    46 , -46 , -58
                Dw    30 , -30 , -59
                Dw    29 , -68 , -55
                Dw    25 , -59 , -58
                Dw    16 , -39 , -59
                Dw     0 , -73 , -55
                Dw     0 , -64 , -58
                Dw     0 , -42 , -59
                Dw   -29 , -68 , -55
                Dw   -25 , -59 , -58
                Dw   -16 , -39 , -59
                Dw   -52 , -52 , -55
                Dw   -46 , -46 , -58
                Dw   -30 , -30 , -59
                Dw   -68 , -29 , -55
                Dw   -59 , -25 , -58
                Dw   -39 , -16 , -59
                Dw   -73 ,   0 , -55
                Dw   -64 ,   0 , -58
                Dw   -42 ,   0 , -59
                Dw   -68 ,  29 , -55
                Dw   -59 ,  25 , -58
                Dw   -39 ,  16 , -59
                Dw   -52 ,  52 , -55
                Dw   -46 ,  46 , -58
                Dw   -30 ,  30 , -59
                Dw   -29 ,  68 , -55
                Dw   -25 ,  59 , -58
                Dw   -16 ,  39 , -59
                Dw     0 ,  73 , -55
                Dw     0 ,  64 , -58
                Dw     0 ,  42 , -59
                Dw    29 ,  68 , -55
                Dw    25 ,  59 , -58
                Dw    16 ,  39 , -59
                Dw    52 ,  52 , -55
                Dw    46 ,  46 , -58
                Dw    30 ,  30 , -59
                Dw    68 ,  29 , -55
                Dw    59 ,  25 , -58
                Dw    39 ,  16 , -59
                Dw   -80 ,   0 ,  41
                Dw  -103 ,   0 ,  41
                Dw  -121 ,   0 ,  40
                Dw  -131 ,   0 ,  37
                Dw  -135 ,   0 ,  30
                Dw   -79 ,  -8 ,  43
                Dw  -104 ,  -8 ,  43
                Dw  -122 ,  -8 ,  41
                Dw  -134 ,  -8 ,  38
                Dw  -137 ,  -8 ,  30
                Dw   -78 , -11 ,  47
                Dw  -106 , -11 ,  47
                Dw  -126 , -11 ,  45
                Dw  -138 , -11 ,  40
                Dw  -143 , -11 ,  30
                Dw   -76 ,  -8 ,  51
                Dw  -107 ,  -8 ,  50
                Dw  -130 ,  -8 ,  48
                Dw  -143 ,  -8 ,  42
                Dw  -148 ,  -8 ,  30
                Dw   -75 ,   0 ,  53
                Dw  -108 ,   0 ,  52
                Dw  -131 ,   0 ,  50
                Dw  -145 ,   0 ,  43
                Dw  -150 ,   0 ,  30
                Dw   -76 ,   8 ,  51
                Dw  -107 ,   8 ,  50
                Dw  -130 ,   8 ,  48
                Dw  -143 ,   8 ,  42
                Dw  -148 ,   8 ,  30
                Dw   -78 ,  11 ,  47
                Dw  -106 ,  11 ,  47
                Dw  -126 ,  11 ,  45
                Dw  -138 ,  11 ,  40
                Dw  -143 ,  11 ,  30
                Dw   -79 ,   8 ,  43
                Dw  -104 ,   8 ,  43
                Dw  -122 ,   8 ,  41
                Dw  -134 ,   8 ,  38
                Dw  -137 ,   8 ,  30
                Dw  -133 ,   0 ,  20
                Dw  -127 ,   0 ,   8
                Dw  -116 ,   0 ,  -5
                Dw  -100 ,   0 , -15
                Dw  -135 ,  -8 ,  19
                Dw  -128 ,  -8 ,   6
                Dw  -117 ,  -8 ,  -7
                Dw   -99 ,  -8 , -17
                Dw  -140 , -11 ,  17
                Dw  -132 , -11 ,   3
                Dw  -118 , -11 , -11
                Dw   -98 , -11 , -23
                Dw  -145 ,  -8 ,  14
                Dw  -135 ,  -8 ,  -1
                Dw  -119 ,  -8 , -15
                Dw   -96 ,  -8 , -28
                Dw  -147 ,   0 ,  14
                Dw  -137 ,   0 ,  -2
                Dw  -119 ,   0 , -17
                Dw   -95 ,   0 , -30
                Dw  -145 ,   8 ,  14
                Dw  -135 ,   8 ,  -1
                Dw  -119 ,   8 , -15
                Dw   -96 ,   8 , -28
                Dw  -140 ,  11 ,  17
                Dw  -132 ,  11 ,   3
                Dw  -118 ,  11 , -11
                Dw   -98 ,  11 , -23
                Dw  -135 ,   8 ,  19
                Dw  -128 ,   8 ,   6
                Dw  -117 ,   8 ,  -7
                Dw   -99 ,   8 , -17
                Dw    85 ,   0 ,  11
                Dw   109 ,   0 ,  17
                Dw   119 ,   0 ,  30
                Dw   125 ,   0 ,  46
                Dw   135 ,   0 ,  60
                Dw    85 , -19 ,   5
                Dw   111 , -17 ,  12
                Dw   122 , -13 ,  27
                Dw   128 ,  -9 ,  45
                Dw   140 ,  -7 ,  60
                Dw    85 , -25 ,  -9
                Dw   115 , -22 ,   1
                Dw   127 , -17 ,  21
                Dw   134 , -12 ,  43
                Dw   150 ,  -9 ,  60
                Dw    85 , -19 , -24
                Dw   119 , -17 ,  -9
                Dw   132 , -13 ,  15
                Dw   141 ,  -9 ,  41
                Dw   160 ,  -7 ,  60
                Dw    85 ,   0 , -30
                Dw   121 ,   0 , -14
                Dw   134 ,   0 ,  12
                Dw   143 ,   0 ,  40
                Dw   165 ,   0 ,  60
                Dw    85 ,  19 , -24
                Dw   119 ,  17 ,  -9
                Dw   132 ,  13 ,  15
                Dw   141 ,   9 ,  41
                Dw   160 ,   7 ,  60
                Dw    85 ,  25 ,  -9
                Dw   115 ,  22 ,   1
                Dw   127 ,  17 ,  21
                Dw   134 ,  12 ,  43
                Dw   150 ,   9 ,  60
                Dw    85 ,  19 ,   5
                Dw   111 ,  17 ,  12
                Dw   122 ,  13 ,  27
                Dw   128 ,   9 ,  45
                Dw   140 ,   7 ,  60
                Dw   139 ,   0 ,  62
                Dw   141 ,   0 ,  63
                Dw   142 ,   0 ,  62
                Dw   140 ,   0 ,  60
                Dw   144 ,  -7 ,  62
                Dw   146 ,  -6 ,  63
                Dw   146 ,  -5 ,  62
                Dw   143 ,  -4 ,  60
                Dw   155 ,  -9 ,  62
                Dw   156 ,  -8 ,  63
                Dw   155 ,  -6 ,  63
                Dw   150 ,  -6 ,  60
                Dw   166 ,  -7 ,  63
                Dw   167 ,  -6 ,  64
                Dw   164 ,  -5 ,  63
                Dw   157 ,  -4 ,  60
                Dw   171 ,   0 ,  63
                Dw   171 ,   0 ,  64
                Dw   168 ,   0 ,  63
                Dw   160 ,   0 ,  60
                Dw   166 ,   7 ,  63
                Dw   167 ,   6 ,  64
                Dw   164 ,   5 ,  63
                Dw   157 ,   4 ,  60
                Dw   155 ,   9 ,  62
                Dw   156 ,   8 ,  63
                Dw   155 ,   6 ,  63
                Dw   150 ,   6 ,  60
                Dw   144 ,   7 ,  62
                Dw   146 ,   6 ,  63
                Dw   146 ,   5 ,  62
                Dw   143 ,   4 ,  60
                Dw     0 ,   0 ,  98
                Dw    17 ,   0 ,  95
                Dw    16 ,   0 ,  89
                Dw    10 ,   0 ,  82
                Dw    10 ,   0 ,  75
                Dw    16 ,  -7 ,  95
                Dw    15 ,  -6 ,  89
                Dw     9 ,  -4 ,  82
                Dw     9 ,  -4 ,  75
                Dw    12 , -12 ,  95
                Dw    12 , -12 ,  89
                Dw     7 ,  -7 ,  82
                Dw     7 ,  -7 ,  75
                Dw     7 , -16 ,  95
                Dw     6 , -15 ,  89
                Dw     4 ,  -9 ,  82
                Dw     4 ,  -9 ,  75
                Dw     0 , -17 ,  95
                Dw     0 , -16 ,  89
                Dw     0 , -10 ,  82
                Dw     0 , -10 ,  75
                Dw    -7 , -16 ,  95
                Dw    -6 , -15 ,  89
                Dw    -4 ,  -9 ,  82
                Dw    -4 ,  -9 ,  75
                Dw   -12 , -12 ,  95
                Dw   -12 , -12 ,  89
                Dw    -7 ,  -7 ,  82
                Dw    -7 ,  -7 ,  75
                Dw   -16 ,  -7 ,  95
                Dw   -15 ,  -6 ,  89
                Dw    -9 ,  -4 ,  82
                Dw    -9 ,  -4 ,  75
                Dw   -17 ,   0 ,  95
                Dw   -16 ,   0 ,  89
                Dw   -10 ,   0 ,  82
                Dw   -10 ,   0 ,  75
                Dw   -16 ,   7 ,  95
                Dw   -15 ,   6 ,  89
                Dw    -9 ,   4 ,  82
                Dw    -9 ,   4 ,  75
                Dw   -12 ,  12 ,  95
                Dw   -12 ,  12 ,  89
                Dw    -7 ,   7 ,  82
                Dw    -7 ,   7 ,  75
                Dw    -7 ,  16 ,  95
                Dw    -6 ,  15 ,  89
                Dw    -4 ,   9 ,  82
                Dw    -4 ,   9 ,  75
                Dw     0 ,  17 ,  95
                Dw     0 ,  16 ,  89
                Dw     0 ,  10 ,  82
                Dw     0 ,  10 ,  75
                Dw     7 ,  16 ,  95
                Dw     6 ,  15 ,  89
                Dw     4 ,   9 ,  82
                Dw     4 ,   9 ,  75
                Dw    12 ,  12 ,  95
                Dw    12 ,  12 ,  89
                Dw     7 ,   7 ,  82
                Dw     7 ,   7 ,  75
                Dw    16 ,   7 ,  95
                Dw    15 ,   6 ,  89
                Dw     9 ,   4 ,  82
                Dw     9 ,   4 ,  75
                Dw    23 ,   0 ,  71
                Dw    41 ,   0 ,  68
                Dw    58 ,   0 ,  64
                Dw    65 ,   0 ,  60
                Dw    21 ,  -9 ,  71
                Dw    38 , -16 ,  68
                Dw    53 , -23 ,  64
                Dw    60 , -26 ,  60
                Dw    16 , -16 ,  71
                Dw    29 , -29 ,  68
                Dw    41 , -41 ,  64
                Dw    46 , -46 ,  60
                Dw     9 , -21 ,  71
                Dw    16 , -38 ,  68
                Dw    23 , -53 ,  64
                Dw    26 , -60 ,  60
                Dw     0 , -23 ,  71
                Dw     0 , -41 ,  68
                Dw     0 , -58 ,  64
                Dw     0 , -65 ,  60
                Dw    -9 , -21 ,  71
                Dw   -16 , -38 ,  68
                Dw   -23 , -53 ,  64
                Dw   -26 , -60 ,  60
                Dw   -16 , -16 ,  71
                Dw   -29 , -29 ,  68
                Dw   -41 , -41 ,  64
                Dw   -46 , -46 ,  60
                Dw   -21 ,  -9 ,  71
                Dw   -38 , -16 ,  68
                Dw   -53 , -23 ,  64
                Dw   -60 , -26 ,  60
                Dw   -23 ,   0 ,  71
                Dw   -41 ,   0 ,  68
                Dw   -58 ,   0 ,  64
                Dw   -65 ,   0 ,  60
                Dw   -21 ,   9 ,  71
                Dw   -38 ,  16 ,  68
                Dw   -53 ,  23 ,  64
                Dw   -60 ,  26 ,  60
                Dw   -16 ,  16 ,  71
                Dw   -29 ,  29 ,  68
                Dw   -41 ,  41 ,  64
                Dw   -46 ,  46 ,  60
                Dw    -9 ,  21 ,  71
                Dw   -16 ,  38 ,  68
                Dw   -23 ,  53 ,  64
                Dw   -26 ,  60 ,  60
                Dw     0 ,  23 ,  71
                Dw     0 ,  41 ,  68
                Dw     0 ,  58 ,  64
                Dw     0 ,  65 ,  60
                Dw     9 ,  21 ,  71
                Dw    16 ,  38 ,  68
                Dw    23 ,  53 ,  64
                Dw    26 ,  60 ,  60
                Dw    16 ,  16 ,  71
                Dw    29 ,  29 ,  68
                Dw    41 ,  41 ,  64
                Dw    46 ,  46 ,  60
                Dw    21 ,   9 ,  71
                Dw    38 ,  16 ,  68
                Dw    53 ,  23 ,  64
                Dw    60 ,  26 ,  60
Palette         Db     0 ,   0 ,   0    ; Mauve, Bleu, Vert, Jaune
                Db     2 ,   0 ,   2    
                Db     3 ,   0 ,   3    
                Db     4 ,   0 ,   4    
                Db     5 ,   0 ,   5
                Db     6 ,   1 ,   6
                Db     7 ,   1 ,   7
                Db     8 ,   1 ,   8
                Db     9 ,   1 ,   9
                Db    10 ,   2 ,  10
                Db    11 ,   2 ,  11
                Db    12 ,   2 ,  12
                Db    13 ,   3 ,  13
                Db    14 ,   3 ,  14
                Db    15 ,   3 ,  15
                Db    16 ,   4 ,  16
                Db    17 ,   4 ,  17
                Db    18 ,   5 ,  18
                Db    19 ,   6 ,  19
                Db    20 ,   6 ,  20
                Db    21 ,   7 ,  21
                Db    22 ,   7 ,  22
                Db    23 ,   8 ,  23
                Db    24 ,   9 ,  24
                Db    25 ,  10 ,  25
                Db    26 ,  10 ,  26
                Db    27 ,  11 ,  27
                Db    28 ,  12 ,  28
                Db    29 ,  13 ,  29
                Db    30 ,  14 ,  30
                Db    31 ,  15 ,  31
                Db    32 ,  16 ,  32
                Db    32 ,  17 ,  32
                Db    33 ,  18 ,  33
                Db    34 ,  19 ,  34
                Db    35 ,  20 ,  35
                Db    36 ,  21 ,  36
                Db    37 ,  22 ,  37
                Db    38 ,  23 ,  38
                Db    39 ,  25 ,  39
                Db    40 ,  26 ,  40
                Db    41 ,  27 ,  41
                Db    42 ,  28 ,  42
                Db    43 ,  30 ,  43
                Db    44 ,  31 ,  44
                Db    45 ,  33 ,  45
                Db    46 ,  34 ,  46
                Db    47 ,  35 ,  47
                Db    48 ,  37 ,  48
                Db    49 ,  38 ,  49
                Db    50 ,  40 ,  50
                Db    51 ,  42 ,  51
                Db    52 ,  43 ,  52
                Db    53 ,  45 ,  53
                Db    54 ,  47 ,  54
                Db    55 ,  48 ,  55
                Db    56 ,  50 ,  56
                Db    57 ,  52 ,  57
                Db    58 ,  54 ,  58
                Db    59 ,  55 ,  59
                Db    60 ,  57 ,  60
                Db    61 ,  59 ,  61
                Db    62 ,  61 ,  62
                Db    63 ,  63 ,  63
                Db     0 ,   0 ,   0    
                Db     2 ,   2 ,   0
                Db     3 ,   3 ,   0
                Db     4 ,   4 ,   0
                Db     5 ,   5 ,   0
                Db     6 ,   6 ,   1
                Db     7 ,   7 ,   1
                Db     8 ,   8 ,   1
                Db     9 ,   9 ,   1
                Db    10 ,  10 ,   2
                Db    11 ,  11 ,   2
                Db    12 ,  12 ,   2
                Db    13 ,  13 ,   3
                Db    14 ,  14 ,   3
                Db    15 ,  15 ,   3
                Db    16 ,  16 ,   4
                Db    17 ,  17 ,   4
                Db    18 ,  18 ,   5
                Db    19 ,  19 ,   6
                Db    20 ,  20 ,   6
                Db    21 ,  21 ,   7
                Db    22 ,  22 ,   7
                Db    23 ,  23 ,   8
                Db    24 ,  24 ,   9
                Db    25 ,  25 ,  10
                Db    26 ,  26 ,  10
                Db    27 ,  27 ,  11
                Db    28 ,  28 ,  12
                Db    29 ,  29 ,  13
                Db    30 ,  30 ,  14
                Db    31 ,  31 ,  15
                Db    32 ,  32 ,  16
                Db    32 ,  32 ,  17
                Db    33 ,  33 ,  18
                Db    34 ,  34 ,  19
                Db    35 ,  35 ,  20
                Db    36 ,  36 ,  21
                Db    37 ,  37 ,  22
                Db    38 ,  38 ,  23
                Db    39 ,  39 ,  25
                Db    40 ,  40 ,  26
                Db    41 ,  41 ,  27
                Db    42 ,  42 ,  28
                Db    43 ,  43 ,  30
                Db    44 ,  44 ,  31
                Db    45 ,  45 ,  33
                Db    46 ,  46 ,  34
                Db    47 ,  47 ,  35
                Db    48 ,  48 ,  37
                Db    49 ,  49 ,  38
                Db    50 ,  50 ,  40
                Db    51 ,  51 ,  42
                Db    52 ,  52 ,  43
                Db    53 ,  53 ,  45
                Db    54 ,  54 ,  47
                Db    55 ,  55 ,  48
                Db    56 ,  56 ,  50
                Db    57 ,  57 ,  52
                Db    58 ,  58 ,  54
                Db    59 ,  59 ,  55
                Db    60 ,  60 ,  57
                Db    61 ,  61 ,  59
                Db    62 ,  62 ,  61
                Db    63 ,  63 ,  63
                Db     0 ,   0 ,   0
                Db     0 ,   2 ,   2
                Db     0 ,   3 ,   3
                Db     0 ,   4 ,   4
                Db     0 ,   5 ,   5
                Db     1 ,   6 ,   6
                Db     1 ,   7 ,   7
                Db     1 ,   8 ,   8
                Db     1 ,   9 ,   9
                Db     2 ,  10 ,  10
                Db     2 ,  11 ,  11
                Db     2 ,  12 ,  12
                Db     3 ,  13 ,  13
                Db     3 ,  14 ,  14
                Db     3 ,  15 ,  15
                Db     4 ,  16 ,  16
                Db     4 ,  17 ,  17
                Db     5 ,  18 ,  18
                Db     6 ,  19 ,  19
                Db     6 ,  20 ,  20
                Db     7 ,  21 ,  21
                Db     7 ,  22 ,  22
                Db     8 ,  23 ,  23
                Db     9 ,  24 ,  24
                Db    10 ,  25 ,  25
                Db    10 ,  26 ,  26
                Db    11 ,  27 ,  27
                Db    12 ,  28 ,  28
                Db    13 ,  29 ,  29
                Db    14 ,  30 ,  30
                Db    15 ,  31 ,  31
                Db    16 ,  32 ,  32
                Db    17 ,  32 ,  32
                Db    18 ,  33 ,  33
                Db    19 ,  34 ,  34
                Db    20 ,  35 ,  35
                Db    21 ,  36 ,  36
                Db    22 ,  37 ,  37
                Db    23 ,  38 ,  38
                Db    25 ,  39 ,  39
                Db    26 ,  40 ,  40
                Db    27 ,  41 ,  41
                Db    28 ,  42 ,  42
                Db    30 ,  43 ,  43
                Db    31 ,  44 ,  44
                Db    33 ,  45 ,  45
                Db    34 ,  46 ,  46
                Db    35 ,  47 ,  47
                Db    37 ,  48 ,  48
                Db    38 ,  49 ,  49
                Db    40 ,  50 ,  50
                Db    42 ,  51 ,  51
                Db    43 ,  52 ,  52
                Db    45 ,  53 ,  53
                Db    47 ,  54 ,  54
                Db    48 ,  55 ,  55
                Db    50 ,  56 ,  56
                Db    52 ,  57 ,  57
                Db    54 ,  58 ,  58
                Db    55 ,  59 ,  59
                Db    57 ,  60 ,  60
                Db    59 ,  61 ,  61
                Db    61 ,  62 ,  62
                Db    63 ,  63 ,  63
                Db     0 ,   0 ,   0
                Db     0 ,   0 ,   2
                Db     0 ,   0 ,   3
                Db     0 ,   0 ,   4
                Db     0 ,   0 ,   5
                Db     0 ,   1 ,   6
                Db     0 ,   1 ,   7
                Db     0 ,   1 ,   8
                Db     0 ,   1 ,   9
                Db     0 ,   2 ,  10
                Db     0 ,   2 ,  11
                Db     0 ,   2 ,  12
                Db     1 ,   3 ,  13
                Db     1 ,   3 ,  14
                Db     1 ,   3 ,  15
                Db     1 ,   4 ,  16
                Db     1 ,   4 ,  17
                Db     1 ,   5 ,  18
                Db     2 ,   6 ,  19
                Db     2 ,   6 ,  20
                Db     2 ,   7 ,  21
                Db     3 ,   7 ,  22
                Db     3 ,   8 ,  23
                Db     3 ,   9 ,  24
                Db     4 ,  10 ,  25
                Db     4 ,  10 ,  26
                Db     5 ,  11 ,  27
                Db     5 ,  12 ,  28
                Db     6 ,  13 ,  29
                Db     6 ,  14 ,  30
                Db     7 ,  15 ,  31
                Db     8 ,  16 ,  32
                Db     9 ,  17 ,  32
                Db     9 ,  18 ,  33
                Db    10 ,  19 ,  34
                Db    11 ,  20 ,  35
                Db    12 ,  21 ,  36
                Db    13 ,  22 ,  37
                Db    14 ,  23 ,  38
                Db    15 ,  25 ,  39
                Db    17 ,  26 ,  40
                Db    18 ,  27 ,  41
                Db    19 ,  28 ,  42
                Db    20 ,  30 ,  43
                Db    22 ,  31 ,  44
                Db    23 ,  33 ,  45
                Db    25 ,  34 ,  46
                Db    27 ,  35 ,  47
                Db    28 ,  37 ,  48
                Db    30 ,  38 ,  49
                Db    32 ,  40 ,  50
                Db    34 ,  42 ,  51
                Db    36 ,  43 ,  52
                Db    38 ,  45 ,  53
                Db    40 ,  47 ,  54
                Db    42 ,  48 ,  55
                Db    45 ,  50 ,  56
                Db    47 ,  52 ,  57
                Db    49 ,  54 ,  58
                Db    52 ,  55 ,  59
                Db    55 ,  57 ,  60
                Db    57 ,  59 ,  61
                Db    60 ,  61 ,  62
                Db    63 ,  63 ,  63
Sinus           Dw     0,   6,  13,  19,  25,  31,  38,  44  ; Cosinus
                Dw    50,  56,  62,  68,  74,  80,  86,  92  ; Sinus+64   
                Dw    98, 104, 109, 115, 121, 126, 132, 137
                Dw   142, 147, 152, 157, 162, 167, 172, 177
                Dw   181, 185, 190, 194, 198, 202, 206, 209
                Dw   213, 216, 220, 223, 226, 229, 231, 234
                Dw   237, 239, 241, 243, 245, 247, 248, 250
                Dw   251, 252, 253, 254, 255, 255, 256, 256
                Dw   256, 256, 256, 255, 255, 254, 253, 252
                Dw   251, 250, 248, 247, 245, 243, 241, 239
                Dw   237, 234, 231, 229, 226, 223, 220, 216
                Dw   213, 209, 206, 202, 198, 194, 190, 185
                Dw   181, 177, 172, 167, 162, 157, 152, 147
                Dw   142, 137, 132, 126, 121, 115, 109, 104
                Dw    98,  92,  86,  80,  74,  68,  62,  56
                Dw    50,  44,  38,  31,  25,  19,  13,   6
                Dw     0,  -6, -13, -19, -25, -31, -38, -44
                Dw   -50, -56, -62, -68, -74, -80, -86, -92
                Dw   -98,-104,-109,-115,-121,-126,-132,-137
                Dw  -142,-147,-152,-157,-162,-167,-172,-177
                Dw  -181,-185,-190,-194,-198,-202,-206,-209
                Dw  -213,-216,-220,-223,-226,-229,-231,-234
                Dw  -237,-239,-241,-243,-245,-247,-248,-250
                Dw  -251,-252,-253,-254,-255,-255,-256,-256
                Dw  -256,-256,-256,-255,-255,-254,-253,-252
                Dw  -251,-250,-248,-247,-245,-243,-241,-239
                Dw  -237,-234,-231,-229,-226,-223,-220,-216
                Dw  -213,-209,-206,-202,-198,-194,-190,-185
                Dw  -181,-177,-172,-167,-162,-157,-152,-147
                Dw  -142,-137,-132,-126,-121,-115,-109,-104
                Dw   -98, -92, -86, -80, -74, -68, -62, -56
                Dw   -50, -44, -38, -31, -25, -19, -13,  -6

Text Db 13,10,"Code By : Jean-Sebastien Royer [99]",13,10,10
     Db " [Insert] And [Delete] For xXx Rotation (Start/Stop)",13,10
     Db "  [F1] - [F4] For Speed xXx Rotation ",13,10,10
     Db " [Home] And [End] For yYy Rotation (Start/Stop)",13,10
     Db "  [F5] - [F8] For Speed yYy Rotation ",13,10,10
     Db " [Page Up] And [Page Down] For zZz Rotation (Start/Stop)",13,10
     Db "  [F9] - [F12] For Speed zZz Rotation ",13,10,10
     Db " Uses Arrows For Moves Objects",13,10,10
     Db " [+] and [-] For Z Positions ",13,10,10
     Db "  [Enter] . . . ",13,10,"$"
Data Ends

Code Segment Dword Public 'CODE'
.486
Assume Cs:Code,Ds:Data,Fs:Data,Gs:Data

Install_New_Handler Proc Near
;****************************************************************************
;*                  I n s t a l l _ N e w _ H a n d l e r                   *
;****************************************************************************
;*  Detourne plusieurs interruptions pour le timing,le keyboard...          *
;****************************************************************************
 Cli
 Lea Di,Key_Table             ; 01 = Touche Relacher
 Mov Cx,32
 Mov Eax,01010101h
 Rep Stosd

 Mov Ax,Seg Key_Table         
 Mov Gs,Ax
 
 Xor Ax,Ax                    ; Sauvegarde l'ancien Gestionnaire
 Mov Es,Ax                    ; du keyboard
 Mov Bx,09*04
 Mov Eax,Es:[Bx]
 Mov Cs:[Old_Int_9],Eax
 
 Mov Cx,Cs                    ; Active le nouveau Gestionnaire
 Shl Ecx,16
 Mov Cx,Offset Handler_9
 Mov Es:[Bx],Ecx

 Sub Bx,04                    ; Sauvegarde l'ancien Gestionnaire
 Mov Eax,Es:[Bx]              ; du Timer
 Mov Cs:[Old_Int_8],Eax

 Mov Cx,Offset Handler_8      ; Active le nouveau Gestionnaire
 Mov Es:[Bx],Ecx
 
 Mov Dx,043h                  ; Remplace le 18,1 interruption a
 Mov Cx,0A904h                ; 1000 interruptions a la seconde
 Mov Al,036h
 Out Dx,Al

 Sub Dx,03
 Mov Al,Ch
 Out Dx,Al
 Mov Al,Cl
 Out Dx,Al

 Mov Bx,01Ch*04
 Mov Eax,Es:[Bx]
 Mov Cs:[Old_Int_1C],Eax
 
 Mov Cx,Cs                    ; Active le nouveau Gestionnaire
 Shl Ecx,16
 Mov Cx,Offset Int_Iret
 Mov Es:[Bx],Ecx
 Sti
Ret
EndP

Remove_New_Handler Proc Near
;****************************************************************************
;*                    R e m o v e _ N e w _ H a n d l e r                   *
;****************************************************************************
;*  Remet les anciennes interruptions pour le timing,le keyboard...         *
;****************************************************************************
 Cli
 Xor Ax,Ax                    ; Active l'ancien gestionnaire du clavier
 Mov Es,Ax
 Mov Bx,09*04
 Mov Eax,Cs:[Old_Int_9]
 Mov Es:[Bx],Eax
 
 Sub Bx,04                    ; Active l'ancien gestionnaire du timer
 Mov Eax,Cs:[Old_Int_8]
 Mov Es:[Bx],Eax

 Mov Dx,043h                  ; Le remet a 18,1 impulsions a la seconde
 Mov Al,036h
 Out Dx,Al
 Sub Dx,03
 Xor Al,Al
 Out Dx,Al
 Out Dx,Al

 Mov Bx,01Ch*04
 Mov Eax,Cs:[Old_Int_1C]
 Mov Es:[Bx],Eax
 Sti
Ret
EndP

Even
Handler_9 Proc Near
;****************************************************************************
;*                             H a n d l e r _ 9                            *
;****************************************************************************
; Nouvelle interruption pour le keyboard.                                   *
; La procedure fonctionne a le methode binaire, un 1 signifie que la touche *
; est relache, un 0 appuyer.                                                *
;****************************************************************************
 Push Ax
 Push Bx
 
 In Al,60h

 Xor Bh,Bh
 Mov Bl,Al
 And Bl,01111111b

 Shr Al,07

 Lea Bx,[Bx+Offset Key_Table]
 Mov Gs:[Bx],Al

 Mov Al,20h
 Out 20h,Al

 Pop Bx
 Pop Ax
Iret
EndP

Even
Handler_8 Proc Near
;****************************************************************************
;*                             H a n d l e r _ 8                            *
;****************************************************************************
;* La procedure permet de synchronizer a la meme vitesse avec toute les     * 
;* machines, ou de faire des delais a temps reelle.                         *
;****************************************************************************
 Push Ax
 Push Bx
 Mov Bx,Offset Counter
 Dec Dword Ptr Gs:[Bx]

 Mov Al,20h
 Out 20h,Al
 
 Pop Bx
 Pop Ax
Iret
EndP

Even
Int_Iret Proc Near
;****************************************************************************
;*                             I n t _ I r e t                              *
;****************************************************************************
Iret
Endp

Even
Old_Int_9  Dd 0     ; Le keyboard
Old_Int_8  Dd 0     ; Le timer
Old_Int_1C Dd 0     ; Le temporisateur

Set_Pal Proc Near
;****************************************************************************
;*                             S e l _ P a l                                *
;****************************************************************************
 Mov Si,Offset Palette
 Xor Al,Al
 Mov Dx,03C8h
 Out Dx,Al
 Inc Dx
 Mov Cx,0768d
 Rep Outsb
Ret
Endp

Clear Proc Near
;****************************************************************************
;*                               C l e a r                                  *
;****************************************************************************
 Mov Es,Screen
 Xor Di,Di
 Xor Eax,Eax
 Mov Cx,16384d
 Rep Stosd
Ret
Endp

Even
Show Proc Near
 Mov Ax,Screen
 Mov Es,Ax
 Xor Di,Di
;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
; Transforme tout les pixels <= A 03Fh pour l'effet des quatres fenetres.
;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
 Mov Ebx,03F3F3F3Fh
 Mov Dx,04
 Mov Cx,65536/16
Even
@Loop_And:
 Mov Eax,Es:[Di]
 And Eax,Ebx
 Mov Es:[Di],Eax
 Add Di,Dx

 Mov Eax,Es:[Di]
 And Eax,Ebx
 Mov Es:[Di],Eax
 Add Di,Dx

 Mov Eax,Es:[Di]
 And Eax,Ebx
 Mov Es:[Di],Eax
 Add Di,Dx

 Mov Eax,Es:[Di]
 And Eax,Ebx
 Mov Es:[Di],Eax
 Add Di,Dx

 Dec Cx
 Jnz @Loop_And

;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
; L'effet Smooth/Blur
;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
 Mov Di,320*195+308
 Mov Bp,320-12
 Mov Dl,05
 Xor Eax,Eax
@Loop_Clear_Jsr:
 Stosd
 Stosd
 Stosd
 Add Di,Bp
 Dec Dl
 Jnz @Loop_Clear_Jsr
 Xor Di,Di
 Mov Cx,160
 Rep Stosd
 Mov Cl,02
 Mov Dx,(64000-1280)/4
 Xor Ah,Ah
 Xor Bh,Bh
Even
@Loop:
 Mov Al,Es:[Di+1]
 Mov Bl,Es:[Di-1]
 Add Ax,Bx
 Mov Bl,Es:[Di-320]
 Add Ax,Bx
 Mov Bl,Es:[Di+320]
 Add Ax,Bx
 Shr Ax,Cl
 Stosb

 Mov Al,Es:[Di+321]
 Mov Bl,Es:[Di-321]
 Add Ax,Bx
 Mov Bl,Es:[Di-319]
 Add Ax,Bx
 Mov Bl,Es:[Di+319]
 Add Ax,Bx
 Shr Ax,Cl
 Stosb

 Mov Al,Es:[Di+1]
 Mov Bl,Es:[Di-1]
 Add Ax,Bx
 Mov Bl,Es:[Di-320]
 Add Ax,Bx
 Mov Bl,Es:[Di+320]
 Add Ax,Bx
 Shr Ax,Cl
 Stosb

 Mov Al,Es:[Di+321]
 Mov Bl,Es:[Di-321]
 Add Ax,Bx
 Mov Bl,Es:[Di-319]
 Add Ax,Bx
 Mov Bl,Es:[Di+319]
 Add Ax,Bx
 Shr Ax,Cl
 Stosb

 Dec Dx
 Jnz @Loop
 Xor Eax,Eax
 Mov Cx,320
 Rep Stosd

;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
; Affiche mes initiales JSR
;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
 Mov Si,Offset Jsr_Logo
 Mov Di,320*195+308
 Mov Dl,05
 Mov Bp,320-12
@Loop_Jsr:
 Movsd
 Movsd
 Movsd
 Add Di,Bp
 Dec Dl
 Jnz @Loop_Jsr

;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
; Effectue La Couleur Diviser en 4 Petits Carres Soit Jaune,Vert,Bleu,Mauve.
;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
 Xor Di,Di
 Mov Ebx,040404040h
 Mov Edx,080808080h
 Mov Bp,04
 Mov Ch,200
Even
@Loop_Four_Mix_Color_1:
 Mov Cl,10
Even
@Loop_Four_Mix_Color_2:
 Mov Eax,Es:[Di]
 Or Eax,Ebx
 Mov Es:[Di],Eax
 Add Di,Bp

 Mov Eax,Es:[Di]
 Or Eax,Ebx
 Mov Es:[Di],Eax
 Add Di,Bp

 Mov Eax,Es:[Di]
 Or Eax,Ebx
 Mov Es:[Di],Eax
 Add Di,Bp

 Mov Eax,Es:[Di]
 Or Eax,Ebx
 Mov Es:[Di],Eax
 Add Di,Bp

 Dec Cl
 Jnz @Loop_Four_Mix_Color_2
 Xchg Ebx,Edx
 Dec Ch
 Jnz @Loop_Four_Mix_Color_1

 Mov Ebx,0C0C0C0C0h
 Mov Dx,160
 Mov Ch,100
Even
@Loop_Four_Mix_Color_4:
 Mov Cl,10
Even
@Loop_Four_Mix_Color_3:
 Mov Eax,Es:[Di]
 Or Eax,Ebx
 Mov Es:[Di],Eax
 Add Di,Bp

 Mov Eax,Es:[Di]
 Or Eax,Ebx
 Mov Es:[Di],Eax
 Add Di,Bp

 Mov Eax,Es:[Di]
 Or Eax,Ebx
 Mov Es:[Di],Eax
 Add Di,Bp

 Mov Eax,Es:[Di]
 Or Eax,Ebx
 Mov Es:[Di],Eax
 Add Di,Bp

 Dec Cl
 Jnz @Loop_Four_Mix_Color_3
 Add Di,Dx
 Dec Ch
 Jnz @Loop_Four_Mix_Color_4

Ret
Endp

Even
A_Counter Dd 00000000  ;  Delay pour l'activation des touches [Insert],[Home] 
B_Counter Dd 00000000  ;  et [Page Up]. Ce qui Permet l'inversion de l'axe
C_Counter Dd 00000000  ;  sans problemes.

Rot_Sinus_X Dd 00000000  
Rot_Cosin_X Dd 00000000  
Rot_Sinus_Y Dd 00000000  
Rot_Cosin_Y Dd 00000000  
Rot_Sinus_Z Dd 00000000  
Rot_Cosin_Z Dd 00000000  

Y_Pos_Obj Dw 100   ; Position du Teapot a l'ordonnee
X_Pos_Obj Dw 160   ; Position du Teapot a l'abscive
Z_Pos_Obj Dw 512   ; Position du Teapot face au buffers Z

X_Rot Db 00        ; Angle de la Rotation X
Y_Rot Db 00        ;                      Y
Z_Rot Db 00        ;                      Z

Temp1 Db 00        ; Backup pour aider au code

X_Inc Db 01        ; Incrementation de 0 a 4
Y_Inc Db 01        ;
Z_Inc Db 01        ;

Temp2 Db 00        ; Backup pour aider au code

X_Inb Db 01        ; 
Y_Inb Db 01        ;
Z_Inb Db 01        ;

Even
Make_Coord_3d Proc Near
 Mov Ax,Ds
 Mov Es,Ax

;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
; Calcule la valeur du Sinus et Cosinus de l'axe xXx
;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
 Mov Cl,01h       ; 64 pour le cosinus et un pour le shiftage
 Mov Bp,Offset Sinus
 Mov Ax,0511d     ; 256*2 du au shiftage
 Mov Dx,0128d     ; double du cosinus (64)

 Xor Bh,Bh
 Mov Bl,X_rot
 Shl Bx,Cl
 Add Bx,Bp    
 Mov Di,[Bx]            ; Lit Sinus

 Sub Bx,Bp
 Add Bx,Dx
 And Bx,Ax
 Add Bx,Bp
 Mov Si,[Bx]            ; Lit Cosinus 

 Movsx Edi,Di
 Movsx Esi,Si
 Mov Cs:[Rot_Sinus_X],Edi
 Mov Cs:[Rot_CoSin_X],Esi

;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
; Calcule la valeur du Sinus et Cosinus de l'axe yYy
;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
 Xor Bh,Bh
 Mov Bl,Y_rot
 Shl Bx,Cl
 Add Bx,Bp    
 Mov Di,[Bx]            ; Lit Sinus

 Sub Bx,Bp
 Add Bx,Dx
 And Bx,Ax
 Add Bx,Bp
 Mov Si,[Bx]            ; Lit Cosinus 

 Movsx Edi,Di
 Movsx Esi,Si
 Mov Cs:[Rot_Sinus_Y],Edi
 Mov Cs:[Rot_CoSin_Y],Esi

;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
; Calcule la valeur du Sinus et Cosinus de l'axe zZz
;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
 Xor Bh,Bh
 Mov Bl,Z_rot
 Shl Bx,Cl
 Add Bx,Bp    
 Mov Di,[Bx]            ; Lit Sinus

 Sub Bx,Bp
 Add Bx,Dx
 And Bx,Ax
 Add Bx,Bp
 Mov Si,[Bx]            ; Lit Cosinus 

 Movsx Edi,Di
 Movsx Esi,Si
 Mov Cs:[Rot_Sinus_Z],Edi
 Mov Cs:[Rot_CoSin_Z],Esi

;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
; Calcule les 530 vertices en 2d
;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
 Mov Si,Offset Teapot_Coords   ; Coordonnees en 3d (X,Y,Z)
 Mov Di,Offset Teapot_2d       ; Coordonnees en 2d (Y,Z);
 Mov Bp,Nbr_Vertives           ; 530 vertices
Even
@Loop_Vertices_3d:
 Push Bp
 Push Di
 Lodsw
 Movsx Ebp,Ax    ;xXx

 Lodsw
 Movsx Edi,Ax    ;yYy

 Lodsw
 Push Si
 Movsx Esi,Ax    ;zZz

;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
; Temp_Y = ( Y*Sinus[Angle+64] - Z*Sinus[Angle] )
; Temp_Z = ( Y*Sinus[Angle] + Z*Sinus[Angle+64] )
; Y = Temp_Y Div 256
; Z = Temp_Z Div 256
;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
 Mov Edx,Cs:[Rot_Sinus_X]
 Mov Ecx,Cs:[Rot_CoSin_X]

 Mov Ebx,Edi
 Imul Ebx,Ecx
 
 Mov Eax,Esi
 Imul Eax,Edx
 Sub Ebx,Eax

 Imul Edx,Edi

 Mov Eax,Esi
 Imul Eax,Ecx
 Add Edx,Eax
    
 Sar Ebx,08                  
 Mov Edi,Ebx

 Sar Edx,08                  
 Mov Esi,Edx

;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
; Temp_X = ( X*Sinus[Angle+64] + Z*Sinus[Angle] )
; Temp_Z = ( Z*Sinus[Angle+64] - X*Sinus[Angle] )
; X = Temp_X Div 256
; Z = Temp_Z Div 256
;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
 Mov Edx,Cs:[Rot_Sinus_Y]
 Mov Ecx,Cs:[Rot_CoSin_Y]

 Mov Ebx,Ebp
 Imul Ebx,Ecx

 Mov Eax,Esi
 Imul Eax,Edx
 Add Ebx,Eax

 Imul Ecx,Esi

 Mov Eax,Ebp
 Imul Eax,Edx
 Sub Ecx,Eax

 Sar Ebx,08               
 Mov Ebp,Ebx

 Sar Ecx,08                
 Mov Esi,Ecx

;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
; Temp_X = ( X*Sinus[Angle+64] - Y*Sinus[Angle] )
; Temp_Y = ( X*Sinus[Angle] + Y*Sinus[Angle+64] )
; X = Temp_X Div 256
; Y = Temp_Y Div 256
;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
 Mov Edx,Cs:[Rot_Sinus_Z]
 Mov Ecx,Cs:[Rot_CoSin_Z]

 Mov Ebx,Ebp
 Imul Ebx,Ecx
 
 Mov Eax,Edi
 Imul Eax,Edx
 Sub Ebx,Eax

 Imul Edx,Ebp

 Mov Eax,Edi
 Imul Eax,Ecx
 Add Edx,Eax

 Sar Ebx,08                   
 Mov Ebp,Ebx

 Sar Edx,08                   
 Mov Eax,Edx

;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
; X = (X * 256) / (Z-Z_Pos_Obj)
; Y = (Y * 256) / (Z-Z_Pos_Obj)
;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
 Mov Cx,Si
 Sub Cx,Z_Pos_Obj

 Cwd
 Shld Dx,Ax,08
 Shl Ax,08
 Idiv Cx

 Pop Si
 Pop Di

 Add Ax,Y_Pos_Obj
 Stosw

 Mov Ax,Bp
 Cwd
 Shld Dx,Ax,08
 Shl Ax,08
 Idiv Cx

 Add Ax,X_Pos_Obj
 Stosw

 Pop Bp
 Dec Bp  
 Jnz @Loop_Vertices_3d

Ret
EndP

Even
Show_Coord_3d Proc Near
;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
; Affichage des pixels avec clipping. . .
;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
 Mov Ax,Screen
 Mov Es,Ax

 Mov Si,Offset Teapot_2d
 Mov Cx,Nbr_Vertives/2
 Mov Dx,03F3Fh
 Mov Bp,Offset Mul_320
Even
@Loop_Vertices:
 Lodsw
 Mov Bx,Ax
 Shl Bx,01
 Lodsw
 Cmp Bx,199*2      ; Y est doubler du a la table des multiplications
 Ja @No_Pixel
 Cmp Ax,318        ; Il Affiche deux Pixels horizontal
 Ja @No_Pixel
 Add Bx,Bp
 Mov Di,Cs:[Bx]
 Add Di,Ax

 Mov Es:[Di],Dx
@No_Pixel:
 Lodsw
 Mov Bx,Ax
 Shl Bx,01
 Lodsw
 Cmp Bx,199*2      ; Y est doubler du a la table des multiplications
 Ja @No_Pixel2
 Cmp Ax,318        ; Il Affiche deux Pixels horizontal
 Ja @No_Pixel2
 Add Bx,Bp
 Mov Di,Cs:[Bx]
 Add Di,Ax

 Mov Es:[Di],Dx
@No_Pixel2:
 Dec Cx
 Jnz @Loop_Vertices

 Call Show
;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
; Affiche le tout a l'ecran
;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
 Mov Bx,Ds
 Mov Ax,0A000h
 Mov Es,Ax
 Mov Ax,Screen
 Mov Ds,Ax

 Xor Di,Di
 Xor Si,Si
 Mov Cx,16000d
 Rep Movsd
 Mov Ds,Bx

;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
; Effectue un Retour de Balayage.
;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
 Mov Dx,03DAh
 Mov Bl,08
@1:
 In Al,Dx
 Test AL,Bl
 Jnz @1
@2:
 In Al,Dx
 Test AL,BL
 Jz @2

Ret
EndP

Even
Mul_320     Dw  00000, 00320, 00640, 00960, 01280, 01600, 01920, 02240
            Dw  02560, 02880, 03200, 03520, 03840, 04160, 04480, 04800
            Dw  05120, 05440, 05760, 06080, 06400, 06720, 07040, 07360
            Dw  07680, 08000, 08320, 08640, 08960, 09280, 09600, 09920
            Dw  10240, 10560, 10880, 11200, 11520, 11840, 12160, 12480
            Dw  12800, 13120, 13440, 13760, 14080, 14400, 14720, 15040
            Dw  15360, 15680, 16000, 16320, 16640, 16960, 17280, 17600
            Dw  17920, 18240, 18560, 18880, 19200, 19520, 19840, 20160
            Dw  20480, 20800, 21120, 21440, 21760, 22080, 22400, 22720
            Dw  23040, 23360, 23680, 24000, 24320, 24640, 24960, 25280
            Dw  25600, 25920, 26240, 26560, 26880, 27200, 27520, 27840
            Dw  28160, 28480, 28800, 29120, 29440, 29760, 30080, 30400
            Dw  30720, 31040, 31360, 31680, 32000, 32320, 32640, 32960
            Dw  33280, 33600, 33920, 34240, 34560, 34880, 35200, 35520
            Dw  35840, 36160, 36480, 36800, 37120, 37440, 37760, 38080
            Dw  38400, 38720, 39040, 39360, 39680, 40000, 40320, 40640
            Dw  40960, 41280, 41600, 41920, 42240, 42560, 42880, 43200
            Dw  43520, 43840, 44160, 44480, 44800, 45120, 45440, 45760
            Dw  46080, 46400, 46720, 47040, 47360, 47680, 48000, 48320
            Dw  48640, 48960, 49280, 49600, 49920, 50240, 50560, 50880
            Dw  51200, 51520, 51840, 52160, 52480, 52800, 53120, 53440
            Dw  53760, 54080, 54400, 54720, 55040, 55360, 55680, 56000
            Dw  56320, 56640, 56960, 57280, 57600, 57920, 58240, 58560
            Dw  58880, 59200, 59520, 59840, 60160, 60480, 60800, 61120
            Dw  61440, 61760, 62080, 62400, 62720, 63040, 63360, 63680

Even
Control_Tea_Pot Proc Near
;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
; S'occupe de faire pivoter le teapot dans les trois axes. 
;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
 Mov Bx,Offset X_Rot

 Mov Eax,Cs:[Bx]    ; X_Rot Y_Rot Z_Rot Temp_1
 Mov Edx,Cs:[Bx+04] ; X_Inc Y_Inc Z_Inc Temp_2

 Add Al,Dl
 Add Ah,Dh

 Bswap Edx
 Bswap Eax
 Add Ah,Dh
 Bswap Eax
 Mov Cs:[Bx],Eax

;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
; Permet la direction du teapot avec aucunes comparaisons, Direction par 4
;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
 Mov Ax,Cs:[Y_Pos_Obj]
 Mov Bx,Cs:[X_Pos_Obj]
 Xor Dh,Dh
 Mov Si,03
 Mov Cx,0102h                 ; Inversion de la touche et deplacement de 4

 Mov Di,Offset Key_Table+72   ; Key_Table 72 Top
 Mov Dl,[Di]
 Xor Dl,Ch
 Shl Dl,Cl
 Sub Ax,Dx

 Add Di,Si                    ; Key_Table 75 Left
 Mov Dl,[Di]
 Xor Dl,Ch
 Shl Dl,Cl
 Sub Bx,Dx

 Add Di,02                    ; Key_Table 77 Right
 Mov Dl,[Di]
 Xor Dl,Ch
 Shl Dl,Cl
 Add Bx,Dx

 Add Di,Si                    ; Key_Table 80 Bottom
 Mov Dl,[Di]
 Xor Dl,Ch
 Shl Dl,Cl
 Add Ax,Dx                 

 Mov Cs:[Y_Pos_Obj],Ax
 Mov Cs:[X_Pos_Obj],Bx

;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
; S'occupe de la presence du teapot dans l'axe Z avec max/min de 4906/256 t16
;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
 Mov Dx,Cs:[Z_Pos_Obj]

 Mov Si,Offset Key_Table+74
 Mov Bl,[Si]
 Test Bl,Bl
 Jne @No_Key_Z_Up
 Sub Dx,256+16
 Jns @No_Z_Up
 Xor Dx,Dx
@No_Z_Up:
 Add Dx,256
@No_Key_Z_Up:

 Mov Bl,[Si+04]
 Test Bl,Bl
 Jne @No_Key_Z_Down
 Sub Dx,4096
 Js @No_Z_Down
 Xor Dx,Dx
@No_Z_Down:
 Add Dx,4096+16
@No_Key_Z_Down:

 Mov Cs:[Z_Pos_Obj],Dx

;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
; Controle des pivotations soit l'activation, desactivation ou le degre
;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
 Mov Si,Offset Key_Table+82
 Mov Bp,Offset X_Inc
 Mov Di,Offset Y_Inc
 Mov Bx,Offset Z_Inc
 Mov Ecx,0256                 ; Delay pour l'inversion
 Mov Dl,[Si]                  ; Insert
 Dec Dl
 Je @No_Rotate_X
 Mov Edx,Cs:[A_Counter]
 Mov Eax,Gs:[Counter]
 Sub Edx,Eax
 Js @No_Rotate_X
 Mov Dh,Cs:[X_Inb]
 Mov Dl,Cs:[Bp]
 Test Dl,Dl
 Je @Rotate_X2
 Neg Dl
 Xchg Dl,Dh
@Rotate_X2:
 Mov Dl,Dh
@Rotate_X:
 Mov Cs:[Bp],Dl

 Sub Eax,Ecx
 Mov Cs:[A_Counter],Eax
@No_Rotate_X:

 Mov Si,Offset Key_Table+71   ; Home
 Mov Dl,[Si]
 Dec Dl
 Je @No_Rotate_Y
 Mov Edx,Cs:[B_Counter]
 Mov Eax,Gs:[Counter]
 Sub Edx,Eax
 Js @No_Rotate_Y
 Mov Dh,Cs:[Y_Inb]
 Mov Dl,Cs:[Di]
 Test Dl,Dl
 Je @Rotate_Y2
 Neg Dl
 Xchg Dl,Dh
@Rotate_Y2:
 Mov Dl,Dh
@Rotate_Y:
 Mov Cs:[Di],Dl

 Sub Eax,Ecx
 Mov Cs:[B_Counter],Eax
@No_Rotate_Y:

 Mov Si,Offset Key_Table+73   ; Page Up
 Mov Dl,[Si]
 Test Dl,Dl
 Jne @No_Rotate_Z
 Mov Edx,Cs:[C_Counter]
 Mov Eax,Gs:[Counter]
 Sub Edx,Eax
 Js @No_Rotate_Z
 Mov Dh,Cs:[Z_Inb]
 Mov Dl,Cs:[Bx]
 Test Dl,Dl
 Je @Rotate_Z2
 Neg Dl
 Xchg Dl,Dh
@Rotate_Z2:
 Mov Dl,Dh
@Rotate_Z:
 Mov Cs:[Bx],Dl

 Sub Eax,Ecx
 Mov Cs:[C_Counter],Eax
@No_Rotate_Z:

 Xor Ah,Ah
 Mov Si,Offset Key_Table+83   ; Delete
 Mov Al,[Si]
 Dec Al
 Je @No_Stop_Rotate_X
 Mov Cs:[Bp],Ah
@No_Stop_Rotate_X:

 Mov Si,Offset Key_Table+79   ; End
 Mov Al,[Si]
 Dec Al
 Je @No_Stop_Rotate_Y
 Mov Cs:[Di],Ah
@No_Stop_Rotate_Y:

 Mov Si,Offset Key_Table+81   ; Page Down
 Mov Al,[Si]
 Dec Al
 Je @No_Stop_Rotate_Z
 Mov Cs:[Bx],Ah
@No_Stop_Rotate_Z:

 Mov Si,Offset Key_Table+59
 Mov Di,Offset X_Inb
 Mov Bp,Offset X_Inc
 Mov Cx,0803h
 Mov Edx,01010101h
 Lodsd                        ;Contient F1 F2 F3 F4
 Xor Eax,Edx                  ;Inverse les uns pour des zero du premier bit
                              ;dans les quatres octets  
 Bsr Ebx,Eax                  ;Cherche le premier bit par reverse
 Jz @No_F14
 Add Bl,Ch
 Shr Bl,Cl

 Mov Al,Cs:[Bp]
 Test Al,Al
 Jns @No_Inverse_X
 Neg Bl
@No_Inverse_X:
 Je @Start_X_Inc
 Mov Cs:[Bp],Bl
@Start_X_Inc:

 Mov Cs:[Di],Bl

@No_F14:

 Inc Bp
 Inc Di
 Mov Si,Offset Key_Table+63
 Lodsd                        ;Contient F5 F6 F7 F8
 Xor Eax,Edx                  ;Inverse les uns pour des zero du premier bit
                              ;dans les quatres octets  
 Bsr Ebx,Eax                  ;Cherche le premier bit par reverse
 Jz @No_F58
 Add Bl,Ch
 Shr Bl,Cl

 Mov Al,Cs:[Bp]
 Test Al,Al
 Je @Start_Y_Inc
 Jns @No_Inverse_Y
 Neg Bl
@No_Inverse_Y:
 Mov Cs:[Bp],Bl
@Start_Y_Inc:

 Mov Cs:[Di],Bl

@No_F58:

 Inc Bp
 Inc Di

 Mov Si,Offset Key_Table+87
 Lodsw
 Shl Eax,16
 Mov Si,Offset Key_Table+67
 Lodsw

 Xor Eax,Edx                  ;Inverse les uns pour des zero du premier bit
                              ;dans les quatres octets  
 Bsr Ebx,Eax                  ;Cherche le premier bit par reverse
 Jz @No_F9C
 Add Bl,Ch
 Shr Bl,Cl

 Mov Al,Cs:[Bp]
 Or Al,Al
 Je @Start_Z_Inc
 Jns @No_Inverse_Z
 Neg Bl
@No_Inverse_Z:
 Mov Cs:[Bp],Bl
@Start_Z_Inc:

 Mov Cs:[Di],Bl

@No_F9C:

Ret
EndP

Get_Mem Proc Near
 Mov Ax,4800h
 Mov Bx,4096d
 Int 21h
 Jc @Miss_Memory
 Mov [Screen],Ax
Ret
EndP

Free_Mem Proc Near
 Mov Ax,Word Ptr [Screen]
 Mov Es,Ax
 Mov Ah,049h
 Int 21h
Ret
Endp

Even
Start Proc Near
 Mov Ax,Data                  ; Donnee Principal
 Mov Ds,Ax
 Mov Es,Ax

 Cld
 Call Install_New_Handler     ; Installe les 3 nouveaux handlers (08,09,1C)
 Call Get_Mem                 ; 65536 octets a screen
 Call Clear                   ; Efface le contenu de screen

;--------------------------------------------------------------------
; Removed text
;--------------------------------------------------------------------
; Mov Ax,03h
; Int 10h
; Mov Ah,09h
; Mov Dx,Offset Text
; Int 21h
; Mov Bx,Offset Key_Table+28   ; [Enter]
;@Text_Loop:
; Mov Al,Gs:[Bx]
; Dec Al
; Jns @Text_Loop
;--------------------------------------------------------------------

 Mov Ax,013h                  ; Mode Video 320x200x256
 Int 10h
 Call Set_Pal                 ; Active la nouvelle palette

Even
@Main_Loop:
 Call Control_Tea_Pot
 Call Make_Coord_3d
 Call Show_Coord_3d

 Mov Bx,Offset Key_Table+1
 Mov Al,Gs:[Bx]
 Dec Al
 Jns @Main_Loop

 Call Free_Mem
@Miss_Memory:
 Call Remove_New_Handler
 Mov Ax,03h
 Int 10h
 Mov Ax,4C00h
 Int 21h
Start EndP

Code Ends
End Start


