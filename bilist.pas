(*=p-,t+*)_program BILIST;
_const c57=57;c58=58;c122=122;eol='{175';c97=97;c98=98;c99=99;
c100=100;c101=101;c102=102;thous=1000;ss='Ь';c40=40;repl='{174';
_type let = 'A'..'Z'; dig='0'..'9'; mask=_set _of 0..47; spec='{141'..'{146';
ar1000 = _array [1..1000] _of char;
state = (s0, s1, s2);
ar7000 = _array [1..7000] _of char;
_var ch:char;
A:ar1000;
g2z:state;
interl, g4z, p, right, cur, g8z, pgright, pgleft:integer;
adj, mono, hyphen, g14z, center, g16z, cont:boolean; conti:integer;
ГЛ, cmds, ЙЬ:mask;
start, g23z, pnum:integer;
doLnum, g1035z:boolean;
lineno, lpp, foo:integer;
W:ar7000;
_procedure P1410;
_var rem: integer;
_procedure doLine;_label 2472;_var i: integer;
_procedure P0162;_var j: integer;
_( (* P0162 *)
  _case g2z _of
  s0: _( W[p] := A[1]; p := p + 1; _);
  s1: _if g4z=2 _then_(W[p]:=A[1]; W[p+1]:=; p:=p+2_)_else_(W[p]:=A[1]; W[p+1]:=repl; W[p+2]:=chr(g4z-1); p:=p+3 _);
  s2: _for j _to g4z _do _( W[p] := A[j]; p := p + 1; _) _end;
_);
_procedure addSp(n:integer); _var i: integer;
_(  rem:=rem-n; _for i _to n _do _( W[p]:=' '; p:=p+1_) _);
_procedure P0315; _label 1577, 1664, 2073; _var t: integer;
_procedure getDec(_var v:integer); _var i:integer; _(
  i := 0;
  _while input@ _in dig _do _( i := i * 10 + ord(input@); get(input) _);
  v := i;
_);
_procedure isPlus(_var r: boolean); _( get(input); r := input@ = '+'; _);
_( (* P0315 *) (start) _( ch := input@; get(input);
  (rep) _if (ch = '{172') _then _( cont := false; conti := 0; _GOTO 2472; _)
  _else _if (ch = eol) _or (ch = '{341') _then _( g1035z := false; _GOTO 2472; _)
   _else _( _if ch = input@ _then _( _if ch = ss _then _( get(input);
  1577: _if (ord(input@) _IN cmds) _then _case input@ _of
          'Л': ch:='{141'; 'Н': ch:=eol;    'З': ch:='{144'; 'К': ch:='{142';
          'И': ch:='{143'; 'Е': ch:='{172'; 'M': ch:='{146';
          '-': _(
    _repeat _while input@ <> ss _do get(input);get(input);ch:=input@;get(input);
    _until (ch = ss) _and (input@ = '+'); get(input); _goto start;
          _)
          _end;
          get(input); _goto rep;
        _) _else  _if _not (ch _in let) _then _(
          g4z := 1;
          _repeat g4z := g4z + 1; get(input); _until (input@ <> ch);
          A[1] := ch;
          g2z := s1;
        _) _else 1664: _(
          g4z := 1;
          A[1] := ch;
          g2z := s2;
          (LOOP) _while (input@ _in let) _or
            (mono _and (input@ <> ' ') _and (input@ < '{141')) _do _(
            _if input@ = ss _then _(
              get(input);
              _if input@ = ss _then _( input@ := '{145'; exit _);
              g4z := g4z + 1;
              A[g4z] := ss; _goto LOOP; _);
            g4z := g4z + 1; A[g4z] := input@; get(input);
          _); (q) _exit q; _); _goto 2073; _);
      _if ch _in spec _then _case ord(ch)-ord('{141') _of
      0: _( cont := false; _GOTO 2472; _);
      1: _( g23z := ord(input@); get(input); _if g23z > 40 _then g23z := 40;
        t := g23z - (57 - rem); _if t >= 1 _then addSp(t); _goto start; _);
      2: _( ch := input@; hyphen := ; get(input); _goto start; _);
      3: _( center := true; _GOTO 2472; _);
      4: _goto 1577;
      5: _( _if (input@ = 'N') _then doLnum := true
        _else _if (input@ = 'M') _then isPlus(mono)
        _else _if (input@ = 'B') _then isPlus(adj)
        _else _if (input@ = 'C') _then _( get(input);getDec(pnum);_goto start _)
        _else _if (input@ = 'L') _then _( get(input); lpp := ord(input@);
        _) _else _if input@ > '4' _then interl := 4
        _else _( interl := ord(input@); (q) _exit q; _);
        get(input); _goto start; _)
    _end _else _if (ch > '{200') _then _(
      g4z := ord(ch) - 128; A[1] := ' '; g2z := s1;
    _) _else _if (input@ = repl) _then _(
      A[1] := ch; get(input); g4z := ord(input@); g2z := s1; get(input);
    _) _else _if (ch <> ' ') _and mono _then _goto 1664
    _else _if (ch _in let) _then _goto 1664
    _else _if (ch _in dig) _then _( g4z := 1; A[1] := ch; g2z := s2;
      _while (input@ _in dig) _and (g4z < 50) _do _(
        g4z := g4z + 1;
        A[g4z] := input@; get(input);
      _);
    _) _else _( g2z := s0; A[1] := ch; g4z := 1; (q) _exit q; _);
  _);
2073: _)_);
_procedure P0702; _var i, j, L, foo:integer; s, s2: _set _of boolean;
_procedure P0635; _(
  _for i _to L _do _( W[p] := A[i]; p := p + 1; _); W[p] := '-';
  p := p + 1; _for i := L + 1 _to g4z _do _( A[i - L] := A[i]; _);
  g4z := g4z - L; rem := rem - L - 1;
_);  
_( (* P0702 *) _if rem = 57 _then _( L := 57; P0635; exit; _);
  _if _not hyphen _then exit; s := [];
  _for i _to g4z _do _( (* loop1 *) s := s + [ord(A[i]) - 32 _IN ГЛ]; 
    _if (s = [false, true]) _then _(
      s := [];
       _for j := g4z _downto 1 _do _(
        s := s + [ord(A[j]) - 32 _IN ГЛ];
        _if (s = [false, true]) _then _(
          _if (j > rem - 1) _then j := rem - 1;
          _if (j > i) _then _(
            _for L := j _downto i _do
_if ((ord(A[L])-32 _IN ГЛ)=(ord(A[L+1])-32 _IN ГЛ)) & ~(ord(A[L+1])-32_IN ЙЬ) 
  | (L <> j) & (ord(A[L])-32 _IN ГЛ) & ~ (ord(A[L+1])-32 _IN ГЛ)
              _then _( P0635; exit _)
            exit _) _else exit
        _) _); exit _)
  _) (* loop1 *);
_);
_function L1045(l4a1z:integer):integer; _(
 _if (l4a1z <> (0)) _or g1035z _then _( L1045 := l4a1z; g1035z := true; _)
 _else L1045 := ord(' ')
_);
_procedure adjust;_var i, j:integer;
_(
  _if _not adj _then exit;
  (l) _for i := p - 1 _downto start _do
    _if (W[i] <> ' ') _then _exit l _else _(
      p := p - 1;
      rem := rem + 1;
    _);
  _for i := p - 1 _downto start _do
    _if (rem <= 0) _then exit
    _else _if (W[i] = ' ') _then _(
      _for j := p - 1 _downto i _do W[j + 1] := W[j];
      p := p + 1;
      rem := rem - 1;
    _);
_);
_( (* doLine *)
  _if cont _then _(
    rem := 57; _if (g23z <> 0) _then addSp(g23z);
    _if doLnum _then _if _not g1035z _then _( g1035z := false; rem := rem - 5;
        W[p] := chr(L1045(lineno _DIV 1000)); p := p + 1;
        W[p] := chr(L1045(lineno _MOD 1000 _DIV 100)); p := p + 1;
        W[p] := chr(L1045(lineno _MOD 100 _DIV 10)); p := p + 1;
        W[p] := chr(lineno _MOD 10); p := p + 1;
        W[p] := '.';  W[p+1] := ' '; p := p + 2;
        lineno := lineno + 1;
        g1035z := true;
      _) _else addSp(5);
    _if g16z _then g16z := false _else P0315;
    _if (g2z = s0) _and (A[1] = ' ') _and _not doLnum _then P0315;
    _while g4z <= rem _do _( P0162; rem := rem - g4z; P0315; _);
    _if (rem > 57 - 20) _and (g2z = s2) _then _(
      _for i _to rem _do _( W[p] := A[i]; p := p + 1; _);
      _for i := rem + 1 _to g4z _do A[i - rem] := A[i];
      g4z := g4z - rem;      rem := 0;      g16z := true;
    _) _else _case g2z _of
      s0: _if (ord(A[1]) _IN [10..17,19..22,25..28,30,31])
         _then _( P0162; rem := rem - 1; _) _else g16z := true;
      s1: _( g4z := g4z - rem;
        _for rem := rem _downto 1 _do _( W[p] := A[1]; p := p + 1; _);
         g16z := true; rem := 0; _);
      s2: _( P0702; g16z := true _)
      _end; adjust;
  _); 2472:  W[p] := eol;
  p := (p + 1);
_);
_procedure P1340; _var L, half, i, last, next:integer; _(
  _if (rem > 4) _then _( half := rem _div 2; next := p + half; last := next - 1;
    p := p - 1; L := 57 - rem + 1;
    _for i _to L _do _( W[last] := W[p]; last := last - 1; p := p - 1; _);
    _for i _to half _do _( W[start] := ' '; start := start + 1; _);
    p := next;
_)_);
_( (* P1410 *)  cont := odd(conti);  _for cur _to lpp _do _( center := false;
    doLine; _if g14z _then P1340;
    _for g8z _to interl _do _( cur := cur + 1;
      _if cur <= lpp _then _( W[p] := eol; p := p + 1; _)
    _);
    start := p; g14z := center; center := false;
  _);
_);
_procedure HR;_( writeln('{131{174{176');  writeLN; writeLN; writeLN; _);
_procedure doPage; _const sp =' '; _(  HR;  cur := 1;  g8z := right;
  _if (pgleft <> 0) _then write(' {174[- ', pgleft:0, ' -');
  _if (pgright <> 0) _then write('{173"- ', pgright:0, ' -');
  writeln(eol:0+1, eol:0+1);
  _repeat write('  ');_while (W[cur]<>eol) _do _( write(W[cur]); cur:=cur+1 _);
    cur := cur + 1; write('{173N');
    _while (W[g8z] <> eol) _do _( write(W[g8z]); g8z := g8z + 1; _);
    g8z := g8z + 1;
    writeLN;
  _until cur = right;
%  _if doLnum _then writeLN;
  writeLN;
  writeLN;
  writeLN;
  writeLN;
_);
_procedure init;
_(
  mono := true;
  adj := true;
  cmds := [ord('К')..ord('Н'),ord('З'),ord('И'),ord('Е'),ord('-')];
  hyphen := true;
  g14z := false;
  g23z := 0;
  g16z := false;
  pnum := 1;
  conti := 1;
  ГЛ := [0,5,8,14,19,26,28:30,34,35,41];
  doLnum := false;
  lineno := 2;
  g1035z := false;
  lpp := 58;
  ЙЬ := [9,27];
  interl := 0;
_);

_( (* BILIST *)
  init;
  writeln('ПАСКАЛЬ-ПРОГРАММА ЛИСТИНГ В ДВЕ КОЛОНКИ.ВЕРС ОТ 14.2.80':74);
  writeLN;
  _repeat
    p := 1;
    start := p;
    P1410;
    pgleft := pnum;
    pnum := pnum + 1;
    right := p;
    P1410;
    pgright := pnum;
    pnum := pnum + 1;
    (* _if inMap(pgleft, pagemap) _or inMap(pgright,  pagemap) _then *)
      doPage;
  _until conti = 0;
  HR;
  writeLN;
_).
