(*=p-,t-,m-,c-,k8*)_program compil;
_label 27721;
_const spaces='      ';c128=128;c4096=4096;T=true;F=false;
branch='branch';back='back';kexit='exit';select='select';not='not';and='and';or='or';
label='label';type='type';with = 'with';downto='downto';for='for';repeat='repeat';
until='until';while='while';do='do';to='to';go='go';if='if';then='then';else='else';
goto='goto';begin='begin';in='in';div='div';mod='mod';extern='extern';const='const';
var='var';functi='functi';proced='proced';nil='nil';record='record';case='case';
of='of';end='end';array='array';file='file';set='set';
(*=a0*)
icomma=',';icolon=':';ieq='=';e050='Э050';asn='СД';vm='ВМ';yta='МР';sm='СМ';
mv='МВ';utm='СА';pi='ПИ';aox='ЛС';wtc='ИК';ra='РА';amulx='АУ';adivx='АД';aplusx='АС';
xmina='ОВ';xta='СЧ';utc='ИА';aminx='АВ';vtm='ПА';ita='ВИ';uj='ПБ';u1a='У1';uza='У0';avx='ИЗ';
aex='СР';vjm='ПВ';atx='ЗЧ';aax='ЛУ';z64='Z64';c256=256;utcm10='10ИА';istar='*';
(*=a1*)z='z';c127=127;i6=6400000000000006C;c100=100;
_type sixwords=_array[1..6] _of alfa;bitset=_set _of 0..47;
letter = 'a'..'z';
int=integer;bool=boolean;
word=_record _case int _of
0:(a:alfa);
1:(b:bitset);
2:(l:bool);
3:(i:int);
4:(p:@word);
5:(s:pstr);
6:(id:idptr);
8:(r:real);
10:(pi:pInst)
_end;
 struc=_record 
 _case int _of
 4:(d4: _array [1..4] _of word);
 5:(d5: _array [1..5] _of word);
 6:(d6: _array [1..6] _of word);
 7:(d7: _array [1..7] _of word);
 8:(d8: _array [1..8] _of word);
 9:(d9: _array [1..9] _of word);
 13:(f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12: word)
_end;
 typchain = _record
    f0:@typchain;
    f1,f2:idptr
 _end;
 ident = _record
    _case int _of
    6:(d6: _array [0..5] _of word);
    7:(d7: _array [0..4] _of word; sz, k: int);
    8:(d8: _array [0..7] _of word);
    9:(d9: _array [0..8] _of word);
    13:(nm:alfa;
    f1:word;
    nxt:idptr; (* next *)
    f3:idptr; (* base type of derived type *)
    f4: word;
    vty: idptr; (* variable type *)
    f6, f7, f8, f9, f10, f11, f12: word)
 _end;
 idptr = @ident;
 pstr = @struc;
 expr = _record f0, f1, f2:word; ty:idptr; in:pInst; f5: word _end;
 inst = _record nxt:pInst; f1:int; f2, op:alfa;
   _case int _of 0:(f4: alfa); 1:(f4b:bitset) _end;
 pInst = @inst;
 tkind = (tk0, tkIdent, tkWord, tkInt, tkStr, tkReal, tkChar, tkField);
 extFile = _record nm:alfa; f1, f2, f3: word; nxt: @extFile _end;
_var
   modeB:int;
   rval:real;
   gl12z, gl13z, modeF,
   modeG, gl16z, modeDe, modeCH, modeeL : bool;
   inInclude: bool;
          errcnt, maxerr, gl23z, lineNum, gl25z, gl26z, gl27z, gl28z, poolIdx,
   gl30z, poolStart, poolAddr, gl33z, modeK, gl35z, gl36z:int;
   gl37z, tok, level:alfa;
   gl40z, gl41z, curLab,
   gl43z, gl44z:alfa; gl45z:alfa;
   fname:alfa;
   gl47z:@word;
   endl:char;
   seqGOST, seqITM:char;
   lastChar: char;
   tokKind:tkind;
   gl53z, gl54z, modeA:int; cv:word;
   gl57z, gl58z, modeC,
   gl60z, leftInsn, gl62z, gl63z, errSeen, modeE, modeP, modeT, modeR, modeM,
   modeL, gl71z, modeI, skipping, modeX: bool;
   curId:idptr; 
   gl76z, gl77z,
   textFile, inFile,  outFile:idptr; ptrType, setType,
   boolType, intType, realType, charType, alfaType: idptr;
   gl88z:idptr; gl89z,
   gl90z, gl91z, savedNum, gl93z, gl94z, gl95z, gl96z, gl97z:int;
   modeV, modeS: bool;
   gl100z, gl101z, gl102z, gl103z: bool;
   gl104z, gl105z:@extFile; gl106z:alfa; gl107z, gl108z, gl109z:bool;
   rets: _array [3..8] _of sixwords;
   extras: _array [1..17] _of alfa;
   idTable, idTabA: _array[0..127] _of idptr;
   gl419z: _array [0..0] _of expr;
   gl425z, gl426z, gl427z: int;
   gl422a: _array [1..16] _of sixwords;
   dummy:_array [1..13] _of char;
   pool: _array[1..4096] _of word;
   gl4633z:pstr; gl4634z:@typchain; gl4635z, gl4736z:_array [0..100] _of char;
   gl4837z, gl4838z:int;
(*=c+*)
_proced L3013(i:int);   
_(   
  write(i:0)
_);

_proced P3020;
_(
  _if inInclude _then _(
    ГГ('*ФАЙЛ ', fname);
    writeLN
  _)
_);
_proced prepErr(i:int);
_(
 rewrite(output);
 P3020;
 _select
 i = 0:  write('ВСТРЕТИЛСЯ КОНЕЦ ФАЙЛА');
 i = 1: _( write('НЕ ЗАКРЫТА УСЛ СЕКЦИЯ'); ГГ(' СТР.='); L3013(gl26z)_);
 i = 2: _( write('ВЛОЖЕННОСТЬ !'); ГГ(' СТР.='); L3013(lineNum)_);
 i = 3: write('НЕ ЗАКРЫТ КОММЕНТАРИЙ');
 i = 4: _( ГГ('ФАЙЛ ', fname); write(' НЕ НАЙДЕН') _);
 i = 5: _( ГГ('В '); L3013(lineNum); write(' СТРОКАХ ОБНАРУЖЕНО ');
         L3013(errcnt); ГГ(' ОШИБ.') _);
  T: _( write('ОШ ПРЕПРОЦЕССОРА'); ГГ(' СТР.='); L3013(lineNum) _)
  _end;
 writeLN;
 code(ПБ76002=,);
_);
_proced P3110(a:alfa; i: int);
_(
rewrite(output);
P3020;
_case a _of
'ОШИБКА': _(
  write('ТРЕБУЕТСЯ ');
 _select
 i = 0: write('ЗАПЯТАЯ');
 i = 1: write('ПРОСТАЯ ПЕРЕМЕННАЯ');
 i = 2: write('КОНСТАНТА');
 T: _( _)
 _end;
_);
'to': _(
 _select
 i = 0: write('НЕЛЬЗЯ ПРИСВАИВАТЬ ФАЙЛЫ');
 i = 1:  write('НЕСООТВ ТИПОВ ПРИ := ');
 i _in [2..4]: _(
   ГГ('МЕТКА ');
   L3013(gl26z);
   _select
    i = 2: write(' ОТСУТСТ В СПИСКЕ МЕТОК');
    i = 3: _(  write(' УЖЕ ОПРЕД В СТРОКЕ '); L3013(cv.i) _);
    T: write(' НЕ ОПРЕД')
    _end;
 _);
 i = 5:  write('ИД НЕ ОПРЕД');
 i = 6:  write('ИД НЕ ПЕРЕМЕН');
 i = 7:  write('ДВАЖДЫ ОПИСАН ВНЕШ ФАЙЛ');
 i = 8:  write('НЕПРАВ ПАРАМ ДЛЯ ВНЕШ ФАЙЛА');
 i = 9:  write('INРUТ∨ОUТРUТ НЕЛЬЗЯ');
 i = 10: write('МЕТКИ И GОТО В ВRАNСН НЕЛЬЗЯ')
 _end;
_);
'sexpr': _(
  _select
  i = 0: write('УНАРНЫЕ + - ТОЛЬКО ДЛЯ RЕАL ИЛИ ЦЙ');
  i = 1: write('ДОЛЖНЫ БЫТЬ ТИПЫ RЕАL ИЛИ ЦЙ');
  (i = 2)_or (i = 3): write('ТРЕБУЮТСЯ ДРУГИЕ ТИПЫ ОПЕРАНДОВ')
  _end
_)
_end; (* case *)
_);
(*=A0 code generation *)
_proced P3330;
_var l2v1z, l2v2z, l2v3z, l2v4z:int; l2v5z: alfa;
_proced P3251(a31:alfa);
_(
 ГГ('F', a31);
 write(':УИ15=15И1');
 ГГ(a31);
 write(',ЛУZ64=У');
 _if (l2v2z _IN [13,15]) _then output@ := '0' _else output@ := '1';
 put(output);
 ГГ('O', a31);
 write(',15ПА');
 write(l2v2z:0);
 write('=ПБМI,');
 _if (l2v2z = (17C)) _then 
 write('Э;ОРF:РО,ОGF:GI,ОRWF:RО,К;ОRF:16ПИ15=ПБRI,')
 _else l2v2z := l2v2z + 1;
_);
_proced P3307(a31:alfa);
_(
 ГГ('F', a31, ':12ПА', a31, '=14ПАО', a31);
 write(icomma);
 _if l2v2z = 25 _then 
 write('FW:УИ15=15И0FW(2),17СЧ=12ПБ,ЛУZ64=У0FW(4),17СЧ=14ПБ,15ПА21=ПБМI,')
 _else ГГ('ПБFW=,');
 l2v2z := l2v2z + 1;
_);
_( (* P3330 *)
 write('У;А1,К;');
 _for l2v1z := 3 _to 8 _do _(;
 _for l2v2z := 1 _to l2v1z - 2 _do _(;
   l2v5z := rets[l2v1z][l2v2z];
  _if l2v5z <> '0' _then _(
 ГГ(l2v5z);
 write(icolon);
 l2v3z := l2v1z;
 ГГ('13ПИ');
 mapia(l2v1z, l2v5z);
 ГГ(l2v5z);
 _while l2v3z >= l2v2z + 2 _do _(
 ГГ('=', l2v5z, 'СЧ2,УИ');
 l2v4z := l2v3z - 1;
 mapia(l2v4z, l2v5z);
 ГГ(l2v5z);
 l2v3z := l2v3z - 1;
 _);
 ГГ('=16ПБ,');
 _)
 _);
 _);
_if extras[17] <> '0' _then 
 write('IS:17СЧ=ИЗЧМ1,УМ11=11СД100,СРИА=17СМ-2,11СД100=17ЗЧ-2,15СР=17ЛУ,17СР=15ЗЧ,16ПБ=,');
_if modeX _then _(
 ГГ('Э;Z1:');
 _if (extras[15] <> 'ИА') _then ГГ('Z8,') _else ГГ('Z1Z,');
 write('ОРF:РО,ОGF:GI,ОRWF:RО,К;');
_) _else _(
  l2v1z := 1;
  _while l2v1z <= 16 _do _(
   _if extras[l2v1z] <> '0' _then _case l2v1z-1 _of
   0: write('Э;СОС:ИА(1236),СОЯ:СОС(1),К;DS:14СЧ=УИ14,ВИ12=СР13,У0DS(6)=СЧСОС,14ЗЧ=ВИ12,14ЗЧ1=ВИ14,ЗЧСОС=16ПБ,СЧСОЯ=14ЗЧ,ВИ14=ЗЧСОЯ,16ПБ=,');
   1,2,3,4,5,6:write('Z', l2v1z:0,':РА3=ВИ13,17ПИ13=17ПИ',l2v1z:0,',ВМ16=ВМ',(l2v1z-1):0,',13ЗЧ2=14ПБ,');
   7: write('ПА:УИ15=15И0ПА(4),15СЧ=У1ПА(3),15СЧ1=ИА,УИ15=16ПБ,ЛУZ64=У0ПА(7),1ИА10=15ПА,16ПБ=,1ИА7=15ПА,16ПБ=,');
   8: _( write('ВИ:УИ15=15И0ВИ(2),'); write('15СЧ2=16ПБ,ЛУZ64=16У0,СЧ13=16ПБ,') _);
   9: _( l2v2z := 12; P3251('РF'); P3251('GF');P3251('RWF');P3251('RF') _);
  10: _( l2v2z := 20; P3251('WS'); P3307('WС');P3307('WА');P3307('WВ');P3307('WI');P3307('WR');P3251('WL');_);
  11: write('АС:РА=15ПААС+2,15АС=ПБТR,Ч;0.5,К;');
  12: write('ПБ:1ПИ15=16ПВRС,13СЧ1=СД117,СД37=У0Е,ПБЕF=,');
  13: write('ТОШ:17ЗЧ=16ПВRО,11СЧ=14ПВГГ,СЧ=17СМ-2,16ПВОWI=,16ПВРR=,1СЧLI=У076002,17СЧ=ПБВА,ЕА:ВМ15=1СМLI,17ПИ15=ВМ15,1ЗЧLI=РА3,16ПБ=,NА:ВИ15=1ИКLI,ЗЧ-1=16ПБ,FА:1ИКLI=17ПА-2,17СЧ2=1ЗЧLI,РА3=16ПБ,ВА:РА3=ВМ13,1АВLI=У1ВА1,ВА3:13СЧ1=СД117,17ЗЧ=14ПА77777,ВИ14=17ЛУ,У0ВА2=УИ14,14ИА=14ПВ,ВА2:13СЧ=УИ13,ВА6:1АВLI=У0ВА3,15ПАВА4=16ПВВА8,ВА7:1ИКLI=СЧ,У0ВА5=1ЗЧLI,ВИ13=ПБВА6,ВА5:15ПАВА9=16ПВ76005,ПБПБ=,А;ВА9:ВЫХОД
,ПО АLТ,С;3640000000000000,К;ВА8:17СЧ-1=15У0,1ИКLI=СР-2,15У0=1ИКLI,СЧ-2=15У0,16ПБ=,ВА4:ВИ13=14ПВRSR,ВА10:1ИКLI=17ПА1,17ИК-2=ПБ,ВА1:15ПАВА10=16ПВВА8,ПБВА7=,FАМ:16ПВFА=,15КЦFАМ=12ПБ,');
  14: _( _if (extras[15] = 'ИА') _then write('Z1:РА3=СЧ5,') _else
         write('ВDОШ:ЗЧ1=16ПИ15,16ПВ76005=,11ПАВDТ=ПБТОШ,А;ВDТ:ОШВD= ,К;ВD:ВИ4=11ЗЧ33,11ПИ4=15ИАВDVЕС,СЧ=4ЗЧ3,4ПБ2=,С;ВDVЕС:0,0,2512141131,26211511,221411,27231411,201411,К;Z1:РА3=СЧ6,СД66=УИ4,СД54=ЛС74014,ЗЧ2=Э0702,ИК5=СЧСЧ1,ЗЧ1=4ПИ5,ВИ4=ЗЧ5,5СА2000=ВИ5,4ЗЧ16=5СА2000,ВИ5=4ЗЧ17,5СА2000=СЧ1,5ЗЧ1=2ПАВDОШ,ВИ2=4ЗЧ11,ВИ5=,');
      write('УИ1=1ПИ17,1ПИ13=15ПВRI,СЧ=1ЗЧLI,14ПИ16=ПБRО,');
  _);
  15: _(
   write('ПВ:ВИ15=ВМ13,СД61=17ЛС,16ПБ=,ВП7:ВИ16=ВМ13,12СМ=СД117,17ЗЧ=12ИК,ПБ=,ВП6:17СЧ=УМ13,УИ16=16ПБ,ВП:17СИ11=11ПИ13,ВП1:12СЧ=У0ВП2,11СР3=У0ВП3,12СЧ=СР13,У1ВПШ=11СЧ3,СР');
 ГГ(gl40z);
 write('=У0ВП4,СР13=У1ВПШ,17СА100=ВИ11,ВМ12=ВМ13,ВМ14=ВМ15,17ЗЧ=11ИА2,12ПА=12ИК,СЧ4=У1ВПШ,12СЧ=СД117,14ПВRSR=,12ИК=16ПВ,17СЧ=УМ15,УМ14=УМ13,УМ12=УИ11,17СЧ10=17СА-100,ПБВП5=,ВП4:11ИК2=СЧ,ВП5:13ЗЧ2=13СА1,12СА1=11СА2,ПБВП1=,ВП3:11СЧ2=ПБВП5,ВП2:11СЧ3=У1ВПШ,17СЧ=ПБRSR,ВПШ:17СЧ=14ПВRSR,11ПАВПТ=СЧ13,ПБТОШ=,А;ВПТ:ФПАРОШ,К;');
  _)
   _end; l2v1z := l2v1z + 1;
  _);
_);
_);
_function getDate:alfa;
_var k:int;l:alfa;
_(
  k:=00003777776Т;l:='3 1   ';
  СОDЕ(Э050114=,2СБ4=2РБ5,СД120=2ЗЧ4,МР=СД70,2ЗЧ5=МР,2СМ5=СД140,17ЛС=2СМ4,СД60=17ЛС,2ЗЧ3=)
_);
_procedure printOct(v:alfa);
_(
  code(=11ПА-17,qqq1:2СЧ3=СД/-3/,2ЗЧ3=МР,); output@:=;put(output);code(11КЦqqq1=)
_);

(*=c-*)_procedure P26222(_var l2a1z:alfa; _var l2a2z:idptr);
_label 26505, 26607, 26631;
_const (*=a1*)block='БЛОК';
arrow='@';dot='.';oparen='(';colon=':';semi=';';lt='<';gt='>';
star='*';slash='/';minus='-'; plus='+';eq='=';neq='#';sp=' ';qu='''';
comma=',';cparen=')'; obrack='[';cbrack=']';(*=a0*)
c259=259;c258=258;e48=4T;
_type oneinsn=_record next:@oneinsn; mode: int; ir, op, addr:alfa _end;
_var l2v1z, l2v2z: idptr;l2v3z,l2v4z, l2v5z:idptr;
l2v6z, l2v7z, l2v8z:alfa;
l2v9z:int; l2v10z:int;
l2v11z, l2v12z:alfa;
l2v13z,l2v14z, l2v15z, l2v16z, l2v17z, l2v18z:int;
l2v19z, l2v20z:bool;
l2v21z, l2v22z, l2v23z, l2v24z:idptr; l2v25z:pstr;
l2v26z:pstr; l2v27z:pInst;
l2v28z, l2v29z, l2v30z: int;
l2v31z, l2v32z:alfa;
(*=c+*)
_function F3575(i:int):int;
_var v31:int;v32,v33:real;
_(
v31 := e48; v33 := i; v32 := 1.0;
code(PA3=3АД7,3АC5=ЦС13,); F3575:=;
_);
_procedure alfAdd(_var a31:alfa; a32:int);
_var v31:int;
_(
  mapai(a31, v31);
  mapia(a32+v31, a31);
_);
(* Level 3 *) _proced putSep; _(
 _if leftInsn _then  output@ := ieq _else output@ := icomma;
 leftInsn := _not leftInsn;
 curLab := '0';
 put(output);
 _);
 _proced putInsn(a31:alfa); _(
 ГГ(a31);
 putSep;
 _);
(* Level 3 *) _proced modBase; _(
 _if modeX _then putInsn('10ИА');
 _);
(* Level 3 *) _proced idxBase; _(
 _if modeX _then ГГ('10');
 _);
_proced L3651(a31:alfa); _(
 idxBase;
 putInsn(a31);
 _);
 _proced L3656(a31, a32:alfa); _(
 ГГ(a31, a32);
 putSep;
 _);
(* Level 3 *) _proced putAlign(a31:alfa);
 _(
 ГГ(a31);
 _if leftInsn _then  write('=,')
 _else _( write(icomma); leftInsn := T_);
 curLab := '0';
 _);
(* Level 3 *) _proced align;
 _(
 _if _not leftInsn _then _( write(icomma); leftInsn := _not leftInsn _)
 _);
(* Level 3 *) _proced L3712;
 _(
 _if gl36z <> 1 _then _( putInsn('РА7'); gl36z := 1 _)
 _);
(* Level 3 *) _proced metka(a31:alfa);
 _(
 align;
 ГГ(a31);
 write(icolon);
 L3712;
 curLab := a31;
 _);
(* Level 3 *) _proced L3732(a31:pInst);
_const mask='070000';
_var v31:alfa; v32:pInst; _(
 (align)_if a31 = _nil _then exit;

 _if a31@.nxt <> _nil _then _(
 _if (a31@.op = gl37z) _and (a31@.nxt@.op = 'ЗЧ') _and
  (a31@.nxt@.f2 = '17') _and (a31@.nxt@.f4 = '0') _then _(
 a31@.op := 'СМ';
 _if (a31@.f2 = '0') _then a31@.f2 := gl44z;
 v32 := a31@.nxt;
 a31@.nxt := a31@.nxt@.nxt;
 _) _else _(
 _if (a31@.nxt@.op = 'ИК') _or (a31@.nxt@.op = 'ИА') _then _(
 _if a31@.f1 <> 0 _then _(
   v32 := a31@.nxt;
 (loop) _while v32@.nxt <> _nil _do _(
   v31 := v32@.nxt@.op;
 _if (v31 = 'ИА') _or (v31 = 'ИК') _then v32 := v32@.nxt
 _else _exit loop;
 _);
 v32@.f1 := a31@.f1;
 _)
 _)
 _);
 L3732(a31@.nxt);
 _); (* 4017 *) _case a31@.f1 _of
  0:;
  1: _if gl36z <> 1 _then _( putInsn('РА3'); gl36z := 1 _);
  2: gl36z := 1;
  3: _if gl36z <> 2 _then _(  putInsn('РА'); gl36z := 2 _);
  4: gl36z := 2
 _end; (* 4050 *)
 _if a31@.f2 = label _then _(
 _if a31@.f4 <> '0' _then metka(a31@.f4) _else _(
  TNL(v31);
 align;
 write('10ПВУРЕГ=,');
 ГГ(v31, ':10СА-');
 putInsn(v31);
 _);
 _) _else _(
 _if (a31@.f2 <> '0') _then  ГГ(a31@.f2);
 _if ((a31@.f4b * [13..15]) <> []) _and
     ((a31@.f4b * [0..12]) = []) _and
     ((a31@.f4b * [13,14,15]) <> [13..15]) _and
     (a31@.op <> 'СА') _and
     (a31@.op <> 'ИА') _and
     (a31@.op <> 'ИК') _then _(
    ГГ('ИА');
    _if a31@.f4 <> '0' _then _( putInsn(a31@.f4 ) _);
   ГГ(a31@.op);
 _) _else _(
   ГГ(a31@.op);
 _if a31@.f4 <> '0' _then  ГГ(a31@.f4);
 _);
 putSep;
 _if (a31@.op = 'ПВ') _or (a31@.op = 'Э050') _then align;
 _); (* 4141 *)
_);
(* Level 3 *) _proced prErr(a31:alfa; a32:int);
 _(
 _if gl71z _then exit;
 P3110(a31, a32);
 (*=a1 error messages *)
 ГГ('***ОШ.', a31, '='); L3013(a32);
 ГГ(' СТР.='); L3013(lineNum); ГГ('.NLЕХ='); L3013(gl23z);
 ГГ('.ИД=', tok, '.СИМ=', lastChar);
 writeln('.КОНТЕКСТ');
 code(16ПВСТХТ=,);
 errSeen := T;
 errcnt := errcnt + 1;
 _if (errcnt > maxerr) _then _GOTO 27721;
 _);(*=a0*)
(* Level 3 *) _proced error(a31:alfa; a32:int);
 _(
 gl71z := F;
 prErr(a31, a32);
 _GOTO 27721;
_);

(* Level 3 *) _proced sysErr(n:int);
 _(
 error((*=a1*)'SУS'(*=a0*), n);
 _);
(* Level 3 *) _proced L4225(a31:int);
_var v31:alfa; v32:idptr; _(
 curLab := '0';
 _case a31 _of
 1: _(  ГГ('ПБЕ'); _if l2v31z <> '0' _then ГГ('F')_);
 0: _(
 v32 := l2a2z;
 align;
 _if level <> '1' _then _(
   mapai(level, a31);
   extras[a31] := 'ИА';
 _);
 _if _not l2v19z  _then write(istar);
 ГГ(v32@.f9);
 write(icolon);
 MAPЯГА( v32@.nm, v31);
 _if (v31 = v32@.f9.a) _then _(
 write('10ПВУРЕГ=,10СА-');
 ГГ(v32@.f9.a);
 write('(1)=14ПВСН,');
 _);
 _if v32@.vty = _NIL _then a31 := 3 _else  a31 := 4;
 v31 := ;
 _if v32@.f10.i > 1 _then _(
  mapia(-(a31 + v32@.f10.i), v31);
  mapai(level, a31);
 _);

 _select
 v32@.f10.i = 0: _( ГГ('14ПВZ'); putAlign(level); _);
 v32@.f10.i = 1: _( ГГ('17ЗЧ', v31, '=14ПВZ', level); write(icomma); _);
 T: _(
 write('ВМ13=17СА');
 ГГ(v31);
 write(',РА3=17ПИ13,17ПИ', a31:0, '=ВМ16,ВМ', (a31 - 1):0, '=13ЗЧ2,');
 _)
 _end;
 MAPЯГА( v32@.nm, v31);
 ГГ('`', v31, '`17СА', v32@.f8.a);
 gl36z := 1;
 _)
 end;
 putSep;
 _);
(* Level 3 *) _proced P4357(a31:int; a32:alfa);
_label 4412, 4424, 4431;
_var v31:alfa; _(
 _if modeX _then _(
 _select
 (a31 < 4): _if (a31 <> 0) _then ГГ('10');
 (a31 = 11) _or (a31 = 10) _or (a31 = 8): putInsn('10ИА')
 _end
 _);
 _case a31 _of
0: _(
 align;
 ГГ(a32);
 write(icolon);
 curLab := a32;
 exit;
_);
1: _(
 ГГ('ПБ');
 4412:
 ГГ(a32);
_);
 2: _(
  ГГ('У1');
 _goto 4412;
 _);
3: _(
 ГГ('У0');
 _goto 4412;
_);
4,5,6,7,9: error(in, a31);
8: _(
 ГГ('14ПВ');
 4424:
 putAlign(a32);
exit; 
_);
10: _(
 ГГ('12ПА');
 _goto 4412;
_);
11: 4431: _(
 ГГ('15ПА');
 _goto 4412;
_);
12: _(
 ГГ('16ПВ');
 _goto 4424;
_);
13: _goto 4431;
14: _(
 ГГ('15ПА-', a32); putSep; TNL(v31); metka(v31);
 write('12ИА=15СЧ'); ГГ(a32); write(',16ИА=15ЗЧ'); ГГ(a32);
 write(icomma);
 _if modeX _then _( write('10ИА=15КЦ'); ГГ(v31); write(icomma); exit _)
 _else _( ГГ('15КЦ', v31); _)
_)
_end;
 putSep;
_);
(* Level 3 *) _proced P4511(a31:int; a32, a33:alfa);
 _(
 _select
 (a31 = 5): _(
 align; modBase;
 ГГ('15ПА', a32); write('=ВИ15,СД'); ГГ(a33);
 write('=13ЛС1,13ЗЧ1'); putSep;
 _);
 (a31 = 6): _(
 ГГ('12ПА-', a33); putSep; modBase;
 ГГ('15ПА', a32); putSep; putAlign('14ПВГТ');
 _);
 T: _(
 ГГ('Э;', a32, icolon, a33, ',К;');
 _)
 _end
 _);
(*=c- Level 3 *)_proced P4646;
_var v31:int;
(*=c+*)
(* Level 4 *) _proced preDecl(a41:alfa; _var a42:idptr);
_var v41:int; v42:idptr; _(
 new(v42,9);
 (*=c-*)mapai(a41 _and '177', v41);(*=c+*)
 v42@ := [a41, 0, idTable[v41], _NIL, 0, 1, 0];
 idTable[v41] := v42; a42 := v42;
 _);
(* Level 4 *) _proced P4605(a41, a42:alfa);
_var v41:idptr; _(
 preDecl(a41, v41);
 v41@.f4.i := 1;
 v41@.vty := curId;
 v41@.f6.a := a42;
 _);
(* Level 4 *) _proced declStandFun(a41:alfa);
_var v41:idptr; _(
 new(v41, 6);
 (*=c-*)mapai(a41 _and '177', v31);(*=c+*)
 v41@ := [a41, 0, idTable[v31], , 3, curId];
 v41@.f3 := ptr(gl26z);
 gl26z := gl26z + 1;
 idTable[v31] := v41;
 _);

_( (* P4646 *)
gl4837z := 75B; gl4838z := 313B;
v31 := 0;
 _while v31 <= 127 _do _(
   idTable[v31] := _NIL;
   idTabA[v31] := _NIL;
   v31 := v31 + 1;
 _);
 modeA := 1;  modeB := ; lineNum := ; level := ; modeC := ; leftInsn := ; gl62z := ; modeM := ;
 gl101z := ;
 modeR := ; modeP := ; modeT := ; gl36z := ;
 fname := spaces;
 gl35z := 0; modeE := ; gl33z := ; gl28z := ; gl53z := ; gl23z := ; gl106z := ;
 gl40z := ; errSeen := ; gl71z := ; gl12z := ; gl13z := ; gl45z := ; skipping := ; modeF := ; modeG := ;
 modeV := ; modeS := ; gl107z := ; gl108z := ; gl109z := ;
 modeDe := ; modeCH := ; modeeL := ; gl102z := ; gl103z := ;
 inInclude := ; modeL := ; gl63z := ; gl58z := ; modeX := ; gl44z := ;
 gl37z := 'СЧ';
 endl := chr(175B);
 gl89z := -1; gl90z := ;
 modeK := (100);
 poolStart := ord(ref(pool[9]));
 poolAddr := poolStart - 9;
 gl47z := _NIL;
 gl4634z := ;
 curId := ;
 gl77z := ;
 gl4633z := ;
 gl105z := ;
 errcnt := 0;
 maxerr := 10;
 gl43z := '11';
 pool[9].p := _NIL;
 pool[9 + 1].i := 0;
 pool[9 + 2].i := 1;
 poolIdx := 11;
 (*=a1*) seqGOST := 'А';
 MAPГA(seqGOST, seqITM);
 TNL(seqITM);
 v31 := 1;
 _while v31 <= 17 _do _(
   extras[v31] := '0';
    v31 := v31 + 1;
 _);
  (*=a0*)extras[15] := 'ИА';
 v31 := 3;
 _while (v31 <= (8)) _do _(
 l2v14z := 1;
 _while (l2v14z <= (v31 - 2)) _do _(
   rets[v31][l2v14z] := '0';
 l2v14z := (l2v14z + 1);
 _);
 v31 := (v31 + 1);
 _);
 (*=a1*)
 preDecl('ВООLЕА', boolType);
 preDecl('INТЕGЕ', intType);
 preDecl('СНАR',   charType);
 preDecl('0', setType);
 setType@ := [,,,intType,,,3];
 preDecl('RЕАL', realType);
 preDecl('00АLFА', alfaType);
 preDecl('0УКNIL', ptrType);
 ptrType@.k := 2;
 curId := boolType;
 P4605('FАLSЕ', '12');
 P4605('ТRUЕ', '13');
 preDecl('ТЕХТ', textFile);
 textFile@.f3 := charType;
 textFile@.k := 6;
 textFile@.vty := ptr(36B);
 textFile@.f7.i := 8;
 preDecl('INРUТ', inFile);
 inFile@.f4.i := 2;
 inFile@.vty := textFile;
 inFile@.k := 7;
 preDecl('ОUТРUТ', outFile);
 outFile@.f4.i := 2;
 outFile@.vty := textFile;
 outFile@.k := (256);
 gl76z := intType;
 curId := _NIL;
 gl26z := 0;
 declStandFun('000РUТ'); % 0
 declStandFun('000GЕТ'); % 1
 declStandFun('RЕWRIТ'); % 2
 declStandFun('0RЕSЕТ'); % 3
 declStandFun('000NЕW'); % 4
 declStandFun('0UNРСК'); % 5
 declStandFun('000РСК'); % 6
 declStandFun('00ЕХIТ'); % 7
 declStandFun('РRINТО'); % 8
 declStandFun('00НАLТ'); % 9
 declStandFun('0МАРIА'); % 10
 declStandFun('0МАРАI'); % 11
 declStandFun('000ТNL'); % 12
 declStandFun('0000ГГ'); % 13
 declStandFun('0МАРГА'); % 14
 declStandFun('МАРЯГА'); % 15
 declStandFun('00СОDЕ'); % 16
 declStandFun('0SЕТUР'); % 17
 declStandFun('RОLLUР'); % 18
 declStandFun('0WRIТЕ'); % 19
 declStandFun('WRIТЕL'); % 20
 declStandFun('DISРОS'); % 21
 declStandFun('00RЕАD'); % 22
 declStandFun('RЕАDLN'); % 23
 declStandFun('0ОРЕND'); % 24
 declStandFun('00РUТD'); % 25
 declStandFun('00GЕТD'); % 26
 declStandFun('00DЕLD'); % 27
 declStandFun('00МОDD'); % 28
 declStandFun('00NЕWD'); % 29
 declStandFun('00ВIND'); % 30
 declStandFun('000INS'); % 31
 gl26z := 0;
 curId := realType;
 declStandFun('00SQRТ');
 declStandFun('000SIN');
 declStandFun('000СОS');
 declStandFun('АRСТАN');
 declStandFun('АRСSIN');
 declStandFun('0000LN');
 declStandFun('000ЕХР');
 declStandFun('000АВS');
 curId := intType;
 declStandFun('0ТRUNС');
 curId := boolType;
 declStandFun('000ОDD');
 curId := intType;
 declStandFun('000ОRD');
 curId := charType;
 declStandFun('000СНR');
 declStandFun('00SUСС');
 declStandFun('00РRЕD');
 curId := boolType;
 declStandFun('000ЕОF');
 curId := ptrType;
 declStandFun('000RЕF');
 declStandFun('000РТR');
 curId := intType;
 declStandFun('000SQR');
 declStandFun('0RОUND');
 declStandFun('000SЕL');
 declStandFun('00САRD');
 declStandFun('0МINЕL');
 curId := boolType;
 declStandFun('00ЕОLN');
 declStandFun('0SНIFТ');
_);
(*=a0*)
(* Level 3 *) _function withSp(a31:alfa):alfa;
_var a:_array [0..12] _of char; i:int;
_(
 unpck(a[1], a31);
 a31 := spaces;
 unpck(a[7], a31);
 i := 1;
 _while i <= 6 _do _(
 _if a[i] <> chr(0) _then _(
    pck(a[i], a31);
    withSp := a31;
  exit;
 _);
 i := i + 1;
 _)
 _);
(* Level 3 *) _proced P5215(_var a31:int; _var a32:int);
 _( code(=15ПА15,ВИ15=СД/4/,MP=3ИК3,ЛС=); a32 := ;
 _);
(* Level 3 *) _proced putConst(_var offset:alfa; force:bool);
_var v31:int; _(
 _if _not force _then _(
 poolStart := poolStart;
 code(=УИ5,);
 v31 := 9 - poolIdx;
 code(=УИ4,);
 cv := cv;
 code(ЗЧ1=,find:СЧ1=5CP,У0done=5CA1,4КЦfind=);
 _);
 poolIdx := poolIdx + 1;
 _if poolIdx >= 4096 _then sysErr(23);

 pool[poolIdx] := cv;
 mapia(poolIdx, offset);
 exit; code(done:ВИ5=);
 v31 := ;
 v31 := v31 - poolAddr;
 mapia(v31, offset);
 _); 
(* Level 3 *) _proced L5264(arg:alfa);
_var dum:char; a: _array[1..12] _of char;
 i:int; res:alfa; _(
 unpck(a[6], arg);
 i := 6;
 _while a[i] = chr(0) _do i := i + 1;
 arg := spaces;
 unpck(a[i-6], arg);
 pck(a[6], res);
 cv.a := res;
 putConst(gl41z, T);
 _);
(* Level 3 *) _proced L5312(arg:alfa);
_var dum:char; a:_array [1..12] _of char;
 i:int; res:alfa;  _(
 unpck(a[6], arg);
 i := 6;
 _while a[i] = chr(0) _do i := i + 1;
 arg := spaces;
 unpck(a[i-6], arg);
 pck(a[6], res);
 cv.a := res;
 putConst(gl41z, F);
 _);
(* Level 3 *) _proced P5340(a31: idptr; a32:bool);
_var v31:alfa; v32:alfa; v33, v34:alfa; _(
 _if a31@.nm = '0' _then _(
 _if a32 _then _(
 TNL(v31);
 idxBase;
 L3656('ПБ', v31);
 align;
 _);
 TNL(v32);
 metka(v32);
 L3651('ЗЧ1');
 a31@.nm := v32;
 cv := a31@.f7;
 putConst(v33, F);
 cv.i := a31@.f8.i - cv.i;
 putConst(v34, F);
 idxBase;
 L3656('АВ', v33);
 putInsn('15У1');
 idxBase;
 L3656('ОВ', v34);
 putInsn('15У1');
 L3651('СЧ1');
 putAlign('16ПБ');
 _if (a32) _then  metka(v31);
 _);
 _);
(* Level 3 *) _proced L5425(a31:idptr);
_var v31:idptr; _(
 _if (a31@.f8.i = 0) _then _(
 v31 := a31@.f3;
 L5264(v31@.nm);
 a31@.f8.a := gl41z;
 (loop) _(
 v31 := v31@.f7.id;
 _if (v31 = _NIL) _then exit;
 L5264(v31@.nm);
 _goto loop _)
 _);
_);

(*=c- Level 3 *) _proced getToken;
_label 6161, 6304, 6335, 6462;
_const max = 1000000000000;
_var v31:_array [0..5] _of char; l3arr: _array [7..13] _of int;
v3E, l3v15z:int;
l3v16z:word;
l3v17z:idptr;
l3v18z:bool;
l3v19z, l3v20z:real;
l3v21z:alfa;
l3a21z: _array [1..17] _of char;
l3arra: _array [39..41] _of int;
l3v42z, l3v43z:int;
(*=c+*)
(* Level 4 *) _proced P5446(a41, a42:char);
_var v41:char; _(
 v41 := input@; get(input);
 _if (input@ = a41) _then _(
     lastChar := a42; get(input);
 _) _else  lastChar := v41;
_);
(* Level 4 *) _proced L5462(a41:int);
 _( (*=a1*)
 prErr('SСАN', a41);
 _if (a41 < (5)) _then _(
 _case a41 _of
 0:;
 1: gl26z := 1;
 2, 3, 4: _(
 _while (input@ <> qu) _do get(input);
 get(input);
 _GOTO 6462;
 _)
 _end
 _)
 _); (*=a0*)
(* Level 4 *) _proced L5512(a41:int);
 _(
 a41 := 001034T + a41; code(4Э0703=,)
_);
_proced closeFile; _var v41:@int; _(
 lineNum := savedNum;
 v41 := ref(gl93z);
 code(=УИ11,11СЧ=ЗЧ75211,11СЧ1=ЗЧ75212,11СЧ2=ЗЧ74221,ЦC75211=17ЗЧ1,17Э0701=,11СЧ3=ЗЧ74220,11СЧ4=ЗЧ75225,ИК75225=СЧ,ЗЧ74217=СЧ74215,17ЗЧ1=CP74220,У1qne=СЧ75225,УИ15=15СЧ-1,ЛУ74330=);
 input@ := ;
 exit;
 code(qne:СЧ74217=СД/-10/,ЗЧ74217=MP,);
 input@ := ;
code(=17СЧ1,СД/1/=17ЗЧ1,CP74220=У1qne,);
_);
(* Level 4 *) _proced setFile(a41, a42:int);
_var v41:int; _(
 v41 := 001034T;
 code(=4цс3,зч75211=4сч4,ав13=зч75212,)
 _);

(* Level 4 *)

 _proced openFile;
 _var v41, v42, v43 : int; v44: alfa;
_(
%gl93z                      : = C/1211;
%gl94z                      : = C/1212;
%gl95z                      : = C/0221;
%gl96z                      : = C/0220;
%gl97z                      : = C/1225;
code(=сч75211,1зч135=сч75212,1зч136=сч74221,1зч137=сч74220,1зч140=сч75225,1зч141=);
 savedNum := lineNum;
lineNum := 1;
 L5512((270037C));
 code(сч71776=СД/-36/,СД/36/=);
 v41 := ;
 L5512(v41);
 code(11ПА70001=12ПА77600,L5601:11СЧ=);
 v44 :=;
 _if (v44 = fname) _then _(
 code(=11СЧ1,СД/30/=4ЗЧ4,MP=СД/30/,4ЗЧ5=);
 setFile(v42 + v41, v43);
 reset(input);
 exit;
 _);
 code(11CA2=12КЦL5601,);
 prepErr(4);
_);
 (* Level 4 *) _proced escChar;
_var v41:int; _(
 get(input);
 _if input@ > '3' _then  L5462(2);

 gl26z := ord(input@);
 v41 := 1;
 _while v41 <= 2 _do _(
   get(input);
  _if input@ > '7' _then _(
   L5462(3);        
    exit;
  _);
 (*=m-*)gl26z := ord(input@) + gl26z*8;
 v41 := v41 + 1;
_);
 input@ := chr(gl26z);
 _);
 (* Level 4 *) _proced getId;
_var t:word; i:int; _(
 t.a := '0';
 i := 1;
  _while (input@ _in letter) _or (ord(input@) < 10) _do _(
 _if i < 7 _then _(
    i := i + 1;
    code(4СЧ3=СД/-10/,1ЛС7=4ЗЧ3,) (* t := (t << 8) | input@ *)
 _);
 get(input);
 _);
 tok := t.a;
_);
(* Level 4 *) _proced skipSp;
 _(
   _while (input@ = sp) _or (input@ > chr(128)) _do get(input);
 _);
(* Level 4 *) _proced skipComment;
_label 5704;
_var v41:char; _(
 5704:
 v41 := input@;
 _if v41 = chr(172B) _then prepErr(3);
 get(input);
 _if (v41 = star) _and (input@ = cparen) _then _(
 get(input);
 exit
 _) _else _if (v41 = oparen) _and (input@ = star) _then _(
 get(input);
 skipComment;
 _) _else _if v41 = endl _then _(
 lineNum := lineNum + 1;
 gl23z := 0;
 _) _else _( _);
 _goto 5704
_);

(* Level 4 *)_proced doComment;
_var bad:bool;
(* Level 5 *) _proced intRange(_var a51:int; a52:int);
 _(
 get(input);
 a51 := 0;
 bad := T;
 _if input@ <= '9' _then
 _while input@ <= '9' _do _(
 a51 := a51 * 10 + ord(input@);
 get(input);
 bad := F;
 _);
 _if a51 > a52 _then  bad := T;
_);
(* Level 5 *) _proced plmin(_var v:bool);
 _(
 get(input);
 _if (input@ = minus) _or (input@ = plus) _then _(
 v := input@ = plus;
 get(input);
 bad := F;
 _)
_);

_( (* P5776 *)
get(input);
 _if input@ = eq _then _(
 _repeat
 get(input);
 bad := T;
 _case input@ _of (*=a1*)
 'L': plmin(modeL);
 'F': _( plmin(modeF); _if modeF _then  gl107z := T_);
 'P': plmin(modeP);
 'G': _( plmin(modeG); _if modeG _then  gl108z := T_);
 'T': plmin(modeT); 
 'V': _( plmin(modeV); _if modeV _then gl109z := T_);
 'A': intRange(modeA, 1);
 'S': _( plmin(modeS); _if modeS _then  gl109z := T_);
 'C': plmin(modeC);
 'R': plmin(modeR);
 'M': plmin(modeM);
 'Ч': plmin(modeCH);
 'X': plmin(modeX);
 'B': intRange(modeB, 4);
 'K': intRange(modeK, 25);
 'Д': plmin(modeDe);
 'Л': plmin(modeeL);
 'I': plmin(modeI);
 'E': plmin(modeE)
 _end;
 _if bad _then L5462(13);
 _until input@ <> comma;
 _);
 skipComment;
 _GOTO 6161;
_);
_( (* getToken *)
6161:
 skipSp;
 _if input@ = '%' _then _(
 _while (input@ <> endl) _and (input@ <> chr(172B)) _do  get(input);
_) _else _if input@ = '$' _then _(
 get(input);
 (a) _if  input@ _in letter _then _(
 getId;
 _if tok = end _then _(
 skipping := F;
 _) _else _(
 l3v21z := tok;
 skipSp;
 _if _not (input@ _in letter) _then _exit a; _(
   getId;
   _select
  (l3v21z = 'DЕF'): _(
   skipping := F;
   gl45z := tok;
 _);
 (l3v21z = 'ВЕG'): _(
    skipping := tok <> gl45z;
    gl26z := lineNum;
 _); 
 (l3v21z = 'INС') _and _not skipping: _(
 _if inInclude _then  prepErr(2);
 fname :=   withSp(tok);
 openFile;
 inInclude := T;
 _);
 T:  _exit a
 _end
 _);
 _);
 _goto 6161;
 _);
 prepErr(6);
_) _else (block) _( (*6244*)
  _if input@ = endl _then _(
     lineNum := lineNum + 1;
     gl23z := 0;
     get (input);
   _) _else _( _if skipping _then _(
     _if input@ = chr(172B) _then  prepErr(1) _else _(
       _if input@ = qu _then _(
         get(input);
         _while (input@ <> qu) _and (input@ <> chr(172B)) _do get(input);
         _if input@ = qu _then  get(input);
       _) _else
        _if input@ = oparen _then _(
          get(input); _if input@ = star _then skipComment;
        _) _else _(
          get(input);
          (q) _exit q;
        _)
      _); _exit block;
    _); _goto 6304; _exit block;
  _)
_);
(* 6303 *) _goto 6161;
6304:
gl23z := gl23z + 1;
_if input@ _in letter _then _(
 tokKind := tkIdent;
 getId;
 gl60z := F;
 (*=c-*)mapai(tok _and '000177', gl25z);(*=c+*)
_case gl53z _of
 0: _( (* 6315 *)
 curId := idTable[gl25z];
 _while curId <> _NIL _do _(
 _if curId@.f1.a = level _then _(
 _if curId@.nm <> tok _then_(
    curId := curId@.nxt;
 _) _else _(
   gl60z := T;
   _goto 6462;
 _)
 _) _else _goto 6462;
 _);
_);
 1: 6335: _( (* 6335 *)
 curId := idTable[gl25z];
 _while curId <> _NIL _do _(
    _if curId@.nm <> tok _then
       curId := curId@.nxt
    _else _goto 6462;
 _);
_);
 2: _( (* 6350 *)
 _if gl28z = 0 _then _goto 6335;
 curId := idTabA[gl25z];
 gl27z := -1;
_while curId <> _NIL _do _(
 _if curId@.nm = tok _then _(
 l3v16z := curId@.f7;
 v3E := gl28z;
 _while v3E >= 1 _do _(
 _if gl422a[v3E][1] = l3v16z.a _then _(
 tokKind := tkField;
 _if v3E > gl27z _then _(
 gl27z := v3E;
 l3v17z := curId;
 _);
 v3E := 0;
 _);
 v3E := v3E - 1;
 _) _);
 curId := curId@.nxt;
 _); (* 6402 *)
  _if gl27z = -1 _then _goto 6335 _else curId := l3v17z;
 _);
 3: _( (* 6407 *)
 curId := idTabA[gl25z];
 tokKind := tkField;
 _while curId <> _NIL _do _(
   _if curId@.nm <> tok _then _(
     curId := curId@.nxt
   _) _else _if gl77z = curId@.f7.id _then
     _goto 6462
   _else curId := curId@.nxt
 _)

 _)
_end; (* 6435 *)
_goto 6462;
_);(* 6436 *)
_if (input@ = '_') _then _(
 get(input);
 tokKind := tkWord;
 _if _not (input@ _in letter ) _then _(
 _if (input@ = cparen) _or (input@ = oparen) _then _(
   _if input@ = oparen _then tok := begin _else tok := end;
    get(input);
 _) _else _(
    tokKind := tk0;
    exit
 _)
 _) _else
   getId;
 6462:
 gl53z := 1;
 lastChar := chr(254);
 exit
 _); (* 6465 *)
 _if input@ <= '9' _then _(
 tokKind := tkInt;
 v3E := 0;
 _repeat
  v3E := v3E + 1;
 _if v3E <= 17 _then l3a21z[v3E] := input@
 _else _( L5462(0);  v3E := 1_);
 get(input);
 _until input@ > '9';
 gl26z := 0;
 _if (input@ = 'B') _or (input@ = 'C') _or (input@ = 'T') _then _(
 l3v15z := 1;
 _while l3v15z <= v3E _do _(
   _if l3a21z[l3v15z] > '7' _then  L5462(5);
   l3v15z := l3v15z + 1;
 _); (* 6521 *)
 _if input@ = 'T' _then _(
 l3v15z := v3E;
 _while l3v15z >= 1 _do _(
   gl26z := gl26z; code(СД/3/=17ЗЧ,);
   gl26z := ord(l3a21z[l3v15z]);
   code(СД/3/=MP,17CP=);
   gl26z := ;
   l3v15z := l3v15z - 1;
 _)
 _) _else _( (* 6537 *)
  l3v15z := 1;
   _while l3v15z <= v3E _do _(
   gl26z := gl26z; code(СД/-3/=17ЗЧ,);
   gl26z := ord(l3a21z[l3v15z]);
   code(17CP=);
   gl26z := ;
   l3v15z := l3v15z + 1;
  _)
 _); (* 6551 *)
 gl102z := input@ = 'B';
 get(input);
 _) _else _( (* 6557 *)
 l3v15z := 1;
 _while l3v15z <= v3E _do _(
 _if gl26z <= max _then _(
  gl26z := 10 * gl26z + ord(l3a21z[l3v15z]);
 _) _else _(
 L5462(7);
 gl26z := 0;
 _);
 l3v15z := l3v15z + 1;
 _);
 l3v43z := 0;
_if input@ = dot _then _(
 get(input);
 _if input@ = dot _then _( input@ := colon; _goto 6462_);
 rval := gl26z;
 tokKind := tkReal;
 _if input@ > '9' _then L5462((8) ) _else _(
 _repeat
   rval := 10.0 * rval + ord(input@);
   l3v43z := l3v43z - 1;
   get(input);
 _until (input@ > '9');
 _)
 _); (* 6620 *)
 _if input@ = 'E' _then _(
 _if l3v43z = 0 _then _( rval := gl26z; tokKind := tkReal_);
   l3v18z := F;
   get(input);
   _case input@ _of
    '+': get(input);
    '-': _( l3v18z := T; get(input) _)
   _end;
   l3v42z := 0;
   _if input@ > '9' _then  L5462(9) _else _(
   _repeat 
   l3v42z := 10*l3v42z + ord(input@);
    get(input);
 _until input@ > '9';
  _); (* 6655 *)
  _if l3v18z _then l3v43z := (l3v43z - l3v42z) _else l3v43z := (l3v43z + l3v42z);
 _); (* 6662 *)
 _if l3v43z <> 0 _then _(
    l3v20z := 1.0;
    l3v18z := l3v43z < 0;
    l3v43z := abs(l3v43z);
    l3v19z := 10.0;
    _if (l3v43z > 18) _then _( l3v43z := 1; L5462(10 ) _);
    _repeat 
     _if odd(l3v43z) _then l3v20z := l3v20z * l3v19z;
      l3v43z := l3v43z _div 2;
     _if (l3v43z <> 0) _then l3v19z := l3v19z * l3v19z;
    _until (l3v43z = 0);
    _if l3v18z _then rval := rval / l3v20z _else rval := rval * l3v20z;
 _);
  _);
 _goto 6462;
 _); (* 6722 *)
 _if input@ = qu _then _(
  _if _not gl58z _then _(
  tok := '0';
  unpck(v31[0], tok);
  v3E := 6;
  (loop) _(
   get(input);
   _if input@ = chr(125B) _then escChar _else _(
      _if input@ = qu _then _( get(input); _if (input@ <> qu) _then _exit loop_);
      _if modeA = 0 _then MAPГA(input@,  input@);
   _);
   _if v3E = 12 _then _( L5462(4); _exit loop _);
   v31[v3E] := input@;
   v3E := v3E + 1;
  _goto loop;
  _); (* 6755 *)
  pck(v31[v3E-6], tok);
  _if v3E > 7 _then  tokKind := tkStr _else  tokKind := tkChar;
  _goto 6462;
  _) _else _( (* 6767 *)
     tokKind := tkStr;
     gl30z := 0;
    gl60z := F;
    l3v15z := 0;
    _while l3v15z <= 250 _do _(
    l3v21z := '0';
    unpck(v31[0], l3v21z);
    v3E := 0;
    (* 7001 *) (oneword)_while v3E <= 5 _do _(
    get(input);
    _if (input@ = endl) _and modeCH _then _( get(input); lineNum := lineNum + 1_);
    _if (input@ = chr(125B)) _then escChar _else _(
     _if (input@ = qu) _then _(
         get(input);
        _if input@ <> qu _then _(
       _if v3E <> 0 _then _( gl60z := T; _exit oneword _);
        _goto 6462;
      _);
 _) _else _(
     _if input@ = endl _then  lineNum := lineNum + 1;
     _if modeA = 0 _then  MAPГA(input@, input@);
   _)
    _); (* 7033 *)
     v31[v3E] := input@;
     gl30z := gl30z + 1;
     v3E := v3E + 1;
    _); (* 7040 *)
    pck(v31[0], l3v21z);
    cv.a := l3v21z;
    putConst(l3v21z, T);
    _if gl58z_then _(  gl58z := F; tok := l3v21z_);
    _if gl60z _then _goto 6462;
    l3v15z := l3v15z + 1;
    _);
    L5462(1);
    _);
 _); (* 7060 *)
 tokKind := tk0;
 _if (input@ = chr(253)) _then _(
    get(input); lastChar := chr(128);
    exit
  _); (* 7065 *)
  _if (input@ _IN [dot,oparen,lt,gt,colon]) _then _(
  _case input@ _of
  ':': P5446('=', chr(128));
  '.': P5446('.', ':');
  '>': P5446('=', chr(79));
  '<': _(
     P5446('=', chr(78));
    _if (lastChar = '<') _and (input@ = '>') _then _(  get(input); lastChar := '#'_);
  _);
  '(': _(
     get(input);
     _if (input@ = '*') _then doComment _else lastChar := '(';
   _)
  _end
  _) _else _( (* 7130*)
  _if (input@ = chr(172B)) _then _(
    _if inInclude _then _(
     closeFile;
     inInclude := F;
     _goto 6161;
    _) _else  prepErr(0);
  _) _else  lastChar := input@;
  get(input);
  _); (* 7142 *)
_);
(* Level 3 *) _function L7143(a31:bitset):bool;
_var v31, v32:bool; v33:int; _(
 v31 := F;
 v33 := 0;
 _while (v33 <= 4) _do _(
   _if (v33 _IN a31) _then _case v33 _of
    0: v32 := ((tokKind = tk0) _and (lastChar = ';')) _or
    (((tok = then) _or (tok = else) _or (tok = until) _or (tok = end) _or (tok = do)) _and (tokKind = tkWord));
    1: v32 := ((tok=begin)_or(tok=functi)_or(tok=proced)_or(tok=type)_or(tok=const)_or(tok=label)_or(tok=var))_and(tokKind=tkWord);
    2: v32 := ((tok=begin)_or(tok=go)_or(tok=if)_or(tok=goto)_or(tok=with)_or(tok=while)_or(tok=repeat)_or(tok=for)_or(tok=select)_or(tok=back)_or(tok=branch))_and(tokKind=tkWord);
    3: v32 := (tokKind = tk0) _and (lastChar = ',');
    4: v32 := tokKind = tkIdent;
    5: v32 := (tokKind = tk0) _and (lastChar = ';')
   _end;
   v31 := v31 _or v32;
   L7143 := v31;
   _if v31 _then exit;
   v33 := (v33 + 1);
 _);
_);
(* Level 3 *) _proced L7305(a31:bitset);
 _(
  _while _not L7143(a31) _do getToken;
 _);
 
(* Level 3 *) _function L7314(a31:alfa):int;
_var v31:int; _(
 _if a31 = '0' _then L7314 := 0 _else _(
    mapai(a31, v31);
    L7314 := pool[v31].i;
 _)
_);
(* Level 3 *) _function typeCheck(t1, t2:idptr):bool;
_label 7355;
_var v31:@typchain; v32, v33:idptr;
(* Level 4 *) _proced L7325;
 _(
 new(v31,9);
 v31@ := [gl4634z, v32, v33];
 gl4634z := v31;
 typeCheck := typeCheck(v32, v33);
 _);

_( (* typeCheck *)
(align) _if (_not modeC) _or (t1 = t2)
_then _( 7355: typeCheck := T; exit _) _else
 _if t1@.k = t2@.k _then _case t1@.k _of
0: _(
    _if ((t1 = alfaType) _and (t2 = charType))
    _or ((t1 = charType) _and (t2 = alfaType))
    _then _goto 7355;
_);
1:_if (t1@.f7.i = t2@.f7.i) _and (t1@.f8.i = t2@.f8.i)
  _and typeCheck(t1@.f3, t2@.f3)
  _then _goto 7355;
2: _(
 _if (t1 = ptrType) _or (t2 = ptrType) _then _goto 7355 _else _(
 v32 := t1@.f3;
 v33 := t2@.f3;
 _if (gl4634z <> _NIL) _then _(
 v31 := gl4634z;
 _while (v31 <> _NIL) _do _(
 _if (v31@.f1 = v32) _and (v31@.f2 = v33)
 _or (v31@.f2 = v32) _and (v31@.f1 = v33) _then _goto 7355
 _else v31 := v31@.f0;
 _);
 L7325;
 _) _else _(
    setup(t1);
    L7325;
    gl4634 := _NIL;
    rollup(t1);
 _);
 exit_)
_);
3: _goto 7355;
4: _if typeCheck(t1@.f3, t2@.f3) _and typeCheck(t1@.f7.id, t2@.f7.id)
   _then _goto 7355;
7: sysErr(2);
6:_if typeCheck(t1@.f3, t2@.f3) _and (t1@.f7.i = t2@.f7.i)
  _then _goto 7355;
5:
_end;
typeCheck := F
_);

(* Level 3 *) _proced P7520(_var a31:idptr; _var a32:alfa;  a33:bool);
_label 7531, 7567, 7570, 7601, 7666;
_var v31:idptr; v32:char; _(
  v31 := a31;
 _case tokKind _of
tkWord: _(
 _if (tok <> 'NIL') _then _goto 7666;
 7531:
 a31 := ptrType;
 a32 := gl43z;
_);
tkIdent: _(
 _if curId = _NIL _then _goto 7666;
 _if (curId@.f4.i <> 1) _or (curId@.f3 <> _NIL) _then _goto 7666;
 _if curId@.vty@.k <> 0 _then _(
     _if curId@.vty = ptrType _then _goto 7531 _else _goto 7666;
 _); (* 7554 *)
  a31 := curId@.vty;
  a32 := curId@.f6.a;
  cv.i := L7314(a32);
_);
tkField: _goto 7666;
tkStr: _( a31 := alfaType;
  7567: cv.a := tok;
  7570: putConst(a32, F);
  _);
tkInt: _(
  a31 := intType;
  cv.i := gl26z;
  _goto 7570;
 _);
tkReal: _(
 a31 := realType;
 7601: cv.r := rval;
 _goto 7570;
 _);
tkChar: _(  a31 := charType; _goto 7567 _);
tk0: _(
 _if _not a33 _then _goto 7666;
 _if (lastChar = '+') _or (lastChar = '-') _then v32 := lastChar _else _goto 7666;
 getToken;
 P7520(a31, a32, F);
 _if (a31 = _NIL) _then _goto 7666;
 _if (v32 = '-') _then _( 
   _if (a31 = intType) _then _( cv.i := -gl26z; _goto 7570 _)
   _else _(
  _if (a31 = realType) _then _( rval := -rval; _goto 7601 _)
  _else _goto 7666;
 _)
 _); 
_)
_end;
 _if (v31 = _NIL) _or typeCheck(v31, a31)
 _then exit;
 7666: a31 := _NIL; (q)
_);
_proced parseType(a31:int; a32:alfa; _var a33:idptr; a34:int);
_label 10503, 10505, 10507, 10527, 11022, 11126;
(*=a1*)_const packed='PACKED';
_var baseType, curType, v33 :idptr;
isPacked:bool;
v35:alfa; v36:word;  v37, l3v8z: int;
(* Level 4 *) _proced typeErr(a41:int);
 _(
 error('ТИП', a41);
 _);
(* Level 4 *) _function bitWidth(a41:idptr):int;
_label 7703;
_var v41:word; _(
 _if a41@.sz <> 1 _then 7703: _(
 bitWidth := 0;
 _) _else _if a41@.k = 1 _then _(
 v41 := a41@.f7;
 _if v41.i < 0 _then _goto 7703;
 v41 := a41@.f8;
 _if v41.i >= 48 _then _goto 7703;
 code(4СЧ5=BH,4ЗЧ5=,);
 bitWidth := 49 - v41.i;
 _) _else _if a41@.k = 2 _then  bitWidth := 15
 _else  _if a41@.k = 0 _then _(
   _if a41 = boolType _then bitWidth := 1
   _else _if a41 = charType _then bitWidth := 8
   _else _goto 7703;
 _) _else
  _goto 7703;
 _);
(* Level 4 *) _proced doFields(_var a41:int; a42, l4a3z:idptr);
_label  7776, 10065;
_var v41, v42: idptr; v43: word;
v44, v45, l4v6z, l4id7z:idptr;
l4v8z:idptr;
l4v9z, l4v10z: int;
l4v11z: alfa;
l4v12z: alfa;
l4v13z, l4v14z: bool;
(* Level 5 *) _proced flistErr(a51:int);
_(
 error('FLISТ', a51);
_);
_( (* doFields *)
 l4v13z := T;
 v41 := _NIL;
_repeat
 l4v8z := _NIL;
 gl53z := 3;
 getToken;
 _if (tokKind = tkField) _then _goto 7776 _else _goto 10065;
 _repeat
 gl53z := 3;
 getToken;
 _if tokKind <> tkField _then flistErr(0); (* no id *)
7776:
 _if (curId <> _NIL) _then flistErr(1); (* id already defined in this record *)
 new(v42,9);
 v42@ := [tok, level, idTabA[gl25z], l4a3z, 4, _NIL, ,a42];
 idTabA[gl25z] := v42;
 _if (l4v13z) _then _(
   _if (l4a3z = _NIL) _then a42@.f3 := v42
   _else l4a3z@.nxt := v42;
   l4v13z := F;
 _);
 _if l4v8z = _NIL _then  l4v8z := v42
 _else v41@.vty := v42;
 v41 := v42;
 getToken;
 _until lastChar <> comma;
 _if (lastChar <> colon) _then flistErr(2); (* need colon after a list of fields *)
 parseType(1, '0', v43.id, 0);
 l4v9z := v43.id@.sz;
 gl77z := a42;
 _while l4v8z <> _NIL _do _(
 l4v8z@.f6 := v43;
 l4v8z@.f8.i := a41;
 a41 := a41 + l4v9z;
 l4v8z := l4v8z@.vty;
 _);
_until (lastChar <> ';');
exit;
 10065:
 _if (tokKind <> tkWord) _or (tok <> case) _then flistErr(3); (* no case *)
 gl53z := 3;
 getToken;
 _if (tokKind <> tkField) _then  flistErr(4); (* after case should be a field or a type *)
 l4v12z := tok;
 l4v10z := gl25z;
 l4id7z := curId;
 new(v42,9);
 v42@ := [tok, level, , l4a3z, 5, _NIL, , a42, a41];
 _if (l4v13z) _then_(
  l4v13z := F;
  _if (l4a3z = _NIL) _then  a42@.f3 := v42
  _else l4a3z@.nxt := v42;
 _) _else
  v42@.vty := v42;
 getToken;
 _if (lastChar = ':') _then _(
  _if (l4id7z <> _NIL) _then flistErr(11); (* selector id already used *)
  v42@.nxt := idTabA[l4v10z];
  idTabA[l4v10z] := v42;
  parseType(2,'0', v43.id, 0);
  l4v10z := 1;
 _) _else _(
  l4id7z := idTable[l4v10z];
  l4v10z := 0;
  _while l4id7z <> _NIL _do _(
   _if l4id7z@.nm <> l4v12z _then l4id7z := l4id7z@.nxt
   _else _(
    _if l4id7z@.f4.i <> 0 _then flistErr(12) (* no type id *)
    _else _(
     _if l4id7z@.k = 7 _then l4id7z := l4id7z@.f3;
     _if l4id7z@.k <> 0 _then flistErr(13); (* must be a discrete type *)
    _);
    v43.id := l4id7z;
    l4id7z := _NIL;
    l4v12z := '0';
   _)
  _); (* 10202 *)
  _if (l4v12z <> '0') _then _( flistErr(14); v43.id := ptrType _)
 _); (* 10206 *)
 v42@.f6 := v43;
 a41 := (a41 + l4v10z);
 _if (tokKind <> tkWord) _or (tok <> of) _then flistErr((6)); (* need "of" *)
 v41 := _NIL;
 l4v10z := a41;
 _repeat
  l4v6z := _NIL;
  l4v9z := l4v10z;
  getToken;
  _repeat
   v44 := v43.id;
   P7520(v44, l4v11z, F);
   _if (v44 = _NIL) _then flistErr(-1); (* bad or missing selector value *)
   new(v45, 7);
   v45@ := [0, l4v11z, _NIL, , 6, _NIL];
   _if (l4v6z = _NIL)
   _then v45@.f3 := v42
   _else v45@.f3 := l4v6z;
   l4v6z := v45;
   v44 := v41;
   (loop) _while (v44 <> _NIL) _do _(
    l4v12z := v44@.f1.a;
    _if (l4v11z > l4v12z) _then _(
     v45@.vty := v44;
     _exit loop
    _) _else _(
     _if l4v11z < l4v12z _then _(
      l4id7z := v44;
      v44 := v44@.vty;
     _) _else flistErr(8); (* repeated selector value *)
    _)
   _);  (*10276 *)
   _if v41 = v44
   _then v41 := v45
   _else l4id7z@.vty := v45;
   getToken;
   _if (lastChar <> comma) _and (lastChar <> colon) _then flistErr(7); (* need comma or colon *)
   l4v14z := lastChar = ':';
   getToken;

  _until l4v14z;
  _if lastChar <> oparen _then flistErr(10); (* need open paren *)
  doFields(l4v9z, a42, l4v6z);
  _if lastChar <> cparen _then flistErr(9); (* need close paren *)
  _if l4v9z > a41 _then  a41 := l4v9z;

  _while l4v6z <> v42 _do _(
   l4v6z@.f6.i := l4v9z;
   l4v6z := l4v6z@.f3;
  _);

  getToken;
 _until lastChar <> semi;
 v42@.vty := v41;
_);

_( (* parseType *)
 getToken;
 isPacked := F;
 _case tokKind _of
tk0: _( (* 10360 *)
 _if (lastChar = oparen) _then _(
 baseType := _NIL;
 new(curType, 9);
 curType@ := [a32, , , , 0, 1, 0];
 _if (a32 <> '0') _then _(
   curType@ := [, level, idTable[a34] ];
   idTable[a34] := curType;
 _); (* 10402 *)
 v37 := 0;
 a33 := curType;
 _repeat
 gl53z := 0;
 getToken;
 _if (tokKind <> tkIdent) _then typeErr(1);
 _if gl60z _then  typeErr(2);
 new(v33, 8);
 cv.i := v37;
 putConst(v35, F);
 v33@ := [ tok, level, idTable[gl25z], _NIL,1, curType, v35];
 idTable[gl25z] := v33;
 v37 := v37 + 1;
 _if (baseType = _NIL) _then curType@.f3 := v33 _else  baseType@.f7.id := v33;
 baseType := v33;
 getToken;
 _until lastChar <> ',';
 _if (lastChar <> cparen) _then typeErr(4);
 v33@.f7.s := _NIL;
 curType@.f7.i := v37;
 curType@.f8.i := 0;
_) _else _( (* 10460 *)
_if (lastChar = '@') _then _(
 parseType(1,'0', baseType, 0);
 new(a33, 7);
 a33@ := [a32, level, , baseType, 0, 1, 2];
 _goto 11126;
_); _goto 10527;
_); 10503: getToken; exit;
  10505:
  getToken;
  10507: a33 := curType;
  _if a32 = '0' _then _( exit; _goto 10527 _);
  new(v33, 7);
  v33@ := [a32, level, idTable[a34], curType, 0, , 7];
  idTable[a34] := v33;
  exit;
10527:
   baseType := _NIL;
   P7520(baseType, v35, T);
   _if (baseType = _NIL) _then typeErr(13);
   v37 := cv.i;
   getToken;
   _if (lastChar <> ':') _then typeErr(14);
   getToken;
   P7520(baseType, v36.a, T);
   _if (baseType = _NIL) _then  typeErr((15));
   l3v8z := cv.i;
   _if (baseType <> intType) _and (baseType <> charType) _and (baseType@.f3 = _NIL)
   _or (baseType@.k <> 0) _then typeErr((16));
   new(curType, 9);
   curType@ := [0, level, _NIL, baseType, 0, 1, 1, v37, l3v8z];
   _if (modeT) _then  P5340(curType, F);
   _goto 10505
_);
tkIdent: _( (* 10613 *)
 _if (curId = _NIL) _then _(
  _if gl57z  _and (a32 = '0') _then _(
   new(a33, 7);
   gl54z := gl54z + 1;
   a33@ := [tok, level, idTable[gl25z], _NIL, 0, 1, 2];
   idTable[gl25z] := a33;
   _goto 10503;
  _) _else typeErr(19);
 _);
 _if (curId@.f4.i <> 0) _then _goto 10527;
 _if (curId@.k = (7)) _then curId := curId@.f3;
 _if (a31 = 1) _and (curId@.k = (6)) _then  typeErr((20));
 _if (a31 = 2) _and (curId@.k <> 0) _and (curId@.k <> 1)
 _then typeErr(21);
 curType := curId;
 _goto 10505;
 _);
tkWord: _( (* 10666 *)
 _if (a31 = 2) _then typeErr(22);
 _if (tok = packed) _then _(
   isPacked := T;
   getToken;
   _if (tokKind <> tkWord) _then typeErr((40));
 _);
 _if tok = record _then _(
 new(baseType, 7);
 v37 := 0;
 baseType@ := [ a32, , , ,0, , 5];
 baseType@ := [, level, idTable[a34] ];
 idTable[a34] := baseType;
 gl77z := baseType;
 doFields(v37, baseType, _NIL);
 _if (tokKind <> tkWord) _or (tok <> end) _then  typeErr(23);
 baseType@.sz := v37;
 a33 := baseType;
 _goto 10503;
 _);
 _if tok = array _then _(
  getToken;
  _if lastChar <> obrack _then typeErr(24);
  curType := _NIL;
  _repeat
  parseType(2, '0', baseType, 0);
  new(v33, 9);
  v33@ := [a32, , curType, , 0, , 4, baseType];
  _if (curType = _NIL) _then_(
   a33 := v33;
   _if a32 <> '0' _then _(
    v33@ := [, level, idTable[a34] ];
    idTable[a34] := v33;
   _)
 _) _else curType@.f3 := v33;
 curType := v33;
 _until lastChar <> comma;
 _if lastChar <> cbrack _then typeErr(25);
 getToken;
 _if (tokKind <> tkWord) _or (tok <> of) _then typeErr(26);
 parseType(1, '0', baseType, 0);
 v33@.f3 := baseType;
 v37 := baseType@.sz;
 _goto 11022;
 _repeat
 curType := curType@.nxt;
 11022:
 v33 := curType@.f7.id;
 _if v33@.k = 1
 _then l3v8z := v33@.f8.i - v33@.f7.i + 1
 _else  typeErr(28);
 _if v37 = 1 _then curType@.f8.i := 0
 _else _(
   v36.i := v37;
 P5215(v36.i, cv.i);
 putConst(v36.a, F);
 curType@.f8 := v36;
 _);
 (*=m+*)
 v37 := v37 * l3v8z;
 curType@.sz := v37;
 _until curType = a33;
 exit
 _); (* 11060 *)
 _if tok = file _then _(
  getToken;
 _if (tokKind <> tkWord) _or (tok <> of) _then typeErr(29);
 parseType(1, '0', baseType, 0);
 l3v8z := 22;
 _if (isPacked ) _then  v37 :=   bitWidth(baseType ) _else  v37 := 0;
 _if (v37 <> 0) _and (v37 <= 24) _then 
 l3v8z := (trunc(48 / v37)) + l3v8z
 _else v37 := 0;
 new(a33, 8);
 a33@ := [0, , , baseType, 0, l3v8z, 6, v37];
 11126:
 _if a32 <> '0' _then _(
 a33@ := [a32, level, idTable[a34]];
 idTable[a34] := a33;
 _);
 exit
_); (* 11140 *)
_if (tok = set) _then _(
 getToken;
 _if (tok <> of) _then  typeErr(-1);
  parseType(2, '0', baseType, 0);
 _if ((baseType@.k <> 1) _or (baseType@.f7.i < 0) _or (baseType@.f8.i > (47))) _and
  (((baseType@.f1.i <> 0) _or _not typeCheck(baseType, boolType)) _and
  ((baseType@.f1.i = 0) _or (baseType@.f7.i > (47))) _or (baseType@.k <> 0)) _then 
    prErr('ТИП', 0);
  curType := setType;
 _goto 10507;
 _);
  typeErr((33));
 _);
  tkInt, tkStr, tkReal, tkChar: _goto 10527;
  tkField: sysErr(3)
 _end;
 sysErr(4);
_);
(* Level 3 *) _proced P11224(_var a31:idptr; _var a32:alfa);
_label 11266;
_var v31, v32:idptr; 
  v33:idptr;
  v34, v35:int; v36:bool; v37:int; _(
 a31@.f7.s := _NIL;
 _repeat
 v33 := _NIL;
 gl53z := 0;
 v35 := 0;
 getToken;
 _if (tokKind = tkIdent) _then _goto 11266;
 _if (tokKind <> tkWord) _then prErr('ФОРПАР', 0);
 _if (tok = var) _then v35 := 1
 _else _if (tok = functi) _then v35 := 2
 _else _if (tok <> 'РRОСЕD') _then prErr('ФОРПАР', 1 )
 _else v35 := 3;
 _repeat 
 gl53z := 0;
 getToken;
 11266:
 a31@.f10.i := a31@.f10.i + 1;
 _if (tokKind <> tkIdent) _or gl60z _then prErr('ФОРПАР', 2);
 _case v35 _of
 0: _( new(v31, 8); v31@.f4.i := 1_);
 1: _( new(v31, 8); v31@.f4.i := 2_);
 2,3: _( new(v31, 13); v31@.f4.i := 3_)
 _end;
 v31@ := [tok, level, idTable[gl25z] ];
 idTable[gl25z] := v31;
 _if a31@.f7.id = _NIL _then a31@.f7.id := v31
 _else v32@.f3 := v31;
 v32 := v31;
 _if v33 = _NIL _then v33 := v31;
 getToken;
_until (lastChar <> ',');
 v34 := 1;
 _if v35 = 3 _then v31 := _NIL
 _else _(
 _if (lastChar <> ':') _then prErr('ФОРПАР', 3);
 parseType(0, '0', v31, 0);
 v37 := v31@.k;
 _if v35 = 0 _then v34 := v31@.sz;
 _if ((v35 = 0) _and (v34 <> 1))
 _or ((v35 = 2) _and (v37 > 3)) _then prErr('ФОРПАР', 4);
 _); (* 11404 *)
 _repeat
 _if v35 < 2 _then _(
  v33@.vty := v31;
  v33@.f6.a := a32;
  _if modeV _and (v37 < 4) _then  v33@.f7.i := 1
  _else v33@.f7.i := 0;
 _) _else _(
  v33@.vty := v31;
  v33@.f8.a := a32;
 _);
 alfAdd(a32, v34);
 v36 := v32 = v33;
 v33 := v33@.f3;
 _until v36;
 _until lastChar <> semi;
 _if lastChar <> cparen _then prErr('ФОРПАР', 5);
 getToken;
 v32@.f3 := a31;
_);
   (* Level 3 *) _proced P11450(a31:pInst; a32, a33:alfa);
_var v31:pInst; _(
 v31 := a31;
 _while v31 <> _NIL _do _(
 _if v31@.f4 = a32 _then v31@.f4 := a33;
 v31 := v31@.nxt;
 _)
_);
(* Level 3 *) _proced mkInst(_var i:pInst);
 _(
 new(i);
 _if i = _NIL _then sysErr(0);
_);
(* Level 3 *) _proced P11512(a31:int; _var a32:expr);
_label 11523, 11525, 11631, 11703, 11735;
_var v31, v32:pInst; v33:alfa; 
(* Level 4 *) _proced L11477;
 _(
 mkInst(v32);
 v32@ := [ a32.in, gl35z ];
 a32.in := v32;
 _);
_( (* P11512 *) (*=a0*)
(a) L11477;
_case a31 _of
0: _( v32@.f4 := '12';
11523: v32@.op := gl37z;
11525: v32@.f2 := gl44z;
_);
1: _(v32@.f4 := '13'; _goto 11523 _);
2: _(v32@.f4 := '13'; v32@.f1 := 1; v32@.op := 'СР'; _goto 11525 _); (* ineff *)
3: _(
 v32@ := [, , a32.f2, gl37z, a32.f1];
 a32.f0.i := 3;
 _if (a32.f2.i = 0)
 _and (a32.f1.i <> 0) 
 _and (v32@.nxt@.op <> 'ИА') 
 _and (v32@.nxt@.op <> 'ИК') _then v32@.f2 := gl44z;
_);
4: _(
 v32@.f4 := 'ТR';
 v32@.f1 := 2;
 _goto 11703;
_);
5: _(
v32@ := [, 1, gl44z, 'АУ', gl41z];
 P11512(17, a32);
_);
6: v32@ := [, 1, 0, 'ИЗ', 'ЧМ1'];
7: v32@ := [, , a32.f2, 'АВ', a32.f1];
8: v32@ := [, , 0, gl37z, 0];
9, 14: sysErr(5);
10: v32@ := [, , '17', gl37z, a32.f1];
11: 11631: _( v32@ := [, , '15', 'ПА', 0]; L11477; v32@ := [, , 0, 'ВИ', '15'] _);
12: _( v32@ := [, , a32.f2, 'ИА', a32.f1]; L11477; v32@ := [, , '15', 'ПА', 0] _);
13: v32@ := [, , '11', 'ПА', 0];
15: v32@ := [, 2, 0, 'РА', '23'];
16: _( v32@.op := 'ЛС'; v32@.f4 := 'Z64'; v32@.f2 := '0'_); (* inefficient *)
17: _if modeM _then _(
   v32@ := [, 1, , , 'ЦУ'];
   11703:
   v32@ := [, , '16', 'ПВ'];
 _) _else v32@ := [, , 0, 'МР', '30'];
18: _(   v32@ := [, 4, , , 'R']; _goto 11703 _);
19: v32@ := [, , '17', 'ЗЧ', 0];
20: v32@ := [, , gl44z, 'ЛУ', '13'];
21: _( v33 := 'АС';
11735:
v32@ := [, 1, 0, v33, '13'] _);
22: _( v33 := 'АВ'; _goto 11735_);
23: _(
 _if (a32.f2.i <> 0) 
 _or (a32.f1.i <> 0) _then _(
 v32@ := [, , a32.f2, 'ИА', a32.f1];
 L11477;
 _) _else _if (a32.in@.nxt <> _NIL) _and (a32.in@.nxt@.op = 'ИК') _then_(
 v31 := a32.in;
 a32.in := v31@.nxt;
 a32.in@.op := gl37z;
 a32.f0.i := 3;
 v31 := a32.in;
 _if (v31@.f2 = '17') _and (v31@.f4 = '0') _then _(
   v31 := v31@.nxt;
   _if (v31@.f2 = '17') _and (v31@.f4 = '0') _and (v31@.op = 'ЗЧ') _then
    a32.in := v31@.nxt;
 _);
 exit
 _);
 _goto 11631
_);
24: _(
 v32@ := [,2, a32.ty@.f1, 'ИА', a32.ty@.f8];
 L11477;
 v32@ := [, , '12', 'ПА', 0];
 L11477;
 v32@ := [, , '16', 'ПВ', 'ВП7'];
_);
25:v32@ := [, , level, 'ИК', l2v11z];
26:v32@ := [, , 0, 0, 0];
27: _( v32@.op := 'СМ'; putConst(v32@.f4, F); v32@.f2 := gl44z _);
28: v32@:= [, , gl44z, 'ЛУ', gl41z]
_end; (* 12127 *)
_);
(* Level 3 *) _proced P12143(a31:int; _var a32:expr; a33:alfa);
_label 12164, 12166, 12205, 12211, 12240, 12242, 12355;
_var v31:pInst; v32:alfa; v33, v34:int; 
(* Level 4 *) _proced L12130;
 _(
 mkInst(v31);
 v31@ := [a32.in, 0];
 a32.in := v31;
 _);
_( (* P12143 *)
 _if (a31 > 23) _then sysErr(4);
 _if (a31 <> 12) _then L12130;
 _case a31 _of
 0:v31@ := [, , label, , a33];
 1: _(
  v31@.op := 'ПБ';
12164:
 v31@.f2 := gl44z;
12166:
 v31@.f4 := a33;
 _);
 2:_( v31@.op := 'У1'; _goto 12164 _);
 3:_( v31@.op := 'У0'; _goto 12164 _);
 4: v31@ := [, gl35z, a32.f2, a33, a32.f1];
 7: 12205: _( v31@.f2 := '15'; v31@.op := 'ПА'; _goto 12166 _);
 5: 12211: _( _if (modeX) _then _( v31@.f2 := '10'; v31@.op := 'ИА'; v31@.f4 := '0'; L12130_); (*ineff*)
 _if a31 = 8 _then _goto 12205 _else _goto 12240;
 _);
 6, 13, 18, 21: sysErr(a31);
 8: _goto 12211;
 9: v31@ := [, ,  '17', a33, 0];
 10: _( v31@.f2 := '17'; v31@.op := 'ЗЧ'; _goto 12166 _);
 11: 12240: _( v31@.f2 := '16'; 12242: v31@.op := 'ПВ'; _goto 12166 _);
 12: _(
 _if (level = a33) _then exit
 _else _(
 mapai(level, v33);
 mapai(a33, v34);
 L12130;
 _if v34 + 1 = v33 _then v31@ := [, , '13', 'ПИ', level]
  _else _(
   a33 := rets[v33][v34];
   _if a33 = '0' _then _(
    TNL(a33);
    rets[v33][v34] := a33;
   _);
   _goto 12211;
  _)
 _); (* 12276 *)
 _);
 14: _( v31@.f2 := '11'; v31@.op := 'ЗЧ'; _goto 12166 _);
 15: _( v31@.f2 := '14'; _goto 12242 _);
 16: _(
  v31@ := [, , a32.f2, 'ИА', a32.f1];
  L12130;
 v31@ := [, , a33, 'ПА', 0];
 L3732(a32.in);
 _);
 17:_( v31@.op := 'СР'; v31@.f2 := '0'; _goto 12166_);
 19: v31@ := [, ,0, 'Э050', a33];
 20:v31@ := [, , '17', 'СА', a33];
 22: _(
  v31@ := [,1, '15', 'ПА', 'ОV'];
   L12130;
   mapia(lineNum, v32);
   v31@ := [, , '14', 'ПА', v32];
 12355: L12130;
 _goto 12211;
 _);
 23: _(
 v31@ := [, , a32.f2, gl37z, a32.f1];
 a32.f0.i := 3;
 _goto 12355
 _)
 _end; (* 12421 *)
_);
(* Level 3 *) _proced P12422(a31, a32:alfa; a33: char; _var a34:expr);
_var v31:pInst; v32:alfa; _(
 mkInst(v31);
 mapia(a33, v32);
 v31@ := [ a34.in, 0, a31, a32, v32];
 a34.in := v31;
_);
(* Level 3 *) _proced L12445(_var a31:expr);
_var v31:int; _(
 v31 := 23;
 _if a31.ty@.k = 6 _then _(
 _if a31.f5.i = 1 _then  v31 := 3
 _else _if a31.f2.i = 0 _then _(
 _if a31.f1.i = 7 _then v31 := 0
 _else _if a31.f1.a = '10' _then _(
   v31 := 3;
   a31.f2.i := 0;
   a31.f1.a := 'Z64';
 _)
 _)
 _);
  P11512(v31, a31);
 _);
(* Level 3 *) _proced L12475(_var a31:expr);
_(
 _if a31.f0.i = 2 _then _(
   putInsn('17ЗЧ');
   P12143(16, a31, '15');
   putInsn('17СЧ'); putInsn('15ЗЧ');
   exit
 _);
 P12143(4, a31, 'ЗЧ');
 L3732(a31.in);
_);
(* Level 3 *) _proced L12520(_var a31:expr);
_label 12556, 12557;
_var v31, v32:alfa;  v33:int; _(
 _if a31.ty = boolType _then _case a31.f0.i _of
 0: _if a31.f5.i = 0 _then P11512(0, a31) _else P11512(1, a31);
 1: _(  P11512(3, a31); _if a31.f5.i <> 0 _then P11512(2, a31) _);
 2:  _if (a31.f1.a <> label) _then _(
   TNL(v31);
   P12143(3 - a31.f5.i, a31, v31);
   12556: v33 := 1;
   12557: TNL(v32);
   P11512(v33, a31);
   P12143(1, a31, v32);
   P12143(0, a31, v31);
   P11512((1 - v33), a31);
   P12143(0, a31, v32);
  _) _else _if a31.f5.i <> 0 _then P11512(2, a31);
 3: _(
   v31 := a31.f1.a;
   _if a31.f5.i = 0 _then _goto 12556
   _else v33 := 0;
   _goto 12557
 _)
 _end _else _( (* 12624 *)
   _if a31.f0.i <> 3 _then _( 
    P11512(3, a31);
    a31.f0.i := 3;
    exit
   _)
  _);
 a31.f0.i := 3
 _);
(* Level 3 *) _proced L12635(_var a31:expr);
_(
 L12520(a31);
 L3732(a31.in);
_);
(* Level 3 *) _proced append(what:pinst; _var where:pinst);
_var i:pinst; _(
 _if where = _NIL _then where := what
 _else _(
   i := where;
   _while i@.nxt <> _NIL _do i := i@.nxt;
   i@.nxt := what;
 _)
_);
(* Level 3 *) _proced P12665(_var a31, a32:expr);
_(
  append(a31.in, a32.in);
_);
(* Level 3 *) _function F12677(a31, a32:idptr):bool;
 _(
 F12677 := (a31@.k = 3) _and (a32@.k = 3);
_);
(* Level 3 *) _proced P12713(_var a31, a32: expr; a33:alfa);
_(
  L12520(a31);
  P11512(19, a31);
  L12520(a32);
  P12143(15, a32, a33);
  append(a31.in, a32.in);
  a31.in := a32.in;
_);
(* Level 3 *) _proced P12741(a31:alfa; a32:bool; _var a33, a34:expr; l3a5z:int);
_label 12747, 12752, 12775, 13013, 13045;
 _(
 _case a33.f0.i _of
 0, 1: _case a34.f0.i _of
   0, 1: 12747: _(
   P11512(3, a33);
 12752:
 append(a33.in, a34.in);
 gl35z := l3a5z;
 P12143(4, a34, a31);
 a33 := [3, , , , a34.in, 0];
   _);
   2: _(
   P11512(3, a34);
   _if a32 _then _(
  12775:
   append(a34.in, a33.in);
 gl35z := l3a5z;
 P12143(4, a33, a31);
 a33 := [3, , , , , 0];
 _) _else 13013: _(
  P11512(19, a34);
  _if (a33.f0.i <> 3) _then  P11512(3, a33);
  a33.f1.i := 0;
  a33.f2.a := '17';
  _goto 12775;
 _); (* 13027 *)
   _);
   3:_if a32 _then _goto 12775 _else _goto 13013
 _end;
 2: _case a34.f0.i _of
   0,1: _goto 12747;
   2: 13045: _( P11512(3, a34); _goto 13013 _);
   3: _goto 13013 _end;
 3: _case a34.f0.i _of
   0, 1: _goto 12752;
   2: _goto 13045;
   3: _goto 13013
   _end
 _end;
 gl35z := 0
_);
(* Level 3 *) _proced L13104(_var a31:expr);
 _(
 _if (a31.ty = intType) _then _(
 _if (a31.f0.i = 0) _then _(
   rval := L7314(a31.f1.a);
   cv := ;
   putConst(a31.f1.a, F);
 _) _else _(
  _if (a31.f0.i <> 3) _then P11512(3, a31);
  P11512(18, a31);
 _)
 _)
_);
(* Level F13134 *) _function F13134(a31:alfa; a32:bool; _var a33, a34:expr):bool;
_label 13153, 13155;
_var v31, v32:idptr; _(
 v31 := a33.ty;
 v32 := a34.ty;
 _if (v31 = realType) _then _(
 _if (v32 = realType) _then _goto 13155;
 _if (v32 = intType) _then L13104(a34 )
 _else 13153: _( F13134 := T;  exit _);
 13155:
 _)_else _if (v31 <> intType) _then _goto 13153
 _else _if (v32 = realType) _then _(
    L13104(a33);
    a33.ty := realType;
 _) _else _goto 13153;

 P12741(a31, a32, a33, a34, 3);
 F13134 := F;
 _);
(* Level 3 *) _proced P13176(a31:bool; _var a32, a33:expr);
_label 13246, 13261, 13323, 13462;
_var v31:alfa; v32:int; v33:expr; _(
 _if a31 _then _(
   a32.f5.l := odd(a32.f5.i + 1);
   a33.f5.l := odd(a33.f5.i + 1);
 _);
 _case a32.f0.i _of
 0: (* 13213 *) _case a33.f0.i _of
   0: _if ((a32.f5.i + a33.f5.i) <> 2) _then a32.f5.i := 0;
   1, 2, 3: _if a32.f5.i = 0 _then a33.in := _NIL _else a32 := a33
 _end;
 1: (* 13245 *) _case a33.f0.i _of
   0: 13246: _if a33.f5.i = 0 _then a32 := [0, , , , _NIL, 0];
   1, 2: _( P11512(3, a32);
     13261: _if a32.f5.i = 0 _then v32 := 3 _else v32 := 2;
     TNL(v31);
     P12143(v32, a32, v31);
     _if (a33.f0.i = 1) _then P11512(3, a33);
     _if (a33.f5.i = 0) _then v32 := 3 _else v32 := 2;
     P12143(v32, a33, v31);
     P12665(a32, a33);
     a32.in := a33.in;
     a32 := [3, v31, , , , 0];
   _);
   3: 13323: _(
   _if (a32.f5.i = 0) _then v32 := 3 _else v32 := 2;
   _if (a33.f5.i = 0) _then _(
    _if (a32.f0.i = 1) _then P11512(3, a32);
    P12143(v32, a32, a33.f1.a);
    a32.f1 := a33.f1;
   _) _else _(
    TNL(v31);
    P12143(1, a33, v31);
    P12143(0, a33, a33.f1.a);
    _if (a32.f0.i = 1) _then P11512(3, a32);
    P12143(v32, a32, v31);
    a32.f1.a := v31;
   _);
   P12665(a33, a32);
   a32 := [3, , , , , 0];
  _)
 _end;
 2: (* 13407 *) _case a33.f0.i _of
   0: _goto 13246;
   1, 2: _goto 13261;
   3: _goto 13323
 _end;
 3: (* 13422 *) _case a33.f0.i _of
   0: _goto 13246;
   1, 2: _(
   v33 := a32;
   a32 := a33;
   a33 := v33;
   _goto 13323;
   _);
   3: 
   _if (a33.f5.i = a32.f5.i) _then _(
    _if (a33.f5.i = 0) _then _(
     P11450(a33.in, a33.f1.a, a32.f1.a);
     13462:
     P12665(a32, a33);
     a32.in := a33.in;
    _) _else _(
     TNL(v31);
     P12143(1, a32, v31);
     P12143(0, a32, a32.f1.a);
     P12143(0, a33, v31);
     P12665(a32, a33);
     a32 := [, a33.f1, , , a33.in];
 _)
 _) _else _(
  _if (a32.f5.i = 0) _then _(
   P12143(1, a33, a32.f1.a);
   P12143(0, a33, a33.f1.a);
  _) _else _(
   P12143(1, a32, a33.f1.a);
   P12143(0, a32, a32.f1.a);
   a32.f1 := a33.f1;
  _);
  a32.f5.i := 0;
  _goto 13462;
 _)
 _end
 _end;
 _if a31 _then a32.f5.l := odd(a32.f5.i + 1);
_);
(* Level 3 *) _proced L13566(_var a31:alfa);
 _(
 _if curLab <> '0' _then a31 := curLab
 _else _(
   TNL(a31);
   P4357(0, a31);
 _)
 _);
(* Level 3 *) _proced P13602(a31:idptr; a32:bool);
_label 13625;
_var v31:idptr; v32:alfa; _(
 _if gl101z _or _not gl109z _then exit;
 _if a31@.k = 1 _then a31 := a31@.f3;
 _if a32 _then v31 := a31@.vty
 _else  v31 := a31;
 _if v31 = alfaType _then _(
   v32 := '12ПА1';
 13625:
 putInsn(v32);
 mapia(l2v28z, v32);
 L3656('14ПА', v32);
 _if a32 _then L5312(a31@.nm)
_else  gl41z := 'ВСS';
 L3656('15ПА', gl41z);
 putAlign('16ПВЩП');
 _) _else _select (* ineff *)
  (v31 = intType): _( v32 := '12ПА5'; _goto 13625 _);
  (v31 = charType): _( v32 := '12ПА4'; _goto 13625 _);
  (v31 = boolType): _( v32 := '12ПА3'; _goto 13625 _);
  (v31 = realType): _( v32 := '12ПА2'; _goto 13625 _);
  (v31@.k = 3): _( v32 := '12ПА6'; _goto 13625 _);
  (v31@.k = 0): _(
 putInsn('17ЗЧ');
 L5425(v31);
 L3656('14ПА', v31@.f8.a);
 putInsn('ВИ14');
 v32 := '12ПА10';
 putInsn(v32);
 mapia(l2v28z, v32);
 L3656('14ПА', v32);
 _if a32 _then  L5312(a31@.nm)
 _else gl41z := 'ВСS';
 L3656('15ПА', gl41z);
 putAlign('16ПВЩП');
 putInsn('17СЧ');
 _);
 T: _( v32 := '12ПА7'; _goto 13625  _)
  _end;  (* 13732 *)
 gl101z := T
_);
(* Level 3 *) _proced P13734(_var a31, a32:expr);
_var v31:int; v32:alfa; v33, v34:pinst; _(
 _if modeC _then v31 := a31.ty@.sz
 _else v31 := 1;
 _if (v31 = 1) _then _(
  _if (a31.f0.i = 2) _and (a31.in@.op = 'ИК') _then _(
   v33 := a31.in;
  _while (v33@.op = 'ИК') _do _( v34 := v33; v33 := v33@.nxt _);
  append(v33, a32.in);
  L12635(a32);
  v34@.nxt := _NIL;
  a31.f0.i := 1;
  _if l2v23z@.f7.l _then P13602(l2v23z, T);
  L12475(a31);
 _) _else _( (* 14002 *)
  L12635(a32);
 _if l2v23z@.f7.l _then P13602(l2v23z, T);
  L12475(a31);
 _)
 _) _else _( (* 14013 *)
  v31 := v31 - 1;
  mapia(v31, v32);
  P12143(16, a32, '12');
  P12143(16, a31, '16');
  P4357(14, v32);
 _) (* 14030 *)
_);

_proced L16431(_var a31:expr);+
_proced doExpr(_var a31:expr);+

(* Level 3 *) _proced P14226(a31:idptr; _var a32:pinst);
_label 14357, 14370, 14374;
(*=a1*)_const param='ПАРАМ';(*=a0*)
_var v31:expr;
v37:alfa; l3v8z:bool;
l3v9z, l3v10z:bool;
l3v11z, l3v12z, v3D, v3E:int; l3v15z:idptr;
l3v16z:idptr; l3v17z:idptr;  l3v18z:pInst; l3v19z:int;

(* Level 4 *) _proced L14031(a41:idptr);
_var v41:alfa; v42:alfa; v43, v44:alfa; v45:idptr; l4v6z:int; _(
 _if (a41@.f3 <> _NIL) _then _(
  P11512(0, v31);
  v31.in@ := [, , a41@.f1, , a41@.f8 ];
 _) _else _(
 _if (a41@.k = 0) _then _(
 _if (gl40z = '0') _then _(  cv.i := 2; putConst(gl40z, F) _);
 extras[14] := 'ИА'; extras[16] := 'ИА'; extras[13] := 'ИА'; (* ineff *)
 TNL(v41); TNL(v42);
 P4357(1, v41); align;
 a41@.f6.a := v42;
 v45 := a41@.f7.id;
 metka(v42); TNL(v44); modBase; ГГ('12ПА');
 putInsn(v44); ГГ('11ПА');
 _if a41@.vty <> _NIL _then  ГГ(1);
 putSep; putAlign('14ПВВП'); ГГ('17СЧ');
 l4v6z := a41@.f10.i + 2;
 _if a41@.vty <> _NIL _then  l4v6z := (l4v6z + 1);
 mapia(l4v6z, v42);
 putInsn(v42); ГГ('17СА');
 _if a41@.f10.i > 1 _then  ГГ(v42);
 putSep; modBase; ГГ('16ПАВП', 6);
 putSep; modBase; ГГ('ПБ', a41@.f9.a);
 align; ГГ('С;', v44); write(icolon);
_if v45 <> _NIL _then_(
_repeat
 l4v6z := v45@.f4.i;
 _if (l4v6z = 3) _and _not (v45@.vty <> _NIL) _then  l4v6z := 4;
 write(l4v6z:0, icomma);
 v45 := v45@.f3;
 _until a41 = v45;
 _);
 ГГ(',К;');
 P4357(0, v41);
 _); (* 14202 *)
 _if (modeX) _then _(
 P12143(1, v31, '000000');
 v31.in@.op := 'ИА';
 _);
 P12143((7), v31, curId@.f6.a);
 P12143(11, v31, 'ПВ');
_) (* 14225 *)
_);
_( (* P14226 *)
  l3v10z := a31@.f3 = _NIL;
  l3v9z := a31@.vty = _NIL;
  v3E := 0;
  _if l3v9z _then  l3v11z := 3 _else  l3v11z := 4;
  _if _not l3v10z  _then  l3v11z := l3v11z + 2;
  _if l3v10z _and (a31@.f10.i >= 2) _or _not l3v10z _then _(
    v31.in := _NIL;
    mapia(l3v11z, v37);
    P12143(20, v31, v37);
    a32 := v31.in;
  _) _else a32 := _NIL;
  _if lastChar = oparen _then _(
    _if l3v10z  _then _(
      l3v16z := a31@.f7.id;
      _if l3v16z = _NIL _then _( l3v11z := 0; prErr(param, l3v11z);exit _)
    _);
   _repeat
    v3E := v3E + 1;
    l3v8z := T;
    _if l3v10z _and (a31 = l3v16z) _then _( prErr(param, 1); L7305([0,1,2]); exit _);
    gl53z := 2;
    getToken;
    v31.in := _NIL;
    _if (tokKind = tkIdent)  _and (curId <> _NIL) _and (curId@.f4.i = 3) _then _(
      l3v17z := curId@.vty;
      l3v19z := 3;
      _if (l3v17z = _NIL) _then _(
        _if (curId@.f1.i = 0) _then prErr(param, 2 ) _else _(
          L14031(curId);
          v3D := 4;
          getToken;
        _)
      _)  _else _(
        l3v15z := curId;
        _if _not l3v10z _then _(
          gl63z := T;
          L16431(v31);
          _if (v31.f0.i = 0) _then _(
14357:
            _if l3v15z@.f1.i = 0 _then  prErr(param, 3 )
            _else _( L14031(l3v15z); v3D := 3_)
          _) _else _( (* 14367 *)
            gl63z := T;
14370:
            gl62z := F;
            doExpr(v31);
14374:
            L12520(v31);
            l3v19z := 1;
            l3v17z := v31.ty;
          _)
        _) _else _( (* 14402 *)
          _if (l3v16z@.f4.i = 3) _then _( getToken; _goto 14357 _) _else _goto 14370;
        _)
      _)
    _) _else _( (* 14411 *)
      gl62z := F;
      doExpr(v31);
      _if (v31.f0.i _IN [1,2]) _then _(
        l3v19z := 2;
        l3v17z := v31.ty
      _) _else _goto 14374;
    _); (* 14422 *)
    _if l3v10z _then _(
      _if (l3v16z@.f4.i <> l3v19z) _then _(
        _if (l3v16z@.f4.i = 1) _and (l3v19z = 2) _then _(
          l3v19z := 1;
          L12520(v31);
        _) _else  prErr(param, 4);
      _); (* 14440 *)
      _if (l3v17z <> _NIL) _then _(
        _if (l3v19z = 3) _then l3v15z := l3v16z@.vty _else l3v15z := l3v16z@.vty; (* ??? *)
        _if _not typeCheck(l3v17z, l3v16z@.vty) _then  prErr(param, 5);
      _);
    _); (* 14457 *)
    _if (l3v19z = 2) _then_(
      l3v18z := v31.in;
      L12445(v31);
      _if (l3v18z = _NIL) _and (v31.in@.op = 'ВИ') _and (v3E > 1) _then _(
        v31.in@.op := 'ВМ';
        l3v8z := F;
      _)
    _); (* 14474 *)
    _if _not l3v10z _then _(
      _if _not (l3v19z = 3) _then  v3D := l3v19z;
      cv.i := v3D;
      P11512(27, v31);
    _) _else  l3v16z := l3v16z@.f3;
    _if l3v8z _and (v3E <> 1) _then _(
      l3v18z := v31.in;
      v31.in := a32;
      P11512(19, v31);
      a32 := v31.in;
      v31.in := l3v18z;
    _);
    append(a32, v31.in);
    a32 := v31.in;
   _until lastChar <> comma;
    _if (l3v10z _and (l3v16z <> a31)) _or (lastChar <> cparen) _then prErr(param, (6) )
    _else getToken;
  _) _else _( (* 14545 *)
    _if l3v10z _and _not (a31@.f7.s = _NIL) _then  prErr(param, (7));
  _); (* 14553 *)
  v31.in := a32;
  MAPЯГА( a31@.nm, v37);
  _if (a31@.f9.a = v37) _then P11512(19, v31);
  _if l3v10z _then _(
    P12143((5), v31, a31@.f9.a);
    v31.in@.f1 := 2;
    v37 := a31@.f1.a;
    _if (a31@.f8.a = extern) _then _(
      P11512(26, v31);
      v31.in@.f2 := label;
    _)
  _) _else _( (* 14607 *)
    _if v3E = 0 _then _(
      v31.in@ := [, , 0, gl37z, 0];
      v3D := (l3v11z + 1);
      mapia(v3D, v37);
      P12143(10, v31, v37);
    _) _else _(
      P11512(26, v31);
      v31.in@.op := 'СМ';
      P12143(10, v31, '1');
      v3D := -(2 * v3E + l3v11z); (* ineff *)
      mapia(v3D, v37);
      P12143(20, v31, v37);
    _); (* 14651 *)
    mapia(lineNum, v37);
    P12143((7), v31, v37);
    v31.ty := a31;
    P11512(24, v31);
    v37 := '1';
  _); (* 14665 *)
  P12143(12, v31, v37);
  _if _not l3v9z _then _(
    mapia(l3v11z - 1, v31.f1.a);
    P11512(10, v31);
  _);
  a32 := v31.in;
  _if l3v9z _then  L3732(a32);
_);

(* Level 3 *) _proced L16714(_var a31:expr);+

(* Level 3 *) _function L14707(_var a31:expr):bool;
 _(
 gl53z := 2;
 getToken;
 L14707 := T;
 _if _not ((tokKind <> tkIdent) _or (curId = _NIL)) 
 _and (_not ((curId@.f4.i <> 1) _or (curId@.f3 = _NIL)) _or (curId@.f4.i = 2))
 _or (tokKind = tkField) _then L16714(a31 )
 _else L14707 := F;
 _);

(* Level 3 *) _proced L14735(a31:int);
 _( (*=a1*) prErr('ОШИБКА', a31); (*=a0*)_);

(* Level 3 *) _proced L14742;
 _(
 _if _not (lastChar = comma) _then  L14735(0);
 _);
 
(* Level 3 *) _proced P14750(a31:int; _var a32:expr);
_const c1='10СР';c2='10ЛУ';c3='17СР';c4='15СЧ';c5='17СР-1';c6='15СР';c7='16ПВIS';
_var v31, v37, v3D:expr;
l3v19z:bool;
l3v20z,
l3v21z, l3v22z, l3v23z:int;
l3v24z:bitset;
l3v25z:alfa;
l3v26z:bool;
l3v27z, l3v28z:alfa;
l3v29z, l3v30z:int; l3v31z:expr; _(
 doExpr(v31);
 L14742;
 doExpr(v37);
 l3v19z := v37.f0.i = 0;
 _if l3v19z _then  l3v20z := L7314(v37.f1.a);
 _if (a31 <> 2) _then _(
   doExpr(v3D);
   _if (v3D.f0.i <> 0) _then  L14735(2);
   l3v22z := L7314(v3D.f1.a);
   _if (l3v22z < 1) _or (l3v22z > (47)) _then L14735((7));
   l3v24z := [48-l3v22z..47];
 _); (* 15020 *)
 _if (a31 <> 1) _then _(
   L12520(v31);
   _if _not (v37.f0.i <= 1) _then  L14735(1);
   _if l3v19z _then _(
     _if (l3v20z <> 0) _then P12422('000000', 'СД', chr(100B + l3v20z), v31);
   _) _else _(
     P12143(4, v37, 'ИК');
     P12422('000000', 'СД', chr(100B), v37);
     P12665(v31, v37);
     v31.in := v37.in;
   _);
   _if (a31 = 0) _then _(
     cv.b := l3v24z;
     putConst(l3v25z, F);
     mapai(l3v25z, l3v23z);
     _if _not l3v19z _or ((l3v22z + l3v20z) <> 48) _then P12422('10', 'ЛУ', chr(l3v23z), v31);
   _);
   a32 := v31;
 _) _else _( (* 15110 *)
   l3v26z := F;
   _if l3v19z _then _(
     l3v21z := -l3v20z;
     _if v31.f0.i = 0 _then_(
       l3v26z := T;
       l3v30z := L7314(v31.f1.a);
       l3v30z := shift(l3v30z, l3v21z);
       cv := ;
       putConst(l3v28z, F);
       v31.f1.a := l3v28z;
     _);
     l3v24z := shift(l3v24z, l3v21z);
     l3v24z := [0..47] - l3v24z;
     cv := ;
     putConst(l3v27z, F);
   _);
   _if l3v26z _and l3v19z _and (a32.in = _NIL) _then _(
     l3v31z := a32;
     L12635(a32);
     ГГ('10СР', l3v28z); putSep;
     ГГ('10ЛУ', l3v27z); putSep;
     ГГ('10СР', l3v28z); putSep;
     L12475(l3v31z);
   _) _else _if l3v19z _and (a32.in = _NIL) _then _(
     l3v31z := a32;
     L12520(v31);
     P12422('00000', 'СД', chr(100B - l3v20z), v31);
     P11512(19, v31);
     P12741('СР', T, v31, a32, 0);
     L3732(a32.in);
     ГГ('10ЛУ', l3v27z); putSep;
     putInsn('17СР');
     L12475(l3v31z);
   _) _else _if l3v19z _then _(
     _if (v31.f2.i = 0) _and (v31.in = _NIL) _then L12520(v31)
     _else _(
       L12520(v31);
       P12422('000000', 'СД', chr(100B - l3v20z), v31);
     _);
     P11512(19, v31);
     L3732(v31.in);
     l3v29z := a32.f0.i;
     P11512(12, a32);
     L3732(a32.in);
     _if l3v29z = 2 _then _(
       putInsn('15СЧ'); putInsn('17СР-1')
     _) _else putInsn('15СР');
     ГГ('10ЛУ', l3v27z); putSep;
     putInsn('17СР');
     putInsn('15ЗЧ');
   _) _else (sel) _(
     L12520(v31);
     cv.b := l3v24z;
     P11512(27, v31);
     P11512(19, v31);
     L12520(v37);
     P11512(19, v37);
     P12665(v31, v37);
     P11512(12, a32);
     P12665(v37, a32);
     extras[17] := 'ИА';
     L3732(a32.in);
     L3712;
     modBase;
     putAlign('16ПВIS'); _exit sel
   _)
 _); (* 15361 *)
_);

(* Level 3 *) _proced L16431(* _var a31:expr *)+
_label 16625, 16503, 16441, 16534;
_const (*=a1*)mnojit='МНОЖИТ'; stfun='СТФУН';(*=a0*)
_var v31:idptr;
v32:int; v33:bool;
v34:alfa;
v35:int;
v36:alfa; v37, l3v8z, l3v9z, l3v10z, l3v11z:int;

(* Level 4 *) _proced L15362(a41:int);
 _(
 _if a41 <> 20 _then  prErr(mnojit, a41);
 L7305([0,1,2]);
 a31 := [1, 1, 1, intType, _NIL, 0];
 _GOTO 16625;
_);

(* Level 4 *) _proced stdCall;
_var checkMode, stProc:int; asBitset:bitset; v44:idptr; 

(* Level 5 *) _proced L15404(err:int);
_(
  prErr(stfun, err);
  _if _not (err <> (9)) _then  L15362((20));
_);

_( (* stdCall *)
  stProc := ord(v31@.f3);
  _if lastChar <> oparen _then  L15362(9); (* open paren expected *)
  _if _not (stProc _IN [19,23]) _then _(
    _select
      stProc _IN [0..13,16..21]: doExpr(a31);
      _not L14707(a31): L15404(9)
    _end;
    a31.f5.i := 0;
    v44 := a31.ty;
    (sel) _select
      a31.ty@.k = 1: _( a31.ty := a31.ty@.f3; _goto sel _);
      a31.ty = realType: checkMode := 0;
      a31.ty = intType: checkMode := 1;
      a31.ty = charType: checkMode := 2;
      (v44@.k = 0) _and (a31.ty <> alfaType): checkMode := 3;
      v44@.k = 2: checkMode := 4;
      v44@.k = 6: checkMode := 5;
      v44@.k = 3: checkMode := 6;
      T: checkMode := (7)
    _end;
    asBitset := [stProc];
    _if ((checkMode <> 0) _or ((asBitset * [0..8,15,17..19]) = []))
    _and ((checkMode <> 1) _or ((asBitset * [0..7,9,11..13,15..17,19]) = []))
    _and (_not (checkMode _IN [2,3,4]) _or ((asBitset * [10,12,13,15]) = []))
    _and ((checkMode <> (5)) _or ((asBitset * [14,15,22]) = []))
    _and ((checkMode <> (6)) _or ((asBitset * [10,15,19,20,21]) = [])) 
    _and ((checkMode <> (7)) _or (stProc <> (15))) _then L15404(2);
    _if  ((asBitset * [7,12,13,17,19]) <> []) _then  v31@.vty := a31.ty;
    _if  ((asBitset * [0..9,12,13,17..21]) <> []) _then  L12520(a31);

  _); (* 15564 *)
  _case stProc _of
  0, 1, 2, 3, 4, 5, 6: (*15565*) _(
    _if checkMode = 1 _then  P11512(18, a31);
    P12143(19, a31, chr(stProc));
  _);
  7: (*15577*) _(
    P11512(26, a31);
    a31.in@ := [, (3 - (2 * checkMode)), , 'МВ'];
  _);
  8: (*15611*) P11512(4, a31);
  9: (*15615*) _( P11512(20, a31); a31.f0.i := 2; a31.f1.a := label _);
  10: (*15624*) _if (a31.ty = boolType) _then  L12520(a31);
  11, 16: (*15631*) _( _);
  12, 13: (* 15632 *) P11512(stProc + 9, a31);
  14: (* 15637 *) 
    _if (a31.f2.i = 0) _then _(
      _if (a31.f1.i = (7)) _then _(
        cv.a := chr(172B);
        putConst(v34, F);
        P11512(0, a31);
        a31.in@ := [, , 1, , 7];
        P11512(2, a31);
        a31.in@.f4 := v34;
        a31.f5.i := 1;
        a31.f0.i := 2;
      _) _else _(
        a31 := [0, '13', 0, , _NIL, 1];
      _)
    _) _else _( (* 15700 *)
      _if a31.f5.i = 0 _then alfAdd(a31.f1.a, 2)
      _else _( P12143(23, a31, 'ВИ');
        a31.f0.i := 2;
        extras[9] := ;
        a31.f1.a := label;
      _)
    _);
  15: _( L12445(a31); a31.f0.i := 3_);
  17: _(
    P11512(19, a31);
    _if  checkMode = 1 _then  P11512(16, a31);
    P12143((9), a31, 'АУ');
    a31.in@.f1 := 3 - 2 * checkMode;
    _if checkMode = 1 _then  P11512(17, a31);
  _);
  18: _( P12143(11, a31, 'АС'); a31.in@.f1 := 2; extras[12] := ;  _);
  20: _( P11512(26, a31); a31.in@.op := 'ВЧ'_);
  21: _(
    P11512(26, a31); a31.in@.op := 'ВН';
    P11512(1, a31); a31.in@.op := 'АВ';
  _);
  22: _(
    cv.a := chr(175B);
    putConst(v34, F);
    _if a31.f2.i = 0 _then _(
      _if a31.f1.i = 7 _then _(
        P11512(0, a31);
        a31.in@ := [, , 1, , 7];
      _) _else  L15404(3);
    _) _else _(
      _if a31.f5.i = 1 _then _(
        L12520(a31);
        P12143(11, a31, 'ПА');
        P11512(0, a31);
        a31.in@ := [, 1, '15' ];
      _) _else _(
        _if a31.ty@.f7.i = 0 _then alfAdd(a31.f1.a, 1);
        P12143(4, a31, 'ИК');
        P11512((8), a31);
      _);
    _); (* 16064 *)
    P11512(2, a31);
    a31.in@.f4 := v34;
    a31.f5.i := 1;
    a31.f0.i := 2;
  _);
  23: _( P14750(2, a31); v31@.vty := a31.ty _);
  19: P14750(0, a31)
  _end;
   _if (lastChar <> cparen) _then L15404(1 ) _else  getToken;
_);

(* Level 4 *) _proced P16240;
_var v41, l4v7z:expr;
l4v13z:pInst; l4v14z:bitset; l4v15z, l4v16z:int;

(* Level 5 *) _proced mkElem(a51:int);
_(
 l4v14z := l4v14z;
 l4v14z := [a51];
_);

(* Level 5 *) _proced mkRange(a51, a52:int);
_(
 l4v14z := l4v14z;
 l4v14z := [a51..a52];
_);

(* Level 5 *) _proced L16170(_var a51:expr);
_(
  doExpr(a51);
  _if a51.ty@.k = 1 _then  a51.ty := a51.ty@.f3;
  v31 := a51.ty;
  _if (v31@.k <> 0)
  _or (v31 = realType) _or (v31 = alfaType)
  _then prErr(mnojit, 8); (* bad base type for a set *)
_);
(* Level 5 *) _proced L16214;
 _(
 _if v33 _then _(
   P11512(8, a31);
   l4v13z := a31.in;
   P11512(19, a31);
   v33 := F;
 _);
 L12520(v41);
 P12665(a31, v41);
 _);

_( (* P16240 *)
 a31 := [0, 0, 0, setType, _NIL, 0];
 gl53z := 2;
 getToken;
 _if lastChar <> cbrack _then _(
   v33 := T;
   gl62z := F;
   l4v14z := [];
   _repeat
     L16170(v41);
     _if lastChar = colon _then _(
       L16170(l4v7z);

       _if (v41.f0.i = 0) _and (l4v7z.f0.i = 0) _then  _(
         l4v15z := L7314(v41.f1.a);
         l4v16z := L7314(l4v7z.f1.a);
         _if (l4v15z < 0) 
         _or (l4v15z > 47) 
         _or (l4v16z < 0) 
         _or (l4v16z > 47) 
         _or (l4v15z > l4v16z) _then prErr(mnojit, 9)
         _else mkRange(l4v15z, l4v16z);
       _) _else _(
         L16214;
         P11512(19, v41);
         L12520(l4v7z);
         P12665(v41, l4v7z);
         P12143(11, l4v7z, 'ЗЧ');
         a31.in := l4v7z.in;
       _); (* 16343 *)
     _) _else _( (* 16344 *)
       _if v41.f0.i = 0 _then _(
         l4v15z := L7314(v41.f1.a);
         _if (l4v15z < 0) _or (l4v15z > 47) _then prErr(mnojit, 0) (* bad set element *)
          _else mkElem(l4v15z);
       _) _else _(
         L16214;
         P12143(11, v41, gl37z);
         a31.in := v41.in;
       _)
     _)
   (* 16373 *) _until lastChar <> comma;
   _if lastChar <> cbrack _then  L15362(10); (* no closing bracket *)
   _if l4v14z <> [] _then _(
     cv.b := l4v14z;
     putConst(v34, F);
   _);
   _if v33 _then _(
     _if l4v14z <> [] _then  a31.f1.a := v34;
   _) _else _(
     _if l4v14z <> [] _then  l4v13z@.f4 := v34;
     P11512(0, a31);
     a31.in@.f2 := '17';
     a31.in@.f4 := '0';
     a31.f0.i := 3;
   _)
_)_);

_( (* L16431 *)
  _case tokKind _of
  tkWord: _( (* 16433 *)
    _if tok <> nil _then _(
      _if tok = not _then _goto 16503 _else L15362(1); (* wrong keyword *)
    _) _else _(
16441:
      v31 := _NIL;
      P7520(v31, v34, F);
      _if (v31 = _NIL) _then  L15362(2); (* not a constant *)
      a31 := [0, v34, 0, v31, _NIL, 0];
      _if modeX _then  a31.f2.a := '10';
      _if (v31 = boolType) _and (v34 <> '12') _then  a31.f5.i := 1;
    _)
  _); 
  tk0: _(
  _if lastChar = oparen _then _(
    doExpr(a31);
    _if lastChar <> cparen _then  L15362(3); (* need closing paren *)
  _) _else _if lastChar = chr(83) _then _(
16503:
      gl53z := 2;
      getToken;
      L16431(a31);
      _if a31.ty <> boolType _then  L15362(4); (* not a bool *)
      a31.f5.l := odd(ord(a31.f5.l)+1);
      exit
    _) _else _if lastChar = obrack _then P16240 _else  L15362(5); (* wrong delimiter *)
  _);
  tkInt, tkStr, tkReal, tkChar: _goto 16441;
  tkField: _goto 16534;
  tkIdent: _(
    _if curId = _NIL _then L15362(6) (* ident not defined *)
    _else _(
    _if curId@.f4.i = 2 _then _(
16534:
      L16714(a31);
      exit
    _);
    _if curId@.f4.i = 1 _then
     _if curId@.f3 = _NIL _then _goto 16441 _else _goto 16534;
    _if curId@.f4.i <> 3 _then  L15362(7); (* id not a var, const or func *)
    v31 := curId;
    getToken;
    v33 := gl63z;
    gl63z := F;
    _if _not ((lastChar = oparen) _or _not v33) _then _(
      a31.f0.i := 0;
      exit
    _) _else _(
      _if v31@.f1.i = 0 _then  stdCall
      _else _(
        _if v31@.vty = _NIL _then  L15362(10);
        P14226(v31, a31.in);
        a31.f0.i := 3;
        a31.f5.i := 0;
        _if v31@.vty = boolType _then_(
          a31.f0.i := 2;
          a31.f1.a := label;
        _);
      _);
      a31.ty := v31@.vty;
      exit;
    _);
  _)_)
  _end;
  getToken;
16625:
_);

(* Level 3 *) _proced L16714 (* _var a31: expr *)+
_label 16753, 17005, 17015, 17042, 17057, 17101, 17107, 17254, 17266;
_const (*=a1*)perem='ПЕРЕМ';(*=a0*)
_var v31:idptr;
v32:idptr;
v33:idptr;
v34:expr;
l3v10z:alfa;
l3v11z, l3v12z, v3D:int;
v3E:pinst;
l3v15z:pinst;
l3v16z, l3v17z, l3v18z, l3v19z:pInst;
l3v20z, l3v21z, l3v22z, l3v23z, l3v24z:int;
l3v25z:bool;
pe:@expr;

(* Level 4 *) _proced L16626(a41:int);
_(
  prErr(perem, a41);
  L7305([0,1,2]);
  _GOTO 17057;
_);

(* Level 4 *) _proced L16651(a41:int);
_var v41:pInst;
(* Level 5 *) _proced L16637;
 _(
 mkInst(v41);
 v41@.nxt := l3v16z;
 l3v16z := v41;
 v41@.f1 := 0;
 _);

_( (* L16651 *)
  L16637;
  _if (a41 = 1) _then _(
    v41@ := [, , v3D, 'ИК', l3v10z];
  _) _else _if (a41 = 3) _then _(
    v41@ := [, , v3D, gl37z, l3v10z];
    L16637;
    v41@ := [, , '16', 'ПВ', 'ПА'];
    extras[8] := ;
  _) _else _(
    v41@ := [, , '17', 'ЗЧ', 0];
    _if (a41 = 0) _then _(
      L16637;
      v41@ := [, , '17', 'ИК', 0];
    _)
  _)
_);

_( (* L16714 *)
l3v25z := T;
 _if tokKind = tkField _then _(
   pe := ref(gl419z[gl27z]);
   v31 := pe@.ty;
   l3v20z := pe@.f0.i;
   l3v10z := pe@.f1.a;
   v3D := pe@.f2.i;
   l3v21z := pe@.f5.i;
   _if pe@.in = _NIL _then l3v16z := _NIL
   _else _(
     mkInst(l3v16z);
     l3v17z := pe@.in;
     l3v18z := l3v16z;
     _goto 16753;
     _repeat
       mkInst(l3v19z);
       l3v18z@.nxt := l3v19z;
       l3v18z := l3v19z;
16753:
       l3v18z@ := l3v17z@;
       l3v17z := l3v17z@.nxt;
     _until l3v17z = _NIL;
   _); (* 16765 *)
   _goto 17042;
 _) _else (* 16766 *) _if tokKind <> tkIdent _then  L16626(0); (* not a var or a field *)
 v31 := curId@.vty;
 l3v20z := 1;
 l3v10z := curId@.f6.a;
 v3D := curId@.f1.i;
 l3v16z := _NIL;
 l3v21z := 0;
 _if curId@.f3 <> _NIL _then _(
   _if curId@.f4.i = 1 _then _goto 17015;
17005: _if v31@.k = 6 _then  l3v21z := 1
   _else _( L16651(1); l3v10z := '0'; v3D := 0_)
 _);
 v33 := curId;
 17015:
 getToken;
 _case v31@.k _of
 2: _(
   l3v25z := F;
   _if (lastChar = arrow) _then _( v31 := v31@.f3; _goto 17005 _) _else _goto 17057;
 _);
 5: _(
 l3v25z := F;
 _if (lastChar <> dot) _then _goto 17057 _else _(
   gl53z := 3;
   gl77z := v31;
   getToken;
   _if (tokKind <> tkField) _or (curId = _NIL) _then L16626(1); (* not a field *)
17042:
   l3v25z := F;
   alfAdd(l3v10z, curId@.f8.i);
   v31 := curId@.f6.id;
   _goto 17015;
 _)_);
 0, 1, 3: _(
  _if l2v23z@.f7.l _and l3v25z _then  gl101z := F;
17057:
  a31 := [l3v20z, l3v10z, v3D, v31, l3v16z, l3v21z];
 _if (v31 = boolType) _and (l3v20z = 2) _then _(
   L16651(1);
   a31.f1.a := label;
   a31.in := l3v16z;
   l3v16z@.op := gl37z;
 _);
 exit;
17101: getToken; _goto 17057;
 _);
 4: _(
   l3v25z := F;
   _if (lastChar <> obrack) _then _goto 17057;
17107:
   v33 := v31@.f7.id;
   v32 := v31@.f3;
   doExpr(v34);
   _if (v34.ty@.k <> 1) _and (v34.ty <> intType)
   _and (v34.ty <> charType) _and (v34.ty@.f3 = _NIL) _then L16626(5); (* ??? *)
   l3v23z := v33@.f7.i;
   l3v22z := 0-l3v23z*v32@.sz;
   alfAdd(l3v10z, l3v22z);
   l3v23z := v32@.sz;
   _if v34.f0.i = 0 _then _(
     l3v22z :=   L7314(v34.f1.a);
     _if (l3v22z < v33@.f7.i) _or (l3v22z > v33@.f8.i) _then prErr(perem, 3); (* const index out of range *)
     _if l3v23z <> 1 _then  l3v22z := l3v22z * l3v23z;
     alfAdd(l3v10z, l3v22z);
   _) _else _(
     _if modeT _and _not typeCheck(v34.ty, v33) _then _(
       L12520(v34);
       P5340(v33, T);
       P12143(22, v34, v33@.nm);
     _);
     _if l3v23z <> 1 _then _(
       gl41z := v31@.f8.a;
       L12520(v34);
       P11512(5, v34);
       _if v33@.f7.i >= 0 _then v34.in@ := [, , 0, 'МР', '30'];
     _);
     _if l3v16z = _NIL _then _(
     _if v34.f0.i = 3 _then _(
        v34 := [2, 0, '17'];
        P12143(4, v34, 'ЗЧ');
        l3v20z := 2;
     _) _else  l3v20z := v34.f0.i;
     P12143(4, v34, 'ИК');
     l3v16z := v34.in;
    _) _else _(
      v3E := l3v16z@.nxt;
      _if (v3E = _NIL) _then _(
17254:
        _if v34.f0.i <> 3 _then L12520(v34);
        append(v34.in, l3v16z);
        l3v16z@.op := 'АС';
17266:
        l3v16z@.f1 := 1;
        L16651(0);
        l3v20z := 2;
      _) _else _(
        l3v15z := v3E@.nxt;
        _if v3E@.op = 'ИК' _then _(
        _if l3v20z = 1 _then _goto 17254
        _else _(
          l3v16z@.op := gl37z;
          _if v34.f0.i <> 1 _then_(
            L16651(2);
            _if v34.f0.i = 2 _then L12520(v34);
            v34 := [, 0, '17'];
          _);
          P12143(4, v34, 'АС');
          append(l3v16z, v34.in);
          l3v16z := v34.in;
          _goto 17266;
        _) 
        _) _else _( (* 17330 *)
          _if v34.f0.i <> 1 _then _(
            _if v34.f0.i = 2 _then L12520(v34);
            v34 := [, v3E@.f4, v3E@.f2 ];
            mkInst(l3v15z);
            l3v15z@ := v3E@;
          _);
          P12143(4, v34, 'АС');
          v34.in@.f1 := 1;
          v3E@.nxt := v34.in;
          append(l3v15z, l3v16z);
          l3v20z := 2;
        _)
      _)
    _)
   _); (* 17370 *)
   v31 := v32;
   gl101z := F;
   _if (lastChar = cbrack) _then _goto 17015;
   _if (lastChar = comma) _and (v31@.k = 4) _then _goto 17107;
   L16626(2); (* not a comma, or var is not an array *)
   _goto 17015;
 _);
 6: _(
   l3v25z := F;
   _if (lastChar <> arrow) _then _goto 17057;
   _if (v3D = 0) _then _(  v3D := 1; v31 := charType; _goto 17101 _);
   _if (l3v21z = 1) _then _(
     L16651(3);
     l3v20z := 2;
     l3v10z := '0';
     l3v21z := ;
     v3D := 261;
     v31 := v31@.f3;
     _goto 17015;
   _);
   _if v31@.f7.i = 0 _then alfAdd(l3v10z, 1);
   v31 := v31@.f3;
   _goto 17005;
 _)
  _end;
  L16626(13); (* unreached *)
_);
(* Level 3 *) _proced L17503(_var a31:expr);
_label 17511, 17636, 17676;
_const imod = 'MOD'; term = (*=a1*)'TERM'(*=a0*);
_var v31, v32:int;
v33, v34:idptr;
v35:expr; l3v11z:int;
l3v12z:bitset; 
(* Level 4 *) _proced L17446;
_(
  prErr(term, v31);
_);

(* Level 4 *) _proced L17467;
(* Level 5 *) _proced L17454(_var a51:expr);
_(
 _if _not (a51.f0.i = 3) _then  P11512(3, a51);
 P11512(18, a51);
_);

_( (* L17467 *) 
 L17454(a31);
 L17454(v35);
 P12741('АД', F, a31, v35, 3);
 _);

_( (* L17503 *)
  _if gl63z _then gl63z := F _else  L16431(a31);
17511:
  _if lastChar = semi _then exit;
  
  _if tokKind = tk0 _then _(
    _if lastChar = star _then v31 := 0
    _else _if lastChar = slash _then v31 := 1
    _else _if lastChar = chr(81) _then  v31 := 2
    _else exit;
  _) _else _( (* 17530 *)
    _if tokKind = tkWord _then _(
      _if tok = div _then v31 := 3
      _else _if tok = mod _then v31 := 4
      _else _if tok = and _then v31 := 2
      _else exit
    _) _else exit
  _); (* 17546 *)
  gl53z := 2;
  getToken;
  L16431(v35);
  _if (a31.ty@.k = 1) _then  a31.ty := a31.ty@.f3;
  v33 := a31.ty;
  _if (v35.ty@.k = 1) _then  v35.ty := v35.ty@.f3;
  v34 := v35.ty;
  (case) _case v31 _of
  0: _(
    _if (v33@.k <> 3) _then _(
    _if _not ((v33 <> v34) _or (v33 <> intType)) _then _(
      L12520(a31);
      _if _not (modeM  _or (v35.f2.i <> 0) _or (v35.in <> _NIL)) _then _(
        v32 :=   L7314(v35.f1.a);
        l3v12z := ;
        _if (v32 > 0) _and (card(l3v12z) = 1) _then_(
          v32 := minel(l3v12z) + 17;
          mapia(v32, v35.f1.a);
          P12741('СД', T, a31, v35, 1);
          _goto 17636;
        _)
      _);
      P11512(16, a31);
      P12741('АУ', T, a31, v35, 1);
      P11512(17, a31);
17636:        
      a31.ty := intType;
      _) _else _if F13134('АУ', T, a31, v35) _then  L17446;
    _) _else _goto 17676
  _);
  1: _if (v33 = v34) _and (v33 = intType) _then _(
       L17467;
       a31.ty := realType;
     _) _else _if F13134('АД', F, a31, v35) _then  L17446;
  2:  _if (v33 = v34) _and (v33 = boolType) _then  P13176(F, a31, v35 )
      _else 17676:  _if modeC _and _not F12677(v33, v34) _then L17446
      _else P12741('ЛУ', T, a31, v35, 0);
  3: _if (v33 <> v34) _or (v33 <> intType) _then L17446
     _else _(
       _if _not (modeM _or (v35.f2.i <> 0) _or (v35.in <> _NIL)) _then _(
         v32 :=   L7314(v35.f1.a);
         l3v12z := ;
         _if (v32 > 1) _then _(
           _if (card(l3v12z) = 1) _then _(
             v32 := 111 - minel(l3v12z);
             mapia(v32, v35.f1.a);
             P12741('СД', T, a31, v35, 1);
             _exit case;
           _) _else _(
             cv.i := F3575(v32);
             putConst(v35.f1.a, F);
             P12741('АУ', T, a31, v35, 1);
             _exit case;
           _)
         _)
       _);
       L17467;
       P11512(4, a31);
     _);
  4: _if (v33 = v34) _then _(
       _if (v33 = intType) _then _(
         _if _not modeM _and (v35.f2.i = 0) _and (v35.in = _NIL) _then _(
           v32 :=   L7314(v35.f1.a);
           l3v12z := ;
           _if (v32 > 1) _and  (card(l3v12z) = 1) _then _(
             v32 := 47 - minel(l3v12z);
             v32 := -v32;
             code(УИ7=,);
             v32 := 0;
             code(L20014:СД/-1/=ЦС13,7СА1=7И1L20014,);
             cv := ;
             putConst(gl41z, F);
             L12520(a31);
             P11512((28), a31);
             _exit case;
         _)_);
         P12713(a31, v35, imod);
       _) _else _if (v33@.k = 3) _then P12741('СР', T, a31, v35, 0 )
       _else (q) _( L17446; _exit q _)
     _) _else L17446
  _end; 
  _goto 17511
_);
(* Level 3 *) _proced L20070(_var a31:expr);
_label 20076, 20131, 20206, 20266;
_const c80=80;
_var v31:bool;
v32:alfa;
v33:idptr;
v34:int; v35:expr;
(* Level 4 *) _proced L20062(a41:int);
 _(
   prErr((*=a1*) 'SЕХРR' (*=a0*), a41);
 _);
_( (* L20070 *)
 v31 := F;
 _if _not gl63z _then _(
   _if (lastChar = minus) _then _(
     v31 := T;
20076:
     gl53z := 2;
     getToken;
   _) _else  _if (lastChar = plus) _then _goto 20076;
 _);
 L17503(a31);
 _if v31 _then _(
   _if (a31.ty <> realType) _and _not typeCheck(a31.ty, intType) _then  L20062(0);
   _if _not (a31.f0.i = 3) _then  P11512(3, a31);
   P11512((6), a31);
   _if _not (a31.ty <> realType) _then  a31.in@.f1 := 3;
 _);
20131: _if (tokKind = tk0) _then _(
   _if (lastChar = semi) _then exit
   _else _if (lastChar = plus) _then v34 := 0
   _else _if (lastChar = minus) _then v34 := 1
   _else _if (lastChar = chr(80)) _then v34 := 2
   _else exit
 _) _else _( (* 20150 *)
   _if (tokKind <> tkWord) _then exit
   _else _if (tok = or) _then v34 := 2
   _else exit
 _);
 gl53z := 2;
 getToken;
 L17503(v35);
 v33 := a31.ty;
 _if v33@.k = 1 _then _( v33 := v33@.f3; a31.ty :=; _);
 l2v2z := v35.ty;
 _if l2v2z@.k = 1 _then  l2v2z := l2v2z@.f3;
 _case v34 _of
 0: _(
   v32 := 'АС';
   v31 := T;
   _if (v33@.k = 3) _then _goto 20266;
20206:
   _if (v33 = l2v2z) _and (v33 = intType) _then P12741(v32, v31, a31, v35, 1 )
   _else _if F13134(v32, v31, a31, v35) _then  L20062(1);
 _);
 1: 
 _if (v33@.k <> 3) _then _( v32 := 'АВ'; v31 := F; _goto 20206 _)
 _else _if F12677(v33, l2v2z) _then _(
   L12520(v35); P12143((17), v35, 'ИА'); P12741('ЛУ', T, a31, v35, 0);
 _) _else  L20062(2);
 2: _if (v33 = l2v2z) _and (v33 = boolType) _then  P13176(T, a31, v35 )
 _else  20266:
 _if F12677(v33, l2v2z) _then  P12741('ЛС', T, a31, v35, 0 )
 _else L20062(3 )
 _end;
 _goto 20131;
_);

(*=c- Level 3 *) _proced doExpr(* _var a31:expr *)+
_label 20317, 20547, 20651, 20621, 20626;
_const (*=a1*)eErr='EXPR';(*=a0*)
_var v31, v32:int; v33, v34:bool;
v35, v36:alfa;
v37, l3v8z:idptr; l3v9z:expr;(*=c+*)
_(
 _if gl62z _then _(  gl53z := 2; getToken _) _else gl62z := T;
 L20070(a31);
20317:
 _if tokKind = tk0 _then _(
   _if lastChar = semi _then exit
   _else _if lastChar = eq _then v31 := 1
   _else _if lastChar = neq _then v31 := 0
   _else _if lastChar = lt _then v31 := 2
   _else _if lastChar = chr(78) _then v31 := 5
   _else _if lastChar = gt _then v31 := 4
   _else _if lastChar = chr(79) _then v31 := 3
   _else exit
 _) _else _if (tokKind = tkWord) _and (tok = in) _then v31 := 6 _else exit;
 gl53z := 2;
 getToken;
 _if _not ((v31 <> 6) _or (tokKind <> tkIdent)
 _or (curId = _NIL) _or (curId@.f4.i <> 0)) _then _(
   _if _not (curId@.k <> 7) _then  curId := curId@.f3;
   _if _not (a31.ty@.k <> 6) _then  prErr(eErr, 20);
   _if _not (curId@.k = 1) _then  prErr(eErr, 0);
   P5340(curId, T);
   L12520(a31);
   TNL(v35);
   P12143((8), a31, v35);
   a31.in@.f1 := 1;
   P12143(5, a31, curId@.nm);
   a31.f0.i := 3;
   a31.ty := boolType;
   a31.f1.a := v35;
   a31.f5.i := 0;
   getToken;
 _) _else _(
   L20070(l3v9z);
   _if  a31.ty@.k = 1 _then  a31.ty := a31.ty@.f3;
   v37 := a31.ty;
   _if l3v9z.ty@.k = 1 _then  l3v9z.ty := l3v9z.ty@.f3;
   l3v8z := l3v9z.ty;
   v33 := (v37 = realType) _or (l3v8z = realType);
   _if v31 <> 6 _then _( 
     _if (v37 <> intType) _and (l3v8z <> intType)
     _or _not v33 _then _if _not typeCheck(v37, l3v8z) _then  prErr(eErr, 1);
   _) _else _if (l3v8z@.k <> 3) _or
  (v37@.k <> 0) _or
  (v37 = alfaType) _or
  (v37 = realType) _or
  (v31 = 2) _or
  (v31 = 4) _then prErr(eErr, 2);
 
  _if v37 = boolType _then
  _case v31 _of
  0, 1: _(
   L12520(l3v9z);
   P11512(19, l3v9z);
   L12520(a31);
   P11512(19, a31);
   a31.in@.op := 'СР';
   P12665(l3v9z, a31);
   a31 := [2, , , , , v31];
  _);
  2, 3: _(
   a31.f5.l := odd(ord(a31.f5.l) + 1);
20547:
   P13176(F, a31, l3v9z);
   _if (v31 = 3) _or (v31 = (5)) _then  a31.f5.l := odd(ord(a31.f5.l) + 1);
  _);
 4, 5: _(
  l3v9z.f5.l := odd(ord(l3v9z.f5.l) + 1);
  _goto 20547;
 _);
 6: _goto 20651
 _end _else (* 20601 *) _if (l3v8z@.k <= 3) _then _( v32 := 3;
  _case v31 _of
  0, 1: _( v36 := '14'; v35 := 'СР'; v34 := T; v32 := 1_);
  2, 3: _if (l3v8z@.k = 3) _then _(
    L12520(a31);
    P12143((17), a31, 'ИА');
20621:
    v34 := T;
    v35 := 'ЛУ';
    v31 := 1;
  _) _else _(
    v35 := 'АВ';
20626:
    v34 := F;
    v36 := '12';
    v31 := v31 - 2;
  _);
 4, 5: 
   _if (l3v8z@.k = 3) _then _(
     L12520(l3v9z);
     P12143((17), l3v9z, 'ИА');
     _goto 20621;
   _) _else _(
     v35 := 'ОВ';
     v31 := v31 - 2;
     _goto 20626;
   _);
 6:  20651: _(
   L12520(a31);
   P11512(19, a31);
   L12520(l3v9z);
   P12665(a31, l3v9z);
   a31.in := l3v9z.in;
   P12143(11, a31, 'ИК');
   a31.in@.f1 := 2;
  _)
 _end;
 _if v31 = 6 _then v31 := 0
 _else _if v33 _then _(
   L13104(a31);
   L13104(l3v9z);
   _if modeR _then _(
     P12713(a31, l3v9z, v35);
     a31.in@.f1 := 2;
     a31.in@.f2 := v36;
     _if v35 = 'СР' _then  a31.f1.a := label;
   _) _else _(
     P12741(v35, v34, a31, l3v9z, v32);
     _if v32 = 3 _then  P11512(15, a31);
   _)
  _) _else _(
     P12741(v35, v34, a31, l3v9z, 1);
   _);
   a31 := [2, , , boolType, , v31];
   _) _else (* 20761 *) prErr(eErr, 3);
 _);
 _goto 20317;
_);
(*=c- Level 3 *) _proced doStmt;
_label 23545, 23546, 23553, 23557, 23611, 23710, 23711, 24134, 24662, 24732, 25141;
_var v31, v32, v33:alfa;
v34:int;
v35, v36:alfa;
v37:int; l3v8z, l3v9z:bool;
l3v10z, l3v11z:pInst;
l3v12z, v3D:idptr;
e1, e2, e3:expr;
l3v32z:pstr;
(*=c+*)
(* Level 4 *) _function L20765(a41:alfa):bool;
_(
 L20765 := T;
 _if (tokKind = tkIdent) _or (a41 = '1') _then _(
   l3v11z := l2v27z;
   v37 := 1;
 _while l3v11z <> _NIL _do _(
 _if l3v11z@.f1 = 1 _then v37 := (v37 - 1)
 _else _if (l3v11z@.f1 = 0) _and (l3v11z@.f4 = tok) _then_(
   _if v37 <> 1 _then _(
     mapia(v37, v32);
     P4357(11, v32);
     v37 := 10;
   _);
   _if a41 = goto _then P4357(v37, l3v11z@.f2)
   _else  P4357(v37, l3v11z@.op);
   _if v37 <> 1 _then putInsn('ПБFАМ');
    exit
   _) _else ; (* 21037 *)
   l3v11z := l3v11z@.nxt;
  _); (* 21041 *)
  _if a41 = '1' _then _(
    _if v37 <> 1 _then _(
      mapia(v37, v32);
      P4357(11, v32);
      write('12ПВFАМ');
      putSep;
      align;
    _);
    L4225(1);
  _) _else  prErr(v36, 2);
 _) _else L20765 := F;
_);
(*=c- Level 4 *) _proced standProc;
_label 21410, 21412, 21420, 21731, 22054, 22177, 22235, 22254, 22500;
_const zun='UN';zia='IА';zai='АI';ztnl='ТNL';zgg='ГГ';zga='ГА';zyaga='ЯГА';ziaca='1ИАСА';
zpvro='16ПВRО';zpvpo='16ПВРО';zpvgi='16ПВGI';zpvri='15ПВRI';zpvpr='16ПВРR';zpvsl='16ПВSL';
(*=a1*)wri='WRITE'(*=a0*);
_var v41:int; v42:alfa;
v43:alfa;
v44:alfa; v45:int; l4v6z:alfa;
l4v7z, l4v8z, l4v9z, l4v10z, l4v11z:bool;
(*=c+*)
(* Level 5 *) _proced L21070(a51:int);
 _(
 prErr(v36, a51);
 _GOTO 23711;
 _);
 (* Level 5 *) _proced P21077(a51:int; a52:bool);
_var l5v1z:alfa; _(
  gl102z := F;
  _if lastChar = colon _then _(
    doExpr(e2);
    l4v11z := F;
    _if ((e2.ty@.k <> 1)  _or (e2.ty@.f3 <> intType))
    _and (e2.ty <> intType) _then  prErr(wri, 0);
    L12635(e2);
 _) _else _(
   _if a52 _then exit;
   mapia(a51, l5v1z);
   ГГ('15ПА', l5v1z);
   putSep;
   putInsn('ВИ15');
 _);
 putInsn('17ЗЧ');
_);

(* Level 5 *) _proced L21145(a51:alfa);
 _(
 _if l4v9z _then _(
   _if modeI _and (a51 = 'WL') _then _( putAlign('16ПВРR'); exit _)
   _else _(
     _if (a51 = 'WС') _and l4v11z _then _( putInsn('1ЗЧ10'); putAlign('16ПВРО'); exit _);
     _if a51 = 'WJ' _then  modBase;
     ГГ('16ПВО');
   _);
 _) _else _(
   _if _not l4v10z _then _(
     ГГ(v44, l4v6z, v45); putSep;
     ГГ('16ПВ', 'F'); extras[11] := 'ИА';
   _) _else _(
     _if (a51 = 'WС') _and l4v11z _then _(
       ГГ(v44, 'ИК', v45); putSep;
       putInsn('ЗЧ');
       ГГ(v44, 'ИА', v45); putSep;
       putInsn('15ПА');
       ГГ('16ПВ'); putAlign('РF');
       exit
     _);
     ГГ(v44, 'ИА', v45); putSep;
     putInsn('15ПА');
     _if a51 = 'WJ' _then  modBase;
      ГГ('16ПВ');
   _)
 _);
 putAlign(a51);
_);
(* Level 5 *) _proced P21247(a51:int; a52:alfa);
_(
 l4v11z := T;
 _if a52 = 'WС' _then P21077(a51, T) _else P21077(a51, F);
 L12635(e1);
 _if gl102z _and (a52 = 'WI') _then _( a52 := 'WJ'; gl103z := T _);
 gl102z := F;
 L21145(a52);
 _);
 
(* Level 5 *) _proced L21277;
_(
  getToken;
  _if (tokKind <> tkIdent) _or (curId = _NIL) _then L21070((9));
_);

(* Level 5 *) _proced P21311(_var a51:expr; a52:idptr);
_label 21335;
 _(
 gl53z := 2;
 getToken;
 _if tokKind = tkIdent _then _(
   _if curId = _NIL _then _(
     L21070(16);
   _) _else _(
   _if ((curId@.f4.i = 1) _and (curId@.f3 <> _NIL)) _or (curId@.f4.i = 2) _then _(
21335:
     L16714(a51);
     _if modeC _and (a52 <> _NIL) _and _not typeCheck(a51.ty, a52) _then  L21070(12);
   _) _else
     L21070(11);
   _)
 _) _else _goto 21335;
_);

_( (* standProc *)
 v41 := ord(l3v12z@.f3);
 v36 := l3v12z@.nm;
 l4v10z := lastChar = oparen;
 _if _not l4v10z _and _not (v41 _IN [7,8,9,20,30]) _then  L21070(5);
 _case v41 _of
 0: _(
   L21277;
   v43 := 'РF';
   _if curId = inFile _then prErr(v36, 10)
   _else _if curId = outFile _then _(
     putAlign('16ПВРО');
21410:
     getToken;
21412:
     _if lastChar <> cparen _then  L21070(7);
     getToken;
     exit
   _) _else 21420: _(
     _if (curId@.f4.i <> 2) _or (curId@.vty@.k <> 6) _then L21070(8);
     l4v7z := curId@.f3 <> _NIL;
     _if modeDe _and (curId@.nm = (*=a1*)'INР'(*=a0*)) _and (v43 = 'GF') _then _(
        ГГ('16ПВ');
        putAlign('76312');
     _) _else _(
        ГГ(curId@.f1.a);
        _if l4v7z _then ГГ(gl37z) _else  ГГ('ИА');
        putInsn(curId@.f6.a);
       _if _not l4v7z _then  putInsn('15ПА');
       ГГ('16ПВ');
       _if l4v7z _then _( extras[10] := 'ИА'; ГГ('F') _);
       putAlign(v43);
     _);
     _goto 21410;
   _);
 _);
 1: _(
   L21277;
   v43 := 'GF';
   _if curId = inFile _then _( putAlign('16ПВGI'); _goto 21410 _)
   _else _if curId = outFile _then prErr(v36, 14)
   _else _goto 21420;
 _);
 2: _(
   L21277;
   v43 := 'RWF';
   _if curId <> outFile _then _(
     _if curId = inFile _then prErr(v36, 15) _else _goto 21420;
   _);
   putAlign('16ПВRО');
   _goto 21410;
 _);
 3: _(
   L21277;
   v43 := 'RF';
   _if curId = inFile _then _(
     putAlign('15ПВRI');
     _goto 21410;
   _) _else _if curId = outFile _then prErr(v36, 17) _else _goto 21420;
 _);
 4, 21: _(
   P21311(e1, _NIL);
   l4v7z := T;
   gl33z := gl33z + 1;
   _if e1.ty@.k <> 2 _then _GOTO 23710;
   l3v12z := e1.ty@.f3;
   v37 := l3v12z@.sz;
   _if lastChar = eq _then _(
     doExpr(e2);
     _if _not typeCheck(e2.ty, intType)  _then  prErr(v36, 4);
     l4v7z := F;
   _) _else _( (* 21574 *)
     _if l3v12z@.k = 5 _then _(
       _if lastChar = semi _then _(
         gl77z := l3v12z;
         gl53z := 3;
         getToken;
         _if curId = _NIL _then prErr(v36, 18)
         _else _( v37 := curId@.f8.i + 1; getToken_)
       _) _else _(
         l3v12z := l3v12z@.f3;
        _while (lastChar = comma) _and (l3v12z <> _NIL) _do _(
          v3D := _NIL;
          getToken;
          P7520(v3D, v42, T);
          _if v3D = _NIL _then _(  v37 := 19; _GOTO 23711_);
          getToken;
          _while (l3v12z <> _NIL) _and (l3v12z@.f4.i <> 5) _do l3v12z := l3v12z@.vty;
          _if l3v12z <> _NIL _then _(
            v3D := l3v12z@.vty;
            _while (v3D <> _NIL) _and (v42 <> v3D@.f1.a) _do v3D := v3D@.vty;
             _if v3D = _NIL _then _(
               v37 := l3v12z@.f8.i + 1;
               l3v12z := _NIL;
             _) _else _(
               v37 := v3D@.k;
               l3v12z := v3D@.nxt;
             _)
           _)
        _)
    _)_)_);
    P12143(16, e1, '14');
    mapia(v37, v42);
    _if l4v7z _then_( ГГ('12ПА'); putInsn(v42) _)
    _else _( L12635(e2); putInsn('УИ12')  _);
    _if v41 = 4 _then putAlign('16ПВАL')
    _else _( putAlign('16ПВDS'); extras[1] := 'ИА'_);
    _goto 21412;
 _);
 5: _( l4v7z := F; v42 := 'UN'; _goto 21731_);
 6: _( l4v7z := T; v42 := 'РА'; 21731:
   l3v12z := charType;
   v3D := alfaType;
   l4v8z := modeT;
   modeT := F;
   P21311(e1, l3v12z);
   _if lastChar <> comma _then  L21070(13);
   P21311(e2, v3D);
   _if l4v7z _then _(
     P11512(12, e1);
     P12143(11, e1, v42);
     e1.f0.i := 3;
     gl101z := T;
     P13734(e2, e1);
   _) _else _(
     P11512(12, e1);
     L12520(e2);
     P12665(e1, e2);
     P12143(11, e2, v42);
     L3732(e2.in);
   _);
   modeT := l4v8z;
   _goto 21412;
 _);
 7: _(
   _if modeF _and (l2v12z <> '0') _then _(
     putInsn('12ПА2');
     L3656('15ПА', l2v12z);
     mapia(lineNum, gl41z);
     L3656('14ПА', gl41z);
     putAlign('16ПВЖЬ');
   _);
   v42 := tok;
   tok := '0';
   l4v7z :=   L20765('1');
   tok := v42;
 _);
 8: putAlign('16ПВРR');
 9: _( putAlign('16ПВПБ'); extras[13] := 'ПА' _);
 10: _( v42 := 'IА'; l3v12z := _NIL; v3D := alfaType;
22054:
   doExpr(e1);
   _if (l3v12z <> _NIL) _and _not typeCheck(e1.ty, l3v12z) _then  L21070(12);
   _if _not (lastChar = comma) _then  L21070(13);
   P21311(e2, v3D);
   L12635(e1);
   ГГ('16ПВ');
   putAlign(v42);
   L12475(e2);
   _goto 21412;
 _);
 11: _( v42 := 'АI'; l3v12z := alfaType; v3D := intType; _goto 22054 _);
 12: _(
   P21311(e1, alfaType);
   _if e1.ty = alfaType _then _(
     P4357(12, 'ТNL');
     L12475(e1);
     _goto 21412;
   _) _else _(
     L12520(e1);
     putAlign('16ПВSL');
     _goto 21412;
   _)
 _);
 13: _(
   v42 := 'ГГ';
   _repeat 
     doExpr(e1);
     L12520(e1);
     P12143(15, e1, v42);
     L3732(e1.in);
   _until (lastChar <> comma);
   _goto 21412;
 _);
 14: _( v42 := 'ГА'; l3v12z := charType; v3D := l3v12z; _goto 22054 _);
 15: _( v42 := 'ЯГА'; l3v12z := alfaType; v3D := l3v12z; _goto 22054 _);
 16: _(
   _if input@ = eq _then _( get(input); _if leftInsn _then  ГГ('ИА=') _)
   _else align;
   _repeat
   _goto 22177;
   _repeat
     get(input);
22177:
     _if input@ = endl _then _( lineNum := lineNum + 1; gl23z := 0 _)
     _else _( MAPГA(input@, output@); put(output) _);
   _until (input@ _IN [comma,eq,semi,chr(26),colon]);
   leftInsn := input@ <> eq;
   get(input);
   _until (input@ = cparen);
   get(input);
   curLab := '0';
   getToken;
 _);
 17: _(
   P21311(e1, _NIL);
   putInsn('1ИАСА');
   putInsn(gl37z);
   L12475(e1);
22235:
   _if (e1.ty@.k <> 2) _then L21070((6));
   _goto 21412;
 _);
 18: _(
   P21311(e1, _NIL);
   L12635(e1);
   putInsn('1ИАСА');
   putInsn('ЗЧ');
   _goto 22235;
 _);
 19: 22254: _(
   l4v7z := T;
   l4v9z := ;
   _repeat
   gl53z := 2;
   gl58z := T;
   getToken;
   gl58z := F;
   l4v6z := 'СМ';
   _if (tokKind = tkStr) _then _(
     v42 := tok;
     getToken;
     _if (lastChar <> colon) _and l4v9z _then _(
       mapia(gl30z, v43);
       P4511((6), v42, v43);
     _) _else _(
       P21077(gl30z, F);
       mapia(gl30z, v43);
       ГГ('12ПА', v43); putSep;
       _if modeX _then _(  ГГ('10ИА'); putSep_);
       ГГ('11ПА', v42); putSep;
       l4v6z := gl37z;
       L21145('WS');
     _)
   _) _else _( (* 22324 *)
     gl62z := F;
     doExpr(e1);
     _if l4v7z _and (e1.ty@.k = (6)) _then _(
       _if e1.f2.i <> 0 _then _(
         _if typeCheck(e1.ty, textFile) _then _(
           l4v9z := F;
           v44 := e1.f2.a;
           v45 := e1.f1.i;
           l4v10z := e1.f5.i = 0;
         _) _else prErr(wri, 3);
       _) _else _(
         _if e1.f1.i = 7 _then  prErr(wri, 1);
       _)
     _) _else _( (* 22363 *)
       _if e1.ty@.k = 1 _then  e1.ty := e1.ty@.f3;
       _if e1.ty = charType _then P21247(1, 'WС')
       _else _if e1.ty = alfaType _then P21247(6, 'WА')
       _else _if e1.ty = boolType _then P21247(6, 'WВ')
       _else _if e1.ty = intType _then P21247(10, 'WI')
       _else _if e1.ty = realType _then _( P21077(14, F); P21247(4, 'WR') _)
       _else _if e1.ty@.k = 0 _then _(
         L5425(e1.ty);
         P21077(6, F);
         L12635(e1);
         putInsn('УИ14'); ГГ('14СА', e1.ty@.f8.a); putSep;
         modBase;
         putInsn('14СЧ');
         L21145('WА');
       _)
       _else prErr(wri, 2);
   _)_); (* 22453 *)
   gl36z := 1;
   l4v7z := F;
   _until lastChar <> comma;
   l4v6z := gl37z;
   _if v41 = 20 _then  L21145('WL');
   _goto 21412;
 _);
 20: _(
   _if l4v10z _then _goto 22254
   _else _if modeI _then putAlign('16ПВРR')
   _else _( ГГ('16ПВО'); putAlign('WL') _)
 _);
 22, 23: L21070(0);
 25, 26, 28: _(
   l4v7z := T;
22500:
   mapia(v41 - 22, v43);
   _repeat
   doExpr(e1);
   _if  e1.ty@.k >= 4 _then  prErr(v36, 0);
   L12635(e1);
   putInsn('ИК5'); putInsn('11ПА'); putInsn('11ЗЧ10');
   _if l4v7z _then _(
     _if lastChar <> comma _then  L21070(1);
     _if _not L14707(e1) _then  L21070(2);
     cv.i := e1.ty@.sz;
     putConst(v42, F);
     L12445(e1);
     L3732(e1.in);
     putInsn('11ЗЧ13');
     _if lastChar = eq _then _(
       doExpr(e2);
       _if e2.ty <> intType _then  prErr(v36, 3);
       L12635(e2);
     _) _else _( ГГ(gl37z); putInsn(v42)_);
     putInsn('11ЗЧ15');
   _);
   P4357(11, v43);
   P4357(12, 'ВD');
   gl36z := 0;
   L3712;
   _until lastChar <> comma;
   extras[15] := 'ИК';
   extras[13] := ;
   extras[14] := ;
   _goto 21412;
 _);
 24, 27: _( l4v7z := F; _goto 22500 _);
 29: L21070(3);
 30: _(
   modBase;
   write('15ПА');
   _if l4v10z  _then_(
     gl58z := T;
     getToken;
     gl58z := F;
     _if tokKind = tkStr _then _(
       _if  gl30z > 60 _then  prErr(v36, 0);
       ГГ(tok);
       getToken;
     _) _else prErr(v36, 1);
   _);
   putSep;
   putAlign('12ПВФ');
   _if l4v10z _then _goto 21412;
 _);
 31: _(
   P21311(e1, _NIL);
   L14742;
   P14750(1, e1);
   _goto 21412; 
 _)
 _end; 
_);
(* Level 4 *) _proced P22731(_var a41:expr; a42:alfa);
_label 22750;
_(
 _case a41.f0.i _of
 0:  _if a41.f5.i = 0 _then  P4357(1, a42);
 2: _goto 22750;
 1: _(
   P11512(3, a41);
22750:
   L3732(a41.in);
   P4357(3 - a41.f5.i, a42);
 _);
 3: _if a41.f5.i = 0 _then _(
   P11450(a41.in, a41.f1.a, a42);
   L3732(a41.in);
 _) _else _(
   L3732(a41.in);
   P4357(1, a42);
   P4357(0, a41.f1.a);
 _)
 _end
_);
(* Level 4 *) _proced doCase;
_label 23252, 23326, 23333;
_type item = _record f0:@item; f1:int; f2, f3: alfa _end;
_var v41, v42, v43, v44, v45:@item;
 l4v6z:bool; l4v7z:int; _(
 l4v7z := lineNum;
 doExpr(e1);
 _if (e1.ty@.k > 1) _or (e1.ty = realType) _then prErr(case, 0);
 L3712;
 TNL(v31);
 P4357(1, v31);
 TNL(v35);
 v41 := _NIL;
 setup(v43);
 _if tok <> of _then _(  v37 := (6); _GOTO 23711 _);
  v3D := _NIL;
  getToken;
  _repeat _if (lastChar <> semi) _and (tokKind <> tkWord) _then _(
    TNL(v33);
    metka(v33);
    _repeat
    gl36z := 1;
    l3v12z := _NIL;
    P7520(l3v12z, v32, T);
    _if l3v12z <> _NIL _then _(
      _if v3D = _NIL _then v3D := l3v12z
      _else _if l3v12z <> v3D _then  prErr(case, 1);
      new(v42, 4);
      v42@.f1 := L7314(v32);
      v37 := v42@.f1;
      v42@.f2 := v33;
      v42@.f3 := v32;
      v44 := v41;
      (loop) _while v44 <> _NIL _do _(
        _if v37 < v44@.f1 _then _exit loop
        _else _if v37 = v44@.f1
        _then _(  prErr(case, 2); _exit loop _)
        _else _( v45 := v44; v44 := v44@.f0 _);
      _);
      _if v44 = v41 _then _(  v42@.f0 := v41; v41 := v42 _)
      _else _( v42@.f0 := v44; v45@.f0 := v42 _);
      getToken;
    _) _else (* 23152 *) _( v37 := 7; _GOTO 23711 _);
    l4v6z := lastChar <> comma;
    _if _not l4v6z  _then  getToken;
    _until l4v6z;
    _if lastChar <> colon _then _( v37 := 3; _GOTO 23711_);
    gl53z := 2;
    getToken;
    doStmt;
    L3712;
    idxBase;
    ГГ('ПБ'); putInsn(v35);
  _); (* 23205 *)
  l4v6z := lastChar <> semi;
  _if _not l4v6z _then _(  getToken;
    _if (tokKind = tkWord) _and  (tok = end) _then_( v37 := 33; _GOTO 23711 _)
  _);
  _until l4v6z;
  _if tok <> end _then_( v37 := 5; _GOTO 23711_) _else getToken;
  l3v12z := e1.ty;
  _if l3v12z@.k = 1 _then  l3v12z := l3v12z@.f3;
  _if _not typeCheck(l3v12z, v3D) _then  prErr(case, 4);
  metka(v31);
  _if v41 = _NIL _then _(
23252:
     rollup(v43);
     exit
  _);
  L12635(e1);
  v37 := 0;
  v44 := v41;
  _while v44 <> _NIL _do _(
    _if v37 = v44@.f1 _then _(
      v37 := v37 + 1;
      v44 := v44@.f0;
    _) _else _goto 23333;
 _);
 align;
 TNL(v31);
 _if modeS _then _(
   l2v28z := l4v7z;
   gl101z := F;
   P13602(e1.ty, F);
 _); 
 putInsn('УИ15');
 modBase;
 ГГ('15ПБ'); putInsn(v31);
 metka(v31);
 v44 := v41;
 _while (v44 <> _NIL) _do _(
   ГГ('ПБ', v44@.f2, '=,');
   v44 := v44@.f0;
 _);
23326:
 metka(v35);
 L3712;
 _goto 23252;
23333:
 v44 := v41;
 idxBase;
 putInsn('ЗЧ1');
 _if modeS _then _(
   l2v28z := l4v7z;
   gl101z := F;
   P13602(e1.ty, F);
 _);
 _while (v44 <> _NIL) _do _(
 ГГ('10', 'СР'); putInsn(v44@.f3);
 ГГ('10', 'У0'); putInsn(v44@.f2);
 v44 := v44@.f0;
 _if (v44 <> _NIL) _then _(  idxBase; putInsn('СЧ1') _);
 _);
 _goto 23326;
_);

_( (* doStmt *)
 setup(l3v10z);
 gl71z := F;
 gl101z := T;
 (*=a1*)
 _if tokKind = tkInt _then _(
   l3v32z := gl4633z;
   L3712;
   l3v8z := T;
   _if l2v17z <> 0 _then  prErr(to, 10);
   _while l3v32z <> l2v26z _do _(
     _if l3v32z@.f0.i <> gl26z _then l3v32z := l3v32z@.f4.s
     _else _(
       l3v8z := F;
       _if l3v32z@.f5.l _then _(  cv := l3v32z@.f1; prErr(to, 3)_)
       _else _(
         _if l3v32z@.f3.i = 0 _then  L13566(l3v32z@.f3.a ) _else P4357(0, l3v32z@.f3.a);
         l3v32z@.f1.i := lineNum;
         l3v32z@.f5.i := 1;
       _);
       l3v32z := l2v26z;
     _)
   _); (* 23446 *)
   _if l3v8z _then  prErr(to, 2);
   getToken;
   _if lastChar <> colon _then prErr('НЕТ : ', 1 )
   _else _( gl53z := 2;   getToken_)
 _); (* 23463 *)
 _if lastChar = oparen _then _(
   getToken;
   _if tokKind <> tkIdent _then _( v36 := 'НЕТ ИД'; _goto 23710 _);
   mkInst(l3v11z);
   L13566(v31);
   TNL(v32);
   l3v11z@ := [ l2v27z, 0, v31, v32, tok];
   l2v27z := l3v11z;
   getToken;
   _if lastChar <> cparen _then _( v36 := 'НЕТ )'; _goto 23710 _);
   gl53z := 2;
   getToken;
   doStmt;
   P4357(0, v32);
   l2v27z := l2v27z@.nxt;
   _goto 25141;
 _); (* 23525 *)
 _if tokKind = tkIdent _then _goto 24662;
 _if tokKind = tkField _then _goto 24732;
 _if tokKind <> tkWord _then _goto 25141;
 v36 := tok;
 _if tok = begin _then _(
   v37 := lineNum;
   _repeat
     gl53z := 2;
     getToken;
     doStmt;
   _until lastChar <> semi;
   _goto 23546;
23545:
   v37 := 1;
23546:
  _if (tokKind <> tkWord) _or (tok <> end) _then _goto 23711;
23553:
  getToken;
  _goto 25141;
 _);
 _if tok = goto _then 23557: _(
   getToken;
   _if tokKind <> tkInt _then _if L20765(goto) _then _goto 23553 _else _goto 23710;
   L3712;
   _if l2v17z <> 0 _then  prErr(to, 10);
   l3v32z := gl4633z;
   _while l3v32z <> _NIL _do _(
     _if l3v32z@.f0.i = gl26z _then _goto 23611
     _else  l3v32z := l3v32z@.f4.s;
   _); prErr('ТО', 4);
23611: (*=a0*)
   _if modeG _then _(
     mapia(gl26z, gl41z);
     L3656('12ПА', gl41z);
     mapia(lineNum, gl41z);
     L3656('14ПА', gl41z);
     putAlign('16ПВZQ');
   _);
   _if l3v32z@.f3.i = 0 _then _(
     TNL(l3v32z@.f3.a);
     l3v32z@.f1.i := lineNum;
   _);
   _if level = l3v32z@.f2.a _then _(
     P4357(1, l3v32z@.f3.a);
   _) _else _(
     ГГ(l3v32z@.f2.a); putInsn('ПИ15');
     modBase;
     ГГ('16ПА'); putInsn(l3v32z@.f3.a);
     putInsn('ПБRС');
   _);
   _goto 23553;
 _); (* 23656 *)
 _if tok = go _then _(
   getToken;
   _if tok = to _then _goto 23557;
   v37 := 0;
   _goto 23711;
 _);
 _if tok = if _then _(
   L3712;
   doExpr(e1);
   _if e1.ty <> boolType _then  prErr(v36, 0);
   TNL(v31);
   P22731(e1, v31);
   _if (tokKind <> tkWord) _or (tok <> then) _then _(
23710:
     v37 := 1;
23711:
     prErr(v36, v37);
     L7305([0,1,2]);
     _goto 25141;
   _);
   gl53z := 2;
   getToken;
   doStmt;
   _if (tokKind = tkWord) _and (tok = else) _then _(
     gl53z := 2;
     getToken;
     TNL(v32);
     v37 := gl36z;
     gl36z := 1;
     P4357(1, v32);
     P4357(0, v31);
     doStmt;
     P4357(0, v32);
     _if v37 <> gl36z _then _( gl36z := 2; L3712_);
   _) _else P4357(0, v31);
   _goto 25141;
 _); (*23755*)
 _if tok = while _then _(
   L3712;
   doExpr(e1);
   _if e1.ty <> boolType _then prErr(v36, 0);
   L13566(v31);
   TNL(v32);
   P22731(e1, v32);
   _if (tokKind <> tkWord) _or (tok <> do) _then _goto 23710;
   gl53z := 2;
   getToken;
   doStmt;
   L3712;
   P4357(1, v31);
   P4357(0, v32);
   gl36z := 1;
   _goto 25141;
 _); (* 24017 *)
 _if tok = repeat _then _(
   L13566(v31);
   L3712;
   _repeat 
     gl53z := 2;
     getToken;
     doStmt;
   _until lastChar <> semi;
   _if (tokKind <> tkWord) _or (tok <> until) _then _goto 23710;
   L3712;
   doExpr(e1);
   _if e1.ty <> boolType _then  prErr(v36, (0));
   P22731(e1, v31);
   _goto 25141;
 _); (* 24054 *)
 _if tok = kexit _then _(
   getToken;
   _if L20765(kexit) _then _goto 23553 _else _goto 23710
 _);
 _if tok = for _then _(
   getToken;
   L3712;
   _if (tokKind <> tkIdent) _or (curId = _NIL) _then _goto 23710;
   _if _not ((curId@.f4.i <> 2) _or (curId@.f3 <> _NIL))
   _or _not ((curId@.f4.i <> 1) _or (curId@.f3 = _NIL)) _then _(
     l3v12z := curId@.vty;
     _if l3v12z@.k = 1 _then  l3v12z := l3v12z@.f3;
     _if _not ((l3v12z@.k <> 0) _or (l3v12z = realType) _or (l3v12z = alfaType) _or (l3v12z = boolType)) _then _(
       L16714(e1);
       _goto 24134;
     _)
   _);
   prErr(v36, 0);
   e1 := [1, , , intType, _NIL, 0];
   getToken;
24134:
   _if lastChar <> chr(128) _then _(
     e2 := [0, '13', 0, e1.ty, _NIL, 0];
     _if modeX _then  e2.f2.a := '10';
   _) _else _(
     doExpr(e2);
     _if e1.ty@.k = 1 _then  e1.ty := e1.ty@.f3;
     _if e2.ty@.k = 1 _then  e2.ty := e2.ty@.f3;
     _if _not typeCheck(e1.ty, e2.ty) _then  prErr(v36, 2);
   _); (* 24171 *)
   L12635(e2);
   e2 := e1;
   L12475(e2);
   _if tokKind <> tkWord _then  prErr(v36, 3);
   _if tok = to _then v33 := 'ОВ'
   _else _if tok = downto _then v33 := 'АВ'
   _else _( v37 := 4; _goto 23711 _);
   doExpr(e2);
   _if e2.ty@.k = 1 _then  e2.ty := e2.ty@.f3;
   _if _not typeCheck(e1.ty, e2.ty) _then  prErr(v36, 5);
   L13566(v31);
   TNL(v32);
   e3 := e1;
   P12741(v33, F, e3, e2, 1);
   e3 := [2, , , boolType, , 1];
   P22731(e3, v32);
   _if (tokKind <> tkWord) _or (tok <> do) _then _( v37 := 6; _goto 23711 _);
   gl53z := 2;
   getToken;
   doStmt;
   L3712;
   e2 := e1;
   L12635(e1);
   idxBase;
   _if v33 = 'ОВ' _then ГГ('АС') _else ГГ('АВ');
   putInsn('13');
   L12475(e2);
   P4357(1, v31);
   P4357(0, v32);
   _goto 25141;
 _); (* 24326 *)
 _if tok = select _then _(
   L3712;
   l3v8z := T;
   TNL(v32);
   _repeat
     gl36z := 1;
     doExpr(e1);
     _if e1.ty <> boolType _then  prErr(v36, 0);
     TNL(v31);
     P22731(e1, v31);
     _if lastChar <> colon _then _( v37 := 2; _goto 23711 _);
     gl53z := 2;
     getToken;
     gl36z := 1;
     doStmt;
     P4357(1, v32);
     l3v8z := l3v8z _and (gl36z = 1);
     P4357(0, v31);
   _until lastChar <> semi;
   P4357(0, v32);
   _if _not l3v8z _then _(  gl36z := 0; L3712 _);
   _goto 23545;
 _); (* 24403 *)
 _if tok = case _then _( doCase; _goto 25141 _);
 _if tok = with _then _(
   v37 := gl28z;
   e3.f0.i := l2v15z;
   _repeat
      gl53z := 2;
      getToken;
      _if tokKind = tkIdent _then _(
        _if curId = _NIL _then _goto 23710
        _else _if ((curId@.f4.i <> 1) _or (curId@.f3 = _NIL))
        _and _not (curId@.f4.i = 2) _then  prErr(v36, 0);
      _) _else _if tokKind <> tkField _then _( v37 := 2; _goto 23711 _);
      L16714(e1);
      _if e1.ty@.k <> 5 _then prErr(v36, 3)
      _else _(
        gl28z := gl28z + 1;
        _if (e1.in <> _NIL) _and (e1.in@.nxt <> _NIL) _then _(
          P11512(23, e1);
          L3732(e1.in);
          e1 := [1, l2v11z, level, , _NIL];
          L12475(e1);
          e1 := [, 0, 0, , _NIL];
          P11512(25, e1);
          l2v15z := l2v15z + 1;
          mapia(l2v15z, l2v11z);
        _); (* 24505 *)
        gl419z[gl28z] := e1;
      _)
   _until lastChar <> comma;
   _if (tokKind <> tkWord) _or (tok <> do) _then _( v37 := 4; _goto 23711 _);
   gl53z := 2;
   getToken;
   doStmt;
   gl28z := v37;
   _if l2v15z > l2v16z _then  l2v16z := l2v15z;
   l2v15z := e3.f0.i;
   mapia(l2v15z, l2v11z);
   _goto 25141;
 _); (* 24536 *)
 _if tok = branch _then _(
   extras[14] := tok;
   extras[13] := ;
   l2v17z := l2v17z + 1;
   mkInst(l3v11z);
   l3v11z@:= [l2v27z, 1];
   l2v27z := l3v11z;
   doExpr(e1);
   _if _not (e1.ty@.k _IN [0,1]) _then prErr(v36, 0);
   L12635(e1);
   TNL(v31);
   TNL(v32);
   P4357(11, v31);
   putAlign('16ПВЕА');
   _if (tokKind <> tkWord) _or  (tok <> of) _then _goto 23710;
   _repeat
     gl36z := 1;
     gl53z := 2;
     getToken;
     doStmt;
     P4357(1, v32);
     P4357(0, v31);
     l3v8z := lastChar = semi;
     _if l3v8z  _then _( 
       TNL(v31);
       P4357(11, v31);
       putAlign('16ПВNА');
     _)
   _until _not l3v8z;
   P4357(0, v32);
   l2v17z := l2v17z - 1;
   putAlign('16ПВFА');
   gl36z := 1;
   l2v27z := l2v27z@.nxt;
   _goto 23545;
 _); (* 24641 *)
 _if (tok = back) _then _(
   doExpr(e1);
   _if _not (e1.ty@.k _IN [0,1]) _then  prErr(v36, 0);
   L12635(e1);
   putInsn('ПБВА');
 _);
 _goto 25141;
24662:
 v36 := to;
 _if (curId = _NIL) _then _( v37 := 5; _goto 23711 _);
 _if (curId@.f4.i = 3) _then _(
   l2v23z := gl88z;
   l3v12z := curId;
   getToken;
   _if l3v12z@.f1.i = 0 _then _( standProc; _goto 25141 _);
   _if l3v12z@.vty <> _NIL _then _(
     e1.f0.i := 1;
     e1.f1.i := 3;
     mapai(l3v12z@.f1.a, v37);
     mapia(v37 + 1, e1.f2.a);
     e1.ty := l3v12z@.vty;
     e1.in := _NIL;
     e1.f5.i := 0;
   _) _else _( P14226(l3v12z, l3v11z); _goto 25141 _)
 _) _else _(
   _if curId@.f4.i <> 2 _then _if ((curId@.f4.i <> 1) _or (curId@.f3 = _NIL))
   _then _( v37 := 6; _goto 23711 _);
24732:
   l2v28z := lineNum;
   l2v23z := curId;
   L16714(e1);
 _); (*=a1 24737 *)
 _if lastChar <> chr(128) _then _( v36 :='НЕТ :='; _goto 23710 _);
 gl53z := 2;
 getToken;
 gl62z := F;
 _if (e1.ty@.k = 5) _and (lastChar = obrack) _then _(
   L12520(e1);
   e1.in@.op := utc;
   P11512(13, e1);
   L3732(e1.in);
   v31 := '0';
   (loop) _( 
     gl53z := 2;
     getToken;
     (wh) _if lastChar <> cbrack _then _(
       _if lastChar = comma _then _(
         alfAdd(v31, 1);
         _goto loop;
       _) _else _(
         gl62z := F;
         doExpr(e2);
         L12520(e2);
         P12143(14, e2, v31);
         L3732(e2.in);
         _goto wh
       _);
     _)
   _);
   getToken;
   _goto 25141;
 _); (* 25016 *)
 _if lastChar = semi _then _(
   _if l2v23z@.f7.l _then  P13602(l2v23z, T);
   L12475(e1);
   gl62z := T;
   _goto 25141;
 _);
 l3v9z := gl101z;
 doExpr(e2);
 gl101z := l3v9z;
 (loop) _if typeCheck(e1.ty, e2.ty) _then _(
   _if e1.ty@.k = 6 _then  prErr(to, 0);
 _) _else _if (e2.ty@.k = 1) _then _(
   e2.ty := e2.ty@.f3;
   _goto loop;
 _) _else _if (e1.ty = realType) _and (e2.ty = intType) _then _(
   L13104(e2 );
   L12520(e2 );
 _) _else _if (e1.ty@.k = 1) _and (e1.ty@.f3 = e2.ty) _then _(
   _if e2.f0.i = 0 _then _(
     v37 := L7314(e2.f1.a);
     _if (v37 < e1.ty@.f7.i) _or (v37 > e1.ty@.f8.i)
     _then prErr('ГР ДИА', 0 );
   _) _else _if modeT _then _(
     L12520(e2);
     P12143(22, e2, e1.ty@.nm);
   _)
 _)_else
   prErr(to, 1); (* 25123 *)
 _if (e1.f0.i = 2) _and (e1.ty = boolType) _then _(
   l3v11z := e1.in;
   e1.in := l3v11z@.nxt;
   e1.f1.a := l3v11z@.f4;
   e1.f2.a := l3v11z@.f2;
 _);
 P13734(e1, e2);
25141: rollup(l3v10z)
_);
(* Level 3 *) _proced P25337;
_var v31:idptr; v32:int; v33:alfa; v34:int; 
(* Level 4 *) _proced L25143(a41:int);
_(
 prErr('ЗАГОЛ', a41);
 L7305([1,2]);
_);
(* Level 4 *) _proced P25153;
_type nuzzzz = 100000B..671420B; len = 1..40B;
_var v41:@extFile; v42:int; _(
 v42 := 0;
 _repeat
   getToken;
   _if tokKind <> tkIdent _then _( L25143(3); exit _);
   v41 := gl105z;
   _if (tok = 'INРUТ') _or (tok = 'ОUТРUТ') _then prErr(to, 9);
   _while v41 <> _NIL _do _(
     _if v41@.nm = tok _then  prErr(to, 7);
     v41 := v41@.nxt;
   _);
   new(v41);
   v41@ := [tok, , 0, 0, gl105z];
   gl105z := v41;
   getToken;
   _if lastChar = eq _then _(
     getToken;
     _if tokKind <> tkInt _then  L25143(4);
     _if gl26z _IN nuzzzz _then v41@.f1.i := gl26z _else prErr(to, 8);
     getToken;
     _if tokKind <> tkInt _then  L25143(4);
     _if gl26z _IN len _then v41@.f2.i := gl26z _else prErr(to, 8);
     getToken;
   _) _else (* 25267 *) _(
     v42 := v42 + 1;
     v41@.f1.i := v42;
   _)
 _until lastChar <> comma;
 mapia(v42, gl106z);
 _if lastChar <> cparen _then  L25143(5);
 getToken;
_);

(*=c- Level 4 *) _proced dumpConst(_var an, ak:word);(*=c+*)
_( code(4СЧ3=УИ5,6ПА46=ПБfirst,loop:);
 put(output);
 code(first:14ПАcheck=ПБstart,zero:14ПВdigit=,check:У0zero=,nezero:);
 put(output);
 code(14ПАnezero=ПБdigit,again:);
 put(output); code(ВИ6=);
 output@ := ;
 code(ВИ5=4СР4,У0fin=5СА1,ПБloop=,);
 code(start:5СЧ=,4ЗЧ6=15ПА-17,digit:4СЧ6=СД/-3/,4ЗЧ6=МР,);
 output@ := ;
 code(=15КЦnext,ПБagain=,next:14ПБ=,fin:);
 put(output);
_);

_( (* P25337 *)
  getToken;
  new(v31,13);
  _if modeX  _then  gl44z := '10';
  _if _not modeC _then _(
   l2v13z := 0;
   _while l2v13z <= 47 _do _(
     pool[9 + 1 + l2v13z].i := l2v13z;
     l2v13z := l2v13z + 1;
   _);
   poolIdx := 9 + l2v13z;
  _);
  _if (tok <> 'PROGRA') _then L25143(0)
  _else _(
   getToken;
   _if (tokKind <> tkIdent) _then L25143(1)
   _else _(
     v31@.nm := tok;
     getToken;
     _if lastChar = oparen _then  P25153;
     _if lastChar <> semi _then L25143(2) _else getToken;
   _)
  _);(*=a0*)
  v31@.f9.a := 'АД';
  v31@.f8.a := 'СА';
  v31@.f7.s := _NIL;
  v31@.f10.i := 0;
  v33 := '12';
  _if modeL _then ГГ('ПВ;``К') _else ГГ('В;` `К');
  write('Д=0000,ЗАГР=77040,LОАD,UNLОАD,СН,Ч=12,LI=4,ИА=74000,УРЕГ=ИА(3),Z0=УРЕГ(2),ПБИ15,ЕF,Н,Т,Е,ОС=Е(5),SL=ОС(2),Z64,РR=SL(10),МОD=РR(3),VR,СПТ,СПЛ,RF=VR(5),ЧМ1,ГТ=RF(5),RС=ГТ(6),СР=RС(4),АВ,ОВ,RWF,СТХТ=ОВ(5),WS,WС,WА,WВ,WI,WR,WL,ОWS,ОWС,ОWА,ОWВ,ОWI,ОWR,ОWL,ИК=ОWL(2),СЧ,ЗЧ,ЦУ=74136,ТR=74141,D=74145,N=74151,РА=74173,R=74202,АL=74206,GI=74222,RI=74251,РО=74257,RО=74313,МI=74323,UN=74337,РF=74715,GF=74760,СL=75075,ГА=75104,ЯГА=75115,ТNL=75165,ОV=75241,IА=75361,АI=75363,ГГ=75365,Ф=75675,RSR=75714,');
  _if modeX _then
  write('DS=СН(3),Z1Z,Z2,Z3,Z4,Z5,Z6,Z7,ПА,ВИ,FРF,FGF,FRWF,FRF,FWS,FWС,FWА,FWВ,FWI,FWR,FWL,АС,ПБ,NА,ВА,ЕА,FА,ВD,Z8,ВП,ВП6,ВП7,ПВ,ОRF,');
  write('Н;КД,К;');
  P26222(v33, v31);
  P3330;
  _if gl107z _or gl109z _then
  write('К;ЩРWR:ИАZРR0=ЗЧ,ВИ16=ВМ7,17ЗЧ=7ПА-17,ZРR1:ИАZРR0=СЧ,СД75=ИАZРR0,ЗЧ=СЧ13,17ЗЧ=МР,16ПВОWI=,7КЦZРR1=17СЧ,УИ7=17СЧ,УИ16=16ПБ,ZРR0:ЗЧ=ЗЧ,ZРR2:ЗЧ=ЗЧ42,');
  _if gl108z _then
  write('К;ZQ:ВИ16=16ПА4,ВМ16=ВМ12,ВМ16=ВМ14,17ЗЧ=1СЧ10,16ПАZQ1=16СР2,У0ZQ0=16ПВРR,ZQ0:17СЧ=16ПВОWI,12ПА-1=15ПАZQ1(1),14ПВГТ=,12ПА-6=15ПАZQ1,14ПВГТ=,17СЧ=16ПВОWI,17СЧ=УИ16,ПБРR=,ZQ1:1ИА40456=3ВИ7017,Э3612417=,ЗЧ=ЗЧ304,');
  _if gl107z _then _(
  write('К;ЖЬ:ВИ16=ВМ7,ВМ6=ВМ12,ВМ15=17ЗЧ,15ПА4=ВИ15,ВМ14=17ЗЧ,1СЧ10=16ПАЖЛОК,16СР2=У0ЖЬ0,16ПВРR=,ЖЬ0:17СЧ=16ПВОWI,12ПА-1=15ПАВХОД(3),14ПВГТ=,17СЧ=УИ7,17СЧ=17ЗЧ,УИ12=15ПАВХОД,12СИ15=12ПА-6,14ПВГТ=,7ПИ15=12ПА-6,14ПВГТ=,7СЧ2=У0WЗВR,7ИК2=ВИ,УИ6=7СЧ1,У0ПАRМ=6СА1,ПАRМ:7СЧ3=У1ПАRМ1,ПАRМ3:17СЧ=17ЗЧ,У0WЗВR=7СЧ1,У0WЗВR=15ПАВХОД(3),12ПА-3=14ПВГТ,6ИА2=16ПА,ВИ16=,');
  write('ИАЖЛОК=ЗЧ,16ПАWЗВR=ВИ16,ИАВХОД(10)=ЗЧ,7СЧ1=ИАZРR0,ЗЧ=ИАВХОД(6),ЛУ=У1ПАRМ10,7СЧ1=ПБНАЧПЕR,ПАRМ1:15ПАВХОД(4)=12ПА-3,14ПВГТ=,СЧ12=ЗЧ1,ПАRМ5:ИК1=7СЧ3,ИАZРR0=ЗЧ,ИК1=6ИА3,14ПА=ИАZРR0,СЧ=СД77,МР=У0ПАRМ0,14ИК=14ПА,ПАRМ4:ВИ14=ИАЖЛОК,ЗЧ=16ПАВЗВТ,ВИ16=ИАВХОД(10),ЗЧ=ИАZРR0,СЧ=ИАВХОД(6),ЛУ=У1ПАRМ10,ИАZРR0=СЧ,');
  write('НАЧПЕR:УИ14=14ПБНАЧПЕR,10ПБЖIN=,10ПБЖRЕ=,10ПБЖВО=,10ПБЖСН=,10ПБЖАL=,10ПБЖРW=,ИАЖЛОК=СЧ,16ПВIА=,СД70=ИАЖЛОК,ЗЧ=15ПАЖЛОК,12ПА-5=14ПВГТ,СЧ13=17ЗЧ,ИАZРR2=СЧ,16ПАВЗВТ=ПБОWС,ЖIN:СЧ13=17ЗЧ,ИКЖЛОК=СЧ,ПБОWI=,ЖRЕ:15ПА4=ВИ15,17ЗЧ=17ЗЧ,ИКЖЛОК=СЧ,ПБОWR=,ЖВО:15ПА6=ВИ15,17ЗЧ=ИКЖЛОК,СЧ=ПБОWВ,');
  write('ЖСН:СЧ13=17ЗЧ,ИКЖЛОК=СЧ,ПБОWС=,ЖАL:ИКЖЛОК=15ПА,12ПА-6=ИАВХОД(10),СЧ=УИ14,ПБГТ=,ЖРW:ИКЖЛОК=СЧ,ПБЩРWR=,ПАRМ10:15ПА6=ВИ15,17ЗЧ=ИКЖЛОК,СЧ=ИАZРR0,ЦС=УИ14,14СЧ=ПБОWА,ПАRМ2:15ПАВХОД(5)=12ПА-2,14ПВГТ=,ПБПАRМ3=,');
  write('ВЗВТ:СЧ13=ЦС1,ЗЧ1=ИК1,7СЧ3=У0ПАRМ2,12ПА-3=15ПАВХОД(7),14ПВГТ=,ПБПАRМ5=,WЗВR:ЗЧ=17СЧ,17СЧ=УМ6,УИ7=17СЧ,УИ16=ПБРR,ПАRМ0:17СЧ=17ЗЧ,У0ПАRМ4=15ПАЖЛОК(1),12ПА-3=14ПАВЗВТ,ПБГТ=,ВХОД:2Э0432456=2Э1007417,2Э0435065=2Э3422017,2Э1232502=3Э0407417,Э3617417=,Э3611017=,Э3611417=,7КЦ77777=17КЦ77770,Э3606417=,ЗЧ=,ЖЛОК:ЗЧ=,1Э2214431=,ЗЧ=ЗЧ304,');
  _);
  _if gl109z _then _(
  write('ЩП:ВМ16=ВМ12,ВМ15=16ПА4,ВМ16=ВМ14,17ЗЧ=16ПАРАВ,1СЧ10=16СР1,У0ЩП1=16ПВРR,ЩП1:17СЧ=16ПВОWI,12ПА-1=15ПАРАВ,14ПВГТ=,17СЧ=УИ15,12ПА-6=14ПВГТ,12ПА-3=15ПАРАВ,14ПВГТ=,16ПАВОЗВR=17СЧ,УИ14=,ПЕR:14ПБПЕR=,10ПБЩАL=,10ПБЩRЕ=,10ПБЩВО=,10ПБЩСН=,10ПБЩIN=,10ПБЩРW=,10ПБЩУК=,ЩSR:15ПА6=ВИ15,17ЗЧ=17СЧ-3,17ЦС-4=УИ14,14СЧ=ПБОWА,ЩАL:17ИА-2=15ПА,12ПА-6=14ПАВОЗВR,ПБГТ=,ЩRЕ:15ПА4=ВИ15,17ЗЧ=17ЗЧ,17СЧ-4=ПБОWR,ЩВО:15ПА6=ВИ15,17ЗЧ=17СЧ-3,ПБОWВ=,ЩСН:10СЧ13=17ЗЧ,17СЧ-3=ПБОWС,');
  write('ЩIN:10СЧ13=17ЗЧ,17СЧ-3=ПБОWI,ЩРW:17СЧ-2=ПБЩРWR,ЩУК:17СЧ-2=16ПВIА,СД70=ИАZРR0,ЗЧ=15ПАZРR0,12ПА-5=14ПВГТ,10СЧ13=17ЗЧ,10ИАZРR2=СЧ,16ПАВОЗВR=ПБОWС,ВОЗВR:16ПВРR=,17СЧ=УИ16,17СЧ=16ПБ,РАВ:Э3612417=,ЗЧ=ЗЧ304,ВСS:1ИА30440=4Э2022417,');
  _);
  _if gl103z _then
  write('К;ОWJ:10ИА=12ПВОСТL,ПБОWI=,WJ:10ИА=12ПВОСТL,ПБWI=,ОСТL:10ИА=14ПАЯЧ,14ЗЧ=10СЧ13,14ЗЧ1=СЧ,14ЗЧ3=,ПОВЬ:14СЧ=14ЛУ4,14ЗЧ2=ЛСZ64,14АУ1=МР30,14АС3=14ЗЧ3,14СЧ=14АВ2,СД103=10У0КН1,14ЗЧ=14СЧ1,СД77=17ЗЧ,СД76=17ЦС,14ЗЧ1=10ПБПОВЬ,КН1:14СЧ3=12ПБ,ЯЧ:ЗЧ=ЗЧ,ЗЧ=ЗЧ,ЗЧ=ЗЧ,ЗЧ=ЗЧ,ЗЧ=ЗЧ7,');
  _if (gl89z <> -1) _or (gl90z <> -1)_then _(
    write('Л;ИМЕНА:ДВНУТ,У;А1,С;77777,ВНЕШ:');
    v34 := 0;
    _while v34 <= gl89z _do _(
      ГГ('А;'); write(withSp(gl4635z[v34])); ГГ(',С;0,');
      v34 := v34 + 1;
   _);
   ГГ('С;0,'); write('ВНУТ:');
   v34 := 0;
   _while v34 <= gl90z _do _(
     write('А;', withSp(gl4736z[v34]), ',Л;Д'); ГГ(gl4736z[v34]);
     write(icomma);
     v34 := v34 + 1;
   _);
   ГГ('С;0,');
  _); (* 25543 *)
  write('Х:Н;11,С;');
  dumpConst(pool[9], pool[poolIdx]);
  write('Н;1,С;');
  printOct(withSp(v31@.nm));
  write(icomma); 
  printOct(getDate);
  write(icomma);
  write('Н;5,Л;ДХ,Н;7,К;10ПВУРЕГ=');
  _if modeX _then ГГ('ПБ') _else ГГ('ИА');
  _if (gl89z <> -1) _or (gl90z <> -1) _then ГГ('ИМЕНА');
  putSep;
  write('10СА-10=10ПБАД,');
  P4511(7, 'СА', v33);
  _if lastChar <> dot _then L25143(6);
_);
(*=a1 Level 3 *) _proced L25617(a31:int);
_(
  prErr('БЛОК', a31);
  L7305([1,2]);
_);
(*=c- Level 3 *) _proced P25626;
_var v31:alfa; v32:int; v33, v34:idptr; (*=c+*)
_(
 L5264(l2a2z@.nm);
 P4511(5, gl41z, '42');
 cv.i := lineNum;
 putConst(v31, T);
 v32 := 0;
 _while v32 <= 127 _do _(
   v33 := idTable[v32];
   _while (v33 <> _NIL) _and (v33 > l2a2z) _do _(
     _if _not ((v33@.f4.i <> 2) _or (v33@.vty@.sz <> 1)) 
     _or _not ((v33@.f4.i <> 1) _or (v33@.f3 = _NIL)) _then _(
       L5264(v33@.nm);
       mapai(v33@.f6.a, cv.i);
       putConst(v31, T);
       v34 := v33@.vty;
       _select
       v34 = realType: cv.i := 0;
       v34 = alfaType: cv.i := 1;
       v34 = charType: cv.i := 2;
       T: cv.i := 3
       _end;
       putConst(v31, T);
     _);
     v33 := v33@.nxt;
   _);
   v32 := v32 + 1;
 _);
 cv.i := 0;
 putConst(v31, T);
_);

(*=c- Level 3 *) _proced P25726;
_var l3v1z, l3v2z:int; l3v3z, l3v4z:int; l3v5z, l3v6z:idptr; l3v7z:int; l3v8z:alfa;
 l3v8a: _array [1..30] _of int; (*=c+*)
_(
 l3v3z := l2a2z@.f10.i;
 l3v2z := 0;
 _if l2a2z@.vty <> _NIL _then _(
   l3v5z := l2a2z@.vty;
   _if l3v5z@.k = 1 _then l3v5z := l3v5z@.f3;
   _select
   l3v5z = intType: l3v2z := 1;
   l3v5z = realType: l3v2z := 2;
   l3v5z = boolType: l3v2z := 3;
   l3v5z = charType: l3v2z := 4;
   l3v5z = alfaType: l3v2z := 5;
   l3v5z@.k = 0: _( L5425(l3v5z); mapai(l3v5z@.f8.a, l3v2z) _);
   l3v5z@.k = 3: l3v2z := 6;
   T: l3v2z := 7
   _end
 _); (* 25776 *)
 _if l3v3z > 0 _then_(
   l3v5z := l2a2z@.f7.id;
   l3v4z := 1;
   _while l3v4z <= l3v3z _do _(
     l3v6z := l3v5z@.vty;
     _if l3v6z@.k = 1 _then  l3v6z := l3v6z@.f3;
     _select
     l3v5z@.f4.i = 3:;
     (l3v6z = intType) _or (l3v6z = realType) _or (l3v6z = boolType)
     _or (l3v6z = charType) _or (l3v6z = alfaType):;
     l3v6z@.k = 0: _( L5425(l3v6z); mapai(l3v6z@.f8.a, l3v1z); l3v8a[l3v4z] := l3v1z _);
     T:
     _end;
      l3v5z := l3v5z@.f3;
      l3v4z := l3v4z + 1;
   _)
 _); (* 26043 *)
 L5264(l2a2z@.nm);
 l2v12z := gl41z;
 cv.i := l3v2z;
 putConst(gl41z, T);
 _if (l2a2z@.vty <> _NIL) _or (l3v3z > 0) _then _(
   l3v5z := l2a2z@.f7.id;
   l3v8z := l2a2z@.f1.a;
   mapai(l3v8z, l3v2z);
   mapia(l3v2z + 1, l3v8z);
   l3v8z := l3v8z;
   cv := ;
   putConst(gl41z, T);
 _);
 l3v2z := 0;
 l3v4z := 1;
 _while l3v4z <= l3v3z _do _(
   l3v6z := l3v5z@.vty;
   _if l3v6z@.k = 1 _then  l3v6z := l3v6z@.f3;
   l3v7z := l3v5z@.f4.i;
   l3v1z := 0;
   _select
   l3v6z = intType: l3v2z := 1;
   l3v6z = realType: l3v2z := 2;
   l3v6z = boolType: l3v2z := 3;
   l3v6z = charType: l3v2z := 4;
   l3v6z = alfaType: l3v2z := 5;
   l3v6z@.k = 3: l3v2z := 6;
   l3v6z@.k = 0: l3v2z := l3v8a[l3v4z];
   T: l3v2z := 7
   _end;
   _if l3v7z = 2 _then  l3v1z := 4T;
   code(3СЧ3=3ЦС4,); cv := ;
   putConst(gl41z, T);
   l3v5z := l3v5z@.f3;
   l3v4z := l3v4z + 1;
 _); (* 26156 *)
 cv.i := 0;
 putConst(gl41z, T);
 (*=a0*)putInsn('12ПА0');
 ГГ('15ПА'); putInsn(l2v12z);
 mapia(lineNum, gl41z);
 L3656('14ПА', gl41z);
 putAlign('16ПВЖЬ');
_);

(* Level 3 *) _proced L26177(_var table:_array [0..127] _of idptr);
 _(
 l2v13z := 0;
 _while l2v13z <= 127 _do _(
   l2v2z := table[l2v13z];
   _while (l2v2z <> _NIL) _and (l2v2z >= l2v21z) _do l2v2z := l2v2z@.nxt;
   table[l2v13z] := l2v2z;
   l2v13z := l2v13z + 1;
 _);
 _);
_( (* P26222 *)
 _if tok = sp _then _(  P4646; P25337; exit _);
 l2v11z := l2a1z;
 l2v19z := modeC;
 _if _not l2v19z _then  ГГ('В;К;');
 gl57z := T;
 gl54z := 0;
 l2v31z := '0';
 l2v12z := ;
 l2v17z := 0;
 l2v27z := _NIL;
 l2v22z := gl76z;
 gl36z := 1;
 l2v26z := gl4633z;
  (*=a1*)
 _if tokKind <> tkWord _then  L25617(1);
 _if tok = label _then _(
   _repeat
   getToken;
   _if tokKind <> tkInt _then prErr('БЛОК', 24)
   _else _(
     new(l2v25z, 6);
     l2v25z@.f0.i := gl26z;
     l2v25z@.f2.a := level;
     l2v25z@.f3.i := 0;
     l2v25z@.f1.i := 0;
     l2v25z@.f5.i := 0;
     l2v25z@.f4.s := gl4633z;
     gl4633z := l2v25z;
     getToken;
   _);
   _if (lastChar <> comma) _and (lastChar <> semi) _then _(
     prErr( 'БЛОК', 25);
     L7305([1,2,3]);
   _);
   _until lastChar <> comma;
   _if lastChar = semi _then  getToken;
   _if tokKind <> tkWord _then  L25617(1);
 _);
 _if tok = const _then _(
   gl53z := 0;
   getToken;
   _if tokKind <> tkIdent _then _(
     prErr('БЛОК', 2);
     L7305([1,2,4]);
   _);
   _while tokKind = tkIdent _do _(
     _if gl60z _then  prErr('БЛОК', 2);
     new(l2v2z, 8);
     l2v2z@ := [tok, level, idTable[gl25z], _NIL, 1, intType];
     idTable[gl25z] := l2v2z;
     getToken;
     _if (lastChar = eq) _then getToken _else prErr('БЛОК', 3);
     l2v1z := _NIL;
     P7520(l2v1z, l2v2z@.f6.a, T);
     _if l2v1z = _NIL _then prErr('БЛОК', 4) _else _( l2v2z@.vty := l2v1z; getToken _);
     l2v29z := 0;
     _select
     lastChar = '+': l2v29z := 1;
     lastChar = '-': l2v29z := 2;
     lastChar = '*': l2v29z := 3;
     lastChar = '/': l2v29z := 4
     _end;
     _if l2v29z > 0 _then _(
       getToken;
       new(l2v24z, 8);
       l2v24z@ := [0, level, idTable[gl25z], _NIL, 1, intType];
       l2v1z := _NIL;
       P7520(l2v1z, l2v24z@.f6.a, F);
       _if l2v1z = _NIL _then prErr('БЛОК', 6)
       _else _if (l2v1z = l2v2z@.vty) _and (l2v1z = intType) _then _(
         l2v30z := L7314(l2v2z@.f6.a);
         _case l2v29z _of
         0: _goto 26505;
         1: cv.i := cv.i + l2v30z;
         2: cv.i := l2v30z - cv.i;
         3: cv.i := l2v30z * cv.i;
         4: _( _if cv.i = 0 _then _( prErr('БЛОК', 8); _goto 26505 _);
            cv.i := trunc(l2v30z / cv.i)
         _)
         _end;
         putConst(l2v2z@.f6.a, F);
         getToken
       _) _else 26505: prErr('БЛОК', 7);
     _); (* 26507 *)
     _if (lastChar = semi) _then _(
       gl53z := 0;
       getToken;
       _if _not L7143([1,2,4]) _then _( prErr('БЛОК', 0); L7305([1,2,4]) _)
     _) _else prErr('БЛОК', 5);     
 _)_); (* 26523 *)
 _if (tok = type) _then _(
   gl53z := 0;
   getToken;
   _repeat
    _if tokKind <> tkIdent _then L25617(2);
    _if gl60z _then _(
      _if (curId@.f4.i = 0) _and (curId@.k = 2) _and (curId@.f3 = _NIL) _then _(
        l2v1z := curId;
        getToken;
        _if lastChar <> eq _then L25617(3);
        getToken;
        _if lastChar <> arrow _then L25617(30);
        gl54z := gl54z - 1;
        gl53z := 0;
        getToken;
        _if (tokKind <> tkIdent) _or _not gl60z _or (curId@.f4.i <> 0) _then L25617(31);
        _if curId@.k = 7 _then curId := curId@.f3;
        _if curId@.k > 5 _then L25617(32);
        l2v1z@.f3 := curId;
        getToken;
        _goto 26607;
      _) _else L25617(2);
    _); (* 26575 *)
    l2v6z := tok;
    l2v13z := gl25z;
    getToken;
    _if lastChar <> eq _then  L25617(3);
    parseType(0, l2v6z, l2v1z, l2v13z );
26607:
    _if lastChar <> semi _then  L25617(6);
    gl53z := 0;
    getToken;
   _until tokKind <> tkIdent;
   _if tokKind <> tkWord _then L25617(1);
 _); (* 26620 *)
 gl57z := F;
 _if gl54z <> 0 _then L25617(33);
 _if tok = var _then _(
   l2v2z := _NIL;
   _repeat
     gl53z := (0);
     getToken;
26631:
     _if (tokKind <> tkIdent) _or gl60z _then L25617(2);
     new(l2v1z, 8);
     l2v1z@ := [ tok, level, idTable[gl25z], _NIL, 2, _NIL ];
     _if modeV _then l2v1z@.f7.i := 1 _else l2v1z@.f7.i := 0; (* l2v1z@.f7.i := ord(modeV) *)
     idTable[gl25z] := l2v1z;
     _if l2v2z = _NIL _then l2v2z := l2v1z _else l2v5z@.vty := l2v1z;
     l2v5z := l2v1z;
     getToken;
   _until lastChar <> comma;
   _if lastChar <> colon _then  L25617(7);
   parseType(0, '0', l2v3z, 0);
   l2v13z := l2v3z@.sz;
   _if l2v3z@.k = 6 _then_(
     mapia(modeB, l2v7z);
     mapia(l2v3z@.f7.i, l2v8z);
     l2v14z := l2v3z@.f3@.sz;
     (*=m-*)cv.i := modeB * 256;
     _if cv.i >= l2v14z _then l2v13z := l2v13z + cv.i - cv.i _MOD l2v14z
     _else l2v13z := l2v13z + l2v14z;
     mapia(l2v14z, l2v6z);
     _if l2v31z = '0' _then _( TNL(l2v31z); P4357(0, l2v31z); (*=a0*) write('ВМ14=17ЗЧ,') _)
     _else  P4357(0, l2v32z);
     TNL(l2v32z);
     l2v20z := (level = '1') _and (gl105z <> _NIL);
     _if l2v20z _then _(
       gl13z := T;
       _if gl106z <> '0' _then _( ГГ('15ПА', gl106z ); write('=ВИ15,СР77765=У1Н,') _)
     _);
     _if l2v2z <> _NIL _then _(
       l2v1z := l2v2z@.vty;
       l2v2z@.vty := l2v3z;
       l2v2z@.f6.a := l2v11z;
       l2v2z@.f7.i := 0;
       ГГ('13','ИА',l2v11z); write('=15ПА,12ПА'); ГГ(l2v6z,'=11ПА',l2v8z,',14ПА',l2v7z,'=СЧ');
       _if l2v20z _then _(
         gl104z := gl105z;
         
       _) (* 27043 *)
     _) (* 27053 *)
   _); (* 27060 *)
 _); (* 27114 *)
 L26177(idTable);
_);
_function time:int;
_( code(Э0634=,); time :=; _);
_(
  prepErr(4); P3110(getDate, 5); P26222(tok, curId);  
  
  (*=a0*)

write('############################################################################################');
write('############################################################################################');

%write('################################################');
%write('########################');
%write('############');
write('######');
write('######');
27721:;
_).
