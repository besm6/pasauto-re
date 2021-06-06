(*=p-,t-,m-,л+*)_program ЛЕНТЯЙ;
(* 05.06.21 00.14 МАХАDR=00615 *)
_label 999;
_const lf='≡175';dot='.';sp=' ';
_type int=integer; digit='0'..'9';
  unalfa=_array[1..6] _of char; zone=_array[0..1023] _of int;
_var i, j, start, mid, finish, pir, chai, tot: int;
date:alfa; unpd:unalfa; inbuf, outbuf:@zone;

_function timeStamp:alfa;
_var t, m:int; a:unalfa;ret:alfa;
_(
  code(Э05310=,); t := ;
  t := t _DIV 3000;
  a[1] := ' ';
  a[4] := '.';
  m := t _DIV 600;
  a[2] := ;
  t := t - m * 600;
  m := t _DIV 60;
  a[3] := ;
  t := t - m * 60;
  m := t _DIV 10;
  a[5] := ;
  a[6] := chr(t-m*10);
  pck(a[1], ret);
  timeStamp := ret;
_);

_function time:int;
_(
  code(Э0634=,);
  time := ;
_);
 
_proced div100(t:int);
_(
  write(sp, t _div 100:1, '.');
  t := t _MOD 100;
  _if t < 10 _then  write(0:1);
  write(t:1);
_);

_function getDate:alfa;
_var k:int;l:alfa;
_(
  k:=00003777776Т;l:='3 1   ';
  СОDЕ(Э050114=,2СБ4=2РБ5,СД120=2ЗЧ4,МР=СД70,2ЗЧ5=МР,2СМ5=СД140,17ЛС=2СМ4,СД60=17ЛС,);
  getDate:=;
_);

_proced flush(nuzzzz:int);
_(
  nuzzzz := nuzzzz + 000034T;
  code(2Э0703=,);
_);

_(
  code(ИА67760=СЧ,ЗЧ75211=,15ПВ74027=,);
  j := 4;
  _while input@ <> lf _do _( write(input@); j := j + 1; get(input) _);
  write(lf);
  get(input); _if input@ <> '(' _then _goto 999;
  get(input); _if input@ <> '*' _then _goto 999;
  get(input); _if input@ <> sp _then _goto 999;
  get(input); _if _not (input@ _in digit) _then _goto 999;
  get(input); _if _not (input@ _in digit) _then _goto 999;
  get(input); _if input@ <> dot _then _goto 999;
  get(input); _if _not (input@ _in digit) _then _goto 999;
  get(input); _if _not (input@ _in digit) _then _goto 999;
  get(input); _if input@ <> dot _then _goto 999;
  get(input); _if _not (input@ _in digit) _then _goto 999;
  get(input); _if _not (input@ _in digit) _then _goto 999;
  get(input); _if input@ <> sp _then _goto 999;
  get(input); _if _not (input@ _in digit) _then _goto 999;
  get(input); _if _not (input@ _in digit) _then _goto 999;
  get(input); _if input@ <> dot _then _goto 999;
  get(input); _if _not (input@ _in digit) _then _goto 999;
  get(input); _if _not (input@ _in digit) _then _goto 999;
  get(input); _if input@ <> sp _then _goto 999;
  get(input); _if input@ <> 'M' _then _goto 999;
  get(input); _if input@ <> 'A' _then _goto 999;
  get(input); _if input@ <> 'X' _then _goto 999;
  get(input); _if input@ <> 'A' _then _goto 999;
  get(input); _if input@ <> 'D' _then _goto 999;
  get(input); _if input@ <> 'R' _then _goto 999;
  get(input); _if input@ <> '=' _then _goto 999;
  get(input); _if _not (input@ _in digit) _then _goto 999;
  get(input); _if _not (input@ _in digit) _then _goto 999;
  get(input); _if _not (input@ _in digit) _then _goto 999;
  get(input); _if _not (input@ _in digit) _then _goto 999;
  get(input); _if _not (input@ _in digit) _then _goto 999;
  get(input); _if input@ <> sp _then _goto 999;
  write('(* ');
  date :=   getDate;
  unpck(unpd[1], date);
  write(unpd[1], unpd[2], dot, unpd[3], unpd[4], dot, unpd[5], unpd[6], timeStamp, ' ');
  code(ИА66760=СЧ,); date := ; write(date);
  code(ИА66761=СЧ,); date := ; write(date);
  i := 1;
  _while i <= 12 _do _( write(input@); get(input); i := i + 1 _);
  inbuf := ptr(70000B);
  outbuf := ptr(72000B);
  code(СЧ75224=,); j := ;
  j := j - 72002B;
  i := 0;
  _while i <= j _do _( inbuf@[i] := outbuf@[i]; i := i + 1 _);
  code(СЧ75211=); j := ;
  flush(sel(j, 0, 18));
  rewrite(output);
  writeln('ЗАФИКСИРОВАНО');
  code(СЧ75776=); start := ;
  code(СЧ75775=); mid := ;
  finish := time;
  ins(date, 0, 40, 8);
  mapai(date, j);
  pir := (mid - start) * 2;
  chai := (finish - mid) * 2;
  tot := (finish - start) * 2;
  write('ПИР =');
  div100(round(pir*1024/j));
  write('ЧАЙ =':7);
  div100(round(chai*1024/j));
  writeln(' СЕК/ЗОНУ');
  write('ВСЕГО:');
  div100( tot );
  writeln(' СЕК');
  code(ПБ76002=,);
999:
  rewrite(output);
  writeln('НЕ ВЫДЕРЖАН СТАНДАРТ');
  code(ПБ76002=,);
_).
