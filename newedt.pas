(*=p-,t-,m-*)_program новред;
_label 5511;
_const c20=20;c16=16;c4=4;ca=73400B;etx='\377';lf='\175';olf='\214';sp=' ';colon=':';eq='=';endf='\172';ilf='\375';
a='a';z='z';c9=9;e31=000001T;e40=001T;c44=44;drum=10300000270036C;c40=40;c8=8;cb=57640B;cc=70000B;
_type letter=a..z; digit='0'..'9';
word=_record _case boolean _of true:(i:integer); false:(a:alfa) _end;
sector=_record a:_array [0..255] _of word _end;
_var g10z:char;
g11z:char;
g12z, g13z:@sector;
g14z, g15z:integer;
g16z:alfa;
g17z:integer;
g18z, g19z:boolean;
g20z, g21z:integer;
g22z:boolean;
g23z:boolean;
f:text;
_proced skipSp;
_(
  _while f@ = ' ' _do get(f);
_);

_proced P0455(l2a1z, l2a2z:integer);
 _(
 l2a1z := l2a2z * e31 + l2a1z;
 code(2Э0703=,);
 _);

_proced P0466(l2a1z, l2a2z:integer);
 _(
 l2a1z := (l2a1z + e40) + (l2a2z * e31);
 code(2Э0703=,);
 _);

_proced L0500;
 _(
   code(СЧ75207=ЗЧ75225,СЧ74215=ЗЧ74220,ИК75225=СЧ,ЗЧ74217=ВИ,ЗЧ74221=);
   get(input);
 _);
 _proced P0607;
 _label 707;
_var l2v1z, l2v2z: @_record a:_array [1..15] _of alfa _end;
l2v3z:alfa;
l2v4z:alfa;
l2v5z:integer;
l2v6z:integer;

_function L0510(_var l3a1z:alfa):boolean;
_var l3v1z, l3v2z:alfa; _(
 _while (input@ =sp) _do  get(input);
L0510 := false;
_if _not (input@ _in letter) _then exit;
code(=7ПА-5,L0530:);
_if (input@ _in letter) _or (input@ _in digit) _then _( l3v2z := input@; get(input) _) _else l3v2z := sp;
code(3СЧ5=СД/-10/,3ЛС6=3ЗЧ5,);
code(7KЦL0530=);
l3a1z := l3v1z;
L0510 := true;
_);

_function F0554(_var l3a1z: integer; _var l3a2z:alfa):boolean;
_var l3v1z:integer; _(
 code(=ИА57776,СЧ=); l3a1z := ;
 l3v1z := (10300000270036C);
 code(3Э0706=,);
 g12z@ := g13z@;
 code(ИА57770=СЧ,СР73400=У0L600,);
 F0554 := false;
 exit;
 code(L600:СЧ73400=); l3a2z := ; 
 F0554 := chr(sel(l3a2z, 40, 8)) _in letter;
 _);

_( (* P0607 *)
 l2v2z := ptr(24480);
 l2v1z := ptr(28672);
 l2v1z@ := l2v2z@;
 L0500;
 _if L0510(l2v3z) _then ;
 _if _not L0510(g16z)_then _(  writeln('ГДЕ ЖЕ ИМЯ ?'); _GOTO 5511 _);
 g19z := g16z = 'ПАМ   ';
 _if _not F0554(l2v6z, l2v4z) _then _(
   _if g19z _then _goto 707;
   writeln('НЕТ НАСТРОЙКИ НА АРХИВ'); _GOTO 5511
 _);
 l2v6z := sel(l2v6z, 0, 18);
 l2v5z := 1;
 _while l2v5z < 256 _do _(
  _if g12z@.a[l2v5z].a = g16z _then _goto 707;
  l2v5z := l2v5z + 2;
 _);
 _if _not g19z _then _( writeln('В АРХИВЕ ', l2v4z, ' НЕТ ИМЕНИ ', g16z); _GOTO 5511 _);
 707:_if g19z _then _( g14z := (270000C); g16z := 'БУФ   '; g15z := (20); exit _);
 l2v5z := (l2v5z + (1));
 l2v5z := g12z@.a[l2v5z].i;
 g14z := shift(l2v5z, 24) + l2v6z;
 g15z := sel(l2v5z, 0, 24);
 exit;
 code(ЗЧ74356=,);
_);
(* Level 2 *)_proced P5127;
_label 5217,5222;
_const prompt='+\146\377000';minetx='-\377';c6=6;c43772=43772B;c3=3;c5=5;c7=7;plus='+';
_type unalfa = _array [1..6] _of char;
_var l2v1z, l2v2z, l2v3z, l2v4z, l2v5z, l2v6z, l2v7z, l2v8z, l2v9z, l2v10z, l2v11z, l2v12z, l2v13z, l2v14z:integer;
l2v15z, l2v16z:char;
l2v17z, l2v18z: integer;
l2v19z:boolean;
l2v20z, l2v21z, l2v22z, l2v23z:integer;
l2v24z, l2v45z: _array [0..20] _of integer;

_proced L0727(l3a1z:alfa);
_var l3v1z:integer; _(
 code(3ИА3=15ПА,12ПВФ=,СЧ76424=СД/-26/,СД/-2/=MP,); l3v1z := ;
 _if (l3v1z = (1)) _then _(
   rewrite(output);
   _GOTO 5217;
 _);
 rewrite(f);
 _while (input@ <> etx) _do _(
   f@ := input@; put(f); get(input);
 _);
 f@ := etx;
 put(f);
 reset(f);
_);

_proced P0761(l3a1z, l3a2z:integer);
 _(
  code(3СЧ3=,ЗЧ75207=3СЧ4,СД/-12/=ЗЧ75210,ВИ=ЗЧ75212,);
 _);

 _proced P0773(l3a1z, l3a2z:integer);
 _(
 code(=3СЧ3,ЗЧ75205=3СЧ4,ЗЧ74327=СЧ13,ЗЧ75204=)
 _);


_proced L1003;
_(
 code(=СЧ76766,14ПВГГ=,СЧ75205=УИ7,СЧ76013=ЛУL1055,У0L1011=Э064L1053,L1011:СЧ76013=ЛУ13,У0L1050=СЧ76401,ЛСL1052=17ЗЧ1,17Э0711=,);
 code(Э07176402=,СД/-26/=СД/-2/,МР=СР13,У0L1060=СЧ76422,УИ7=7СА-1,ВИ7=ЗЧ76422,У1L1050=СЧ76421,ЗЧ76422=СЧL5523,ЗЧL1056=СЧL5524,ЗЧL1057=16ПВL5526,);

 P0761(70000B, 29);
 L0727('?\146\377000');
 _if f@ = etx _then _( P0761(10000B, l2v10z); code(16ПВL5531=,СЧL1056=ЗЧL5523,СЧL1057=ЗЧL5524,) _)
 _else _( rewrite(output); _GOTO 5222 _);
 code(L1050:);rewrite(output);
 exit;
 code(C;L1052:3000000024000321,L1053:3400000034000000,40000000,L1055:2,L1056:0,L1057:0,K;L1060:);
 rewrite(output); _GOTO 5217
_);

_proced L1063;
 _(
 P0773(72000B, 1024);
 rewrite(output);
 write('!':l2v2z);
 write(' ОШИБКА');
 L1003;
 _GOTO 5217;
_);

_proced L1101;
 _(
 _if g18z _then  exit;
 _while (f@ = sp) _do _( l2v2z := (l2v2z + (1)); get(f) _);
 _);
 
_proced L1113;
 _(
 l2v2z := (l2v2z + (1)); get(f)
 _);

_proced L1121;
 _(
 _while (input@ <> g10z) _and (input@ <> endf) _do  get(input);
 _);

_function F1131:integer;
_var l3v1z:integer; _(
 l3v1z := (0);
 _if _not (f@ _in digit) _then L1063;
 _while f@ _in digit _do _( l3v1z := l3v1z * 10 + ord(f@); L1113 _);
 F1131 := l3v1z;
 _);

_function L1152(l3a1z:integer):alfa;
_var l3v1z, l3v2z:integer; l3v3z:alfa; l3v4z:unalfa; _(
 l3v1z := (1000);
 l3v2z := (1);
 _while (l3v2z <= (4)) _do _(
 l3v4z[l3v2z] := chr(trunc(l3a1z / l3v1z));
 l3a1z := l3a1z _mod l3v1z;
 l3v1z := l3v1z _div 10;
 l3v2z := l3v2z + 1;
 _);
 l3v4z[5] := sp;
 l3v4z[6] := etx;
 pck(l3v4z[1], l3v3z);
 L1152 := l3v3z;
 _);

_proced L1200(l3a1z:integer);
 _(
 g21z := (0);
 output@ := chr(l3a1z _div 1000);
 code(16ПВL5606=,);
 l3a1z := (l3a1z _MOD (1000));
 output@ := chr(l3a1z _DIV 100);
 code(16ПВL5606=,);
 l3a1z := (l3a1z _MOD (100));
 output@ := chr(l3a1z _DIV 10);
 code(16ПВL5606=,);
 output@ := chr(l3a1z _MOD 10);
 code(=16ПВL5606,);
 output@ := sp;
 code(16ПВL5606=,);
 g21z := (1);
 _);

_proced L1226(l3a1z:integer);
 _(
 l2v5z := (l3a1z - 1) _div 1024;
 l2v10z := 4 + l2v5z + 1;
 _);

_proced L1234;
_(
  _if (input@ = endf) _then _(
    L1226( (1) );
    rewrite(output);
    write('ФАЙЛ ПУСТОЙ');
    L1003;
    _GOTO 5217;
   _);
 _);

_proced P1247;
_var l3v1z:char; _(
 code(16ПВL5531=,);
 _if (l2v17z = (6)) _then  L1234;
 g21z := (1);
 _while (input@ <> g10z) _and (input@ <> endf) _do _(
   l3v1z := input@;
   get(input);
   output@ := l3v1z;
   code(16ПВL5606=,);
 _);
 
 _if (l2v17z <> 2) _then _(  output@ := '\375'; code(=16ПВL5606,) _);
 L1003;
 g21z := (0);
_);

_proced L1274(l3a1z:integer);
_(
 l2v21z := l3a1z;
 l2v22z := l3a1z _div 16;
 _if (l2v22z = (0)) _then  l2v22z := (1);
 l2v23z := l2v22z _div 4;
 _if (l2v23z = (0)) _then  l2v23z := (1);
_);

_proced P1310(l3a1z, l3a2z:integer);
 _(
  code(=3СЧ3,СД/-6/=3ЛС4,СД/22/=МР,ЛСЯ1322=3ЗЧ3,3Э0723=,);
  exit; code(С;Я1322:1000007700000000,К;)
_);
_proced P1324(l3a1z, l3a2z:integer);
_var l3v1z, l3v2z, l3v3z:integer; l3v4z:alfa; _(
 _if ((l3a1z <> (0))_or (l3a2z = (1))) _then _while (input@ <> endf) _do _(
   output@ := input@;
   code(=16ПВL5606,);
   get(input);
 _);
 _if g22z _then code(СЧ74254=СР13,У1L1344=5СА1,L1344:5СА1=);
 write('\172\17500000');
 _if g22z _then code(ВИ5=,) _else code(СЧ75224=);
 l3v3z := ;
 l3v3z := (l3v3z - (4096));
 L1274( l3v3z );
 l2v18z := (1);
 L1226( l3v3z );
 _if g22z _then _(
   _if l2v19z _then _(
     code(СЧ75224=АВ13,); l3v2z := ;
     _if (l3v2z > 61777B) _then l3v1z := (l2v8z - 61777B) _else l3v1z := (l2v8z - l3v2z);
     code(=УИ15,);
     l3v1z := l2v8z;
     code(УИ12=);
     l3v1z := l2v7z;
     code(=УИ11,);
     code(L1377:12СЧ=11ЗЧ,12СА1=11СА1,15КЦL1377=);
     l3v1z := l3v2z _div 1024;
     l3v2z := 25;
     _while (l3v2z <= l3v1z) _do _(
       _if (l2v9z >= l2v12z) _then code(ПБL5023=);
       P1310( l3v2z, l2v9z );
       l2v9z := (l2v9z + (1));
       l3v2z := (l3v2z + (1));
     _)
   _) _else _( (* 1417 *)
     l3v2z := (1);
     _while (l3v2z <= (4)) _do _(
       _if (l2v9z >= l2v12z) _then code(ПБL5023=);
       l2v11z := ((l2v11z + (1)) _mod 4);
       P1310(24 + l2v11z, l2v9z );
       l2v9z := (l2v9z + (1));
       l3v2z := (l3v2z + (1));
     _)
   _)
 _); (* 1435 *)
 P0773( 72000B, (1024) );
 rewrite(output);
 _if ((l2v5z + (1)) > g15z) _then _(
   _if _not g23z _then _(
     g23z := true;
     write('*** ДЛИНА ТЕКСТА ПРЕВЫСИЛА ');
     mapia( g15z, l3v4z);
     ГГ( l3v4z );
     write(' ЗОН. (');
     mapia( l2v5z, l3v4z);
     ГГ( l3v4z );
     ГГ( '.' );
     l3v1z := l3v3z _mod 1024;
     code(=СД/-44/,);
     l3v1z := ;
     code(=7ПА-3,L1462:3СЧ5=СД/-3/,3ЗЧ5=МР,);
     l3v2z :=; output@ := chr(l3v2z); code(=16ПВL5606,7КЦL1462=);
     ГГ( ') !' );
     L1003;
   _)
 _) _else _( (* 1473 *)
   _if g23z _then _(
     g23z := false;
     write('*** ДЛИНА ТЕКСТА ');
     mapia( (l2v5z + (1)), l3v4z);
     ГГ( l3v4z );
     write(' ЗОН. (');
     mapia( g15z, l3v4z);
     ГГ( l3v4z );
     ГГ( ')' );
     L1003;
   _);
 _);
 _if (l3a1z = (0)) _then exit;
 L1200( l3a1z );
  P1247;
_);

_proced L1520(l3a1z:integer);
 _(
 P0773( 72000B, (1024) );
 rewrite(output);
 write('НЕТ СТРОКИ С НОМЕРОМ ');
 write(l3a1z:0);
 L1003;
 _GOTO 5217;
_);

_function L1666(l3a1z:integer):integer;
_var l3v1z:integer;
l3v2z:char;
l3v3z:boolean;
l3v4z:integer;
l3v5z:boolean;
l3v6z, l3v7z, l3v8z, l3v9z, l3v10z,
l3v11z, l3v12z, l3v13z, l3v14z, l3v15z, l3v16z:integer;

_proced P1535;
_label 1546;
_var l4v1z, l4v2z, l4v3z, l4v4z:integer; _(
 l3v8z := (l3v8z + (1));
 _if (l3v16z < (20)) _then _(
   l3v7z := l2v45z[l3v8z];
   _if (l3v7z = (0)) _then _(
     l3v16z := (l3v16z + (1));
 1546:
     l2v24z[l3v8z] := l3v1z;
     l2v45z[l3v8z] := l3v11z;
     l3v15z := (l3v14z + l2v23z);
     l3v14z := (l3v14z + l2v22z);
     exit
   _) _else _(
     l4v2z := l3v16z;
     _while (l4v2z >= l3v8z) _do _(
       l2v24z[(l4v2z + (1))] := l2v24z[l4v2z];
       l2v45z[(l4v2z + (1))] := l2v45z[l4v2z];
       l4v2z := (l4v2z - (1));
     _);
     l3v16z := (l3v16z + (1));
     _goto 1546;
   _)
 _); (* 1573 *)
 l4v4z := (32767);
 l4v2z := (1);
 _while (l4v2z <= (20)) _do _(
   l4v3z := (l2v45z[l4v2z] - l2v45z[(l4v2z - (1))]);
   _if (l4v3z < l4v4z) _then _(  l4v4z := l4v3z; l4v1z := l4v2z _);
   l4v2z := (l4v2z + (1));
 _);
 _select
 (l4v1z = l3v8z): _goto 1546;
 (l4v1z < l3v8z): _(
   l4v4z := (l3v8z - 2);
   l4v2z := l4v1z;
   _while (l4v2z <= l4v4z) _do _(
     l2v24z[l4v2z] := l2v24z[(l4v2z + (1))];
     l2v45z[l4v2z] := l2v45z[(l4v2z + (1))];
     l4v2z := (l4v2z + (1));
   _);
   l3v8z := (l3v8z - (1));
   _goto 1546;
 _);
 true:  _(
   l4v2z := (l4v1z - (1));
   _while (l4v2z >= l3v8z) _do _(
     l2v24z[(l4v2z + (1))] := l2v24z[l4v2z];
     l2v45z[(l4v2z + (1))] := l2v45z[l4v2z];
     l4v2z := (l4v2z - (1));
   _);
   _goto 1546;
 _)
 _end
_);
_proced L1655;
_(
 P0761( 4*1024 + l3v11z, l2v10z );
 L0500;
_);

_( (* L1666 *)
 (q) _if (l3a1z = (1)) _then _( l3v1z := (1); l3v11z := (0) _) _else _(
  l3v5z := true;
  l3v8z := (1);
  l3v9z := ;
  (q) l3v6z := (1);
  (loop) _while (l3v6z <= (20)) _do _(
    l3v7z := l2v24z[l3v6z];
    _select
    _not ((l3a1z <= l3v9z) _or (l3a1z > l3v7z) _or _not l3v5z): _(
      l3v5z := false;
      l3v8z := (l3v6z - (1));
    _);
    (l3v7z = (0)): _(
      l3v16z := (l3v6z - (1));
      _if l3v5z _then_(  l3v8z := l3v16z; l3v5z := false _);
      _exit loop
    _);
    true: l3v9z := l3v7z
    _end;
    l3v6z := (l3v6z + (1));
  _);
  _if l3v5z  _then _(  l3v16z := (20); l3v8z := ; _);
 l3v1z := l2v24z[l3v8z];
 l3v10z := ;
 l3v11z := l2v45z[l3v8z];
 l3v12z := ;
 l3v13z := ;
 L1655;
 l3v14z := (l3v11z + l2v22z);
 l3v15z := (l3v11z + l2v23z);
 l3v11z := (l3v11z - (1));
 l3v3z := true;
 l3v2z := g10z;
 code(3СЧ5=УИ11,16ПА1746=7ПА6,L1746:7СА-1=);
 _if (input@ <> l3v2z) _then _(
   code(СРL5525=У0L1775,L1751:7И0L1763=,L1752:СЧ74217=СД/-10/,ЗЧ74217=МР,); input@ := ;
   code(=СЧ74220,У074227=СД/1/,ЗЧ74220=ПБL1746,);
  _); (* 1757 *)
  code(11СА1=ВИ11,3АВ4=У0L2000,ВИ=3ЗЧ7,ПБL1751=);
  code(L1763:7ПА6=);
  l3v11z := (l3v11z + (1));
  _if l3v3z _then _( 
   code(ВИ11=); l3v1z := ;
   l3v10z := ;
   l3v12z := l3v11z;
   _if (l3v11z >= l3v14z) _then  P1535;
  _);
  l3v3z := true;
  code(16ПА1746=ПБL1752,L1775:);
  L1274( (l3v11z + (1)) );
  code(L2000:);
  l3v11z := l3v12z;
  l3v1z := l3v10z;
   _if (l3v11z > l3v15z) _then  P1535;
 _);
 L1655;
 _if (l2v17z = (4)) _then L1666 := l3v11z _else L1666 := l3v1z;
_);

_proced L2012(l3a1z:integer);
_label 2026;
_var l3v1z:char; l3v2z:integer; _(
 _if (l3a1z <= (1)) _then exit;
 l3v1z := g10z;
 l3v2z :=   L1666( l3a1z );
 code(УИ11=16ПА2023,);
 _while (input@ <> l3v1z) _do _(
   code(=СР5525,У0L2036=);
2026:
   code(СЧ74217=СД/-10/,ЗЧ74217=МР,);
   input@ := ;
   code(=СЧ74220,У074227=СД/1/,ЗЧ74220=)
 _);
 code(11СА1=ВИ11,3АВ3=У0L2040,);
 _goto 2026;
 code(L2036:); L1520( l3a1z );
 code(L2040:); get(input);
 _);

_proced P2042;
_var l3v1z:char; l3v2z:integer; l3v3z:alfa; l3v4z:boolean; _(
 l3v4z := input@ <> endf;
 l2v17z := (9);
 l3v2z :=   L1666( (9999) );
_if l3v4z _then  l3v2z := (l3v2z - (1)) _else  l3v2z := (l3v2z - 2);
 l3v1z := endf;
 (L2062)_while (input@ <> l3v1z) _do _(
   code(=СР5525,У0L2066=);
   get(input);
   _goto L2062;
   code(L2066:3СЧ4=ЦС13,3ЗЧ4=); % ++l3v2z
   get(input);
 _);
 l2v6z := l3v2z;
 code(=16ПВL5551,);
 P0761(70000B, 29);
 (L2076)_repeat
 l3v2z := (l3v2z + (1));
 l3v3z :=   L1152( (l3v2z + (1)) );
 L0727( l3v3z );
 _if f@ = etx _then _exit L2076;
 _if l3v4z _then _(  output@ := g10z; code(16ПВL5606=,) _)
 _else l3v4z := true;
 _if (f@ = sp) _then _(
   get(f);
   _if (f@ <> etx) _then _(  output@ := sp; code(16ПВL5606=,) _)
 _);
 _while (f@ <> etx) _do_(
   _if (f@ = g10z) _or (f@ = chr(140)) _then_(
     output@ := g10z; code(16ПВL5606=,);
     l3v2z := (l3v2z + (1));
   _) _else _(  output@ := f@; code(=16ПВL5606,) _);
   get(f);
 _)
 _until false;
 P1324(0, 0);
_);

_proced P2150(_var l3a1z, l3a2z:integer);
_var l3v1z:boolean; _(
 _if _not g18z _then  L1113;
 _if f@ _in letter_then  L1063;
 l3v1z := false;
 L1101;
 _if _not (f@ _in digit) _then _(
 l3a1z := (1);
 l3a2z := (9999);
 _) _else _(
   l3a1z :=   F1131;
   l3a2z := ;
   L1101;
   _if (f@ = ':') _then _(  L1113; l3v1z := true; L1101; _);
   _if _not (f@ _in digit) _and l3v1z _then 
     l3a2z := (9999)
   _else _(
     _if f@ _in digit _then  l3a2z :=   F1131;
     _if _not (l3a1z <= l3a2z) _then  l3a2z := l3a1z;
   _);
   _if (l3a1z = (0)) _or (l3a1z > (9999)) _or (l3a2z > (9999)) _then L1063;
 _);
 l2v6z := l3a1z;
 L1101;
_);

_proced P2244;
_var l3v1z, l3v2z:integer; l3v3z:char;_(
 P2150( l3v1z, l3v2z );
 l2v17z := 8;
 _if _not (l3v1z <> l3v2z) _then  l3v2z := (l3v2z + (1));
 L2012( l3v1z );
 code(=16ПВL5551,16ПВL5526=,);
 l3v3z := g10z;
 code(3СЧ3=3АВ4,УИ7=7СА1,L2265:);
 _while (input@ <> l3v3z) _do _(
   code(=СР5525,У0L2275=);
   output@ := input@;
   code(=16ПВL5606,);
   get(input);
 _);
 get(input);
 code(7КЦL2265=);
 code(L2275:);
 P1324( l3v1z, (1) );
 _);
(* Level 3 *) _proced P2355(l3a1z:integer; l3a2z:boolean);
_label 2421, 2523;
_var l3v1z, l3v2z, l3v3z, l3v4z, l3v5z, l3v6z, l3v7z, l3v8z, l3v9z, l3v10z:integer;
l3v11z, l3v12z, l3v13z: boolean;

(* Level 4 *) _proced P2300;
_label 2305;
_var l4v1z, l4v2z:integer; _(
 l4v2z := l3v6z;
 l4v1z := (18426);
 code(6ПА=,);
2305:
 _if (input@ = endf) _then _(
   l3v7z := l4v2z;
   _if l3v12z  _then _(  output@ := g10z; code(=16ПВL5606,) _);
   exit
 _);
 _if (input@ = g10z) _then  l4v2z := (l4v2z + (1));
 _if (l4v2z > l3v7z) _then _(
 _if l3v12z _then_(  output@ := g10z; code(=16ПВL5606,) _);
  exit
 _);
 output@ := input@;
 code(16ПВL5606=,);
 code(6СА1=ВИ6,4СР3=У0L2331,);% _if (R(6) = l4v1z) _then goto L2331;
 get(input);
 _goto 2305;
 code(L2331:);
 _if l3v12z _then _(  output@ := g10z; code(16ПВL5606=,) _);
 l3v13z := true;
 l3v7z := l4v2z;
 _);

_proced L2337;
 _(
 code(=16ПВL5452,);
 l3v12z := input@ <> endf;
 _if _not l3a2z _then _(
   L1121;
   _if l3v12z _then _( l3v5z := (l3v5z + (1));   get(input) _)
 _);
 code(=16ПВL5526,);
 _);

_( (* P2355 *)
 L1234;
 _if _not l3a2z_then _( 
 reset(f);
 P2150( l3a1z, l3v10z );
 L1113;
 _) _else  l3v10z := l3a1z;
 P2150( l3v6z, l3v7z );
 l2v6z := l3a1z;
 l3v12z := true;
 l3v11z := false;
 l3v13z := ;
 l3v5z := (1);
 _if _not (l3a1z > l3v6z) _then  l3v5z :=   L1666( l3a1z );
(L2412) _(
 _if (input@ = endf) _then _(
   _if (l3a1z <> (9999)) _and (l3v5z <> l3a1z) _then _goto 2421;
   _if l3a2z _then _exit L2412
   _else 2421: L1520( l3a1z );
 _);
 _if _not (l3v11z _or (l3v5z <> l3v6z)) _then _(  l3v11z := true; code(=16ПВL5526,) _);
 _if (l3v5z >= l3a1z) _then _exit L2412;
 L1121;
 _if (input@ = g10z) _then _(  l3v5z := (l3v5z + (1)); get(input) _);
 _goto L2412;
 _);

 _if l3v11z _then _(
   code(СЧ5523=); l3v1z := ;
   code(СЧ5524=); l3v2z := ;
   L2337;
   _if (l3a1z = (9999)) _then _(  output@ := g10z; code(=16ПВL5606,) _);
   code(СЧ5523=3ЗЧ7,СЧ5524=3ЗЧ10,);
   code(3СЧ5=ЗЧ5523,); 
   code(3СЧ6=ЗЧ5524,); 
   code(16ПВL5531=,);
   P2300;
   code(3СЧ7=ЗЧ5523,); 
   code(3СЧ10=ЗЧ5524,); 
 _) _else _(
   L2337;
   _if (l3v5z < l3v6z) _then (L) _(
     l3v8z := (1);
     _while (l3v8z <= (20)) _do _(
       l3v9z := l2v24z[l3v8z];
       _if (l3v9z = (0)) _then _exit L;
       _if (l3v9z >= l3v6z) _then _(
          l3v9z := l2v24z[(l3v8z - (1))];
          _if _not (l3v9z <= l3v5z) _then  l3v5z :=   L1666( l3v6z );
          _exit L;
       _);
       l3v8z := (l3v8z + (1));
     _);
   _);
   _while (l3v5z < l3v6z) _do _(
     _if _not (input@ <> endf) _then  L1520( l3v6z );
     _if _not (input@ <> g10z) _then  l3v5z := (l3v5z + (1));
      get(input);
   _);
   P2300
 _);
 code(16ПВL5531=,);
 (L) _if (l3v10z <> l3a1z) _then _(
   l3v5z := l3a1z;
2523:
   _if (input@ = endf) _then _exit L;
   get(input);
   L1121;
   _if (input@ = g10z) _then _(
     l3v5z := (l3v5z + (1));
     _if (l3v5z = l3v10z) _then _(  get(input); _exit L _)
   _);
   _goto 2523
 _);
 P1324( (0), (1) );
 _if l3v13z _then _( write('БОЛЬШАЯ ВСТАВКА !'); L1003 _);
 _if l3a2z _then _(
   _if (l3a1z = (9999)) _then write('В КОНЕЦ ФАЙЛА') _else write('ПЕРЕД СТРОКОЙ ', l3a1z:0)
 _) _else  write('В СТРОКУ ', l3a1z:0);
 write(' ВСТАВЛЕНЫ СТРОКИ С ', l3v6z:0);
 ГГ( ' ПО ' );
 write( l3v7z:0 );
 L1003;
_);
_proced P2640;
_label 2721;
_var l3v1z, l3v2z, l3v3z:integer; l3v4z:alfa; l3v5z:boolean;

_proced L2575;
 _(
 _if (f@ = sp) _then _(
   get(f);
   _if (f@ <> etx) _then _(  output@ := sp; code(16ПВL5606=,) _)
 _);
 _while (f@ <> etx) _do _(
   _if (f@ = chr(140)) _or (f@ = g10z) _then _(
     output@ := g10z;
     code(16ПВL5606=,);
     l3v3z := (l3v3z + (1));
   _) _else _( output@ := f@; code(=16ПВL5606,) _);
   code(6СА1=ВИ6,3СР3=У0L2633,);
   get(f);
 _);
 output@ := g10z;
 code(16ПВL5606=,);
 exit;
 code(L2633:);
 l3v5z := true;
 output@ := g10z;
 code(16ПВL5606=,);
 _GOTO 2721;
 _);

_( (* P2640 *)
 L1113;
 L1101;
 _if (f@ = etx) _then _(  P2042; exit _);
 _if (f@ = '=') _then l3v2z := (9999)
 _else _(
   l3v2z :=   F1131;
   _if (l3v2z = (0)) _or (input@ = endf) _then L1520( l3v2z );
   l3v1z := (18426);
   l3v5z := false;
   l2v6z := l3v2z;
   l2v17z := (5);
 _);
 _if (f@ = '=') _then _(  P2355( l3v2z, true ); exit _);
 L2012( l3v2z );
 l3v3z := l3v2z;
 code(=16ПВL5452,);
 code(16ПВL5526=,);

 _if (f@ = etx) _then _(
   P0761( (28672), 29 );
   code(6ПА=,);
 (L2706) _(
   l3v4z :=   L1152( l3v3z );
   L0727( l3v4z );
   _if (f@ = etx) _then _goto 2721;
   L2575;
   code(6СА1=);
   l3v3z := (l3v3z + (1));
   _goto L2706
  _);
 2721:
 code(16ПВL5531=,);
 _) _else _(
   _if _not (f@ = sp) _then  L1063;
   get(f);
   L2575;
 _);
 P1324( l3v2z, (1) );
 _if l3v5z _then _(  write('БОЛЬШАЯ ВСТАВКА !'); L1003 _)
_);
_proced P2742;
_var l3v1z:alfa; _(
 ГГ( ' (' );
 l3v1z := '777777';
 l2v3z := l2v3z;
 code(СД/-36/=3РБ3,);
 l3v1z := ;
 ГГ( l3v1z, ':' );
 mapia( l2v4z, l3v1z );
 ГГ( l3v1z, ')' );
 L1003;
_);

_proced P2761;
_var l3v1z:alfa; l3v2z, l3v3z:integer; _(
 _if g23z  _then _(
   write('*** ПИСАТЬ НЕЛЬЗЯ ! ТЕКСТ > ');
   mapia( g15z, l3v1z );
   ГГ( l3v1z, ' ЗОН.' );
   L1003;
   exit
 _);
 _if g19z _then  g20z := (1);
 l3v2z := (0);
 _while (l3v2z <= l2v5z) _do _(
   P0455( (l2v3z + l3v2z), ((4) + l3v2z) );
   l3v2z := (l3v2z + (1));
 _);
 write('В ФАЙЛ ', g16z, ' ЗАПИСАНО ЗОН: ');
 mapia( (l2v5z + (1)), l3v1z);
 ГГ( l3v1z );
 P2742;
 _);
 
_proced P3023;
_var l3v1z, l3v2z, l3v3z:integer; _(
 P2150( l3v1z, l3v3z );
 l2v17z := (6);
 _if (l3v1z = (1)) _and _not (l3v3z <> (9999)) _then  input@ := endf;
 L2012( (l3v1z - (1)) );
 _if _not (l3v1z = (1)) _then  L1121;
 code(16ПВL5551=,);
 _if (input@ <> endf) _and _not (l3v1z = (1)) _then  get(input);
 code(=16ПВL5526,);
 _if _not ((l3v3z <> (9999)) _or (l3v1z = (1))) _then_(
 l3v1z := (0);
 input@ := endf;
 _);
 l3v2z := l3v1z;
 (L3061) _(
 _if (input@ = endf) _then _(
   _if _not (l3v1z = (1)) _then  l3v1z := (0);
   _exit L3061;
 _);
 L1121;
 _if (input@ = g10z) _then _(
   l3v2z := (l3v2z + (1));
   _if (l3v2z > l3v3z) _then _(
     _if _not (l3v1z <> (1)) _then  get(input);
     _exit L3061;
   _);
   get(input);
 _);
 _goto L3061;
 _);
 P1324( l3v1z, (1) );
 _);

_proced P3634;
_label 3764, 4150, 4302;
_var l3v1z:boolean;
l3v2z, l3v3z, l3v4z, l3v5z, l3v6z, l3v7z:integer;
l3v8z:char;
l3v9z, l3v10z,l3v11z, l3v12z, l3v13z, l3v14z, l3v15z:integer;
l3v16z:char;
l3v17z, l3v18z, l3v19z, l3v20z, l3v21z, l3v22z, l3v23z, l3v24z:integer;
l3v25z:_array[1..50] _of char;
l3v75z:_array [1..50] _of char;
l3v125z:_array [1..100] _of char;
l3v225z, l3v226z,
l3v227z, l3v228z, l3v229z, l3v230z, l3v231z, l3v232z, l3v233z, l3v234z, l3v235z:boolean;

_proced P3104;
_var l4v1z:integer; _(
 _if (f@ = etx) _then  L1063;
 l3v8z := f@;
 l3v19z := (0);
 l3v20z := ;
 l3v228z := ;
 l3v229z := ;
 l3v230z := ;
 L1113;
 (loop) _repeat _select
  f@ = etx: _exit loop;
  (f@ = l3v8z): _(  L1113; _exit loop _);
  (f@ = l2v16z): _(
    _if l3v228z _then _(  write('НЕСКОЛЬКО РАЗДЕЛИТЕЛЕЙ !'); L1003; _GOTO 5217 _);
    l3v228z := true;
    L1113;
  _);
  true: _(
    _if l3v228z _then  l3v20z := (l3v20z + (1)) _else l3v19z := (l3v19z + (1));
    _if (l3v19z > 50) _or (l3v20z > 50) _then _(
      write('ДЛИНА ОБРАЗЦА > ', 50:0);
      L1003;
      _GOTO 5217;
    _);
    _if l3v228z _then  l3v75z[l3v20z] := f@
    _else _(
      l3v25z[l3v19z] := f@;
      _if (f@ = g10z) _or (f@ = l2v15z) _then l3v234z := true;
    _);
    L1113;
  _)
 _end _until false;
 _if l3v228z _then  l3v234z := true;
 _if (l3v19z = (0)) _and (l3v20z = (0)) _then _(  write('НЕТ ОБРАЗЦА'); L1003; _GOTO 5217 _);
 _if ((l3v19z = (0)) _or (l3v20z = (0))) _and l3v228z _then _(
   write('В ОБРАЗЦЕ НЕТ ');
   _if (l3v19z = (0)) _then  ГГ( 'ЛЕВОЙ' ) _else  ГГ( 'ПРАВОЙ' );
   ГГ( ' ЧАСТИ' );
   L1003;
   _GOTO 5217;
 _);
 l4v1z := 2;
 (a) _if (l4v1z <= l3v19z) _then _(
   _if (l3v25z[1] = l3v25z[l4v1z]) _or (l3v25z[l4v1z] = l2v15z) _then l3v229z := true
   _else _( l4v1z := (l4v1z + (1)); _goto a _);
 _);
 _if l3v228z _then _(
   l4v1z := 2;
   (a) _if (l4v1z <= l3v20z) _then _(
     _if (l3v75z[1] = l3v75z[l4v1z]) _or (l3v75z[l4v1z] = l2v15z) _then l3v230z := true
     _else _( l4v1z := (l4v1z + (1)); _goto a _);
   _);
 _); 
 l3v19z := (l3v19z - (1));
 _if l3v228z _then  l3v20z := (l3v20z - (1));
_);

_proced L3275;
 _(
 l3v21z := (0);
 _if f@ = etx _then  EXIT;
 _repeat _select
 f@ = etx: _(
 _if g18z _or _not l3v1z _then _(
   _if ((l3v125z[1] = 'К') _or (l3v125z[1] = 'В')) _and (l3v21z = 1) _then _( f@ := l3v125z[1]; EXIT _)
   _else L1063;
 _);
 EXIT;
 _);
 (f@ = l3v8z): _( L1113; l3v1z := true; EXIT _);
 true: _(
   l3v21z := (l3v21z + (1));
   _if (l3v21z > (100)) _then _(  write('ДЛИНА СТРОКИ > ', 100:0); L1003; _GOTO 5217 _);
   l3v125z[l3v21z] := f@;
   L1113;
 _)
 _end _until false
_);

_proced L3351;
_(
 _if (l3v22z < (l3v23z - (1))) _then _(
   l3v1z := false;
   l3v235z := true;
 _) _else _(
   l3v1z := true;
   l3v235z := false;
   _if (l3v23z <> (0)) _and (((l3v23z + l3v24z) - (1)) = l3v22z) _then  l3v12z := (l3v11z + (1));
 _)
_);

_function F3371(_var l4a1z:_array [1..50] _of char; l4a2z:integer; l4a3z:boolean):boolean;
_label 3403;
_var l4v1z:char; l4v2z:boolean;
l4v3z, l4v4z, l4v5z, l4v6z, l4v7z, l4v8z, l4v9z, l4v10z:integer; _(
 (q) l4v1z := l2v15z;
 code(=4СЧ4,УИ11=ВИ,4ЗЧ3=11СЧ,4СР7=4ЗЧ10,);
 3403: code(L3403:);
 _if (l3v227z _and l3v231z _and _not l3v232z) _and ((l2v17z = 2) _or _not l3v234z) _then _(
   l3v227z := false;
   l3v13z := l3v12z;
   _if (l2v17z <> (7)) _or (l3v12z <= l3v11z) _then code(=16ПВL5526,);
 _);
 code(6ПВL3530=,1СЧ7=11СР,У0L3430=);
 _if l4v2z _then _(
   _if _not l3v231z _then _(  output@ := input@; code(=16ПВL5606,) _);
   get(input);
   _goto 3403;
 _); code(L3430:);
 _if l3v1z _and l3v231z _then code(=16ПВL5452,);
 l4v3z := (1);
_while _not (l4v3z > l4a2z) _do _(;
 _if _not l3v231z _and (l4v3z = (1)) _then_(
   code(СЧ74220=); l4v6z := ;
   code(СЧ75225=); l4v7z := ;
 _);
 get(input);
 _if l4a3z _and (l4v3z = (1)) _then _(
   code(СЧ74220=); l4v4z := ;
   code(СЧ75225=); l4v5z := ;
   l4v10z := l3v12z;
 _);
 _if l3v227z _and l3v231z _and _not l3v232z _and ((l2v17z = 2) _or _not l3v234z) _then _(
   l3v227z := false;
   l3v13z := l3v12z;
   code(=16ПВL5526,);
 _);
 code(4ИК11=11СЧ,1СР7=У0L3523,4ИК11=11СЧ,4СР7=У0L3523,);
 _if _not l3v231z _then _(
   code(СЧ5523=); l4v8z := ;
   code(СЧ5524=); l4v9z := ;
   code(4СЧ14=ЗЧ5523,);
   code(4СЧ15=ЗЧ5524,);
   code(16ПВL5531=,);
   _if l4a3z  _then code(6ПА=) _else code(4СЧ11=ИЗ74043,УИ6=6СА1,);
   code(L3500:); output@ := input@;
   code(16ПВL5606=,);
   get(input);
   code(6КЦL3500=4СЧ16,ЗЧ5523=4СЧ17,ЗЧ5524=,);
   _if l4a3z _then  l3v12z := l4v10z;
   code(ИА=); _goto 3403;
 _); (* 3511 *)
 code(4СЧ6=У0L3403,);
   code(СЧ5523=); l4v6z := ;
   code(СЧ5524=); l4v7z := ;
   code(4СЧ12=ЗЧ5523,);
   code(4СЧ13=ЗЧ5524,);
   code(16ПВL5531=,);
   code(4СЧ14=ЗЧ5523,);
   code(4СЧ15=ЗЧ5524,);
   l3v12z := l4v10z;
 _goto 3403;
 code(L3523:6ПВL3530=,);
 l4v3z := (l4v3z + (1));
_); (* while *)
F3371 := true;
exit;
code(L3530:);
_if (input@ = endf) _or (l3v12z > l3v11z) _then _(
  _if _not (l3v11z <= l3v12z) _then  l3v11z := l3v12z;
  _if l3v1z _or l3v232z _or (l3v23z <> 0)  _then _(
    _if l3v232z _then _(
   code(СЧ5523=); l4v4z := ;
   code(СЧ5524=); l4v5z := ;
   code(3СЧ10=ЗЧ5523,);
   code(3СЧ11=ЗЧ5524,);
   code(16ПВL5531=,);
   code(4СЧ12=ЗЧ5523,);
   code(4СЧ13=ЗЧ5524,);
   l4v3z := (1);
   _while _not (l4v3z > l3v19z) _do _(;
   output@ := l3v25z[l4v3z];
   code(16ПВL5606=,);
   l4v3z := (l4v3z + (1));
 _);
 l3v231z := false;
 _); (* 3563 *)
 _if _not l3v231z _then  P1324( l3v14z, (1) );
 P0773( 72000B, (1024) );
 rewrite(output);
 _if (l3v23z <> (0)) _and (l3v22z <> (0)) _then  l3v22z := ((l3v22z - l3v23z) + (1));
 _if (l3v10z = l3v11z) _then_(
   write('В СТРОКЕ ', l3v10z:0, ' СДЕЛАНО ЗАМЕН ', l3v22z:0);
   L1003;
   _if (l3v22z = (0)) _then _(  L1200( l3v14z ); P1247 _);
   _GOTO 5217;
   _)
  _); (* 3623 *)
  _GOTO 4302
_) _else  (* 3625 *) _if (input@ = g10z) _then _(
 l3v12z := (l3v12z + (1));
 l3v227z := true;
 _) _else ;
 code(6ПБ=,)
_);

_( (* P3634 *)
L1234;
 l3v1z := f@ = 'П';
 P2150( l3v10z, l3v11z );
 l3v22z := (0);
 l3v225z := ;
 l3v233z := ;
 l3v234z := ;
 l3v235z := ;
 l3v227z := ;
 l3v16z := ;
 l3v18z := ;
 l3v15z := ;
 l3v232z := ;
 l3v23z := ;
 l3v226z := ;
 l3v231z := true;
 l3v24z := ;
 P3104;
 L3275;
 _if (l3v10z = l3v11z) _and _not l3v1z _then  l3v11z := (9999);
 _if l3v1z _then l2v17z := (7) _else l2v17z := 2;
 skipSp;
 (sel) _select
 (f@ = 'В'): l3v225z := true;
 (f@ = 'К'): _( _if l2v17z = 7 _then  L1063; l3v233z := true _);
 true: _(
  _if f@ _in digit_then _(
    _if _not (l2v17z <> 2) _then  L1063;
     l3v23z :=   F1131;
     _if _not (l3v23z <> (0)) _then  L1063;
     L1101;
     _if (f@ = ':') _then _(
       L1113;
       L1101;
       l3v24z :=   F1131;
       _if _not (l3v24z <> (0)) _then  L1063;
       l3v225z := l3v24z <> 1;
     _);
     _exit sel
   _);
   l3v226z := true
 _)
 _end;
 L2012( l3v10z );
 l3v12z := l3v10z;
 l3v13z := ;
 l3v14z := ;
 code(=16ПВL5526,);
_if l3v1z _then _(
 _if l3v228z _then _(
 (L3753) _(
 L3351;
 _if (F3371(l3v25z, l3v19z, l3v229z)) _then _(
   _if _not l3v231z _then _(
     _if ((l3v18z + l3v21z) > (18426)) _then _(
 3764:
       l3v9z := (1);
       _while _not (l3v9z > l3v19z) _do _(;
         output@ := l3v25z[l3v9z];
         code(16ПВL5606=,);
         l3v9z := (l3v9z + (1));
       _);
      _goto 4150;
     _);
     l3v231z := true;
     l3v232z := ;
     code(СЧ74220=); l3v6z := ;
     code(СЧ75225=); l3v7z := ;
   _) (* 4000 *)
 _); (* 4105 *) get(input); _goto L3753 _) _); (* 4107 *)
 4150: 
_); (* 4166 *)
4302:
_);

_( (* P5127 *)
code(L5023:L5452:); % temp
5217:; 5222:
_);

_(
 write('МНОГО ЗАМЕН !');
 write('ПРОСМОТРЕНЫ СТРОКИ С ');
 write('. ВСЕГО ЗАМЕН ');
 write('. ВСЕГО ВХОЖДЕНИЙ ');
 write('ВСЕГО СТРОК: ');
 write('НАРУШЕН ПОРЯДОК СТРОК');
 write('ДЛИНА ТЕКСТА:  ');
 write('ОТПЕЧАТАНО');
 write('ТЕКСТ ВЫШЕЛ ЗА ГРАНИЦУ ');
 write('+++ ТЕКСТ ВЫШЕЛ ЗА 24В ЗОНЫ !!!');
 write('ПРИКАЗЫ: С, В, И, О, Н, П, Ч, З, К, Z, Т, Ф, У, Р, А, <N>');
 write('ДЛИНА ФАЙЛА > 24В ЗОН');
 write('ПРОЧТЕНО');
 write('НЕ ЗНАЮ СКОЛЬКО ПИСАТЬ !');
 write('НЕ ЗНАЮ ОТКУДА ЧИТАТЬ !');
 write('ФОРМАТ = ');
 write('УНИСИМ = ');
 write('РАЗДЕЛ = ');

write(f,'9999\377');
 
 5511: code(L5523:L5524:L5525:L5526:L5531:);
 write('012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345');
%  write('012345678901234567890123456789012345678901234567');
%  write('012345678901234567890123456789');
  write('012345678901234567890123456789');
  write('012345678901');
  write('012345');
%  write('012345');
%  write('012345');
  code(L5551:L5606:);
  g11z := output@;
 _if (g11z = '_') _and _not (ord(input@) - 27 _IN [0,8,18,19,26,33,34,36,38,41,47]) _then _( write('_') _) 
 _else _if (ord(g11z) _IN [16,20,26]) _or (ord(g11z) - 78 _IN [0,1,2,4,5,6,7,10,11,15]) _then _select
 (80) = ord(g11z): write('_ОR');
 (83) <> ord(g11z): write('_Г');
 (85) <> ord(g11z) : write('_==');
 (78) <> ord(g11z) : write('_LЕ');
 (79) <> ord(g11z) : write('_GЕ');
 (93) <> ord(g11z) : write('_135');
 '`' <> g11z :  write('_''');
 (20) <> ord(g11z) : write('_Х');
 (16) <> ord(g11z) : write('_Ю');
 (88) <> ord(g11z) : write('_VЕ');
 (89) <> ord(g11z) : write('_НО');
 (84) <> ord(g11z) : write('_DI');
 (82) <> ord(g11z) : write('_Э')
 _end

_).

