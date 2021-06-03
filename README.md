# Decompiling the Pascal-Autocode compiler (the first Pascal compiler for the BESM-6).

The work on the compiler started in February of 1975, and a beta version released in early 1976.
The presented version, with major number 9, is dated May 17, 1988. There is a newer minor fix, dated December 9, 1988 (the differences are trivial).

The BESM-6 Pascal system operated in an interactive environment, allowing to compile and execute a Pascal program with a single CLI command.

The compiler is called as an overlay by the helper program and compiles to an "autocode" language which used Cyrillic mnemonics for opcodes and used neither spaces nor newlines as separators. The lack of newlines allowed to form the assembly code in the standard output file without a single call to `writeln`, causing the runtime system to buffer everything on a magnetic drum.

The assembler is then called, to which the contents of the drum are given as input. It produces an executable binary in memory. The helper program either jumps to it (by default), or saves it to a file, if requested.

There was no need for a (static) linker: the runtime library was loaded into a predefined location, and the compiler spewed a list of equivalences which had to be in sync with the library. There was a mechanism to declare external subroutines and to dynamically load overlays containing those subroutines. 

The overall format of the autocode instruction is {optional octal index}{two-letter opcode}{optional octal or mnemonic offset}{separator}, where {separator} is a comma to separate instruction words, or an equal sign to separate the two instructions in a word.

Here is an example of a small program and its assembly listing:

```
           СИСТЕМА ПАСКАЛЬ ВЕРСИИ 1.7.76
         1. (*=Р-,Т-,L+*)_РRОGRАМ РRIМЕS;
         2. _СОNSТ РRIМЕLIМIТ = 1023;
         3.
         4. _VАR
         5.  РRIМЕS: _АRRАУ [2..РRIМЕLIМIТ] _ОF ВООLЕАN;
         6.  N, К, WIDТН, РОS: INТЕGЕR;
         7.
         8. _ВЕGIN
         9.  (* САLСULАТЕ ТНЕ РRIМЕS *)
        10.   _FОR N := 2 _ТО РRIМЕLIМIТ _DО РRIМЕS[N] := ТRUЕ;
        11.   _FОR N := 2 _ТО ТRUNС(SQRТ(РRIМЕLIМIТ)) _DО _ВЕGIN
        12.     _IF РRIМЕS[N] _ТНЕN _ВЕGIN
        13.       К := SQR(N);
        14.       _WНILЕ К <= РRIМЕLIМIТ _DО _ВЕGIN
        15.         РRIМЕS[К] := FАLSЕ;
        16.         К := К + N
        17.        _ЕND
        18.      _ЕND
        19.   _ЕND;
        20.
        21.   (* ОUТРUТ ТНЕ РRIМЕS *)
        22.   РОS := 1;
        23.   _FОR N := 2 _ТО РRIМЕLIМIТ _DО
        24.    _IF РRIМЕS[N] _ТНЕN _ВЕGIN
        25.       WIDТН := ТRUNС(LN(N)/LN(10)+1)+1;
        26.       РОS := РОS + WIDТН;
        27.       WRIТЕ(N:WIDТН);
        28.       _IF РОS > 120 _ТНЕN _ВЕGIN
        29.          WRIТЕLN; РОS := 1;
        30.      _ЕND
        31.    _ЕND;
        32.    _IF РОS <> 1 _ТНЕN WRIТЕLN
        33. _ЕND.
        34.
 ПАСКАЛЬ-АВТОКОД 9.(17.05.88)
________________________________________________________________________________________________________________________________
                АВТОКОД  00.00.70. БЛОК           N 000001 ЛИСТ 000000






В;КД=0021,ЗАГР=77040,LОАD,UNLОАD,СН,Ч=12,LI=4,ИА=74000,УРЕГ=ИА(3),
  Z0=УРЕГ(2),ПБИ15,ЕF,Н,Т,Е,ОС=Е(5),SL=ОС(2),Z64,РR=SL(10),МОD=РR(3),
  VR,СПТ,СПЛ,RF=VR(5),ЧМ1,ГТ=RF(5),RС=ГТ(6),СР=RС(4),АВ,ОВ,RWF,СТХТ=ОВ(5),
  WS,WС,WА,WВ,WI,WR,WL,ОWS,ОWС,ОWА,ОWВ,ОWI,ОWR,ОWL,ИК=ОWL(2),СЧ,
  ЗЧ,ЦУ=74136,ТR=74141,D=74145,N=74151,РА=74173,R=74202,АL=74206,
  GI=74222,RI=74251,РО=74257,RО=74313,МI=74323,UN=74337,РF=74715,
  GF=74760,СL=75075,ГА=75104,ЯГА=75115,ТNL=75165,ОV=75241,IА=75361,
  АI=75363,ГГ=75365,Ф=75675,RSR=75714,
   Н;           КД,
   К;      АД:  14 ПВ   Z1=             ,                     РRIМЕS                             00021  14 31 00103 00 000 0000
                17 СА   СА=                СЧ   15,                                              00022  17 25 02014 00 010 0015
                 1 ЗЧ   2010=           ,                                                        00023  01 000 2010 00 000 0000
           А2:   1 СЧ   2010=              ОВ   14,                                              00024  01 010 2010 00 006 0014
                   У1   А3=                СЧ   13,                                              00025  00 27 00031 00 010 0013
                 1 ИК   2010=            1 ЗЧ   10,                                              00026  01 23 02010 01 000 0010
                 1 СЧ   2010=              АС   13,                                              00027  01 010 2010 00 004 0013
                 1 ЗЧ   2010=              ПБ   А2,                                              00030  01 000 2010 00 30 00024
           А3:     СЧ   15=              1 ЗЧ   2010,                                            00031  00 010 0015 01 000 2010
           А4:     СЧ   14=             16 ПВ   R,                                               00032  00 010 0014 16 31 74202
                   Э050 =               ,                                                        00033  00 050 0000 00 000 0000
                16 ПВ   ТR=             ,                                                        00034  16 31 74141 00 000 0000
                 1 СМ   2010=           17 ОВ   ,                                                00035  01 003 2010 17 006 0000
                   У1   А5=              1 ИК   2010,                                            00036  00 27 00053 01 23 02010
                 1 СЧ   10=                У0   А6,                                              00037  01 010 0010 00 26 00051
                 1 СЧ   2010=           17 ЗЧ   ,                                                00040  01 010 2010 17 000 0000
                   ЛС   Z64=            17 АУ   ,                                                00041  00 115 4022 17 017 0000
                16 ПВ   ЦУ=             ,                                                        00042  16 31 74136 00 000 0000
                 1 ЗЧ   2011=           ,                                                        00043  01 000 2011 00 000 0000
           А7:   1 СЧ   2011=              ОВ   14,                                              00044  01 010 2011 00 006 0014
                   У1   А10=               СЧ   12,                                              00045  00 27 00051 00 010 0012
                 1 ИК   2011=            1 ЗЧ   10,                                              00046  01 23 02011 01 000 0010
                 1 СЧ   2011=            1 АС   2010,                                            00047  01 010 2011 01 004 2010
                 1 ЗЧ   2011=              ПБ   А7,                                              00050  01 000 2011 00 30 00044
          А10:
           А6:   1 СЧ   2010=              АС   13,                                              00051  01 010 2010 00 004 0013
                 1 ЗЧ   2010=              ПБ   А4,                                              00052  01 000 2010 00 30 00032
           А5:     СЧ   13=              1 ЗЧ   2013,                                            00053  00 010 0013 01 000 2013
                   СЧ   15=              1 ЗЧ   2010,                                            00054  00 010 0015 01 000 2010
          А11:   1 СЧ   2010=              ОВ   14,                                              00055  01 010 2010 00 006 0014
                   У1   А12=             1 ИК   2010,                                            00056  00 27 00100 01 23 02010
                 1 СЧ   10=                У0   А13,                                             00057  01 010 0010 00 26 00076
                   СЧ   16=             16 ПВ   R,                                               00060  00 010 0016 16 31 74202
                   Э050 5=              ,                                                        00061  00 050 0005 00 000 0000
                 1 СМ   2010=           16 ПВ   R,                                               00062  01 003 2010 16 31 74202
                   Э050 5=              ,                                                        00063  00 050 0005 00 000 0000
                17 АД   =                  АС   17,                                              00064  17 016 0000 00 004 0017
                16 ПВ   ТR=             ,                                                        00065  16 31 74141 00 000 0000
                   АС   13=              1 ЗЧ   2012,                                            00066  00 004 0013 01 000 2012
                 1 СЧ   2013=            1 АС   2012,                                            00067  01 010 2013 01 004 2012
                 1 ЗЧ   2013=            1 СЧ   2012,                                            00070  01 000 2013 01 010 2012
                17 ЗЧ   =                1 СЧ   2010,                                            00071  17 000 0000 01 010 2010
                16 ПВ   ОWI=            ,                                                        00072  16 31 74104 00 000 0000
                 1 СЧ   2013=              ОВ   20,                                              00073  01 010 2013 00 006 0020
                   У0   А14=            16 ПВ   РR,                                              00074  00 26 00076 16 31 74031
                   СЧ   13=              1 ЗЧ   2013,                                            00075  00 010 0013 01 000 2013
          А14:
          А13:   1 СЧ   2010=              АС   13,                                              00076  01 010 2010 00 004 0013
                 1 ЗЧ   2010=              ПБ   А11,                                             00077  01 000 2010 00 30 00055
          А12:   1 СЧ   2013=              СР   13,                                              00100  01 010 2013 00 012 0013
                   У0   А15=            16 ПВ   РR,                                              00101  00 26 00102 16 31 74031
          А15:     ПБ   Е=              ,                                                        00102  00 30 74012 00 000 0000
   У;           А1,
   К;      Z1:     РА   3=                 СЧ   5,                                               00103  00 037 0003 00 010 0005
                   УИ   1=               1 ПИ   17,                                              00104  00 040 0001 01 044 0017
________________________________________________________________________________________________________________________________
                АВТОКОД  00.00.70. БЛОК           N 000001 ЛИСТ 000001






                 1 ПИ   13=             15 ПВ   RI,                                              00105  01 044 0013 15 31 74251
                   СЧ   =                1 ЗЧ   LI,                                              00106  00 010 0000 01 000 0004
                14 ПИ   16=                ПБ   RО,                                              00107  14 044 0016 00 30 74313
            Х:
   Н;           11,
   С;           64000,                                                                           00011  00 000 0000 00 006 4000
                0,                                                                               00012  00 000 0000 00 000 0000
                1,                                                                               00013  00 000 0000 00 000 0001
                1777,                                                                            00014  00 000 0000 00 000 1777
                2,                                                                               00015  00 000 0000 00 000 0002
                12,                                                                              00016  00 000 0000 00 000 0012
                4050000000000000,                                                                00017  10 050 0000 00 000 0000
                170,                                                                             00020  00 000 0000 00 000 0170
   Н;           1,
   С;           1404350213022510,                                                                00001  03 004 3502 02 30 22510
                0040400001201001,                                                                00002  00 040 4000 00 120 1001
   Н;           5,
   Л;           ДХ,                                                                              00005  00 000 0000 00 000 0110
   Н;           7,
   К;           10 ПВ   УРЕГ=              ИА   =                                                00007  10 31 74003 00 22 00000
                10 СА   -10=            10 ПБ   АД,                                              00010  10 25 77770 10 30 00021
   Э;      СА:2014,
   К;
   Н;           66005,
Е;
________________________________________________________________________________________________________________________________
                АВТОКОД  00.00.70. БЛОК           N 000001 ЛИСТ 000001






 2 3 5 7 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 73 79 83 89 97 101 103 107 109 113 127 131 137 139 149 151 157 163
 167 173 179 181 191 193 197 199 211 223 227 229 233 239 241 251 257 263 269 271 277 281 283 293 307 311 313 317 331 337
 347 349 353 359 367 373 379 383 389 397 401 409 419 421 431 433 439 443 449 457 461 463 467 479 487 491 499 503 509 521
 523 541 547 557 563 569 571 577 587 593 599 601 607 613 617 619 631 641 643 647 653 659 661 673 677 683 691 701 709 719
 727 733 739 743 751 757 761 769 773 787 797 809 811 821 823 827 829 839 853 857 859 863 877 881 883 887 907 911 919 929
 937 941 947 953 967 971 977 983 991 997 1009 1013 1019 1021
ВСЕ СДЕЛАНО.
```
(Legend: `СЧ` = "load" (`СМ` = "stack push and load") , `ЗЧ` = "store", `ИК` provides an indirect address for the next instruction, `У0`/`У1` are "branch if zero/nonzero", `АС`, `ОВ`, `АУ`, `АД` are ADD, SUB (negated), MUL and DIV respectively, `ПВ` = call, `ПБ` = jump, `СА` modifies an index register, `Э050` is an "extracode" for transcendental functions. 

The implementation was somewhat incomplete, but with some extensions for low-level programming. Packed arrays and structures were not implemented; explicit bit field selection and insertion intrinsics (`SEL` and `INS`) have been provided instead. 
