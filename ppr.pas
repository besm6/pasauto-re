(*=p-,t-*)_program ppr;
_label 436,625;
_const strlen=30;
c56=56;c55=55;
(*=a0*)oparen='(';cparen=')';endf='≡140';bang='!';eol='≡073';over='^';(*=a1*)c2=2;c3=3;
ls='    ЛС';ps='    ПС';pr='    ПР';at='    АТ';lt='<';ppr='   PPR';usu='  ОБЫК';c7=7;
_type
kind=(op, cp, sp, smth);
struc=_record next:@struc; len:integer; k:kind; str:_array [1..strlen] _of char _end; pstr=@struc;
_var mode, g11z, maxlen, indent:integer; g14z:kind; curlen, lnum, g17z:integer; g18z:alfa;
g19z, prev:char;
g21z:boolean; g22z:integer;
g23z, g24z, cur, list, tail:pstr;

_proced println;
_(
 g14z := op;
 tail := _NIL;
 _case mode _of
 0: _(
   write(endf:0+1, endf:7);                                     % :0+1 needed for code alignment
   code(5ПА72000=Э064L0077,);
   rewrite(output);
   exit; code(L0077:5ЗЧ=5ЗЧ,4Э040=10ЗЧ,);
 _);
 1: write(g19z:0+1)
 _end
_);


_proced relink;
_var p:pstr; _(
 p := list;
 list := p@.next;
 tail := _NIL;
 _if p@.k = smth _then _(
   p@.next := g23z;
   g23z := p;
 _) _else _(
   p@.next := g24z;
   g24z := p;
 _);
 _);
_proced getch;
_(
  _repeat prev := input@; get(input) _until (prev <> eol);
_);

_proced process(l2a1z:pstr);
_var l2v1z:pstr; match:boolean; i:integer; _(
 match := false;
_repeat
 l2v1z := list;
 match := list = l2a1z;
 _if (list@.k = cp) _or (list@.len <= maxlen) _then _(
   _case list@.k _of
   op: _( indent := indent + 1; write(oparen:0+1) _);
   cp: _( indent := indent - 1; write(cparen:0+1) _);
   sp: write(' ':list@.len);
   smth: _(
     i := 1;
     _while i <= list@.len _do _(
       write(list@.str[i]:0+1);
       i := i + 1;
     _); (q)                                                    % (q) needed for code alignment
   _)
   _end;
   maxlen := maxlen - list@.len;
   relink;
 _) _else _(
   g14z := op;
   println;
   _GOTO 436;
 _);
 _until match;
 _);

_proced L0226;
 _(
 g22z := 1;
 _if (list <> _NIL) _then _(
 cur := list;
 _while cur@.next <> _NIL _do cur := cur@.next;
 process(cur);
 _);
 _GOTO 625;
 _);
_proced L0243(l2a1z:kind);
 _(
 _if l2a1z = smth _then _(
   _if g23z <> _NIL _then _(  cur := g23z; g23z := g23z@.next _)
   _else new(cur)
 _) _else _(
   _if g24z <> _NIL _then _(  cur := g24z; g24z := g24z@.next _)
   _else new(cur)
 _);
 cur@.next := _NIL;
 _if list = _NIL _then list := cur _else tail@.next := cur;
 tail := cur;
_);
_proced P0276;
_var i:integer; k:kind; _(
 _if list <> _NIL _then
   _if tail = _NIL _then _( cur := list; tail := list; exit  _)
   _else _if tail@.next <> _NIL _then _( tail := tail@.next;  cur := tail;  exit_);
 _if prev = ' ' _then _(
   i := 0;
   _repeat
   i := i + 1;
   getch;
   _until prev <> ' ';
   L0243(sp);
   cur@.len := i;
   cur@.k := sp;
 _) _else  _if (prev = cparen) _or (prev = oparen) _then _(
   _if prev = cparen _then k := cp _else k := op;
   L0243(k);
   cur@.len := 1;
   cur@.k := k;
   getch;
 _) _else _if (prev = bang) _and (input@ = endf) _then L0226
 _else _(
   L0243(smth);
   i := 0;
  _while (prev <> ' ') _and (prev <> oparen) _and (prev <> cparen) _and (i <> strlen)
  _and ((prev <> bang) _or (input@ <> endf)) _do _( (* binary-patched conditions? *)
    (q) _exit q;                			% code alignment
    i := i + 1;
    cur@.str[i] := prev;
    getch;
 _);
  cur@.len := i;
  cur@.k := smth;
 _);
_);

_(
 code(ИК76015=ИК3,СЧ2=); g11z :=;
 _if g11z = 0 _then mode := 0
 _else _(
   code(ИК76015=ИК3,ИК2=СЧ,); g18z :=;
   mode := 1;
   _if g18z = '≡175     ' _then g19z := eol _else g19z := over;
 _);
  writeln('ПАСКАЛЬ-ПРОГРАММА ''РRЕТТУ РRINТ FОR LISР''');

 list := _NIL;
 g23z := _NIL;
 g24z := _NIL;
 indent := 0;
 g14z := op;
 g17z := 0;
 lnum := 1;
 g22z := 0;
 getch;
436:
 g21z := false;
 _case g14z _of
 op: _(
   _if mode = 0 _then _(
     write( lnum:4, (*=a0*)'. '(*=a1*), indent:2);
     lnum := lnum + 1;
     _if indent = 0 _then _(
       g17z := g17z + 1;
       write(g17z:5);
     _) _else _(
       write(' ':5);
     _);
     write(' ':indent+1);
   _) _else  _if indent <> 0 _then  write(' ':indent);
   maxlen := 56 - indent;
   tail := _NIL;
   _repeat
     g21z := true;
     P0276;
     _case cur@.k _of
     op: g14z := sp;
     cp: g14z := cp;
     sp: g21z := false;
     smth: g14z := cp
     _end;
     _if cur@.k = sp _then relink _else  process(cur);
   _until g21z;
  _);
  cp:_repeat 
    P0276;
    _if cur@.k = op _then _( g14z := op; println; _goto 436 _);
    process(cur);
  _until g21z;
  sp:_repeat
    P0276;
    _if cur@.k = op _then _( g14z := smth; _goto 436 _);
    _if cur@.k = cp _then _(  g14z := cp; g21z := true; _);
    process(cur);
  _until g21z;
  smth: _(
    g11z := indent + 1;
    curlen := 1;
    _repeat
    P0276;
    _case cur@.k _of;
    op: g11z := g11z + 1;
    cp: _(
      g11z := g11z - 1;
      _if g11z = indent _then _(
        process(cur);
        P0276;
        _while cur@.k = cp _do _(  process(cur); P0276 _);
        println;
        _goto 436;
      _)
    _);
    sp, smth:
    _end;
    curlen := curlen + cur@.len;
    _if curlen > maxlen _then _(  g21z := true; println; g14z := op _);
   _until g21z;
  _)
 _end;
 _goto 436;
 625:
 println;
 write(bang:0+1, endf:0+1);
 _if mode = 0 _then code(ПБ76002=) _else code(СЧ=ЗЧ74003,);
 write('000000000000000000000000'); 			% Needed for const. pool alignment

_).
