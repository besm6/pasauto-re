(*=p-,t-*)_program pretty;
_label 4661, 4704, 4731;
_const F=false;T=true;drum=270000B; nzones=16; sp=' ';spaces='      ';lf='≡175';
colon=':';comma=',';qu='''';oparen='(';cparen=')';star='*';
begin='begin ';end='end   ';goto='goto  ';nil='nil   ';c132=132B;
select='select';case='case  ';kexit='exit  ';var='var   ';const='const ';
type='type  ';functi='functi';proced='proced';label='label ';eq = '=';
plus='+';etx='≡377';if='if    ';for='for   ';then='then  ';else='else  ';
do='do    ';to='to    ';downto='downto';with='with  ';while='while ';
repeat='repeat';until='until ';c170=170B;over='^';dot='.';array='array ';
file='file  ';set='set   ';extern='extern';record='record';packed='packed';
in='in    ';semi=';';endf='≡172';
_type
   int=integer;
   bool=boolean;
   letter='a'..'z';
   digit='0'..'9';
   unalfa=_array[1..6]_of char;
   mode=(m0, m1, m2, m3, m4);
   intArray=_array [1..1022] _of int;
   charArray=_array [1..11024]_of char;
   string=_record
     s:_array[1:30] _of char;
     l:int
   _end;
_var pos,indent,lineNum,len : int;
   g14z,savPos,idx,g17z,indIncr:int;
   outNum, g20z, g21z      : int;
   toFile            : bool;
   tok, g24z: alfa;
   g25z: bool;
   g26z, g27z, g28z,
   g29z, g30z, g31z, g32z:bool;g33z:bool;
   g33a, g64a, g95a:string;
   g127z:int;
   g127a:intArray;
   buf: charArray;
   g12174z:int;
   a12174:_array[1:30] _of char;
   cbfSize:int;
   commBuf:_array[1..100] _of char;
(* Level 2 *) _proced endLn;
_var l2v1z, l2v2z, l2v3z:integer; _(
 _if toFile _then write(lf) _else _(
   writeLN;
   l2v3z := outNum;
   l2v2z := 1000;
   l2v1z := 1; 
   _while l2v1z <= 4 _do _(
     write(l2v3z _div l2v2z:0);
     l2v3z := l2v3z _MOD l2v2z;
     l2v2z := l2v2z_div 10;
     l2v1z := l2v1z + 1;
   _);
   outNum := outNum + 1;
   write(sp);
 _);
 pos := 0;
 _);
(* Level 2 *) _proced bufc(l2a1z:char);
 _(
 buf[idx] := l2a1z;
 idx := (idx + 1);
 _);
(* Level 2 *) _proced GG(l2a1z:alfa);
_var l2v1z:bool; l2v2z:int; l2v3z:unalfa;
_(
 l2v1z := F;
 unpck( l2v3z[1], l2a1z );
 l2v2z := 1;
 _while l2v2z <= 6 _do _(
   _if l2v3z[l2v2z] <> '0' _then  l2v1z := T;
   _if l2v1z _then  bufc( l2v3z[l2v2z] );
   l2v2z := l2v2z + 1;
 _);
 _);
(* Level 2 *) _proced bufstr;
_var l2v1z:integer; _(
 l2v1z := 1;
 _while l2v1z <= len _do _(
   bufc( g33a.s[l2v1z] );
   l2v1z := l2v1z + 1;
 _);
 _);
(* Level 2 *) _proced error(l2a1z:integer);
 _(
 rewrite(output);
 writeln('ОШИБКА=':15, l2a1z:0, sp, 'СИМ=', input@, ' СТР=', lineNum);
 writeln('КОНТЕКСТ=');code(16ПВCTXT=,); _GOTO 4661;
 _);
(* Level 2 *) _proced P0535;
_label 572, 707;
_var l2v1z, l2v2z, l2v3z, l2v4z, l2v5z, l2v6z, l2v7z:int;
l2v8z:_record c:_array[1:9] _of char _end;
l2v17z:char; _(
 _if _not (idx <> 0) _then  exit;
 l2v4z := (g17z + 1);
 l2v5z := g20z;
 idx := (idx - 1);
 l2v8z := [ ';', 81, 80, '*', '/', '+', '-', ',', 15];
 _if g31z _or g32z_then  l2v8z := [ ,   ',',  ':',  '=',  ')',  '(',  '+',  '-'];
 572: write(sp:g17z);
 _if (idx < l2v5z) _then _(
   l2v1z := l2v4z;
   _while (l2v1z <= idx) _do _( write(buf[l2v1z]); l2v1z := (l2v1z + 1) _);
   endLn;
   indIncr := 0; idx := ; g32z := ; g31z := ; g127z := ;
   exit
 _) _else _(
   l2v5z := (l2v5z - 1);
(L0615) _(
 l2v1z := 1;
 _while (l2v1z <= 9) _do _( (q);
  l2v17z := l2v8z.c[l2v1z];
   l2v2z := l2v5z;
  _while (l2v2z >= l2v4z) _do _(
 _if (buf[l2v2z] = l2v17z) _then _(
  _if (g127z <> 0) _then _(
   l2v6z := 1;
   _while (l2v6z <= g127z) _do _(
   _if (g127a[(l2v6z * 2)] > l2v2z) _and
    (g127a[((l2v6z * 2) - 1)] < l2v2z) _and
     (l2v1z <> 9) _then _goto 707;
   l2v6z := (l2v6z + 1);
 _)_);
 l2v3z := l2v4z;
 _while l2v3z <= l2v2z _do _( write(buf[l2v3z]);  l2v3z := (l2v3z + 1) _);
 endLn;
 g17z := g17z + indIncr;
 indIncr := 0;
 l2v4z := l2v2z + 1;
 l2v5z := l2v4z + g20z - g17z;
 _if buf[l2v4z] = sp _then _(  l2v4z := l2v4z + 1; l2v5z := l2v5z + 1 _);
 _if l2v4z >= idx _then _(  indIncr := 0; idx := ; g32z := ; g31z := ; g127z := ; exit _);
_goto 572;
 _);
 l2v2z := l2v2z - 1;
 _); 
 707: l2v1z := l2v1z + 1;
 _);
 _if g127z <> 0 _then _( g127z := 0; _goto L0615 _)
 _);
 error(999);
 _)
_);

(* Level 2 *) _proced putName;
_var l2v1z:int; l2v2z:unalfa; _(
 g30z := F;
 _if g24z <> spaces _then _(
   GG( ' (* ' );
   unpck( l2v2z[1], g24z );
   g24z := spaces;
   l2v1z := 1;
   _while l2v1z <= 6 _do _(
     _if l2v2z[l2v1z] <> sp _then  bufc( l2v2z[l2v1z] );
     l2v1z := l2v1z + 1;
   _);
   GG( ' *)' );
 _);
 P0535;
 _);

(* Level 2 *) _proced L0743;
 _(
 _if g25z _then _( g25z := F;  putName _);
 _);

(* Level 2 *) _proced L0751(l2a1z:integer);
 _(
 write( sp: (indent + l2a1z) );
 _);

(* Level 2 *) _proced L0756(l2a1z:integer);
 _(
 g17z := (indent + l2a1z);
 idx := (g17z + 1);
 _);
 
(* Level 2 *) _proced putc(l2a1z:char);
 _(
 write(l2a1z);
 pos := (pos + 1);
 _if (pos > 7777777777B) _then  pos := 0;
 _);

(* Level 2 *) _proced L0773(l2a1z:alfa);
_var l2v1z:unalfa; l2v7z:int; l2v8z:bool; _(
 l2v8z := F;
 unpck( l2v1z[1], l2a1z );
 l2v7z := 1;
 _while (l2v7z <= 6) _do _(
   _if _not (l2v1z[l2v7z] = '0') _then  l2v8z := T;
   _if l2v8z _then  putc( l2v1z[l2v7z] );
   l2v7z := (l2v7z + 1);
 _);
_);
(* Level 2 *) _proced skipSp;
_label 1017;
 _(
1017:
 _while (input@ = sp) _do  get(input);
 _if (input@ > chr(127)) _then _( get(input); _goto 1017 _);
 _if _not (input@ = lf) _then  exit;
 lineNum := (lineNum + 1);
 get(input);
_goto 1017; (q);
_);

(* Level 2 *) _proced upTo(l2a1z:char);
_label 1035;
 _(
1035:
 _while (input@ <> l2a1z) & (input@ <> lf) _do _(  putc( input@ ); get(input) _);
 _if input@ = l2a1z _then _(  putc( input@ ); get(input); exit _);
 lineNum := lineNum + 1;
 get(input);
 L0773( '(≡175)' );
 _goto 1035;
_);
(* Level 2 *) _proced bufUpTo(l2a1z:char);
_label 1057;
 _(
1057:
 _while (input@ <> l2a1z) & (input@ <> lf) _do _(
 bufc( input@ );
 get(input);
 _);
 _if (input@ = l2a1z) _then _(  bufc( input@ ); get(input); exit _);
 GG( '_==175' );
 lineNum := lineNum + 1;
 get(input);
 _goto 1057; (q); 
_);
(* Level 2 *) _proced literal;
 _(
 _while (input@ = qu) _do _(  putc( input@ ); get(input); upTo( qu ) _)
 _);
 
(* Level 2 *) _proced bufLiteral;
_var l2v1z:integer; _(
 _while input@ = qu _do _(
   g127z := g127z + 1;
   l2v1z := ;
   g127a[l2v1z*2 - 1] := idx;
   bufc( input@ );
   get(input);
   bufUpTo( qu );
 _);
 g127a[l2v1z*2] := idx - 1;
 _);

(* Level 2 *) _proced P1134;
_var l2v1z:integer; _(
 len := g33a.l;
 l2v1z := 1;
 _while l2v1z <= len _do _(
   putc( g33a.s[l2v1z] );
   l2v1z := l2v1z + 1;
 _);
 _);
(* Level 2 *) _proced number;
 _(
 _while input@ _in digit _do _( putc(input@); get(input) _);
 _if (input@ = 'T') _or (input@ = 'C') _or (input@ = 'B') _then _(  putc( input@ ); get(input) _);
 _);
(* Level 2 *) _proced getIdent;
_var l2v1z:integer; _(
 l2v1z := 1;
 tok := spaces;
 unpck(g33a.s[1], tok );
 _while (input@ _in letter) _or (ord(input@) < 10) _do _(
   g33a.s[l2v1z] := input@;
   get(input);
   l2v1z := l2v1z + 1;
 _);
 pck(g33a.s[1], tok);
 len := l2v1z - 1;
 g33a.l := len;
 skipSp;
 _);
(* Level 2 *) _proced getKeyword;
 _(
 get(input);
 _if input@ _in letter _then getIdent
 _else _(
   _if input@ = oparen _then _(
     tok := 'ВЕGIN ';
     len := 5;
     unpck(g33a.s[1], tok );
   _) _else _if input@ = cparen _then _(
     tok := 'ЕND   ';
     len := 3;
     unpck(g33a.s[1], tok );
   _) _else  error( 50 );
   get(input);
 _);
 skipSp;
_);
 
(* Level 2 *) _proced saveComm;
_var i:integer; _(
 _if g33z _then _(
   cbfSize := cbfSize + 1;
   i := ;
   _if i > 100 _then  error( 99 );
   commBuf[i] := input@;
 _)
_);

_proced chkComment;+

(* Level 2 *) _proced doComment;
_label 1332;
_var l2v1z, l2v2z:int; l2v3z:bool; _(
 get(input);
 l2v1z := lineNum;
 _if input@ = '=' _then_(
_repeat
 get(input);
 _if (input@ = 'C') _or (input@ = 'А') _or (input@ = 'I') _or (input@ = 'M') _then _(
   g12174z := g12174z + 1;
   l2v2z := ;
   a12174[l2v2z * 2 - 1] := input@;
 get(input);
 a12174[l2v2z * 2] := input@;
 get(input);
 _) _else _(
 get(input);
 get(input);
 (q) _exit q;
 _);
 _until input@ <> ',';
 _);
1332:
 _while _not ((input@ = '*') _or  (input@ = lf) _or (input@ = oparen) _or (input@ = endf)) _do _(
   saveComm;
   get(input);
 _);
 _if (input@ = endf) _then _(
   writeln('НЕЗАКРЫТЫЙ КОМ. СТР.= ', l2v1z:0);
   _GOTO 4661;
 _);
 _if input@ = lf _then _(  lineNum := lineNum + 1; get(input); _goto 1332 _);
 _if input@ = oparen _then _(
   saveComm;
   get(input);
   l2v3z := g33z;
   g33z := F;
   _if input@ = '*' _then _(
     _if l2v3z _then  cbfSize := cbfSize - 1;
     doComment;
   _);
   g33z := l2v3z;
   _goto 1332;
 _) _else _(
   saveComm;
   get(input);
   _if input@ <> cparen _then _goto 1332;
   get(input);
   _if g33z _then  cbfSize := cbfSize - 1;
   skipSp;
 _); (* 1411 *)
 _if _not ((cbfSize = 0) _or _not g33z) _or (g12174z <> 0) _then _(
   _case g21z _of
   1: _(
     _if _not (input@ _in letter) _and (input@ <> '_') _and (input@ <> oparen) _then endLn;
     L0751(3);
   _);
   2,3: _( _if pos <> 0 _then  endLn;  L0751( 3 ) _);
   4: _( _if (idx <> 0) _and (g17z + 1 <> idx) _then  P0535; L0751( 0 ) _)
   _end;
   write('(*');
   _if g12174z <> 0 _then write(eq);
   l2v2z := 1;
   _while l2v2z <= g12174z _do _(
     write(a12174z[l2v2z * 2 - 1], a12174z[l2v2z * 2]);
     _if l2v2z <> g12174z _then write(comma);
     l2v2z := l2v2z + 1;
   _);
   l2v2z := 1;
   _while l2v2z <= cbfSize _do _( write(commBuf[l2v2z]); l2v2z := l2v2z + 1 _);
   write('*)');
   endLn;
   _case g21z _of
   0:;
   1:_if _not (input@ _in letter) _and (input@ <> '_') _and (input@ <> oparen) _then L0751(6);
   2,3:_if input@ <> '_' _then _(  L0751( 6 ); pos := indent + 6 _);
   4: _if input@ = '_' _then idx := 0 _else L0756( 0 )
   _end;
   g12174z := 0;
   cbfSize :=;
 _);
 chkComment;
_);
_proced chkComment+ _(
 skipSp;
 _if input@ = oparen _then _( get(input); _if (input@ = '*') _then  doComment _)
_);

(* Level 2 *) _proced L1577;
 _(
 write(sp: (indent + 3) );
 write('_LАВЕL ');
 (lab) _(
   chkComment;
   getIdent;
   P1134;
   chkComment;
   _if input@ = ',' _then _(
     get(input); write(comma, sp);
     _goto lab
   _)
 _);
 _if input@ <> semi _then  error( 81 );
 write(semi);
 endLn;
 get(input);
 chkComment;
 _if input@ <> '_' _then  error( 82 );
 getKeyword;
 _);
(* Level 2 *) _proced L1640;
 _(
 _select
 (input@ = ':') : _(
   get(input);
   _if (input@ = '=') _then _(   get(input); GG( ' := ' ); _) _else  GG( ': ' );
 _);
 (input@ = sp): skipSp;
 (input@ = qu): bufLiteral;
 (input@ = '<'): _(
   get(input);
   _if (input@ = '>') _then_(  GG( ' # ' ); get(input) _) 
  _else _if (input@ = '=') _then _(  GG( ' ≤ ' ); get(input) _)
 _else GG( ' < ' );
 _);
 (input@ = '>'): _(
   get(input);
   _if (input@ = '=') _then _(  GG( ' ≥ ' ); get(input) _) _else  GG( ' > ' );
  _);
  (input@ = '='): _( get(input); GG( ' = ' ) _);
  (input@ = '#'): _( get(input); GG( ' # ' ) _);
  (input@ = '≥'): _( get(input); GG( ' ≥ ' ) _);
  (input@ = '≤'): _( get(input); GG( ' ≤ ' ) _);
  (input@ = oparen): _(
    get(input);
   _if (input@ = '*') _then doComment _else bufc( oparen);
  _);
  (input@ = ','): _(  get(input); GG( ', ' ) _);
  (input@ = lf): _(  get(input); lineNum := (lineNum + 1) _);
   T: _( bufc( input@ ); get(input) _)
 _end
_);
(* Level 2 *) _proced L1756;
_( _select
 (tok = 'NОТ   '): bufc( chr(83) );
 (tok = 'АND   '): bufc( chr(81) );
 (tok = 'ОR    '): bufc( chr(80) );
 T: _( _if tok <> 'NIL   ' _then bufc( sp ); bufc( '_' ); bufstr; bufc( sp ) _)
_end
_);
(* Level 2 *) _proced L2005;
_label 2007;
 _(
 2007: _select
  (input@ = ':') _and g29z: exit;
  (input@ = '_') _and _not g29z: exit;
  (input@ = '_'): _(  getKeyword; L1756 _);
 T: L1640
 _end;
  _goto 2007
_);

_proced L2236(l2a1z:char);+

(* Level 2 *) _proced L2026;
_label 2030;
 _(2030:
   L2005; getKeyword;
 _if (tok = 'ТНЕN  ') _then _(
   indIncr := 4;
   P0535;
   indent := (indent + 3);
   L0756( 0 );   GG( '_ТНЕN ' );   L2236( ';' );
   _if (tok <> 'ЕLSЕ  ') _then _(  g25z := T; indent := (indent - 3); exit _);
   putName;  L0756( 0 ); GG( '_ЕLSЕ ' ); g30z := F; L2236( ';' );
   indent := (indent - 3);
   g25z := T;
   exit
 _) _else  L1756;
 _goto 2030
_);

(* Level 2 *) _proced L2071;
_label 2073;
 _( 2073:
 L2005;
 getKeyword;
 _if (tok = 'ТО    ') _or (tok = 'DОWNТО') _then _(  GG( ' _' ); bufstr; bufc(sp) _)
 _else _if (tok = 'DО    ') _then _(  GG( ' _DО ' ); L2236( ';' ); g25z := T; exit _)
 _else  L1756;
 _goto 2073;
 _);

(* Level 2 *) _proced L2121;
_label 2124;
 _(
 indent := indent + 3;
2124:
 L0756( 0 );
 g29z := T;
 L2005;
 GG( ' : ' );
 get(input);
 g29z := F;
 g33z := T;
 chkComment;
 g33z := F;
 L2236( ';' );
 g25z := T;
 g30z := F;
 _if (tok = 'ЕND   ') _then _( 
 putName;
 indent := indent - 3;
 L0756( 0 );
 GG( '_ЕND ' );
 g25z := T;
 exit;
 _);
 bufc( ';' );
 putName;
 get(input);
 _goto 2124;
 _);

(* Level 2 *) _proced L2160;
_label 2162;
_( 2162:
 L2005; getKeyword;
 _if tok = 'DО    ' _then _( indIncr := 7; GG( ' _DО ' ); L2236( ';' ); g25z := T; exit _)
 _else L1756;
 _goto 2162;
 _);

(* Level 2 *) _proced L2200;
 _( L2236(sp); putName; L0756(0); bufc('_'); GG( 'UNТIL ' ); indIncr := 7; L2236( ';' ) _);

(* Level 2 *) _proced setStmt(l2a1z:alfa);
 _( _if g24z = spaces _then  g24z := l2a1z; _);

_proced L2236+
_label 2245, 2322, 2674;
_var l2v1z, l2v2z:bool;
l2v3z, l2v4z, l2v5z:bool; l2v6z:integer;
(* Level 3 *) _proced L2223;
 _(
 _if (l2a1z <> sp) _then P0535
 _else _if l2v2z _then _( P0535; l2v2z := F _)
 _);

_( (* L2236 *)
 indent := (indent + 3); l2v1z := T; l2v3z := ; l2v2z := F; l2v4z := ; l2v5z := ;
2245:
 skipSp;
 _select
 input@ _in letter: _(
  _if l2v1z & (l2a1z = sp) _then _(  L0756( 0 ); l2v1z := F _);
  l2v3z := F; getIdent; bufstr;
  _if (tok = 'WRIТЕ ') _or (tok = 'WRIТЕL') _then  g32z := T;
  _if (tok = 'СОDЕ  ') _then _(
    g31z := T;
    l2v6z := 1;
    bufc(oparen);
    get(input);
    _while (l2v6z <> 0) _do _(
    _if (input@ = cparen) _then l2v6z := (l2v6z - 1)
    _else _if _not (input@ <> oparen) _then  l2v6z := (l2v6z + 1);
    _if (input@ <> lf) _then bufc( input@ )
    _else lineNum := lineNum + 1;
    get(input);
  _)
 _) _else  l2v5z := T
 _);
 input@ = '_': _(
    getKeyword;
2322:
 _select
 (tok = 'ЕND   '): _(
   indent := indent - 3;
   _if l2a1z = sp _then _(
     _if g25z _or _not l2v1z _then putName;
     L0756( 0 );
    GG( '_ЕND ' );
     g25z := T;
     g28z := F;
   _) _else  g28z := T;
   exit
 _);
 (tok = 'ВЕGIN '): _(
   _if l2a1z <> sp _then  P0535;
   L0751( 0 );
   write('_BEGIN');
   endLn;
   g25z := F;
   L2236(sp );
   g30z := T;
 _);
 (tok = 'ЕLSЕ  '): _(  indent := indent - 3; g28z := T; exit _);
 (tok = 'САSЕ  '): _(
   L2223; L0756( 0 ); GG( '_САSЕ ' ); L2005;
   getKeyword; GG( ' _ОF ' ); P0535; L2121; setStmt( 'САSЕ  ' )
 _);
 (tok = 'SЕLЕСТ'): _(  L2223; L0751( 0 ); write('_SЕLЕСТ'); endLn; L2121; setStmt( 'SЕLЕСТ' ) _);
 (tok = 'IF    '): _(  L2223; L0756( 0 );
   GG( '_IF ' );
   L2026;
   _if g30z _then  setStmt( 'IF    ' );
   _if g28z _then _goto 2322
 _);

 (tok = 'FОR   '): _(
   L2223;
   L0756( 0 );
   GG( '_FОR ' );
   L2071;
   _if g30z _then  setStmt( 'FОR   ' );
   _if g28z _then _goto 2322
 _);
 (tok = 'WIТН  '): _(
   L2223;
   L0756( 0 );
   GG( '_WIТН ' );
   L2160;
   _if g30z _then  setStmt( 'WIТН  ' );
   _if g28z _then _goto 2322
 _);
 (tok = 'WНILЕ '): _(
   L2223;
   L0756( 0 );
   bufc( '_' );
   GG( 'WНILЕ ' );
   L2160;
   _if g30z _then  setStmt( 'WНILЕ ' );
   _if g28z _then _goto 2322
 _);
 (tok = 'RЕРЕАТ'): _(
   L2223;
   L0751( 0 );
   write('_RЕРЕАТ ');
   endLn;
   L2200;
   g25z := T;
   _if g28z _then _goto 2322
 _);
 (tok = 'UNТIL '): _(
   indent := indent - 3;
   _if l2a1z = sp _then g28z := F _else g28z := T;
  exit
 _);
 T: _(
   _if l2v1z_and (l2a1z = sp) _then _(  l2v1z := F; L0756( 0 ) _);
   l2v3z := F;
   _if (tok <> 'NIL   ') _and
    (tok <> 'GОТО  ') _and
    _not (tok = 'ЕХIТ  ') _then  bufc(sp);
   _select
   (tok = 'NОТ   '): bufc( chr(83) );
   (tok = 'АND   '): bufc( chr(81) );
   (tok = 'ОR    '): bufc( chr(80) );
   T: _( bufc( '_' ); bufstr _)
   _end;
   bufc( sp );
   l2v3z := F;
  _)
  _end
 _);
 (input@ = ';'): _(
   l2v3z := T;
   _if l2a1z = ';' _then _(
     indent := indent - 3;
     g28z := F;
     tok := ';';
     exit
   _);
   GG( '; ' );
   l2v2z := _not g25z;
   _if g25z _then  l2v1z := T;
   L0743;
   get(input);
   skipSp;
   _while input@ = ';' _do _(  get(input); skipSp _);
 _);
 (input@ = qu): bufLiteral;
 (input@ = oparen): _(
   get(input);
 _if input@ = '*' _then doComment _else _(
   skipSp;
   _if input@ _in letter _then _(
     getIdent;
     _if input@ = cparen _then _(
       _if ((buf[idx-1] _in letter) _or (buf[idx-1] _in digit)) _and l2v5z _then _goto 2674;
       get(input);
       _if _not (l2v1z _or (l2a1z <> sp)) _or
       _not (_not l2v1z _or (l2a1z = sp)) _then P0535;
       l2v1z := F;
       L0756( 0 );
       GG( '( ' );
       bufstr;
       GG( ' )' );
       L2236( ';' );
       _if g28z_then _goto 2322;
     _) _else 2674: _( bufc(oparen); bufstr _)
   _) _else bufc(oparen);
  _)_);
  T: _( _if (input@ _in digit) _and l2v3z _then _(
  l2v4z := T;
   _if _not l2v1z _then _(
   _if idx <> 0 _then _if g17z + 1 <> idx _then  P0535;
   l2v1z := T;
   _)_);
   _if l2v1z _and (l2a1z = sp) _then _( L0756( 0 ); l2v1z := F _);
   l2v3z := F;
   _if l2v4z _then _(
     l2v4z := F;
     g29z := T;
     L2005;
     g29z := F;
     get(input);
     GG( ': ' );
     L2236( ';' );
     _if g28z _then _goto 2322;
   _) _else  L1640
  _)
 _end; _goto 2245; (q)
_);
(* Level 2 *) _function F2746:bool;
_label 2760;
 _(
 F2746 := F;
 _if (input@ = '+') _or (input@ = '-') _then _(
   putc( input@ );
   get(input);
   skipSp;
2760:
   _if input@ _in digit _then _( number; exit _)
   _else _(
     _if input@ _in letter _then _( getIdent; P1134; F2746 := T; exit _);
     error(84)
   _)
 _) _else _if (input@ = qu) _then _(  literal; exit _)
   _else _if (input@ = '_') _then _(
   getKeyword;
   putc('_' );
   P1134;
   _if (tok = 'NIL   ') _then exit;
   error( 390 );
 _) _else _goto 2760;
 F2746 := F;
 _);
(* Level 2 *) _proced P3017;
_label 3022, 3027, 3040, 3061;
_var l2v1z:bool; _(
 l2v1z := T;
 3022:
 _if input@ _in letter _then _(
   getIdent;
   P1134;
3027:
   chkComment;
   _if input@ = '.' _then _(
    get(input);
     skipSp;
     _if input@ <> '.' _then  error( 200 );
3040:
     L0773( ' .. ' );
     get(input);
     chkComment;
     _if F2746 _then ;
   _);
   _if input@ = ':' _then _goto 3040;
   chkComment;
   exit
 _);
 _if input@ = oparen _then _(
   get(input);
   _if input@ = '*' _then _( doComment; _goto 3022 _);
   L0773( '( ' );
  3061:
   chkComment;
   _if input@ _in letter _then _(
     getIdent;
     P1134;
     chkComment;
     _if input@ = ',' _then _(  get(input); L0773( ', ' ); _goto 3061 _);
     _if input@ = cparen _then _(  get(input); L0773( ' )' ); chkComment; exit _);
     error( 201 );
  _); (* 3103 *)
  error( 202 );
 _); (* 3105 *)
 _if input@ _in digit _then _( number; l2v1z := F; _goto 3027 _);
 _if input@ = qu _then _( literal; _goto 3027 _);
 _if (input@ = '+') _or (input@ = '-') _then _(  get(input); putc( input@ ); _goto 3022 _);
 error( 203 );
_);

_proced L3264;+

(* Level 2 *) _proced L3126;
_label 3143, 3173;
 _(
 _if (input@ = '@') _then _(
   putc( input@ );
   get(input);
   skipSp;
   _if (input@ = '_') _then _goto 3143;
   getIdent;
   P1134;
   chkComment;
   exit
 _);
3143: _if input@ = '_' _then _(
  getKeyword;
  _select
  (tok = 'FILЕ  '): _(
   _if (input@ = '_') _then _(
     getKeyword;     L0773( '_FILЕ ' ); L0773( '_ОF ' ); L3126;
   _) _else  error( 204 );
 _);
 (tok = 'АRRАУ '): _(
 _if (input@ <> '[') _then  error( 205 );
 L0773( '_АRRАУ' ); L0773( ' [ ' );
 3173:
 get(input);
 P3017;
 _if (input@ = ',') _then _( L0773( ', ' ); _goto 3173 _);
 _if (input@ <> ']') _then  error( 206 );
 L0773( ' ] _ОF' ); putc( ' ' );
 get(input);
 skipSp;
 _if (input@ <> '_') _then  error( 207 );
 getKeyword;
 L3126;
 _);
 (tok = 'SЕТ   '): _(
   _if _not (input@ = '_') _then  error( 208 );
   write('_SЕТ _ОF ');
   getKeyword;
   P3017;
 _);
 (tok = 'РАСКЕD'): _goto 3143;
 (tok = 'RЕСОRD'): _(
   savPos := pos;
   endLn;
   L0751( savPos - indent );
   write('_RЕСОRD');
   endLn;
   savPos := savPos + 3;
   pos := ;
   L0751( savPos - indent );
   L3264;
   savPos := savPos - 3;
 _);
 T: error(209)
  _end;
  chkComment; exit
 _);
 P3017
_);

_proced L3264+
_label 3267, 3323, 3411, 3414, 3420, 3432;
_var l2v1z, l2v2z:integer; _(
 l2v2z := savPos;
3267:
 chkComment;
 _if input@ _in letter _then _(
   getIdent;
   P1134;
   chkComment;
   _if (input@ = ',') _then _(  get(input); L0773( ', ' ); _goto 3267 _);
   _if _not (input@ = ':') _then  error( 210 );
   get(input);
   L0773( ' : ' );
   L3126;
   _if (input@ = ';') _then _(
     get(input); write(semi); endLn;
     pos := savPos; L0751( savPos - indent );
     _goto 3267;
   _);
3323:
   _if _not (input@ <> ')') _then  exit;
   _if _not (input@ = '_') _then  error( 211 );
   getKeyword;
   _if (tok = 'ЕND   ') _then _(
     endLn;
     savPos := l2v2z;
     write( sp:(savPos - 3), '_ЕND ');
     exit
   _);
   error( 212 );
 _); (* 3346 *)
 _if _not (input@ = '_') _then  error( 213 );
 getKeyword;
 _if (tok = 'САSЕ  ') _then _(
   chkComment;
   write('_САSЕ ');
   _if input@ _in letter _then _(
     getIdent; P1134; chkComment;
     _if (input@ = ':') _then _(  get(input); chkComment; getIdent; write(' : '); P1134; chkComment _);
     _if _not (input@ = '_') _then  error( 501 );
     getKeyword;
     write(' _ОF');
     endLn;
     savPos := savPos + 3;
3411:
     pos := savPos;
     write(sp: savPos);
3414:
     chkComment;
     _if F2746 _then 3420: _(
       chkComment;
       _if (input@ = ',') _then _( get(input); L0773( ', ' ); _goto 3414 _);
       _if (input@ = ':') _then _(
         get(input);
         L0773( ' : ' );
3432:
         _while (input@ <> oparen) _and (input@ <> lf) _do _(  putc( input@ ); get(input) _);
         _if (input@ = oparen) _then _(  putc( input@ ); get(input) _)
         _else _(  lineNum := (lineNum + 1); get(input);  _goto 3432 _);
         putc( ' ' );
         l2v1z := savPos;
         savPos := pos;
         L3264;
         savPos := l2v1z;
         _if input@ <> cparen _then  error( 502 );
         get(input);
         write(' )');
         chkComment;
         _if (input@ = ';') _then _( get(input); write(semi); endLn; _goto 3411 _);
         _goto 3323;
       _);
       error(503);
     _); _goto 3420;
   _); error(505);
 _); (* 3502 *)
 error(215);
_);
(* Level 2 *) _proced L3504;
_label 3516;
 _(
 indent := (indent + 6);
 L0751( -3 );
 write('_ТУРЕ');
 endLn;
 chkComment;
3516:
 L0751( 0 );
 pos := indent;
 savPos := ;
 _if input@ _in letter _then _(
   getIdent;
   L0773( tok );
   chkComment;
   _if _not (input@ = '=') _then  error( 216 );
   L0773( ' = ' );
   get(input);
   L3126;
   _if _not (input@ = ';') _then  error( 217 );
   write(semi); endLn;
   get(input);
   chkComment;
   _if (input@ = '_') _then _(  getKeyword; indent := (indent - 6); exit _)
 _) _else  error( 216 );
 _goto 3516; (q)
_);

_proced L4134(_var s: string);+

(* Level 2 *) _proced L3562(l2a1z:bool);
_label 3606, 3637, 3670, 3720;
_var l2v1z:bool; l2v2z:int; l2v3z:string;
_(
 g25z := F;
 getIdent;
 P1134;
 l2v3z := g33a;
 l2v2z := len;
 l2v3z.l := l2v2z;
 skipSp;
 _if (input@ = '+') _then _( get(input); chkComment; write(' + '); endLn; _goto 3637 _);
3606:
 _if l2a1z & (input@ = ':') _then _(
   get(input);   skipSp; write(' : ');
   _if input@ _in letter _then _(  getIdent; P1134 _) _else  error( 101 );
   chkComment;
 _);
 _if (input@ = ';') _then _(
   get(input);
   skipSp;
   write(semi);
   _if _not (input@ <> '+') _then  write(' +');
   endLn;
3637:
   g33z := T;
   chkComment;
   g33z := F;
   L4134( l2v3z );
   skipSp;
   chkComment;
   _if (input@ = '_') _then _(  getKeyword; exit _);
   error( 65 );
 _);
 _if _not (input@ = oparen) _then  error( 66 );
 get(input);
 _if (input@ = '*') _then _(  doComment; _goto 3606 _);
 l2v1z := F;
 write(' ( ');
3670:
 chkComment;
 _if input@ _in letter _then _(
   getIdent;
   P1134;
   chkComment;
   _if (input@ = ',') _then _(  get(input); write(', '); _goto 3670 _);
   _if l2v1z _then _goto 3720;
   _if (input@ <> ':') _then error( 67 );
   get(input);
   write(' : ');
   skipSp;
   L3126;
3720:
   l2v1z := F;
   _if (input@ = ';') _then _(
     get(input); write(semi); endLn;
     write( sp:((indent + 14) + l2v2z));
     _goto 3670;
   _);
   _if (input@ = cparen) _then _(
     get(input);
     write(' )');
     skipSp;
     _goto 3606;
   _);
   error( 68 );
 _); (* 3743 *)
 _if _not (input@ = '_') _then  error( 69 );
 getKeyword;
 l2v1z := F;
 write (chr(90));
 P1134;
 write(sp);
 _if (tok = 'VАR   ') _or (tok = 'FUNСТI') _then _goto 3670;
 _if _not (tok = 'РRОСЕD') _then  error( 70 );
 l2v1z := T;
 _goto 3670;
_);

(* Level 2 *) _proced L3771;
_label 4004, 4026;
 _(
 write( sp:(indent + 3), '_СОNSТ');
 endLn;
 g33z := T;
 chkComment;
 g33z := F;
4004:
 write(sp: (indent + 6));
 _if input@ _in letter _then getIdent _else error( 85 );
 write(tok, ' = ');
 _if _not (input@ = '=') _then  error( 86 );
4026: 
 get(input);
 chkComment;
 _if F2746 _then ;
 chkComment;
 _if (input@ = '/') _or (input@ = '*') _or (input@ = '-') _or (input@ = '+') _then _(
   write(input@);
   _goto 4026;
 _);
 _if (input@ = '.') _or (input@ = 'Е') _then _(
   write(input@);
   _goto 4026;
 _);
 _if _not (input@ = ';') _then  error( 87 );
 get(input);
 write(semi);
 endLn;
 g33z := T;
 chkComment;
 g33z := F;
 _if (input@ = '_') _then _(  getKeyword; exit _);
 _goto 4004;
_);

(* Level 2 *) _proced level;
_var l2v1z:integer; _(
 endLn;
 write( sp:(indent + 2), '(* ');
 l2v1z := 1;
 _while (l2v1z <= 9) _do _( write(plus); l2v1z := (l2v1z + 1) _);
 write( indent _div 3 + 1 : 2, sp);
  l2v1z := 1;
 _while (l2v1z <= 9) _do _( write(plus); l2v1z := (l2v1z + 1) _);
 write(' *)');
 endLn;
 endLn;
 _);

_proced L4134+
_label 4176, 4226, 4244;
_var l2v1z:bool; _(
 l2v1z := F;
 g21z := 1;
 _if (input@ = '+') _then _( get(input); exit _);
 _while (input@ = oparen) _do _(
   get(input);
   _if (input@ = '*') _then doComment _else error( 41 );
 _);
 _if input@ _in letter _then _(
   getIdent;
   _if tok <> 'ЕХТЕRN' _then  error( 800 );
   _if input@ <> ';' _then  error( 801 );
   get(input);
   exit
 _);
_if input@ <> '_' _then  error( 42 );
 getKeyword;
4176:
 _select
 (tok = 'LАВЕL '): _( L1577; _goto 4176 _);
 (tok = 'СОNSТ '): _( L3771; _goto 4176 _);
 (tok = 'ТУРЕ  '): _( g21z := 2; L3504; _goto 4176 _);
 (tok = 'VАR   '): _(
   L0751( 3 );
   g21z := 3;
   write('_VАR');
   endLn;
   L0751( 6 );
   pos := indent + 6;
4226:
   chkComment;
   _if input@ _in letter _then _(
      getIdent;
      _if pos > 115 - len _then _(  endLn; L0751( 6 ); pos := indent + 6 _);
      P1134;
4244:
      _if input@ = ',' _then _( get(input); L0773( ', ' ); _goto 4226 _);
      _if input@ = ':' _then _( get(input); L0773( ' : ' ); skipSp; L3126 _);
      _if input@ = ';' _then _( get(input); write(semi);  endLn; chkComment _);
      _if input@ = '_' _then _( getKeyword; _goto 4176 _);
      _if input@ = oparen _then _(
         get(input);
         _if (input@ = '*') _then doComment _else  error( 45 );
         _goto 4244;
      _);
      write(sp: indent+6);
      pos := indent + 6;
      _goto 4226;
   _); (* 4305 *)
   _if (input@ = oparen) _then _(
     get(input);
     _if (input@ = '*') _then doComment _else error( 46 );
     _goto 4226;
   _);
   error( 47 );
 _);
 (tok = 'РRОСЕD'): _(
   l2v1z := T;
   indent := indent + 3;
   level;
   write(sp: indent, '_РRОСЕDURЕ ');
   L3562( F );
   indent := indent - 3;
   _goto 4176;
 _);
 (tok = 'FUNСТI'): _(
   l2v1z := T;
   indent := indent + 3;
   level;
   write(sp: indent, '_FUNСТIОN  ');
   L3562( T );
   indent := indent - 3;
   _goto 4176;
 _);
 (tok = 'ВЕGIN '): _(
   _if indent = 0 _then _(
     endLn;
     write('(* НАЧАЛО ПРОГРАММЫ ');
     g33a := g95a;
     P1134;
     write(' *)');
     endLn;
   _);
   _if l2v1z _then  endLn;
   indent := indent + 3;
   g25z := F;
   L0751( 0 );
   write('_ВЕGIN');
   endLn;
   g21z := 4;
   L2236( ' ' );
   g21z := 1;
   skipSp;
   _if input@ = ';' _then _(
     get(input);
     GG( '; (* ' );
     GG( 'ЕND ' );
     g33a := s;
     len := s.l;
     bufstr;
     GG( ' *)' );
     P0535;
     indent := indent - 3;
     exit
   _);
   _if input@ <> '.' _then  error( 49 );
   bufc( '.' );
   P0535;
   exit
 _);
 T: error( 50 )
_end
_);
(* Level 2 *) _proced P4452(l2a1z, l2a2z:integer);
_var l2v1z:integer; _(
 l2v1z := 001034T;
 code(2ЦС3=ЗЧ75211,2СЧ4=У076002,АВ13=ЗЧ75212,);
 _);

(* Level 2 *) _proced P4464(l2a1z, l2a2z:integer);
_var l2v1z:int; _(
 l2v1z := 000035T;
 code(2ЦС3=ЗЧ75203,ЗЧ75223=2СЧ4,У076002=ЦС13,ЗЧ75204=,);
 _);
 
(* Level 2 *) _proced L4477(_var l2a1z:integer);
_var l2v1z, l2v2z, l2v3z, l2v4z:int; _(
 code(СЧ75203=2ЗЧ4,СЧ75223=2ЗЧ5,);
 l2v3z := sel(l2v1z, 0, 12);
 l2v4z := sel(l2v2z, 0, 12);
 code(СЧ75223=Э07075223,);
 P4464(drum, nzones);
 rewrite(output);
 l2a1z := ((l2v4z - l2v3z) + 1);
 _);
(* Level 2 *) _proced P4610;
_label 4624;
_var l2v1z, l2v2z:integer;

(* Level 3 *) _function F4515:int;
_var l3v1z:int; _(
 l3v1z := 0;
 _while (input@ < '9') _do _( l3v1z := ((l3v1z * 8) + ord(input@));  get(input) _);
 _if (l3v1z > 671777B) _or (l3v1z < 100000B) _then _(
   writeln('НЕ БУДУ.');
   g14z := (g14z + 1);
   _GOTO 4661;
 _);
 F4515 := l3v1z;
 _while _not (input@ _in digit) _and  (input@ <> etx) _do get(input);
 _if (input@ = etx) _then _(
   write('ПОВТОРИТЕ');
   g14z := (g14z + 1);
   _GOTO 4661;
 _)
_);
(* Level 3 *) _function F4557:integer;
_var l3v1z:integer; _(
 l3v1z := 0;
 _while (input@ < '9') _do _( l3v1z := ((l3v1z * 8) + ord(input@)); get(input) _);
 _if (l3v1z < 1) _or (l3v1z > 37B) _then _(
   writeln('ВЕЛИК МАССИВ');
   g14z := g14z + 1;
   _GOTO 4661
 _);
 F4557 := l3v1z;
 _while input@ = sp _do get(input);
_);

_( (* P4610 *)
 _if (g14z = 5) _then writeln('ДЛЯ ВЫХОДА СДЕЛАЙТЕ "ЕТХ"');
 _if (g14z > 10) _then _goto 4624;
 BIND(' ==> ≡172');
 g27z := F;
 _if (input@ = etx) _then _(
4624:
   writeln('ВЫХОД В ПУЛЬТ');
   code(ПБ76002=,)
 _);
 toFile := F;
 g20z := 120;
 l2v1z :=   F4515;
 l2v2z :=   F4557;
 P4452( l2v1z, l2v2z );
 _if (input@ = '/') _then _(
   get(input);
   l2v1z :=   F4515;
   l2v2z :=   F4557;
   toFile := T;
   g20z := 115B;
   P4464( l2v1z, l2v2z );
   rewrite(output);
 _);
 code(15ПВ74027=,);
_);

_(
  g14z := 0;
 4661:
  rewrite(output);
 indent := 0;
 idx := ;
 pos := ;
 savPos := ;
 indIncr := ;
 g24z := spaces;
 g30z := F;
 outNum := 1;
 g25z := F;
 g27z := F;
 g29z := ;
 lineNum := 1;
 g127z := 0;
 g12174z := ;
 cbfSize := ;
 g33z := ;
 g21z := 0;
 g32z := F;
 g31z := F;
 P4610;
 endLn;
4704:
 chkComment;
 _if input@ = oparen _then _goto 4704;
 _if input@ <> '_' _then  error( 1 );
 getKeyword;
 _if tok <> 'РRОGRА' _then  error( 2 );
 getIdent;
 g95a := g33a;
 write('_РRОGRАМ ');
 P1134;
 write(sp);
4731:
 _if input@ = oparen _then _(
   get(input);
   _if input@ = '*' _then doComment _else write(oparen);
 _);
 _if input@ = lf _then _(  lineNum := lineNum + 1; get(input); _goto 4731 _);
 write(input@);
 _if input@ = ';' _then _(  endLn; get(input); skipSp _) _else _(  get(input); _goto 4731 _);
 L4134(g64a);
 _if input@ <> '.' _then  error( 3 );
 _if toFile _then _(
   write('≡172≡175000000');
   L4477( indent );
   mapia( indent, tok );
   write('ЗАПИСАНО ');
   code(1СЧ27=14ПВ74053,);
   writeln(' ЗОН');
 _);
 P4452(drum, nzones );
 _goto 4661;

_).
