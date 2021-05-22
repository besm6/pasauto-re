(*=p-,t-,m-,k8*)_program compil;
_label 27721;(*=a0*)
_const c0=0; c1=1; c2=2; c3=3; c4=4; c5=5;c6=6;c7=7;c8=8;c9=9;c10=10;c11=11;
c12=12;c13=13;c14=14;sp=15;c16=16;c17=17;c18=18;c19=19;c20=20;c21=21;c22=22;c23=23;
c24=24;c25=25;c26=26;c27=27;c28=28;c29=29;c30=30;c31=31;c32=32;c33=33;c34=34;c35=35;
c36=36;c37=37;icomma=',';c39=39;c40=40;c41=41;c42=42;c43=43;c44=44;c45=45;icolon=':';ieq='=';
(*=a1*)
spaces='      ';c128=128;c4096=4096;
branch='branch';back='back';kexit='exit';select='select';not='not';and='and';or='or';
label='label';type='type';with = 'with';downto='downto';for='for';repeat='repeat';
until='until';while='while';do='do';to='to';go='go';if='if';then='then';else='else';
goto='goto';begin='begin';in='in';div='div';mod='mod';extern='extern';const='const';
var='var';functi='functi';proced='proced';nil='nil';record='record';case='case';
of='of';end='end';array='array';file='file';set='set';
(*=a0*)
e050='Э050';asn='СД';vm='ВМ';yta='МР';sm='СМ';
mv='МВ';utm='СА';pi='ПИ';aox='ЛС';wtc='ИК';ra='РА';amulx='АУ';adivx='АД';aplusx='АС';
xmina='ОВ';xta='СЧ';utc='ИА';aminx='АВ';vtm='ПА';ita='ВИ';uj='ПБ';u1a='У1';uza='У0';avx='ИЗ';
aex='СР';vjm='ПВ';atx='ЗЧ';aax='ЛУ';z64='Z64';c256=256;utcm10='10ИА';star='*';
(*=a1*)z='z';c127=127;i6=6400000000000006C;c100=100;
_type sixwords=_array[1..6] _of alfa;bitset=_set _of 0..47;
letter = 'a'..'z';
word=_record _case integer _of
0:(a:alfa);
1:(b:bitset);
2:(l:boolean);
3:(i:integer);
4:(p:@word);
5:(s:pstr);
6:(id:idptr);
8:(r:real);
9:(ps:psix);
10:(pi:pInst)
_end;
 struc=_record 
 _case integer _of
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
    _case integer _of
    7:(d7: _array [0..6] _of word);
    8:(d8: _array [0..7] _of word);
    9:(d9: _array [0..8] _of word);
    13:(f0:alfa;
    f1:word;
    f2:idptr; (* next *)
    f3:idptr; (* base type of derived type *)
    f4: word;
    f5: word; (* variable type *)
    f6, f7, f8, f9, f10, f11, f12: word)
 _end;
 idptr = @ident;
 pstr = @struc;
 six = _record f0, f1, f2, f3, f4, f5: word _end;
 psix = @six;
 inst = _record f0:pInst; f1:integer; f2, f3:alfa;
   _case boolean _of true:(f4: alfa); false:(f4b:bitset) _end;
 pInst = @inst;
 tkind = (tk0, tkIdent, tkWord, tkInt, tkStr, tkReal, tkChar, tkField);
_var
   modeB:integer;
   rval:real;
   gl12z, gl13z, modeF,
   modeG, gl16z, modeDe, modeCH, modeeL : boolean;
   inInclude: boolean;
          errcnt, maxerr, gl23z, lineNum, gl25z, gl26z, gl27z, gl28z, poolIdx,
   gl30z, poolStart, poolAddr, gl33z, modeK, gl35z, gl36z:integer;
   gl37z, tok, gl39z:alfa;
   gl40z, gl41z, gl42z,
   gl43z, gl44z:alfa; gl45z:alfa;
   fname:alfa;
   gl47z:@word;
   endl:char;
   seqGOST, seqITM:char;
   lastChar: char;
   tokKind:tkind;
   gl53z, gl54z, modeA:integer; curVal:word;
   gl57z, gl58z, modeC,
   gl60z, leftInsn, gl62z, gl63z, errSeen, modeE, modeP, modeT, modeR, modeM,
   modeL, gl71z, modeI, skipping, modeX: boolean;
   curIdent:idptr; 
   gl76z, gl77z,
   textFile, inFile,  outFile:idptr; ptrType, setType,
   boolType, intType, realType, charType, alfaType: idptr;
   gl88z, gl89z,
   gl90z, gl91z, savedNum, gl93z, gl94z, gl95z, gl96z, gl97z:integer;
   modeV, modeS: boolean;
   gl100z, gl101z, gl102z, gl103z: boolean;
   gl104z, gl105z, gl106z, gl107z, gl108z:integer; gl109z:boolean;
   gl91a: _array [3..8] _of sixwords;
   gl145z: _array [1..17] _of alfa;
   idTable, idTabA: _array[0..127] _of idptr;
   gl419z: _array [0..0] _of six;
   gl425z, gl426z, gl427z: integer;
   gl422a: _array [1..16] _of sixwords;
   dummy:_array [1..13] _of char;
   pool: _array[1..4096] _of word;
   gl4633z:char; gl4634z:@typchain; gl4635z, gl4736z:_array [0..100] _of char;
   gl4837z, gl4838z:integer;
_proced L3013(i:integer);   
_(   
  write(i:0)
_);

_proced P3020;
_(
  _if inInclude _then _(
    ГГ( '*ФАЙЛ ' ); ГГ( fname );
    writeLN
  _)
_);
_proced prepErr(l2a1z:integer);
_(
 rewrite(output);
 P3020;
 _select
 (l2a1z = 0):  write('ВСТРЕТИЛСЯ КОНЕЦ ФАЙЛА');
 (l2a1z = 1): _( write('НЕ ЗАКРЫТА УСЛ СЕКЦИЯ'); ГГ( ' СТР.=' ); L3013( gl26z ); _);
 (l2a1z = 2): _( write('ВЛОЖЕННОСТЬ !'); ГГ( ' СТР.=' ); L3013( lineNum ); _);
 (l2a1z = (3C)): write('НЕ ЗАКРЫТ КОММЕНТАРИЙ');
 (l2a1z = (4C)): _( ГГ( 'ФАЙЛ ' ); ГГ( fname ); write(' НЕ НАЙДЕН') _);
 (l2a1z = (5C)): _( ГГ( 'В '); L3013( lineNum ); write(' СТРОКАХ ОБНАРУЖЕНО ');
         L3013( errcnt ); ГГ( ' ОШИБ.' ) _);
  true: _( write('ОШ ПРЕПРОЦЕССОРА'); ГГ( ' СТР.=' ); L3013( lineNum ) _)
  _end;
 writeLN;
 code(ПБ76002=,);
  _);
_proced P3110(l2a1z:alfa; l2a2z: integer);
_(
rewrite(output);
P3020;
_case l2a1z _of
'ОШИБКА': _(
  write('ТРЕБУЕТСЯ ');
 _select
 l2a2z = 0: write('ЗАПЯТАЯ');
 l2a2z = 1: write('ПРОСТАЯ ПЕРЕМЕННАЯ');
 l2a2z = 2: write('КОНСТАНТА');
 true: _( _)
 _end;
_);
'to': _(
 _select
 l2a2z = 0: write('НЕЛЬЗЯ ПРИСВАИВАТЬ ФАЙЛЫ');
 l2a2z = 1:  write('НЕСООТВ ТИПОВ ПРИ := ');
 l2a2z _in [2..4]: _(
   ГГ( 'МЕТКА ' );
   L3013( gl26z );
   _select
    (l2a2z = 2): write(' ОТСУТСТ В СПИСКЕ МЕТОК');
    (l2a2z = (3C)): _(  write(' УЖЕ ОПРЕД В СТРОКЕ '); L3013( curVal.i ) _);
    true: write(' НЕ ОПРЕД')
    _end;
 _);
 l2a2z = (5C):  write('ИД НЕ ОПРЕД');
 l2a2z = (6C):  write('ИД НЕ ПЕРЕМЕН');
 l2a2z = (7C):  write('ДВАЖДЫ ОПИСАН ВНЕШ ФАЙЛ');
 l2a2z = (10C):  write('НЕПРАВ ПАРАМ ДЛЯ ВНЕШ ФАЙЛА');
 l2a2z = (11C):  write('INРUТ∨ОUТРUТ НЕЛЬЗЯ');
 l2a2z = (12C):  write('МЕТКИ И GОТО В ВRАNСН НЕЛЬЗЯ')
 _end;
_);
'sexpr': _(
  _select
  (l2a2z = 0): write('УНАРНЫЕ + - ТОЛЬКО ДЛЯ RЕАL ИЛИ ЦЙ');
  (l2a2z = 1): write('ДОЛЖНЫ БЫТЬ ТИПЫ RЕАL ИЛИ ЦЙ');
  (l2a2z = 2)_or (l2a2z = (3C)): write('ТРЕБУЮТСЯ ДРУГИЕ ТИПЫ ОПЕРАНДОВ')
  _end
_)
_end; (* case *)
_);
(*=A0 code generation *)
_proced P3330;
_var l2v1z, l2v2z, l2v3z, l2v4z:integer; l2v5z: alfa;
_proced P3251(l3a1z:alfa);
_(
ГГ( 'F' );
  ГГ( l3a1z );
 write(':УИ15=15И1');
 ГГ( l3a1z );
 write(',ЛУZ64=У');
 _if (l2v2z _IN [13,15]) _then output@ := '0' _else output@ := '1';
 put(output);
 ГГ( 'O' );
 ГГ( l3a1z );
 write(',15ПА');
 write(l2v2z:0);
 write('=ПБМI,');
 _if (l2v2z = (17C)) _then 
 write('Э;ОРF:РО,ОGF:GI,ОRWF:RО,К;ОRF:16ПИ15=ПБRI,')
 _else l2v2z := (l2v2z + 1);
_);
_proced P3307(l3a1z:alfa);
_(
 ГГ( 'F' );
 ГГ( l3a1z );
 ГГ( ':12ПА' );
 ГГ( l3a1z );
 ГГ( '=14ПАО' );
 ГГ( l3a1z );
 write(icomma);
 _if (l2v2z = (31C)) _then 
 write('FW:УИ15=15И0FW(2),17СЧ=12ПБ,ЛУZ64=У0FW(4),17СЧ=14ПБ,15ПА21=ПБМI,')
 _else ГГ( 'ПБFW=,' );
 l2v2z := (l2v2z + 1);
_);
_( (* P3330 *)
 write('У;А1,К;');
 _for l2v1z := 3 _to 8 _do _(;
 _for l2v2z := 1 _to (l2v1z - 2) _do _(;
   l2v5z := gl91a[l2v1z][l2v2z];
  _if (l2v5z <> '000000') _then _(
 ГГ( l2v5z );
 write(icolon);
 l2v3z := l2v1z;
 ГГ( '13ПИ' );
 mapia( l2v1z, l2v5z );
 ГГ( l2v5z );
 _while (l2v3z >= (l2v2z + 2)) _do _(
 ГГ( (57C) );
 ГГ( l2v5z );
 ГГ( 'СЧ2,УИ' );
 l2v4z := (l2v3z - 1);
 mapia( l2v4z, l2v5z );
 ГГ( l2v5z );
 l2v3z := (l2v3z - 1);
 _);
 ГГ( '=16ПБ,' );
 _)
 _);
 _);
_if (gl145z[17] <> '000000') _then 
 write('IS:17СЧ=ИЗЧМ1,УМ11=11СД100,СРИА=17СМ-2,11СД100=17ЗЧ-2,15СР=17ЛУ,17СР=15ЗЧ,16ПБ=,');
_if modeX _then _(
 ГГ( 'Э;Z1:' );
 _if (gl145z[15] <> 'ИА') _then ГГ( 'Z8,' ) _else ГГ( 'Z1Z,' );
 write('ОРF:РО,ОGF:GI,ОRWF:RО,К;');
_) _else _(
  l2v1z := 1;
  _while l2v1z <= 16 _do _(
   _if gl145z[l2v1z] <> '0' _then _case l2v1z-1 _of
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
  14: _( _if (gl145z[15] = 'ИА') _then write('Z1:РА3=СЧ5,') _else
         write('ВDОШ:ЗЧ1=16ПИ15,16ПВ76005=,11ПАВDТ=ПБТОШ,А;ВDТ:ОШВD= ,К;ВD:ВИ4=11ЗЧ33,11ПИ4=15ИАВDVЕС,СЧ=4ЗЧ3,4ПБ2=,С;ВDVЕС:0,0,2512141131,26211511,221411,27231411,201411,К;Z1:РА3=СЧ6,СД66=УИ4,СД54=ЛС74014,ЗЧ2=Э0702,ИК5=СЧСЧ1,ЗЧ1=4ПИ5,ВИ4=ЗЧ5,5СА2000=ВИ5,4ЗЧ16=5СА2000,ВИ5=4ЗЧ17,5СА2000=СЧ1,5ЗЧ1=2ПАВDОШ,ВИ2=4ЗЧ11,ВИ5=,');
      write('УИ1=1ПИ17,1ПИ13=15ПВRI,СЧ=1ЗЧLI,14ПИ16=ПБRО,');
  _);
  15: _(
   write('ПВ:ВИ15=ВМ13,СД61=17ЛС,16ПБ=,ВП7:ВИ16=ВМ13,12СМ=СД117,17ЗЧ=12ИК,ПБ=,ВП6:17СЧ=УМ13,УИ16=16ПБ,ВП:17СИ11=11ПИ13,ВП1:12СЧ=У0ВП2,11СР3=У0ВП3,12СЧ=СР13,У1ВПШ=11СЧ3,СР');
 ГГ( gl40z );
 write('=У0ВП4,СР13=У1ВПШ,17СА100=ВИ11,ВМ12=ВМ13,ВМ14=ВМ15,17ЗЧ=11ИА2,12ПА=12ИК,СЧ4=У1ВПШ,12СЧ=СД117,14ПВRSR=,12ИК=16ПВ,17СЧ=УМ15,УМ14=УМ13,УМ12=УИ11,17СЧ10=17СА-100,ПБВП5=,ВП4:11ИК2=СЧ,ВП5:13ЗЧ2=13СА1,12СА1=11СА2,ПБВП1=,ВП3:11СЧ2=ПБВП5,ВП2:11СЧ3=У1ВПШ,17СЧ=ПБRSR,ВПШ:17СЧ=14ПВRSR,11ПАВПТ=СЧ13,ПБТОШ=,А;ВПТ:ФПАРОШ,К;');
  _)
   _end; l2v1z := l2v1z + 1;
  _);
_);
_);
_function getDate:alfa;
_var k:integer;l:alfa;
_(
  k:=00003777776Т;l:='3 1   ';
  СОDЕ(Э050114=,2СБ4=2РБ5,СД120=2ЗЧ4,МР=СД70,2ЗЧ5=МР,2СМ5=СД140,17ЛС=2СМ4,СД60=17ЛС,2ЗЧ3=)
_);
_procedure printOct(v:integer);
_(
  code(=11ПА77761,qqq1:2СЧ3=СД75,2ЗЧ3=МР,); output@:=;put(output);code(11КЦqqq1=)
_);

_procedure P26222(_var l2a1z:alfa; _var l2a2z:idptr);
_const (*=a1*)block='БЛОК';
arrow='@';dot='.';oparen='(';colon=':';semi=';';lt='<';gt='>';
star='*';slash='/';minus='-'; plus='+';eq='=';neq='#';
comma=',';cparen=')'; obrack='[';cbrack=']';(*=a0*)
c259=259;c258=258;e48=4T;
_type oneinsn=_record next:@oneinsn; mode: integer; ir, op, addr:alfa _end;
_var l2v1z:integer; l2v2z: idptr; arra:_array [3..10] _of integer;
l2v11z:integer;
l2v12z:alfa;
l2v13z,l2v14z, l2v15z, l2v16z, l2v17z, l2v18z:integer;
l2v19z:boolean; l2v20z:word; l2v21z:idptr; l2v22z:word;
l2v23z:idptr;
l2arrb:_array [24..26] _of integer;
l2v27z:pstr;
l2v28z, l2v29z, l2v30z: integer;
l2v31z: integer; l2v32z:alfa;
_function F3575(i:integer):integer;
_var l3v1z:integer;l3v2z,l3v3z:real;
_(
l3v1z := e48; l3v3z := i; l3v2z := 1.0;
code(PA3=3АД7,3АC5=ЦС13,); F3575:=;
_);
_procedure P3606(_var l3a1z:alfa; l3a2z:integer);
_var l3v1z:integer;
_(
  mapai(l3a1z, l3v1z);
  mapia(l3a2z+l3v1z, l3a1z);
_);
(* Level 3 *) _proced putSep; _(
 _if leftInsn _then  output@ := ieq _else output@ := icomma;
 leftInsn := _not leftInsn;
 gl42z := '0';
 put(output);
 _);
 _proced putInsn(l3a1z:alfa); _(
 ГГ( l3a1z );
 putSep;
 _);
(* Level 3 *) _proced L3636; _(
 _if modeX _then putInsn( '10ИА' );
 _);
(* Level 3 *) _proced L3644; _(
 _if modeX _then ГГ( '10' );
 _);
_proced L3651(l3a1z:alfa); _(
 L3644;
 putInsn( l3a1z );
 _);
 _proced L3656(l3a1z, l3a2z:alfa); _(
 ГГ( l3a1z );
 ГГ( l3a2z );
 putSep;
 _);
(* Level 3 *) _proced L3667(l3a1z:alfa);
 _(
 ГГ( l3a1z );
 _if leftInsn _then  write('=,')
 _else _( write(icomma); leftInsn := true; _);
 gl42z := '0';
 _);
(* Level 3 *) _proced align;
 _(
 _if _not leftInsn _then _( write(icomma); leftInsn := _not leftInsn _)
 _);
(* Level 3 *) _proced L3712;
 _(
 _if (gl36z <> (1)) _then _( putInsn( 'РА7' ); gl36z := (1) _)
 _);
(* Level 3 *) _proced L3721(l3a1z:alfa);
 _(
 align;
 ГГ( l3a1z );
 write(icolon);
 L3712;
 gl42z := l3a1z;
 _);
(* Level 3 *) _proced L3732(l3a1z:pInst);
_const mask='070000';
_var l3v1z:alfa; l3v2z:pInst; _(
 (align)_if (l3a1z = _nil) _then exit;

 _if (l3a1z@.f0 <> _nil) _then _(
 _if (l3a1z@.f3 = gl37z) _and (l3a1z@.f0@.f3 = 'ЗЧ') _and
  (l3a1z@.f0@.f2 = '17') _and (l3a1z@.f0@.f4 = '0') _then _(
 l3a1z@.f3 := 'СМ';
 _if (l3a1z@.f2 = '0') _then l3a1z@.f2 := gl44z;
 l3v2z := l3a1z@.f0;
 l3a1z@.f0 := l3a1z@.f0@.f0;
 _) _else _(
 _if (l3a1z@.f0@.f3 = 'ИК') _or (l3a1z@.f0@.f3 = 'ИА') _then _(
 _if (l3a1z@.f1 <> (0)) _then _(
   l3v2z := l3a1z@.f0;
 (loop) _while (l3v2z@.f0 <> _nil) _do _(
   l3v1z := l3v2z@.f0@.f3;
 _if (l3v1z = 'ИА') _or (l3v1z = 'ИК') _then l3v2z := l3v2z@.f0
 _else _exit loop;
 _);
 l3v2z@.f1 := l3a1z@.f1;
 _)
 _)
 _);
 L3732(l3a1z@.f0);
 _); (* 4017 *) _case l3a1z@.f1 _of
  0:;
  1: _if (gl36z <> (1)) _then _( putInsn( 'РА3' ); gl36z := (1) _);
  2: gl36z := 1;
  3: _if (gl36z <> (2)) _then _(  putInsn( 'РА' ); gl36z := (2) _);
  4: gl36z := 2
 _end; (* 4050 *)
 _if (l3a1z@.f2 = label) _then _(
 _if l3a1z@.f4 <> '0' _then L3721( l3a1z@.f4 ) _else _(
  TNL(l3v1z);
 align;
 write('10ПВУРЕГ=,');
 ГГ( l3v1z );
 ГГ( ':10СА-' );
 putInsn( l3v1z );
 _);
 _) _else _(
 _if (l3a1z@.f2 <> '00') _then  ГГ( l3a1z@.f2 );
 _if ((l3a1z@.f4b * [13..15]) <> []) _and
     ((l3a1z@.f4b * [0..12]) = []) _and
     ((l3a1z@.f4b * [13,14,15]) <> [13..15]) _and
     (l3a1z@.f3 <> 'СА') _and
     (l3a1z@.f3 <> 'ИА') _and
     (l3a1z@.f3 <> 'ИК') _then _(
    ГГ( 'ИА' );
    _if l3a1z@.f4 <> '0' _then (q) putInsn( l3a1z@.f4 );
   ГГ( l3a1z@.f3 );
 _) _else _(
   ГГ( l3a1z@.f3 );
 _if l3a1z@.f4<> '0' _then  ГГ( l3a1z@.f4 );
 _);
 putSep;
 _if (l3a1z@.f3 = 'ПВ') _or (l3a1z@.f3 = 'Э050') _then align;
 _); (* 4141 *)
_);
(* Level 3 *) _proced P4142(l3a1z:alfa; l3a2z:integer);
 _(
 _if gl71z _then exit;
 P3110( l3a1z, l3a2z );
 (*=a1 error messages *)
 ГГ( '***ОШ.' ); ГГ( l3a1z ); ГГ( '=' ); L3013( l3a2z );
 ГГ( ' СТР.=' ); L3013( lineNum ); ГГ( '.NLЕХ=' ); L3013( gl23z );
 ГГ( '.ИД=' ); ГГ( tok ); ГГ( '.СИМ=' ); ГГ( lastChar );
 writeln('.КОНТЕКСТ');
 code(16ПВСТХТ=,);
 errSeen := true;
 errcnt := (errcnt + (1));
 _if (errcnt > maxerr) _then (q) _GOTO 27721;
 _);(*=a0*)
(* Level 3 *) _proced error(l3a1z:alfa; l3a2z:integer);
 _(
 gl71z := false;
 P4142( l3a1z, l3a2z );
 _GOTO 27721;
_);

(* Level 3 *) _proced sysErr(n:integer);
 _(
 error( (*=a1*)'SУS'(*=a0*), n);
 _);
(* Level 3 *) _proced L4225(l3a1z:integer);
_var l3v1z:alfa; l3v2z:idptr; _(
 gl42z := '0';
 _case l3a1z _of
 1: _(  ГГ( 'ПБЕ' ); _if (l2v31z <> (0)) _then ГГ( 'F' ); _);
 0: _(
 l3v2z := l2a2z;
 align;
 _if (gl39z <> '1') _then _(
    mapai( gl39z, l3a1z );
   gl145z[l3a1z] := 'ИА';
 _);
 _if _not l2v19z  _then _( output@ := '*'; put(output) _);
 ГГ( l3v2z@.f9 );
 write(icolon);
 MAPЯГА( l3v2z@.f0, l3v1z);
 _if (l3v1z = l3v2z@.f9.a) _then _(
 write('10ПВУРЕГ=,10СА-');
 ГГ( l3v2z@.f9.a );
 write('(1)=14ПВСН,');
 _);
 _if (l3v2z@.f5.p = _NIL) _then l3a1z := (3) _else  l3a1z := (4);
 l3v1z := ;
 _if (l3v2z@.f10.i > (1)) _then _(
  mapia( -((l3a1z + l3v2z@.f10.i)), l3v1z );
  mapai( gl39z, l3a1z );
 _);

 _select (l3v2z@.f10.i = (0)): _(
 ГГ( '14ПВZ' );
 L3667( gl39z );
 _); (l3v2z@.f10.i = (1)): _(
 ГГ( '17ЗЧ' );
 ГГ( l3v1z );
 ГГ( '=14ПВZ' );
 ГГ( gl39z );
 write(icomma);
 _);
 true: _(
 write('ВМ13=17СА');
 ГГ( l3v1z );
 write(',РА3=17ПИ13,17ПИ');
 write( l3a1z:0 );
 write('=ВМ16,ВМ');
 write((l3a1z - (1)):0 );
 write('=13ЗЧ2,');
 _)
 _end;
 MAPЯГА( l3v2z@.f0, l3v1z);
 ГГ( '`' );
 ГГ( l3v1z );
 ГГ( '`17СА' );
 ГГ( l3v2z@.f8.a );
 gl36z := (1);
 _)
 end;
 putSep;
 _);
(* Level 3 *) _proced P4357(l3a1z:integer; l3a2z:alfa);
_label 4412, 4424, 4431;
_var l3v1z:word; _(
 _if modeX _then _(
 _select
 (l3a1z < (4)): _if (l3a1z <> (0)) _then ГГ( '10' );
 (l3a1z = 11) _or (l3a1z = 10) _or (l3a1z = (8)): putInsn( '10ИА' )
 _end
 _);
 _case l3a1z _of
0: _(
 align;
 ГГ( l3a2z );
 write(icolon);
 gl42z := l3a2z;
 exit;
_);
1: _(
 ГГ( 'ПБ' );
 4412:
 ГГ( l3a2z );
_);
 2: _(
  ГГ( 'У1' );
 _goto 4412;
 _);
3: _(
 ГГ( 'У0' );
 _goto 4412;
_);
4,5,6,7,9: error(in, l3a1z );
8: _(
 ГГ( '14ПВ' );
 4424:
 L3667( l3a2z );
exit; 
_);
10: _(
 ГГ( '12ПА' );
 _goto 4412;
_);
11: 4431: _(
 ГГ( '15ПА' );
 _goto 4412;
_);
12: _(
 ГГ( '16ПВ' );
 _goto 4424;
_);
13: _goto 4431;
14: _(
 ГГ( '15ПА-' ); ГГ( l3a2z ); putSep; TNL(l3v1z.a); L3721( l3v1z.a );
 write('12ИА=15СЧ'); ГГ( l3a2z ); write(',16ИА=15ЗЧ'); ГГ( l3a2z );
 write(icomma);
 _if modeX _then _(
 write('10ИА=15КЦ');
 ГГ( l3v1z.a );
 write(icomma);
 exit
 _) _else _(
 ГГ( '15КЦ' ); ГГ( l3v1z.a );
 _)
_)
_end;
 putSep;
_);
(* Level 3 *) _proced P4511(l3a1z:integer; l3a2z, l3a3z:alfa);
 _(
 _select
 (l3a1z = 5): _(
 align; L3636;
 ГГ( '15ПА' ); ГГ( l3a2z ); write('=ВИ15,СД'); ГГ( l3a3z );
 write('=13ЛС1,13ЗЧ1'); putSep;
 _);
 (l3a1z = 6): _(
 ГГ( '12ПА-' ); ГГ( l3a3z ); putSep; L3636;
 ГГ( '15ПА' ); ГГ( l3a2z ); putSep; L3667( '14ПВГТ' );
 _);
 true: _(
 ГГ( 'Э;' ); ГГ( l3a2z ); ГГ( icolon ); ГГ( l3a3z ); ГГ( ',К;' );
 _)
 _end
 _);
_proced P4646;
_var l3v1z:integer;
(* Level 4 *) _proced preDecl(l4a1z:alfa; _var l4a2z:idptr);
_var l4v1z:integer; l4v2z:idptr; _(
 new(l4v2z,9);
 (*=c-*)mapai(l4a1z _and '177', l4v1z);(*=c+*)
 l4v2z@ := [l4a1z, 0, idTable[l4v1z], _NIL, 0, 1, 0];
 idTable[l4v1z] := l4v2z; l4a2z := l4v2z;
 _);
(* Level 4 *) _proced P4605(l4a1z:alfa; l4a2z:integer);
_var l4v1z:idptr; _(
 preDecl( l4a1z, l4v1z );
 l4v1z@.f4.i := (1);
 l4v1z@.f5.id := curIdent;
 l4v1z@.f6.i := l4a2z;
 _);
(* Level 4 *) _proced declStandFun(l4a1z:alfa);
_var l4v1z:@struc; _(
 new(l4v1z, 6);
 (*=c-*)mapai(l4a1z _and '177', l3v1z );(*=c+*)
 l4v1z@ := [l4a1z, 0, idTable[l3v1z], , 3, curIdent];
 l4v1z@.f3.i := gl26z;
 gl26z := gl26z + 1;
 (*=c-*)idTable[l3v1z] := l4v1z;(*=c+*)
 _);

_( (* P4646 *)
gl4837z := 75B; gl4838z := 313B;
l3v1z := (0);
 _while l3v1z <= 127 _do _(
   idTable[l3v1z] := _NIL;
   idTabA[l3v1z] := _NIL;
   l3v1z := l3v1z + 1;
 _);
 modeA := 1;  modeB := ; lineNum := ; gl39z := ; modeC := ; leftInsn := ; gl62z := ; modeM := ;
 gl101z := ;
 modeR := ; modeP := ; modeT := ; gl36z := ;
 fname := spaces;
 gl35z := (0); modeE := ; gl33z := ; gl28z := ; gl53z := ; gl23z := ; gl106z := ;
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
 curIdent := ;
 gl77z := ;
 gl4633z := ;
 gl105z := ;
 errcnt := (0);
 maxerr := 10;
 gl43z := '11';
 pool[9].p := _NIL;
 pool[9 + 1].i := 0;
 pool[9 + 2].i := 1;
 poolIdx := 11;
 (*=a1*) seqGOST := 'А';
 MAPГA( seqGOST, seqITM );
 TNL(seqITM);
 l3v1z := 1;
 _while l3v1z <= 17 _do _(
   gl145z[l3v1z] := '000000';
    l3v1z := l3v1z + 1;
 _);
  (*=a0*)gl145z[15] := 'ИА';
 l3v1z := 3;
 _while (l3v1z <= (8)) _do _(
 l2v14z := (1);
 _while (l2v14z <= (l3v1z - (2))) _do _(
   gl91a[l3v1z][l2v14z] := '000000';
 l2v14z := (l2v14z + (1));
 _);
 l3v1z := (l3v1z + (1));
 _);
 (*=a1*)
 preDecl( 'ВООLЕА', boolType );
 preDecl( 'INТЕGЕ', intType );
 preDecl( 'СНАR',   charType );
 preDecl( '000000', setType );
 setType@ := [,,,intType,,,3];
 preDecl( 'RЕАL', realType );
 preDecl( '00АLFА', alfaType );
 preDecl( '0УКNIL', ptrType );
 ptrType@.f6.i := (2);
 curIdent := boolType;
 P4605( 'FАLSЕ', (258) );
 P4605( 'ТRUЕ', (259) );
 preDecl( 'ТЕХТ', textFile );
 textFile@.f3 := charType;
 textFile@.f6.i := (6);
 textFile@.f5.i := 36B;
 textFile@.f7.i := (8);
 preDecl( 'INРUТ', inFile );
 inFile@.f4.i := (2);
 inFile@.f5.id := textFile;
 inFile@.f6.i := (7);
 preDecl( 'ОUТРUТ', outFile );
 outFile@.f4.i := (2);
 outFile@.f5.id := textFile;
 outFile@.f6.i := (256);
 gl76z := intType;
 curIdent := _NIL;
 gl26z := (0);
 declStandFun( '000РUТ' );
 declStandFun( '000GЕТ' );
 declStandFun( 'RЕWRIТ' );
 declStandFun( '0RЕSЕТ' );
 declStandFun( '000NЕW' );
 declStandFun( '0UNРСК' );
 declStandFun( '000РСК' );
 declStandFun( '00ЕХIТ' );
 declStandFun( 'РRINТО' );
 declStandFun( '00НАLТ' );
 declStandFun( '0МАРIА' );
 declStandFun( '0МАРАI' );
 declStandFun( '000ТNL' );
 declStandFun( '0000ГГ' );
 declStandFun( '0МАРГА' );
 declStandFun( 'МАРЯГА' );
 declStandFun( '00СОDЕ' );
 declStandFun( '0SЕТUР' );
 declStandFun( 'RОLLUР' );
 declStandFun( '0WRIТЕ' );
 declStandFun( 'WRIТЕL' );
 declStandFun( 'DISРОS' );
 declStandFun( '00RЕАD' );
 declStandFun( 'RЕАDLN' );
 declStandFun( '0ОРЕND' );
 declStandFun( '00РUТD' );
 declStandFun( '00GЕТD' );
 declStandFun( '00DЕLD' );
 declStandFun( '00МОDD' );
 declStandFun( '00NЕWD' );
 declStandFun( '00ВIND' );
 declStandFun( '000INS' );
 gl26z := (0);
 curIdent := realType;
 declStandFun( '00SQRТ' );
 declStandFun( '000SIN' );
 declStandFun( '000СОS' );
 declStandFun( 'АRСТАN' );
 declStandFun( 'АRСSIN' );
 declStandFun( '0000LN' );
 declStandFun( '000ЕХР' );
 declStandFun( '000АВS' );
 curIdent := intType;
 declStandFun( '0ТRUNС' );
 curIdent := boolType;
 declStandFun( '000ОDD' );
 curIdent := intType;
 declStandFun( '000ОRD' );
 curIdent := charType;
 declStandFun( '000СНR' );
 declStandFun( '00SUСС' );
 declStandFun( '00РRЕD' );
 curIdent := boolType;
 declStandFun( '000ЕОF' );
 curIdent := ptrType;
 declStandFun( '000RЕF' );
 declStandFun( '000РТR' );
 curIdent := intType;
 declStandFun( '000SQR' );
 declStandFun( '0RОUND' );
 declStandFun( '000SЕL' );
 declStandFun( '00САRD' );
 declStandFun( '0МINЕL' );
 curIdent := boolType;
 declStandFun( '00ЕОLN' );
 declStandFun( '0SНIFТ' );
_);
(*=a0*)
(* Level 3 *) _function L5172(l3a1z:alfa):alfa;
_var dum:char; a:_array [1..12] _of char; i:integer;
_(
 unpck( a[1], l3a1z );
 l3a1z := spaces;
 unpck( a[7], l3a1z );
 i := 1;
 _while i <= 6 _do _(
 _if a[i] <> chr(0) _then _(
    pck(a[i], l3a1z);
    L5172 := l3a1z;
  exit;
 _);
 i := i + 1;
 _)
 _);
(* Level 3 *) _proced P5215(_var l3a1z:integer; _var l3a2z:integer);
 _( code(=15ПА15,ВИ15=СД/4/,MP=3ИК3,ЛС=); l3a2z := ;
 _);
(* Level 3 *) _proced putConst(_var offset:alfa; force:boolean);
_var l3v1z:integer; _(
 _if _not force _then _(
 poolStart := poolStart;
 code(=УИ5,);
 l3v1z := 9 - poolIdx;
 code(=УИ4,);
 curVal := curVal;
 code(ЗЧ1=,find:СЧ1=5CP,У0done=5CA1,4КЦfind=);
 _);
 poolIdx := poolIdx + 1;
 _if poolIdx >= 4096 _then sysErr(23);

 pool[poolIdx] := curVal;
 mapia( poolIdx, offset );
 exit; code(done:ВИ5=);
 l3v1z := ;
 l3v1z := (l3v1z - poolAddr);
 mapia( l3v1z, offset );
 _);
(* Level 3 *) _proced L5264(l3a1z:alfa);
_var dum:char; l3v1z: _array[1..11] _of char;
l3v13z, l3v14z:integer; l3v15z:word; _(
 unpck( l3v1z[6], l3a1z );
 l3v14z := (6);

 _while (l3v1z[l3v14z] = chr (0)) _do _(
 l3v14z := (l3v14z + (1));

 _);

 l3a1z := spaces;
 unpck( l3v1z[l3v14z-6], l3a1z );
 pck(l3v1z[6], l3v15z.a);
 curVal := l3v15z;
 putConst( gl41z, true );
 _);
(* Level 3 *) _proced L5312(l3a1z:alfa);
_var dum:char; l3v1z:_array [1..11] _of char; l3v13z, l3v14z:integer; l3v15z:word;  _(
 unpck( l3v1z[6], l3a1z );
 l3v14z := (6);
 _while (l3v1z[l3v14z] = chr(0)) _do _(
 l3v14z := (l3v14z + (1));
 _);
 l3a1z := spaces;
 unpck( l3v1z[l3v14z-6], l3a1z );
 pck(l3v1z[6], l3v15z.a);
 curVal := l3v15z;
 putConst( gl41z, false );
 _);
(* Level 3 *) _proced P5340(l3a1z: idptr; l3a2z:boolean);
_var l3v1z:alfa; l3v2z:alfa; l3v3z, l3v4z:alfa; _(
 _if (l3a1z@.f0 = '000000') _then _(
 _if (l3a2z) _then _(
 TNL(l3v1z);
 L3644;
 L3656( 'ПБ', l3v1z );
 align;
 _);
 TNL(l3v2z);
 L3721( l3v2z );
 L3651( 'ЗЧ1' );
 l3a1z@.f0 := l3v2z;
 curVal := l3a1z@.f7;
 putConst( l3v3z, false );
 curVal.i := l3a1z@.f8.i - curVal.i;
 putConst( l3v4z, false );
 L3644;
 L3656( 'АВ', l3v3z );
 putInsn( '15У1' );
 L3644;
 L3656( 'ОВ', l3v4z );
 putInsn( '15У1' );
 L3651( 'СЧ1' );
 L3667( '16ПБ' );
 _if (l3a2z) _then  L3721( l3v1z );
 _);
 _);
(* Level 3 *) _proced L5425(l3a1z:idptr);
_var l3v1z:idptr; _(
 _if (l3a1z@.f8.i = (0)) _then _(
 l3v1z := l3a1z@.f3;
 L5264( l3v1z@.f0 );
 l3a1z@.f8.a := gl41z;
 (loop) _(
 l3v1z := l3v1z@.f7.id;
 _if (l3v1z = _NIL) _then exit;
 L5264( l3v1z@.f0 );
 _goto loop _)
 _);
_);

(* Level 3 *) _proced getToken;
_label 6161, 6304, 6335, 6462;
_const max = 1000000000000;
_var l3v1z:_array [0..5] _of char; l3arr: _array [7..13] _of integer;
l3v14z, l3v15z:integer;
l3v16z:word;
l3v17z:idptr;
l3v18z:boolean;
l3v19z, l3v20z:real;
l3v21z:alfa;
l3a21z: _array [1..17] _of char;
l3arra: _array [39..41] _of integer;
l3v42z, l3v43z:integer;
(* Level 4 *) _proced P5446(l4a1z, l4a2z:char);
_var l4v1z:char; _(
 l4v1z := input@; get(input);
 _if (input@ = l4a1z) _then _(
     lastChar := l4a2z; get(input);
 _) _else  lastChar := l4v1z;
_);
(* Level 4 *) _proced L5462(l4a1z:integer);
 _( (*=a1*)
 P4142( 'SСАN', l4a1z );
 _if (l4a1z < (5)) _then _(
 _case l4a1z _of
 0:;
 1: gl26z := (1);
 2, 3, 4: _(
 _while (input@ <> '''') _do get(input);
 get(input);
 _GOTO 6462;
 _)
 _end
 _)
 _); (*=a0*)
(* Level 4 *) _proced L5512(l4a1z:integer);
 _(
 l4a1z := 001034T + l4a1z; code(4Э0703=,)
_);
_proced closeFile; _var l4v1z:@integer; _(
 lineNum := savedNum;
 l4v1z := ref(gl93z);
 code(=УИ11,11СЧ=ЗЧ75211,11СЧ1=ЗЧ75212,11СЧ2=ЗЧ74221,ЦC75211=17ЗЧ1,17Э0701=,11СЧ3=ЗЧ74220,11СЧ4=ЗЧ75225,ИК75225=СЧ,ЗЧ74217=СЧ74215,17ЗЧ1=CP74220,У1qne=СЧ75225,УИ15=15СЧ-1,ЛУ74330=);
 input@ := ;
 exit;
 code(qne:СЧ74217=СД/-10/,ЗЧ74217=MP,);
 input@ := ;
code(=17СЧ1,СД/1/=17ЗЧ1,CP74220=У1qne,);
_);
(* Level 4 *) _proced setFile(l4a1z, l4a2z:integer);
_var l4v1z:integer; _(
 l4v1z := 001034T;
 code(=4цс3,зч75211=4сч4,ав13=зч75212,)
 _);

(* Level 4 *)

 _proced openFile;
 _var l4v1z, l4v2z, l4v3z : integer; l4v4z: alfa;
_(
%gl93z                      : = C/1211;
%gl94z                      : = C/1212;
%gl95z                      : = C/0221;
%gl96z                      : = C/0220;
%gl97z                      : = C/1225;
code(=сч75211,1зч135=сч75212,1зч136=сч74221,1зч137=сч74220,1зч140=сч75225,1зч141=);
 savedNum := lineNum;
lineNum := 1;
 L5512( (270037C) );
 code(сч71776=СД/-36/,СД/36/=);
 l4v1z := ;
 L5512( l4v1z );
 code(11ПА70001=12ПА77600,L5601:11СЧ=);
 l4v4z :=;
 _if (l4v4z = fname) _then _(
 code(=11СЧ1,СД/30/=4ЗЧ4,MP=СД/30/,4ЗЧ5=);
 setFile(l4v2z + l4v1z, l4v3z );
 reset(input);
 exit;
 _);
 code(11CA2=12КЦL5601,);
 prepErr( (4) );
_);
 (* Level 4 *) _proced escChar;
_var l4v1z:integer; _(
 get(input);
 _if (input@ > chr(3)) _then  L5462( (2) );

 gl26z := ord(input@);
 l4v1z := (1);
 _while (l4v1z <= (2)) _do _(
   get(input);
  _if (input@ > chr(7)) _then _(
   L5462( (3) );        
    exit;
  _);
 (*=m-*)gl26z := ord(input@) + gl26z*8;
 l4v1z := (l4v1z + (1));
_);
 input@ := chr(gl26z);
 _);
 (* Level 4 *) _proced getId;
_var t:word; i:integer; _(
 t.a := '000000';
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
   _while (input@ = ' ') _or (input@ > chr(128)) _do get(input);
 _);
(* Level 4 *) _proced skipComment;
_label 5704;
_var l4v1z:char; _(
 5704:
 l4v1z := input@;
 _if (l4v1z = chr(172B)) _then prepErr( (3) );
 get(input);(*=a1*)
 _if (l4v1z = '*') _and (input@ = ')') _then _(
 get(input);
 exit
 _) _else _if (l4v1z = '(') _and (input@ = '*') _then _(
 get(input);
 skipComment;
 _) _else _if (l4v1z = endl) _then _(
 lineNum := lineNum + 1;
 gl23z := (0);
 _) _else _( _);
 _goto 5704
_);

(* Level 4 *)_proced doComment;
_var l4v1z:boolean;
(* Level 5 *) _proced P5733(_var l5a1z:integer; l5a2z:integer);
 _(
 get(input);
 l5a1z := 0;
 l4v1z := true;
 _if (input@ <= chr(9)) _then
 _while (input@ <= chr(9)) _do _(
 l5a1z := l5a1z * 10 + ord(input@);
 get(input);
 l4v1z := false;
 _);
 _if (l5a1z > l5a2z) _then  l4v1z := true;
_);
(* Level 5 *) _proced L5760(_var l5a1z:boolean);
 _(
 get(input);
 _if (input@ = '-') _or (input@ = '+') _then _(
 l5a1z := (input@ = '+');
 get(input);
 l4v1z := false;
 _)
_);

_( (* P5776 *)
get(input);
 _if (input@ = '=') _then _(
 _repeat
 get(input);
 l4v1z := true;
 _case input@ _of
 'L': L5760(modeL);
 'F': _( L5760(modeF); _if modeF _then  gl107z := (1); _);
 'P': L5760(modeP);
 'G': _( L5760(modeG); _if modeG _then  gl108z := (1); _);
 'T': L5760(modeT); 
 'V': _( L5760(modeV); _if modeV _then gl109z := true; _);
 'A': P5733(modeA, (1) );
 'S': _( L5760(modeS); _if modeS _then  gl109z := true; _);
 'C': L5760(modeC);
 'R': L5760(modeR);
 'M': L5760(modeM);
 'Ч': L5760(modeCH);
 'X': L5760(modeX);
 'B': P5733(modeB, 4);
 'K': P5733(modeK, 25);
 'Д': L5760(modeDe);
 'Л': L5760(modeeL);
 'I': L5760(modeI);
 'E': L5760(modeE)
 _end;
 _if l4v1z _then L5462(13);
 _until input@ <> ',';
 _);
 skipComment;
 _GOTO 6161;
_);
_( (* getToken *)
6161:
 skipSp;
 _if (input@ = '%') _then _(
 _while (input@ <> endl) _and (input@ <> chr(172B)) _do  get(input);
_) _else _if (input@ = '$') _then _(
 get(input);
 (a) _if  (input@ _in letter) _then _(
 getId;
 _if (tok = 'ЕND') _then _(
 skipping := false;
 _) _else _(
 l3v21z := tok;
 skipSp;
 _if _not (input@ _in letter) _then _exit a; _(
   getId;
   _select
  (l3v21z = 'DЕF'): _(
   skipping := false;
   gl45z := tok;
 _);
 (l3v21z = 'ВЕG'): _(
    skipping := tok <> gl45z;
    gl26z := lineNum;
 _); 
 (l3v21z = 'INС') _and _not skipping: _(
 _if inInclude _then  prepErr( (2) );
 fname :=   L5172( tok );
 openFile;
 inInclude := true;
 _);
 true:  _exit a
 _end
 _);
 _);
 _goto 6161;
 _);
 prepErr( (6) );
_) _else (block) _( (*6244*)
  _if (input@ = endl) _then _(
     lineNum := lineNum + 1;
     gl23z := 0;
     get (input);
   _) _else _( _if skipping _then _(
     _if (input@ = chr(172B)) _then  prepErr(1) _else _(
       _if (input@ = '''') _then _(
         get(input);
         _while (input@ <> '''') _and (input@ <> chr(172B)) _do get(input);
         _if (input@ = '''') _then  get(input);
       _) _else _(
          _if (input@ = '(') (*)*) _then _(
            get(input); _if (input@ = '*') _then skipComment;
          _) _else _(
            get(input);
            (q)_exit q;
          _)
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
 gl60z := false;
 (*=c-*)mapai( (tok _and '000177'), gl25z );(*=c+*)
_case gl53z _of
 0: _( (* 6315 *)
 curIdent := idTable[gl25z];
 _while (curIdent <> _NIL) _do _(
 _if (curIdent@.f1.a = gl39z) _then _(
 _if (curIdent@.f0 <> tok) _then_(
    curIdent := curIdent@.f2;
 _) _else _(
   gl60z := true;
   _goto 6462;
 _)
 _) _else _goto 6462;
 _);
_);
 1: 6335: _( (* 6335 *)
 curIdent := idTable[gl25z];
 _while (curIdent <> _NIL) _do _(
    _if (curIdent@.f0 <> tok) _then
       curIdent := curIdent@.f2
    _else _goto 6462;
 _);
_);
 2: _( (* 6350 *)
 _if (gl28z = (0)) _then _goto 6335;
 curIdent := idTabA[gl25z];
 gl27z := -1;
_while (curIdent <> _NIL) _do _(
 _if (curIdent@.f0 = tok) _then _(
 l3v16z := curIdent@.f7;
 l3v14z := gl28z;
 _while (l3v14z >= (1)) _do _(
 _if (gl422a[l3v14z][1] = l3v16z.a) _then _(
 tokKind := tkField;
 _if (l3v14z > gl27z) _then _(
 gl27z := l3v14z;
 l3v17z := curIdent;
 _);
 l3v14z := (0);
 _);
 l3v14z := (l3v14z - (1));
 _) _);
 curIdent := curIdent@.f2;
 _); (* 6402 *)
  _if gl27z = -1 _then _goto 6335 _else curIdent := l3v17z;
 _);
 3: _( (* 6407 *)
 curIdent := idTabA[gl25z];
 tokKind := tkField;
 _while (curIdent <> _NIL) _do _(
 _if (curIdent@.f0 <> tok) _then _(
 curIdent := curIdent@.f2;
 _) _else _if (gl77z = curIdent@.f7.id) _then
   _goto 6462
   _else curIdent := curIdent@.f2;
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
   _if (input@ = oparen) _then tok := 'ВЕGIN' _else tok := 'ЕND';
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
 l3v14z := 0;
 _repeat
  l3v14z := l3v14z + 1;
 _if l3v14z <= 17 _then l3a21z[l3v14z] := input@
 _else _( L5462( (0) );  l3v14z := (1); _);
 get(input);
 _until input@ > '9';
 gl26z := (0);
 _if (input@ = 'B') _or (input@ = 'C') _or (input@ = 'T') _then _(
 l3v15z := (1);
 _while (l3v15z <= l3v14z) _do _(
   _if (l3a21z[l3v15z] > '7') _then  L5462( 5 );
   l3v15z := l3v15z + 1;
 _); (* 6521 *)
 _if input@ = 'T' _then _(
 l3v15z := l3v14z;
 _while (l3v15z >= (1)) _do _(
   gl26z := gl26z; code(СД/3/=17ЗЧ,);
   gl26z := ord(l3a21z[l3v15z]);
   code(СД/3/=MP,17CP=);
   gl26z := ;
   l3v15z := l3v15z - 1;
 _)
 _) _else _( (* 6537 *)
  l3v15z := (1);
   _while (l3v15z <= l3v14z) _do _(
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
 l3v15z := (1);
 _while (l3v15z <= l3v14z) _do _(
 _if (gl26z <= max) _then _(
  gl26z := 10 * gl26z + ord(l3a21z[l3v15z]);
 _) _else _(
 L5462( (7) );
 gl26z := (0);
 _);
 l3v15z := (l3v15z + (1));
 _);
 l3v43z := (0);
_if (input@ = '.') _then _(
 get(input);
 _if (input@ = '.') _then _( input@ := ':'; _goto 6462; _);
 rval := gl26z;
 tokKind := tkReal;
 _if (input@ > '9') _then L5462( (8) ) _else _(
 _repeat
   rval := 10.0 * rval + ord(input@);
   l3v43z := l3v43z - 1;
   get(input);
 _until (input@ > '9');
 _)
 _); (* 6620 *)
 _if (input@ = 'E') _then _(
 _if (l3v43z = (0)) _then _( rval := gl26z; tokKind := tkReal; _);
   l3v18z := false;
   get(input);
   _case input@ _of
    '+': get(input);
    '-': _( l3v18z := true; get(input) _)
   _end;
   l3v42z := (0);
   _if (input@ > '9') _then  L5462( (9) ) _else _(
   _repeat 
   l3v42z := 10*l3v42z + ord(input@);
    get(input);
 _until (input@ > '9');
  _); (* 6655 *)
  _if l3v18z _then l3v43z := (l3v43z - l3v42z) _else l3v43z := (l3v43z + l3v42z);
 _); (* 6662 *)
 _if (l3v43z <> 0) _then _(
    l3v20z := 1.0;
    l3v18z := l3v43z < 0;
    l3v43z := abs(l3v43z);
    l3v19z := 10.0;
    _if (l3v43z > 18) _then _( l3v43z := (1); L5462( 10 ) _);
    _repeat 
     _if odd(l3v43z) _then l3v20z := l3v20z * l3v19z;
      l3v43z := l3v43z _div 2;
     _if (l3v43z <> (0)) _then l3v19z := l3v19z * l3v19z;
    _until (l3v43z = (0));
    _if l3v18z _then rval := rval / l3v20z _else rval := rval * l3v20z;
 _);
  _);
 _goto 6462;
 _); (* 6722 *)
 _if input@ = '''' _then _(
  _if _not gl58z _then _(
  tok := '000000';
  unpck(l3v1z[0], tok);
  l3v14z := (6);
  (loop) _(
   get(input);
   _if (input@ = chr(125B)) _then escChar _else _(
      _if (input@ = '''') _then _( get(input); _if (input@ <> '''') _then _exit loop; _);
      _if (modeA = 0) _then MAPГA( input@,  input@);
   _);
   _if (l3v14z = 12) _then _( L5462( (4) ); _exit loop _);
   l3v1z[l3v14z] := input@;
   l3v14z := (l3v14z + (1));
  _goto loop;
  _); (* 6755 *)
  pck(l3v1z[l3v14z-6], tok);
  _if (l3v14z > (7)) _then  tokKind := tkStr _else  tokKind := tkChar;
  _goto 6462;
  _) _else _( (* 6767 *)
     tokKind := tkStr;
     gl30z := (0);
    gl60z := false;
    l3v15z := (0);
    _while (l3v15z <= 250) _do _(
    l3v21z := '000000';
    unpck(l3v1z[0], l3v21z);
    l3v14z := (0);
    (* 7001 *) (oneword)_while l3v14z <= 5 _do _(
    get(input);
    _if (input@ = endl) _and modeCH _then _( get(input); lineNum := lineNum + 1; _);
    _if (input@ = chr(125B)) _then escChar _else _(
     _if (input@ = '''') _then _(
         get(input);
        _if (input@ <> '''') _then _(
       _if (l3v14z <> (0)) _then _( gl60z := true; _exit oneword _);
        _goto 6462;
      _);
 _) _else _(
     _if (input@ = endl) _then  lineNum := lineNum + 1;
     _if (modeA = (0)) _then  MAPГA( input@, input@ );
   _)
    _); (* 7033 *)
     l3v1z[l3v14z] := input@;
     gl30z := (gl30z + (1));
     l3v14z := (l3v14z + (1));
    _); (* 7040 *)
    pck(l3v1z[0], l3v21z);
    curVal.a := l3v21z;
    putConst(l3v21z, true);
    _if gl58z_then _(  gl58z := false; tok := l3v21z; _);
    _if gl60z _then _goto 6462;
    l3v15z := (l3v15z + (1));
    _);
    L5462(1);
    _);
 _); (* 7060 *)
 tokKind := tk0;
 _if (input@ = chr(253)) _then _(
    get(input); lastChar := chr(128);
    exit
  _); (* 7065 *)
  _if (input@ _IN ['.','(','<','>',':']) _then _(
  _case input@ _of
  ':': P5446( '=', chr(128) );
  '.': P5446('.', ':');
  '>': P5446( '=', chr(79) );
  '<': _(
     P5446( '=', chr(78) );
    _if (lastChar = '<') _and (input@ = '>') _then _(  get(input); lastChar := '#'; _);
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
     inInclude := false;
     _goto 6161;
    _) _else  prepErr( (0) );
  _) _else  lastChar := input@;
  get(input);
  _); (* 7142 *)
_);
(* Level 3 *) _function L7143(l3a1z:bitset):boolean;
_var l3v1z, l3v2z:boolean; l3v3z:integer; _(
 l3v1z := false;
 l3v3z := (0);
 _while (l3v3z <= (4)) _do _(
   _if (l3v3z _IN l3a1z) _then _case l3v3z _of
    0: l3v2z := ((tokKind = tk0) _and (lastChar = ';')) _or
    (((tok = then) _or (tok = else) _or (tok = until) _or (tok = end) _or (tok = do)) _and (tokKind = tkWord));
    1: l3v2z := ((tok=begin)_or(tok=functi)_or(tok=proced)_or(tok=type)_or(tok=const)_or(tok=label)_or(tok=var))_and(tokKind=tkWord);
    2: l3v2z := ((tok=begin)_or(tok=go)_or(tok=if)_or(tok=goto)_or(tok=with)_or(tok=while)_or(tok=repeat)_or(tok=for)_or(tok=select)_or(tok=back)_or(tok=branch))_and(tokKind=tkWord);
    3: l3v2z := (tokKind = tk0) _and (lastChar = ',');
    4: l3v2z := tokKind = tkIdent;
    5: l3v2z := (tokKind = tk0) _and (lastChar = ';')
   _end;
   l3v1z := l3v1z _or l3v2z;
   L7143 := l3v1z;
   _if l3v1z _then exit;
   l3v3z := (l3v3z + (1));
 _);
_);
(* Level 3 *) _proced L7305(l3a1z:bitset);
 _(
  _while (_not L7143( l3a1z) ) _do getToken;
 _);
 
(* Level 3 *) _function L7314(l3a1z:alfa):integer;
_var l3v1z:integer; _(
 _if (l3a1z = '000000') _then L7314 := (0) _else _(
    mapai( l3a1z, l3v1z);
    L7314 := pool[l3v1z].i;
 _)
_);
(* Level 3 *) _function typeCheck(l3a1z, l3a2z:idptr):boolean;
_label 7355;
_var l3v1z:@typchain; l3v2z, l3v3z:idptr;
(* Level 4 *) _proced L7325;
 _(
 new(l3v1z,9);
 l3v1z@ := [gl4634z, l3v2z, l3v3z];
 gl4634z := l3v1z;
 typeCheck :=   typeCheck( l3v2z, l3v3z );
 _);

_( (* typeCheck *)
(align) _if (_not modeC) _or (l3a1z = l3a2z)
_then _( 7355: typeCheck := true; exit _) _else
 _if (l3a1z@.f6.i = l3a2z@.f6.i) _then _case l3a1z@.f6.i _of
0: _(
    _if (((l3a1z = alfaType) _and (l3a2z = charType))
    _or ((l3a1z = charType) _and (l3a2z = alfaType)))
    _then _goto 7355;
_);
1:_if (l3a1z@.f7.i = l3a2z@.f7.i) _and (l3a1z@.f8.i = l3a2z@.f8.i)
  _and typeCheck( l3a1z@.f3, l3a2z@.f3)
  _then _goto 7355;
2: _(
 _if (l3a1z = ptrType) _or (l3a2z = ptrType) _then _goto 7355 _else _(
 l3v2z := l3a1z@.f3;
 l3v3z := l3a2z@.f3;
 _if (gl4634z <> _NIL) _then _(
 l3v1z := gl4634z;
 _while (l3v1z <> _NIL) _do _(
 _if (l3v1z@.f1 = l3v2z) _and (l3v1z@.f2 = l3v3z)
 _or (l3v1z@.f2 = l3v2z) _and (l3v1z@.f1 = l3v3z) _then _goto 7355
 _else l3v1z := l3v1z@.f0;
 _);
 L7325;
 _) _else _(
    setup(l3a1z);
    L7325;
    gl4634 := _NIL;
    rollup(l3a1z);
 _);
 exit; _)
_);
3: _goto 7355;
4: _if typeCheck(l3a1z@.f3, l3a2z@.f3) _and typeCheck(l3a1z@.f7.id, l3a2z@.f7.id)
   _then _goto 7355;
7: sysErr(2);
6:_if typeCheck(l3a1z@.f3, l3a2z@.f3) _and (l3a1z@.f7.i = l3a2z@.f7.i)
  _then _goto 7355;
5:
_end;
typeCheck := false
_);

(* Level 3 *) _proced P7520(_var l3a1z:idptr; _var l3a2z:alfa;  l3a3z:boolean);
_label 7531, 7567, 7570, 7601, 7666;
_var l3v1z:idptr; l3v2z:char; _(
  l3v1z := l3a1z;
 _case tokKind _of
tkWord: _(
 _if (tok <> 'NIL') _then _goto 7666;
 7531:
 l3a1z := ptrType;
 l3a2z := gl43z;
_);
tkIdent: _(
 _if (curIdent = _NIL) _then _goto 7666;
 _if (curIdent@.f4.i <> (1)) _or (curIdent@.f3 <> _NIL) _then _goto 7666;
 _if (curIdent@.f5.id@.f6.i <> 0) _then _(
     _if (curIdent@.f5.id = ptrType) _then _goto 7531 _else _goto 7666;
 _); (* 7554 *)
  l3a1z := curIdent@.f5.id;
  l3a2z := curIdent@.f6.a;
  curVal.i := L7314( l3a2z );
_);
tkField: _goto 7666;
tkStr: _( l3a1z := alfaType;
  7567: curVal.a := tok;
  7570: putConst( l3a2z, false );
  _);
tkInt: _(
  l3a1z := intType;
  curVal.i := gl26z;
  _goto 7570;
 _);
tkReal: _(
 l3a1z := realType;
 7601: curVal.r := rval;
 _goto 7570;
 _);
tkChar: _(  l3a1z := charType; _goto 7567 _);
tk0: _(
 _if _not l3a3z _then _goto 7666;
 _if (lastChar = '+') _or (lastChar = '-') _then l3v2z := lastChar _else _goto 7666;
 getToken;
 P7520( l3a1z, l3a2z, false );
 _if (l3a1z = _NIL) _then _goto 7666;
 _if (l3v2z = '-') _then _( 
   _if (l3a1z = intType) _then _( curVal.i := -gl26z; _goto 7570 _)
   _else _(
  _if (l3a1z = realType) _then _( rval := -rval; _goto 7601 _)
  _else _goto 7666;
 _)
 _); 
_)
_end;
 _if (l3v1z = _NIL) _or typeCheck( l3v1z, l3a1z)
 _then exit;
 7666: l3a1z := _NIL; (q)
_);
_proced parseType(l3a1z, l3a2z:integer; _var l3a3z:idptr; l3a4z:integer);
_label 10503, 10505, 10507, 10527, 11022, 11126;
(*=a1*)_const packed='PACKED';
_var baseType, curType, l3v3z :idptr;
isPacked:boolean;
l3v5z:alfa; l3v6z:word;  l3v7z, l3v8z: integer;
(* Level 4 *) _proced typeErr(l4a1z:integer);
 _(
 error( 'ТИП', l4a1z );
 _);
(* Level 4 *) _function bitWidth(l4a1z:idptr):integer;
_label 7703;
_var l4v1z:word; _(
 _if (l4a1z@.f5.i <> (1)) _then 7703: _(
 bitWidth := (0);
 _) _else _if (l4a1z@.f6.i = (1)) _then _(
 l4v1z := l4a1z@.f7;
 _if (l4v1z.i < (0)) _then _goto 7703;
 l4v1z := l4a1z@.f8;
 _if (l4v1z.i >= 48) _then _goto 7703;
 code(4СЧ5=BH,4ЗЧ5=,);
 bitWidth := ((49) - l4v1z.i);
 _) _else _if (l4a1z@.f6.i = (2)) _then  bitWidth := (15)
 _else  _if (l4a1z@.f6.i = (0)) _then _(
   _if (l4a1z = boolType) _then bitWidth := (1)
   _else _if (l4a1z = charType) _then bitWidth := (8)
   _else _goto 7703;
 _) _else
  _goto 7703;
 _);
(* Level 4 *) _proced doFields(_var l4a1z:integer; l4a2z, l4a3z:idptr);
_label  7776, 10065;
_var l4v1z, l4v2z: idptr; l4v3z: word;
l4v4z, l4v5z, l4v6z, l4id7z:idptr;
l4v8z:idptr;
l4v9z:word; l4v10z: integer;
l4v11z: alfa;
l4v12z: alfa;
l4v13z, l4v14z: boolean;
(* Level 5 *) _proced flistErr(l5a1z:integer);
_(
 error( 'FLISТ', l5a1z );
_);
_( (* doFields *)
 l4v13z := true;
 l4v1z := _NIL;
_repeat
 l4v8z := _NIL;
 gl53z := (3);
 getToken;
 _if (tokKind = tkField) _then _goto 7776 _else _goto 10065;
 _repeat
 gl53z := (3);
 getToken;
 _if (tokKind <> tkField) _then flistErr(0); (* no id *)
7776:
 _if (curIdent <> _NIL) _then flistErr(1); (* id already defined in this record *)
 new(l4v2z,9);
 l4v2z@ := [tok, gl39z, idTabA[gl25z], l4a3z, 4, _NIL, ,l4a2z];
 idTabA[gl25z] := l4v2z;
 _if (l4v13z) _then _(
   _if (l4a3z = _NIL) _then l4a2z@.f3 := l4v2z
   _else l4a3z@.f2 := l4v2z;
   l4v13z := false;
 _);
 _if (l4v8z = _NIL) _then  l4v8z := l4v2z
 _else l4v1z@.f5.id := l4v2z;
 l4v1z := l4v2z;
 getToken;
 _until lastChar <> ',';
 _if (lastChar <> ':') _then flistErr(2); (* need colon after a list of fields *)
 parseType( (1), (0), l4v3z.id, (0) );
 l4v9z := l4v3z.id@.f5;
 gl77z := l4a2z;
 _while (l4v8z <> _NIL) _do _(
 l4v8z@.f6 := l4v3z;
 l4v8z@.f8.i := l4a1z;
 l4a1z := l4a1z + l4v9z.i;
 l4v8z := l4v8z@.f5.id;
 _);
_until (lastChar <> ';');
exit;
 10065:
 _if (tokKind <> tkWord) _or (tok <> case) _then flistErr( (3) ); (* no case *)
 gl53z := (3);
 getToken;
 _if (tokKind <> tkField) _then  flistErr( (4) ); (* after case should be a field or a type *)
 l4v12z := tok;
 l4v10z := gl25z;
 l4id7z := curIdent;
 new(l4v2z,9);
 l4v2z@ := [tok, gl39z, , l4a3z, 5, _NIL, , l4a2z, l4a1z];
 _if (l4v13z) _then_(
  l4v13z := false;
  _if (l4a3z = _NIL) _then  l4a2z@.f3 := l4v2z
  _else l4a3z@.f2 := l4v2z;
 _) _else
  l4v2z@.f5.id := l4v2z;
 getToken;
 _if (lastChar = ':') _then _(
  _if (l4id7z <> _NIL) _then flistErr(11); (* selector id already used *)
  l4v2z@.f2 := idTabA[l4v10z];
  idTabA[l4v10z] := l4v2z;
  parseType( (2), (0), l4v3z.id, (0) );
  l4v10z := 1;
 _) _else _(
  l4id7z := idTable[l4v10z];
  l4v10z := (0);
  _while (l4id7z <> _NIL) _do _(
   _if (l4id7z@.f0 <> l4v12z) _then l4id7z := l4id7z@.f2
   _else _(
    _if (l4id7z@.f4.i <> (0)) _then flistErr(12) (* no type id *)
    _else _(
     _if (l4id7z@.f6.i = (7)) _then l4id7z := l4id7z@.f3;
     _if (l4id7z@.f6.i <> (0)) _then flistErr(13); (* must be a discrete type *)
    _);
    l4v3z.id := l4id7z;
    l4id7z := _NIL;
    l4v12z := '000000';
   _)
  _); (* 10202 *)
  _if (l4v12z <> '000000') _then _( flistErr(14); l4v3z.id := ptrType _)
 _); (* 10206 *)
 l4v2z@.f6 := l4v3z;
 l4a1z := (l4a1z + l4v10z);
 _if (tokKind <> tkWord) _or (tok <> of) _then flistErr( (6) ); (* need "of" *)
 l4v1z := _NIL;
 l4v10z := l4a1z;
 _repeat
  l4v6z := _NIL;
  l4v9z.i := l4v10z;
  getToken;
  _repeat
   l4v4z := l4v3z.id;
   P7520(l4v4z, l4v11z, false );
   _if (l4v4z = _NIL) _then flistErr(-1); (* bad or missing selector value *)
   new(l4v5z, 7);
   l4v5z@ := [0, l4v11z, _NIL, , 6, _NIL];
   _if (l4v6z = _NIL)
   _then l4v5z@.f3 := l4v2z
   _else l4v5z@.f3 := l4v6z;
   l4v6z := l4v5z;
   l4v4z := l4v1z;
   (loop) _while (l4v4z <> _NIL) _do _(
    l4v12z := l4v4z@.f1.a;
    _if (l4v11z > l4v12z) _then _(
     l4v5z@.f5.id := l4v4z;
     _exit loop
    _) _else _(
     _if (l4v11z < l4v12z) _then _(
      l4id7z := l4v4z;
      l4v4z := l4v4z@.f5.id;
     _) _else flistErr( (8) ); (* repeated selector value *)
    _)
   _);  (*10276 *)
   _if (l4v1z = l4v4z)
   _then l4v1z := l4v5z
   _else l4id7z@.f5.id := l4v5z;
   getToken;
   _if (lastChar <> '00000,') _and (lastChar <> ':') _then flistErr( (7) ); (* need comma or colon *)
   l4v14z := lastChar = ':';
   getToken;

  _until l4v14z;
  _if lastChar <> '(' _then flistErr( 10 ); (* need open paren *)
  doFields(l4v9z.i, l4a2z, l4v6z );
  _if (lastChar <> ')') _then flistErr( (9) ); (* need close paren *)
  _if (l4v9z.i > l4a1z) _then  l4a1z := l4v9z.i;

  _while (l4v6z <> l4v2z) _do _(
   l4v6z@.f6 := l4v9z;
   l4v6z := l4v6z@.f3;
  _);

  getToken;
 _until lastChar <> ';';
 l4v2z@.f5.id := l4v1z;
_);

_( (* parseType *)
 getToken;
 isPacked := false;
 _case tokKind _of
tk0: _( (* 10360 *)
 _if (lastChar = oparen) _then _(
 baseType := _NIL;
 new(curType, 9);
 curType@ := [l3a2z, , , , 0, 1, 0];
 _if (l3a2z <> (0)) _then _(
   curType@ := [, gl39z, idTable[l3a4z] ];
   idTable[l3a4z] := curType;
 _); (* 10402 *)
 l3v7z := (0);
 l3a3z := curType;
 _repeat
 gl53z := (0);
 getToken;
 _if (tokKind <> tkIdent) _then typeErr( (1) );
 _if gl60z _then  typeErr( (2) );
 new(l3v3z, 8);
 curVal.i := l3v7z;
 putConst(l3v5z, false);
 l3v3z@ := [ tok, gl39z, idTable[gl25z], _NIL, (1), curType, l3v5z];
 idTable[gl25z] := l3v3z;
 l3v7z := l3v7z + 1;
 _if (baseType = _NIL) _then curType@.f3 := l3v3z _else  baseType@.f7.id := l3v3z;
 baseType := l3v3z;
 getToken;
 _until lastChar <> ',';
 _if (lastChar <> cparen) _then typeErr( (4) );
 l3v3z@.f7.s := _NIL;
 curType@.f7.i := l3v7z;
 curType@.f8.i := (0);
_) _else _( (* 10460 *)
_if (lastChar = '@') _then _(
 parseType( (1), (0), baseType, (0) );
 new(l3a3z, 7);
 l3a3z@ := [l3a2z, gl39z, , baseType, 0, 1, 2];
 _goto 11126;
_); _goto 10527;
_); 10503: getToken; exit;
  10505:
  getToken;
  10507: l3a3z := curType;
  _if l3a2z = 0 _then _( exit; _goto 10527 _);
  new(l3v3z, 7);
  l3v3z@ := [l3a2z, gl39z, idTable[l3a4z], curType, 0, , 7];
  idTable[l3a4z] := l3v3z;
  exit;
10527:
   baseType := _NIL;
   P7520(baseType, l3v5z, true );
   _if (baseType = _NIL) _then typeErr(13);
   l3v7z := curVal.i;
   getToken;
   _if (lastChar <> ':') _then typeErr(14);
   getToken;
   P7520(baseType, l3v6z.a, true );
   _if (baseType = _NIL) _then  typeErr( (15) );
   l3v8z := curVal.i;
   _if (baseType <> intType) _and (baseType <> charType) _and (baseType@.f3 = _NIL)
   _or (baseType@.f6.i <> (0)) _then typeErr( (16) );
   new(curType, 9);
   curType@ := [0, gl39z, _NIL, baseType, 0, 1, 1, l3v7z, l3v8z];
   _if (modeT) _then  P5340( curType, false);
   _goto 10505
_);
tkIdent: _( (* 10613 *)
 _if (curIdent = _NIL) _then _(
  _if gl57z  _and (l3a2z = (0)) _then _(
   new(l3a3z, 7);
   gl54z := gl54z + 1;
   l3a3z@ := [tok, gl39z, idTable[gl25z], _NIL, 0, 1, 2];
   idTable[gl25z] := l3a3z;
   _goto 10503;
  _) _else typeErr( 19 );
 _);
 _if (curIdent@.f4.i <> (0)) _then _goto 10527;
 _if (curIdent@.f6.i = (7)) _then curIdent := curIdent@.f3;
 _if (l3a1z = (1)) _and (curIdent@.f6.i = (6)) _then  typeErr( (20) );
 _if (l3a1z = (2)) _and (curIdent@.f6.i <> (0)) _and (curIdent@.f6.i <> (1))
 _then typeErr(21 );
 curType := curIdent;
 _goto 10505;
 _);
tkWord: _( (* 10666 *)
 _if (l3a1z = (2)) _then typeErr( 22 );
 _if (tok = packed) _then _(
   isPacked := true;
   getToken;
   _if (tokKind <> tkWord) _then typeErr( (40) );
 _);
 _if (tok = record) _then _(
 new(baseType, 7);
 l3v7z := (0);
 baseType@ := [ l3a2z, , , , (0), , (5)];
 baseType@ := [, gl39z, idTable[l3a4z] ];
 idTable[l3a4z] := baseType;
 gl77z := baseType;
 doFields(l3v7z, baseType, _NIL );
 _if (tokKind <> tkWord) _or (tok <> end) _then  typeErr( 23 );
 baseType@.f5.i := l3v7z;
 l3a3z := baseType;
 _goto 10503;
 _);
 _if (tok = array) _then _(
  getToken;
  _if (lastChar <> '[') _then typeErr( 24 );
  curType := _NIL;
  _repeat
  parseType(2, 0, baseType, 0);
  new(l3v3z, 9);
  l3v3z@ := [l3a2z, , curType, , 0, , 4, baseType];
  _if (curType = _NIL) _then_(
   l3a3z := l3v3z;
   _if (l3a2z <> (0)) _then _(
    l3v3z@ := [, gl39z, idTable[l3a4z] ];
    idTable[l3a4z] := l3v3z;
   _)
 _) _else curType@.f3 := l3v3z;
 curType := l3v3z;
 _until (lastChar <> ',');
 _if (lastChar <> ']') _then typeErr(25);
 getToken;
 _if (tokKind <> tkWord) _or (tok <> of) _then typeErr(26);
 parseType( (1), (0), baseType, (0) );
 l3v3z@.f3 := baseType;
 l3v7z := baseType@.f5.i;
 _goto 11022;
 _repeat
 curType := curType@.f2;
 11022:
 l3v3z := curType@.f7.id;
 _if l3v3z@.f6.i = 1
 _then l3v8z := l3v3z@.f8.i - l3v3z@.f7.i + 1
 _else  typeErr( (28) );
 _if l3v7z = 1 _then curType@.f8.i := (0)
 _else _(
   l3v6z.i := l3v7z;
 P5215( l3v6z.i, curVal.i );
 putConst( l3v6z.a, false );
 curType@.f8 := l3v6z;
 _);
 (*=m+*)
 l3v7z := (l3v7z * l3v8z);
 curType@.f5.i := l3v7z;
 _until (curType = l3a3z);
 exit
 _); (* 11060 *)
 _if (tok = file) _then _(
  getToken;
 _if (tokKind <> tkWord) _or (tok <> of) _then typeErr(29);
 parseType( (1), (0), baseType, (0) );
 l3v8z := 22;
 _if (isPacked ) _then  l3v7z :=   bitWidth( baseType ) _else  l3v7z := (0);
 _if (l3v7z <> (0)) _and (l3v7z <= 24) _then 
 l3v8z := (trunc(48 / l3v7z)) + l3v8z
 _else l3v7z := (0);
 new(l3a3z, 8);
 l3a3z@ := [0, , , baseType, 0, l3v8z, 6, l3v7z];
 11126:
 _if (l3a2z <> (0)) _then _(
 l3a3z@ := [l3a2z, gl39z, idTable[l3a4z]];
 idTable[l3a4z] := l3a3z;
 _);
 exit
_); (* 11140 *)
_if (tok = set) _then _(
 getToken;
 _if (tok <> of) _then  typeErr(-1);
  parseType( (2), (0), baseType, (0) );
 _if ((baseType@.f6.i <> (1)) _or (baseType@.f7.i < (0)) _or (baseType@.f8.i > (47))) _and
  (((baseType@.f1.i <> (0)) _or _not typeCheck( baseType, boolType)) _and
  ((baseType@.f1.i = (0)) _or (baseType@.f7.i > (47))) _or (baseType@.f6.i <> (0))) _then 
    P4142( 'ТИП', (0) );
  curType := setType;
 _goto 10507;
 _);
  typeErr( (33) );
 _);
  tkInt, tkStr, tkReal, tkChar: _goto 10527;
  tkField: sysErr(3)
 _end;
 sysErr(4);
_);
(* Level 3 *) _proced P11224(_var l3a1z:idptr; _var l3a2z:alfa);
_label 11266;
_var l3v1z, l3v2z:idptr; 
  l3v3z:idptr;
  l3v4z, l3v5z:integer; l3v6z:boolean; l3v7z:integer; _(
 l3a1z@.f7.s := _NIL;
 _repeat
 l3v3z := _NIL;
 gl53z := (0);
 l3v5z := (0);
 getToken;
 _if (tokKind = tkIdent) _then _goto 11266;
 _if (tokKind <> tkWord) _then P4142( 'ФОРПАР', (0) );
 _if (tok = var) _then l3v5z := (1)
 _else _if (tok = functi) _then l3v5z := (2)
 _else _if (tok <> 'РRОСЕD') _then P4142( 'ФОРПАР', (1) )
 _else l3v5z := (3);
 _repeat 
 gl53z := (0);
 getToken;
 11266:
 l3a1z@.f10.i := l3a1z@.f10.i + 1;
 _if (tokKind <> tkIdent) _or gl60z _then P4142( 'ФОРПАР', (2) );
 _case l3v5z _of
 0: _( new(l3v1z, 8); l3v1z@.f4.i := 1; _);
 1: _( new(l3v1z, 8); l3v1z@.f4.i := 2; _);
 2,3: _( new(l3v1z, 13); l3v1z@.f4.i := 3; _)
 _end;
 l3v1z@ := [tok, gl39z, idTable[gl25z] ];
 idTable[gl25z] := l3v1z;
 _if (l3a1z@.f7.id = _NIL) _then l3a1z@.f7.id := l3v1z
 _else l3v2z@.f3 := l3v1z;
 l3v2z := l3v1z;
 _if (l3v3z = _NIL) _then l3v3z := l3v1z;
 getToken;
_until (lastChar <> ',');
 l3v4z := (1);
 _if (l3v5z = (3)) _then l3v1z := _NIL
 _else _(
 _if (lastChar <> ':') _then P4142( 'ФОРПАР', (3) );
 parseType( (0), (0), l3v1z, (0) );
 l3v7z := l3v1z@.f6.i;
 _if (l3v5z = (0)) _then l3v4z := l3v1z@.f5.i;
 _if ((l3v5z = (0)) _and (l3v4z <> (1)))
 _or ((l3v5z = (2)) _and (l3v7z > (3))) _then P4142( 'ФОРПАР', (4) );
 _); (* 11404 *)
 _repeat
 _if (l3v5z < (2)) _then _(
  l3v3z@.f5.id := l3v1z;
  l3v3z@.f6.a := l3a2z;
  _if modeV _and (l3v7z < 4) _then  l3v3z@.f7.i := (1)
  _else l3v3z@.f7.i := (0);
 _) _else _(
  l3v3z@.f5.id := l3v1z;
  l3v3z@.f8.a := l3a2z;
 _);
 P3606( l3a2z, l3v4z );
 l3v6z := l3v2z = l3v3z;
 l3v3z := l3v3z@.f3;
 _until l3v6z;
 _until lastChar <> ';';
 _if (lastChar <> ')') _then P4142( 'ФОРПАР', (5) );
 getToken;
 l3v2z@.f3 := l3a1z;
_);
   (* Level 3 *) _proced P11450(l3a1z:pstr; l3a2z:integer; l3a3z:alfa);
_var l3v1z:pstr; _(
 l3v1z := l3a1z;
 _while (l3v1z <> _NIL) _do _(
 _if (l3v1z@.f4.i = l3a2z) _then l3v1z@.f4.a := l3a3z;
 l3v1z := l3v1z@.f0.s;
 _)
_);
(* Level 3 *) _proced mkInst(_var l3a1z:pInst);
 _(
 new(l3a1z);
 _if (l3a1z = _NIL) _then sysErr( (0) );
_);
(* Level 3 *) _proced P11512(l3a1z:integer; _var l3a2z:six);
_label 11523, 11525, 11631, 11703, 11735;
_var l3v1z, l3v2z:pInst; l3v3z:alfa; 
(* Level 4 *) _proced L11477;
 _(
 mkInst(l3v2z);
 l3v2z@ := [ l3a2z.f4, gl35z ];
 l3a2z.f4.pi := l3v2z;
 _);
_( (* P11512 *) (*=a0*)
(a) L11477;
_case l3a1z _of
0: _( l3v2z@.f4 := '12';
11523: l3v2z@.f3 := gl37z;
11525: l3v2z@.f2 := gl44z;
_);
1: _(l3v2z@.f4 := '13'; _goto 11523 _);
2: _(l3v2z@.f4 := '13'; l3v2z@.f1 := 1; l3v2z@.f3 := 'СР'; _goto 11525 _); (* ineff *)
3: _(
 l3v2z@ := [, , l3a2z.f2, gl37z, l3a2z.f1];
 l3a2z.f0.i := (3);
 _if (l3a2z.f2.i = (0))
 _and (l3a2z.f1.i <> (0)) 
 _and (l3v2z@.f0@.f3 <> 'ИА') 
 _and (l3v2z@.f0@.f3 <> 'ИК') _then l3v2z@.f2 := gl44z;
_);
4: _(
 l3v2z@.f4 := 'ТR';
 l3v2z@.f1 := (2);
 _goto 11703;
_);
5: _(
l3v2z@ := [, 1, gl44z, 'АУ', gl41z];
 P11512( (17), l3a2z );
_);
6: l3v2z@ := [, 1, 0, 'ИЗ', 'ЧМ1'];
7: l3v2z@ := [, , l3a2z.f2, 'АВ', l3a2z.f1];
8: l3v2z@ := [, , 0, gl37z, 0];
9, 14: sysErr( (5) );
10: l3v2z@ := [, , '17', gl37z, l3a2z.f1];
11: 11631: _( l3v2z@ := [, , '15', 'ПА', 0]; L11477; l3v2z@ := [, , 0, 'ВИ', '15'] _);
12: _( l3v2z@ := [, , l3a2z.f2, 'ИА', l3a2z.f1]; L11477; l3v2z@ := [, , '15', 'ПА', 0] _);
13: l3v2z@ := [, , '11', 'ПА', 0];
15: l3v2z@ := [, 2, 0, 'РА', '23'];
16: _( l3v2z@.f3 := 'ЛС'; l3v2z@.f4 := 'Z64'; l3v2z@.f2 := '0'_); (* inefficient *)
17: _if modeM _then _(
   l3v2z@ := [, 1, , , 'ЦУ'];
   11703:
   l3v2z@ := [, , '16', 'ПВ'];
 _) _else l3v2z@ := [, , 0, 'МР', '30'];
18: _(   l3v2z@ := [, 4, , , 'R']; _goto 11703 _);
19: l3v2z@ := [, , '17', 'ЗЧ', 0];
20: l3v2z@ := [, , gl44z, 'ЛУ', '13'];
21: _( l3v3z := 'АС';
11735:
l3v2z@ := [, 1, 0, l3v3z, '13'] _);
22: _( l3v3z := 'АВ'; _goto 11735; _);
23: _(
 _if (l3a2z.f2.i <> (0)) 
 _or (l3a2z.f1.i <> (0)) _then _(
 l3v2z@ := [, , l3a2z.f2, 'ИА', l3a2z.f1];
 L11477;
 _) _else _if (l3a2z.f4.s@.f0.s <> _NIL) _and (l3a2z.f4.s@.f0.s@.f3.a = 'ИК') _then_(
 l3v1z := l3a2z.f4.pi;
 l3a2z.f4.pi := l3v1z@.f0;
 l3a2z.f4.s@.f3.a := gl37z;
 l3a2z.f0.i := (3);
 l3v1z := l3a2z.f4.pi;
 _if (l3v1z@.f2 = '17') _and (l3v1z@.f4 = '0') _then _(
   l3v1z := l3v1z@.f0;
   _if (l3v1z@.f2 = '17') _and (l3v1z@.f4 = '0') _and (l3v1z@.f3 = 'ЗЧ') _then
    l3a2z.f4.pi := l3v1z@.f0;
 _);
 exit
 _);
 _goto 11631
_);
24: _(
 l3v2z@ := [, (2), l3a2z.f3.s@.f1, 'ИА', l3a2z.f3.s@.f8];
 L11477;
 l3v2z@ := [, , '12', 'ПА', 0];
 L11477;
 l3v2z@ := [, , '16', 'ПВ', 'ВП7'];
_);
25:l3v2z@ := [, , gl39z, 'ИК', l2v11z];
26:l3v2z@ := [, , 0, 0, 0];
27: _( l3v2z@.f3 := 'СМ'; putConst( l3v2z@.f4, false); l3v2z@.f2 := gl44z _);
28: l3v2z@:= [, , gl44z, 'ЛУ', gl41z]
_end; (* 12127 *)
_);
(* Level 3 *) _proced P12143(l3a1z:integer; _var l3a2z:six; l3a3z:alfa);
_label 12164, 12166, 12205, 12211, 12240, 12242, 12355;
_var l3v1z:pInst; l3v2z:alfa; l3v3z, l3v4z:integer; 
(* Level 4 *) _proced L12130;
 _(
 mkInst(l3v1z);
 l3v1z@ := [l3a2z.f4, 0];
 l3a2z.f4.pi := l3v1z;
 _);
_( (* P12143 *)
 _if (l3a1z > 23) _then sysErr(4);
 _if (l3a1z <> 12) _then L12130;
 _case l3a1z _of
 0:l3v1z@ := [, , label, , l3a3z];
 1: _(
  l3v1z@.f3 := 'ПБ';
12164:
 l3v1z@.f2 := gl44z;
12166:
 l3v1z@.f4 := l3a3z;
 _);
 2:_( l3v1z@.f3 := 'У1'; _goto 12164 _);
 3:_( l3v1z@.f3 := 'У0'; _goto 12164 _);
 4: l3v1z@ := [, gl35z, l3a2z.f2, l3a3z, l3a2z.f1];
 7: 12205: _( l3v1z@.f2 := '15'; l3v1z@.f3 := 'ПА'; _goto 12166 _);
 5: 12211: _( _if (modeX) _then _( l3v1z@.f2 := '10'; l3v1z@.f3 := 'ИА'; l3v1z@.f4 := '0'; L12130; _); (*ineff*)
 _if l3a1z = 8 _then _goto 12205 _else _goto 12240;
 _);
 6, 13, 18, 21: sysErr(l3a1z);
 8: _goto 12211;
 9: l3v1z@ := [, ,  '17', l3a3z, 0];
 10: _( l3v1z@.f2 := '17'; l3v1z@.f3 := 'ЗЧ'; _goto 12166 _);
 11: 12240: _( l3v1z@.f2 := '16'; 12242: l3v1z@.f3 := 'ПВ'; _goto 12166 _);
 12: _(
 _if (gl39z = l3a3z) _then exit
 _else _(
 mapai( gl39z, l3v3z);
 mapai( l3a3z, l3v4z);
 L12130;
 _if l3v4z + 1 = l3v3z _then l3v1z@ := [, , '13', 'ПИ', gl39z]
  _else _(
   l3a3z := gl91a[l3v3z][l3v4z];
   _if (l3a3z = '000000') _then _(
    TNL(l3a3z);
    gl91a[l3v3z][l3v4z] := l3a3z;
   _);
   _goto 12211;
  _)
 _); (* 12276 *)
 _);
 14: _( l3v1z@.f2 := '11'; l3v1z@.f3 := 'ЗЧ'; _goto 12166 _);
 15: _( l3v1z@.f2 := '14'; _goto 12242 _);
 16: _(
  l3v1z@ := [, , l3a2z.f2, 'ИА', l3a2z.f1];
  L12130;
 l3v1z@ := [, , l3a3z, 'ПА', 0];
 L3732( l3a2z.f4.pi );
 _);
 17:_( l3v1z@.f3 := 'СР'; l3v1z@.f2 := '0'; _goto 12166; _);
 19: l3v1z@ := [, , (0), 'Э050', l3a3z];
 20:l3v1z@ := [, , '17', 'СА', l3a3z];
 22: _(
  l3v1z@ := [, (1), '15', 'ПА', 'ОV'];
   L12130;
   mapia( lineNum, l3v2z );
   l3v1z@ := [, , '14', 'ПА', l3v2z];
 12355: L12130;
 _goto 12211;
 _);
 23: _(
 l3v1z@ := [, , l3a2z.f2, gl37z, l3a2z.f1];
 l3a2z.f0.i := (3);
 _goto 12355
 _)
 _end; (* 12421 *)
_);
(* Level 3 *) _proced P12422(l3a1z, l3a2z:alfa; l3a3z: char; _var l3a4z:six);
_var l3v1z:pInst; l3v2z:alfa; _(
 mkInst(l3v1z);
 mapia( l3a3z, l3v2z);
 l3v1z@ := [ l3a4z.f4, 0, l3a1z, l3a2z, l3v2z];
 l3a4z.f4.pi := l3v1z;
_);
(* Level 3 *) _proced L12445(_var l3a1z:six);
_var l3v1z:integer; _(
 l3v1z := 23;
 _if (l3a1z.f3.s@.f6.i = (6)) _then _(
 _if (l3a1z.f5.i = (1)) _then  l3v1z := (3)
 _else _if (l3a1z.f2.i = (0)) _then _(
 _if (l3a1z.f1.i = (7)) _then l3v1z := (0)
 _else _if (l3a1z.f1.i = (256)) _then _(
   l3v1z := (3);
   l3a1z.f2.i := (0);
   l3a1z.f1.a := 'Z64';
 _)
 _)
 _);
  P11512( l3v1z, l3a1z );
 _);
(* Level 3 *) _proced L12475(_var l3a1z:six);
 _(
 _if (l3a1z.f0.i = (2)) _then _(
   putInsn( '17ЗЧ' );
   P12143( (16), l3a1z, '15' );
   putInsn( '17СЧ' ); putInsn( '15ЗЧ' );
   exit
 _);
 P12143( (4), l3a1z, 'ЗЧ' );
 L3732( l3a1z.f4.pi );
 _);
(* Level 3 *) _proced L12520(_var l3a1z:six);
_label 12556, 12557;
_var l3v1z, l3v2z:alfa;  l3v3z:integer; _(
 _if (l3a1z.f3.id = boolType) _then _case l3a1z.f0.i _of
 0: _if l3a1z.f5.i = 0 _then P11512(0, l3a1z) _else P11512(1, l3a1z);
 1: _(  P11512(3, l3a1z); _if l3a1z.f5.i <> 0 _then P11512(2, l3a1z) _);
 2:  _if (l3a1z.f1.a <> label) _then _(
   TNL(l3v1z);
   P12143( ((3) - l3a1z.f5.i), l3a1z, l3v1z );
   12556: l3v3z := (1);
   12557: TNL(l3v2z);
   P11512( l3v3z, l3a1z );
   P12143( (1), l3a1z, l3v2z );
   P12143( (0), l3a1z, l3v1z );
   P11512( ((1) - l3v3z), l3a1z );
   P12143( (0), l3a1z, l3v2z );
  _) _else _if l3a1z.f5.i <> 0 _then P11512(2, l3a1z );
 3: _(
  l3v1z := l3a1z.f1.a;
 _if (l3a1z.f5.i = (0)) _then _goto 12556
 ;(*_else*) (q) _(  l3v3z := (0); _goto 12557 _)
 _)
 _end _else _( (* 12624 *)
   _if (l3a1z.f0.i <> (3)) _then _( 
    P11512( (3), l3a1z );
    l3a1z.f0.i := (3);
    exit
   _)
  _);
 l3a1z.f0.i := 3
 _);
(* Level 3 *) _proced L12635(_var l3a1z:six);
 _(
 L12520( l3a1z );
 L3732( l3a1z.f4.pi );
 _);
(* Level 3 *) _proced P12643(l3a1z:pinst; _var l3a2z:pinst);
_var l3v1z:pinst; _(
 _if (l3a2z = _NIL) _then l3a2z := l3a1z
 _else _(
  l3v1z := l3a2z;
  _while (l3v1z@.f0 <> _NIL) _do  l3v1z := l3v1z@.f0;
   l3v1z@.f0 := l3a1z;
 _)
_);
(* Level 3 *) _proced P12665(_var l3a1z, l3a2z:six);
 _(
 P12643( l3a1z.f4.pi, l3a2z.f4.pi );
_);
(* Level 3 *) _function F12677(l3a1z, l3a2z:idptr):boolean;
 _(
 F12677 := (l3a1z@.f6.i = 3) _and (l3a2z@.f6.i = 3);
_);
(* Level 3 *) _proced P12713(_var l3a1z, l3a2z: six; l3a3z:alfa);
 _(
 L12520( l3a1z );
 P11512( 19, l3a1z );
 L12520( l3a2z );
 P12143( (15), l3a2z, l3a3z );
 P12643( l3a1z.f4.pi, l3a2z.f4.pi );
 l3a1z.f4 := l3a2z.f4;
 _);
(* Level 3 *) _proced P12741(l3a1z:alfa; l3a2z:boolean; _var l3a3z, l3a4z:six; l3a5z:integer);
_label 12747, 12752, 12775, 13013, 13045;
 _(
 _case l3a3z.f0.i _of
 0, 1: _case l3a4z.f0.i _of
   0, 1: 12747: _(
   P11512( (3), l3a3z );
 12752:
 P12643( l3a3z.f4.pi, l3a4z.f4.pi );
 gl35z := l3a5z;
 P12143( (4), l3a4z, l3a1z );
 l3a3z := [3, , , , l3a4z.f4, 0];
   _);
   2: _(
   P11512( (3), l3a4z );
   _if l3a2z _then _(
  12775:
   P12643( l3a4z.f4.pi, l3a3z.f4.pi );
 gl35z := l3a5z;
 P12143( (4), l3a3z, l3a1z );
 l3a3z := [3, , , , , 0];
 _) _else 13013: _(
  P11512( 19, l3a4z );
  _if (l3a3z.f0.i <> (3)) _then  P11512( (3), l3a3z );
  l3a3z.f1.i := (0);
  l3a3z.f2.a := '17';
  _goto 12775;
 _); (* 13027 *)
   _);
   3:_if l3a2z _then _goto 12775 _else _goto 13013
 _end;
 2: _case l3a4z.f0.i _of
   0,1: _goto 12747;
   2: 13045: _( P11512( (3), l3a4z ); _goto 13013 _);
   3: _goto 13013 _end;
 3: _case l3a4z.f0.i _of
   0, 1: _goto 12752;
   2: _goto 13045;
   3: _goto 13013
   _end
 _end;
 gl35z := 0
_);
(* Level 3 *) _proced L13104(_var l3a1z:six);
 _(
 _if (l3a1z.f3.id = intType) _then _(
 _if (l3a1z.f0.i = (0)) _then _(
   rval := L7314( l3a1z.f1.a);
   curVal := ;
   putConst( l3a1z.f1.a, false);
 _) _else _(
  _if (l3a1z.f0.i <> (3)) _then P11512( (3), l3a1z );
  P11512( 18, l3a1z );
 _)
 _)
_);
(* Level F13134 *) _function F13134(l3a1z:alfa; l3a2z:boolean; _var l3a3z, l3a4z:six):boolean;
_label 13153, 13155;
_var l3v1z, l3v2z:idptr; _(
 l3v1z := l3a3z.f3.id;
 l3v2z := l3a4z.f3.id;
 _if (l3v1z = realType) _then _(
 _if (l3v2z = realType) _then _goto 13155;
 _if (l3v2z = intType) _then L13104( l3a4z )
 _else 13153: _( F13134 := true;  exit _);
 13155:
 _)_else _(
 _if (l3v1z <> intType) _then _goto 13153
  _else _(
 _if (l3v2z = realType) _then _(
   L13104( l3a3z );
  l3a3z.f3.id := realType;
  _) _else _goto 13153
 _)
 _);
 P12741( l3a1z, l3a2z, l3a3z, l3a4z, (3) );
 F13134 := false;
 _);
(* Level 3 *) _proced P13176(l3a1z:boolean; _var l3a2z, l3a3z:six);
_label 13246, 13261, 13323, 13462;
_var l3v1z:alfa; l3v2z:integer; l3v3z:six; _(
 _if l3a1z _then _(
   l3a2z.f5.l := odd(l3a2z.f5.i + 1);
   l3a3z.f5.l := odd(l3a3z.f5.i + 1);
 _);
 _case l3a2z.f0.i _of
 0: (* 13213 *) _case l3a3z.f0.i _of
   0: _if ((l3a2z.f5.i + l3a3z.f5.i) <> (2)) _then l3a2z.f5.i := (0);
   1, 2, 3: _if (l3a2z.f5.i = (0)) _then l3a3z.f4.s := _NIL _else l3a2z := l3a3z
 _end;
 1: (* 13245 *) _case l3a3z.f0.i _of
   0: 13246: _if (l3a3z.f5.i = (0)) _then l3a2z := [0, , , , _NIL, 0];
   1, 2: _( P11512( (3), l3a2z );
     13261: _if (l3a2z.f5.i = (0)) _then l3v2z := (3) _else l3v2z := (2);
     TNL(l3v1z);
     P12143( l3v2z, l3a2z, l3v1z );
     _if (l3a3z.f0.i = (1)) _then P11512( (3), l3a3z );
     _if (l3a3z.f5.i = (0)) _then l3v2z := (3) _else l3v2z := (2);
     P12143( l3v2z, l3a3z, l3v1z );
     P12665( l3a2z, l3a3z );
     l3a2z.f4 := l3a3z.f4;
     l3a2z := [3, l3v1z, , , , 0];
   _);
   3: 13323: _(
   _if (l3a2z.f5.i = (0)) _then l3v2z := (3) _else l3v2z := (2);
   _if (l3a3z.f5.i = (0)) _then _(
    _if (l3a2z.f0.i = (1)) _then P11512( (3), l3a2z );
    P12143( l3v2z, l3a2z, l3a3z.f1.a );
    l3a2z.f1 := l3a3z.f1;
   _) _else _(
    TNL(l3v1z);
    P12143( (1), l3a3z, l3v1z );
    P12143( (0), l3a3z, l3a3z.f1.a );
    _if (l3a2z.f0.i = (1)) _then P11512( (3), l3a2z );
    P12143( l3v2z, l3a2z, l3v1z );
    l3a2z.f1.a := l3v1z;
   _);
   P12665( l3a3z, l3a2z );
   l3a2z := [3, , , , , 0];
  _)
 _end;
 2: (* 13407 *) _case l3a3z.f0.i _of
   0: _goto 13246;
   1, 2: _goto 13261;
   3: _goto 13323
 _end;
 3: (* 13422 *) _case l3a3z.f0.i _of
   0: _goto 13246;
   1, 2: _(
   l3v3z := l3a2z;
   l3a2z := l3a3z;
   l3a3z := l3v3z;
   _goto 13323;
   _);
   3: 
   _if (l3a3z.f5.i = l3a2z.f5.i) _then _(
    _if (l3a3z.f5.i = (0)) _then _(
     P11450( l3a3z.f4.s, l3a3z.f1.i, l3a2z.f1.a );
     13462:
     P12665( l3a2z, l3a3z );
     l3a2z.f4 := l3a3z.f4;
    _) _else _(
     TNL(l3v1z);
     P12143( (1), l3a2z, l3v1z );
     P12143( (0), l3a2z, l3a2z.f1.a );
     P12143( (0), l3a3z, l3v1z );
     P12665( l3a2z, l3a3z );
     l3a2z := [, l3a3z.f1, , , l3a3z.f4];
 _)
 _) _else _(
  _if (l3a2z.f5.i = (0)) _then _(
   P12143( (1), l3a3z, l3a2z.f1.a );
   P12143( (0), l3a3z, l3a3z.f1.a );
  _) _else _(
   P12143( (1), l3a2z, l3a3z.f1.a );
   P12143( (0), l3a2z, l3a2z.f1.a );
   l3a2z.f1 := l3a3z.f1;
  _);
  l3a2z.f5.i := (0);
  _goto 13462;
 _)
 _end
 _end;
 _if l3a1z _then l3a2z.f5.l := odd(l3a2z.f5.i + 1);
_);
(* Level 3 *) _proced L13566(l3a1z:pstr);
 _(
 _if (gl42z <> '0') _then l3a1z@.f0.a := gl42z
 _else _(
   TNL(l3a1z@.f0.a);
   P4357( (0), l3a1z@.f0.a );
 _)
 _);
(* Level 3 *) _proced P13602(l3a1z:idptr; l3a2z:boolean);
_label 13625;
_var l3v1z:idptr; l3v2z:alfa; _(
 _if gl101z _or _not gl109z _then exit;
 _if (l3a1z@.f6.i = (1)) _then l3a1z := l3a1z@.f3;
 _if l3a2z _then l3v1z := l3a1z@.f5.id
 _else  l3v1z := l3a1z;
 _if (l3v1z = alfaType) _then _(
   l3v2z := '12ПА1';
 13625:
 putInsn( l3v2z );
 mapia( l2v28z, l3v2z );
 L3656( '14ПА', l3v2z );
 _if (l3a2z) _then L5312( l3a1z@.f0 )
_else  gl41z := 'ВСS';
 L3656( '15ПА', gl41z );
 L3667( '16ПВЩП' );
 _) _else _select (* ineff *)
  (l3v1z = intType): _( l3v2z := '12ПА5'; _goto 13625 _);
  (l3v1z = charType): _( l3v2z := '12ПА4'; _goto 13625 _);
  (l3v1z = boolType): _( l3v2z := '12ПА3'; _goto 13625 _);
  (l3v1z = realType): _( l3v2z := '12ПА2'; _goto 13625 _);
  (l3v1z@.f6.i = 3): _( l3v2z := '12ПА6'; _goto 13625 _);
  (l3v1z@.f6.i = 0): _(
 putInsn( '17ЗЧ' );
 L5425( l3v1z );
 L3656( '14ПА', l3v1z@.f8.a );
 putInsn( 'ВИ14' );
 l3v2z := '12ПА10';
 putInsn( l3v2z );
 mapia( l2v28z, l3v2z );
 L3656( '14ПА', l3v2z );
 _if l3a2z _then  L5312( l3a1z@.f0 )
 _else gl41z := 'ВСS';
 L3656( '15ПА', gl41z );
 L3667( '16ПВЩП' );
 putInsn( '17СЧ' );
 _);
 true: _( l3v2z := '12ПА7'; _goto 13625  _)
  _end;  (* 13732 *)
 gl101z := true
_);
(* Level 3 *) _proced P13734(_var l3a1z, l3a2z:six);
_var l3v1z:integer; l3v2z:alfa; l3v3z, l3v4z:pinst; _(
 _if modeC _then l3v1z := l3a1z.f3.s@.f5.i
 _else l3v1z := (1);
 _if (l3v1z = (1)) _then _(
  _if (l3a1z.f0.i = (2)) _and (l3a1z.f4.s@.f3.a = 'ИК') _then _(
   l3v3z := l3a1z.f4.pi;
  _while (l3v3z@.f3 = 'ИК') _do _( l3v4z := l3v3z; l3v3z := l3v3z@.f0 _);
  P12643( l3v3z, l3a2z.f4.pi );
  L12635( l3a2z );
  l3v4z@.f0 := _NIL;
  l3a1z.f0.i := (1);
  _if l2v23z@.f7.l _then P13602( l2v23z, true );
  L12475( l3a1z );
 _) _else _( (* 14002 *)
  L12635( l3a2z );
 _if (l2v23z@.f7.l) _then P13602( l2v23z, true );
  L12475( l3a1z );
 _)
 _) _else _( (* 14013 *)
  l3v1z := (l3v1z - (1));
  mapia( l3v1z, l3v2z);
  P12143( (16), l3a2z, '12' );
  P12143( (16), l3a1z, '16' );
  P4357( 14, l3v2z );
 _) (* 14030 *)
_);

_proced L16431(_var l3a1z:six);+
_proced L20307(_var l3a1z:six);+

(* Level 3 *) _proced P14226(l3a1z:idptr; l3a2z:pstr);
_label 14357, 14370, 14374;
(*=a1*)_const param='ПАРАМ';(*=a0*)
_var l3v1z:six;
l3v7z:alfa; l3v8z:boolean;
l3v9z, l3v10z:boolean;
l3v11z, l3v12z, l3v13z, l3v14z:integer; l3v15z:word;
l3v16z:idptr; l3v17z:idptr;  l3v18z:pstr; l3v19z:integer;

(* Level 4 *) _proced L14031(l4a1z:idptr);
_var l4v1z:alfa; l4v2z:alfa; l4v3z, l4v4z:alfa; l4v5z:idptr; l4v6z:integer; _(
 _if (l4a1z@.f3 <> _NIL) _then _(
  P11512( (0), l3v1z);
  l3v1z.f4.s@ := [, , l4a1z@.f1, , l4a1z@.f8 ];
 _) _else _(
 _if (l4a1z@.f6.i = (0)) _then _(
 _if (gl40z = '0') _then _(  curVal.i := (2); putConst( gl40z, false ) _);
 gl145z[14] := 'ИА'; gl145z[16] := 'ИА'; gl145z[13] := 'ИА'; (* ineff *)
 TNL(l4v1z); TNL(l4v2z);
 P4357( (1), l4v1z ); align;
 l4a1z@.f6.a := l4v2z;
 l4v5z := l4a1z@.f7.id;
 L3721( l4v2z ); TNL(l4v4z); L3636; ГГ( '12ПА' );
 putInsn( l4v4z ); ГГ( '11ПА' );
 _if _not (l4a1z@.f5.s = _NIL) _then  ГГ( (1) );
 putSep; L3667( '14ПВВП' ); ГГ( '17СЧ' );
 l4v6z := (l4a1z@.f10.i + (2));
 _if _not (l4a1z@.f5.s = _NIL) _then  l4v6z := (l4v6z + (1));
 mapia( l4v6z, l4v2z);
 putInsn( l4v2z ); ГГ( '17СА' );
 _if _not (l4a1z@.f10.i <= (1)) _then  ГГ( l4v2z );
 putSep; L3636; ГГ( '16ПАВП' ); ГГ( (6) );
 putSep; L3636; ГГ( 'ПБ' ); ГГ( l4a1z@.f9.a );
 align; ГГ( 'С;' ); ГГ( l4v4z );
 output@ := ':';
 put(output);
_if (l4v5z <> _NIL) _then_(
_repeat
 l4v6z := l4v5z@.f4.i;
 _if (l4v6z = (3)) _and _not (l4v5z@.f5.s <> _NIL) _then  l4v6z := (4);
 write(l4v6z:0 );
 output@ := ',';
 put(output);
 l4v5z := l4v5z@.f3;
 _until (l4a1z = l4v5z);
 _);
 ГГ( ',К;' );
 P4357( (0), l4v1z );
 _); (* 14202 *)
 _if (modeX) _then _(
 P12143( (1), l3v1z, '000000' );
 l3v1z.f4.s@.f3.a := 'ИА';
 _);
 P12143( (7), l3v1z, curIdent@.f6.a );
 P12143( 11, l3v1z, 'ПВ' );
_) (* 14225 *)
_);
_( (* P14226 *)
  l3v10z := (l3a1z@.f3 = _NIL) ;
  l3v9z := l3a1z@.f5.s = _NIL;
  l3v14z := (0);
  _if l3v9z _then  l3v11z := (3) _else  l3v11z := (4);
  _if _not l3v10z  _then  l3v11z := (l3v11z + (2));
  _if l3v10z _and (l3a1z@.f10.i >= (2)) _or _not l3v10z _then _(
    l3v1z.f4.s := _NIL;
    mapia( l3v11z, l3v7z );
    P12143( (20), l3v1z, l3v7z );
    l3a2z@.f0 := l3v1z.f4;
  _) _else l3a2z@.f0.s := _NIL;
  _if (lastChar = oparen) _then _(
    _if l3v10z  _then _(
      l3v16z := l3a1z@.f7.id;
      _if (l3v16z = _NIL) _then _( l3v11z := (0); P4142(param, l3v11z );exit _)
    _);
   _repeat
    l3v14z := (l3v14z + (1));
    l3v8z := true;
    _if l3v10z _and (l3a1z = l3v16z) _then _( P4142(param, (1) ); L7305([0,1,2]); exit _);
    gl53z := (2);
    getToken;
    l3v1z.f4.s := _NIL;
    _if (tokKind = tkIdent)  _and (curIdent <> _NIL) _and (curIdent@.f4.i = (3)) _then _(
      l3v17z := curIdent@.f5.id;
      l3v19z := (3);
      _if (l3v17z = _NIL) _then _(
        _if (curIdent@.f1.i = (0)) _then P4142( param, (2) ) _else _(
          L14031( curIdent );
          l3v13z := (4);
          getToken;
        _)
      _)  _else _(
        l3v15z.id := curIdent;
        _if _not l3v10z _then _(
          gl63z := true;
          L16431(l3v1z);
          _if (l3v1z.f0.i = (0)) _then _(
14357:
            _if (l3v15z.s@.f1.i = (0)) _then  P4142( param, (3) )
            _else _( L14031( l3v15z.id ); l3v13z := (3); _)
          _) _else _( (* 14367 *)
            gl63z := true;
14370:
            gl62z := false;
            L20307(l3v1z);
14374:
            L12520(l3v1z);
            l3v19z := (1);
            l3v17z := l3v1z.f3.id;
          _)
        _) _else _( (* 14402 *)
          _if (l3v16z@.f4.i = (3)) _then _( getToken; _goto 14357 _) _else _goto 14370;
        _)
      _)
    _) _else _( (* 14411 *)
      gl62z := false;
      L20307(l3v1z);
      _if (l3v1z.f0.i _IN [1,2]) _then _(
        l3v19z := (2);
        l3v17z := l3v1z.f3.id
      _) _else _goto 14374;
    _); (* 14422 *)
    _if l3v10z _then _(
      _if (l3v16z@.f4.i <> l3v19z) _then _(
        _if (l3v16z@.f4.i = (1)) _and (l3v19z = (2)) _then _(
          l3v19z := (1);
          L12520(l3v1z);
        _) _else  P4142(param, (4) );
      _); (* 14440 *)
      _if (l3v17z <> _NIL) _then _(
        _if (l3v19z = (3)) _then l3v15z := l3v16z@.f5 _else l3v15z := l3v16z@.f5; (* ??? *)
        _if _not typeCheck( l3v17z, l3v16z@.f5.id) _then  P4142( param, (5) );
      _);
    _); (* 14457 *)
    _if (l3v19z = (2)) _then_(
      l3v18z := l3v1z.f4.s;
      L12445(l3v1z);
      _if (l3v18z = _NIL) _and (l3v1z.f4.s@.f3.a = 'ВИ') _and (l3v14z > (1)) _then _(
        l3v1z.f4.s@.f3.a := 'ВМ';
        l3v8z := false;
      _)
    _); (* 14474 *)
    _if _not l3v10z _then _(
      _if _not (l3v19z = (3)) _then  l3v13z := l3v19z;
      curVal.i := l3v13z;
      P11512( 27, l3v1z);
    _) _else  l3v16z := l3v16z@.f3;
    _if l3v8z _and (l3v14z <> (1)) _then _(
      l3v18z := l3v1z.f4.s;
      l3v1z.f4 := l3a2z@.f0;
      P11512(19, l3v1z );
      l3a2z@.f0 := l3v1z.f4;
      l3v1z.f4.s := l3v18z;
    _);
    P12643( l3a2z@.f0.pi, l3v1z.f4.pi );
    l3a2z@.f0 := l3v1z.f4;
   _until lastChar <> comma;
    _if (l3v10z _and (l3v16z <> l3a1z)) _or (lastChar <> cparen) _then P4142(param, (6) )
    _else getToken;
  _) _else _( (* 14545 *)
    _if l3v10z _and _not (l3a1z@.f7.s = _NIL) _then  P4142( param, (7) );
  _); (* 14553 *)
  l3v1z.f4 := l3a2z@.f0;
  MAPЯГА( l3a1z@.f0, l3v7z);
  _if (l3a1z@.f9.a = l3v7z) _then P11512(19, l3v1z );
  _if l3v10z _then _(
    P12143( (5), l3v1z, l3a1z@.f9.a );
    l3v1z.f4.s@.f1.i := (2);
    l3v7z := l3a1z@.f1.a;
    _if (l3a1z@.f8.a = extern) _then _(
      P11512( 26, l3v1z );
      l3v1z.f4.s@.f2.a := label;
    _)
  _) _else _( (* 14607 *)
    _if (l3v14z = (0)) _then _(
      l3v1z.f4.s@ := [, , 0, gl37z, 0];
      l3v13z := (l3v11z + (1));
      mapia( l3v13z, l3v7z);
      P12143( 10, l3v1z, l3v7z );
    _) _else _(
      P11512( 26, l3v1z );
      l3v1z.f4.s@.f3.a := 'СМ';
      P12143(10, l3v1z, '1' );
      l3v13z := -(2 * l3v14z + l3v11z); (* ineff *)
      mapia( l3v13z, l3v7z);
      P12143( (20), l3v1z, l3v7z );
    _); (* 14651 *)
    mapia( lineNum, l3v7z);
    P12143( (7), l3v1z, l3v7z );
    l3v1z.f3.id := l3a1z;
    P11512( 24, l3v1z );
    l3v7z := '1';
  _); (* 14665 *)
  P12143(12, l3v1z, l3v7z );
  _if _not l3v9z _then _(
    mapia( (l3v11z - (1)), l3v1z.f1.a);
    P11512( 10, l3v1z);
  _);
  l3a2z@.f0 := l3v1z.f4;
  _if l3v9z _then  L3732( l3a2z@.f0.pi );
_);

(* Level 3 *) _proced L16714(_var l3a1z:six);+

(* Level 3 *) _function L14707(_var l3a1z:six):boolean;
 _(
 gl53z := (2);
 getToken;
 L14707 := true;
 _if _not ((tokKind <> tkIdent) _or (curIdent = _NIL)) 
 _and (_not ((curIdent@.f4.i <> 1) _or (curIdent@.f3 = _NIL)) _or (curIdent@.f4.i = (2)))
 _or (tokKind = tkField) _then L16714( l3a1z )
 _else L14707 := false;
 _);

(* Level 3 *) _proced L14735(l3a1z:integer);
 _( (*=a1*) P4142( 'ОШИБКА', l3a1z ); (*=a0*)_);

(* Level 3 *) _proced L14742;
 _(
 _if _not (lastChar = comma) _then  L14735( (0) );
 _);
 
(* Level 3 *) _proced P14750(l3a1z:integer; _var l3a2z:six);
_const c1='10СР';c2='10ЛУ';c3='17СР';c4='15СЧ';c5='17СР-1';c6='15СР';c7='16ПВIS';
_var l3v1z, l3v7z, l3v13z:six;
l3v19z:boolean;
l3v20z,
l3v21z, l3v22z, l3v23z:integer;
l3v24z:bitset;
l3v25z:alfa;
l3v26z:boolean;
l3v27z, l3v28z:alfa;
l3v29z, l3v30z:integer; l3v31z:six; _(
 L20307(l3v1z);
 L14742;
 L20307(l3v7z);
 l3v19z := l3v7z.f0.i = 0;
 _if l3v19z _then  l3v20z :=   L7314( l3v7z.f1.a );
 _if (l3a1z <> (2)) _then _(
   L20307(l3v13z);
   _if (l3v13z.f0.i <> (0)) _then  L14735( (2) );
   l3v22z :=   L7314( l3v13z.f1.a );
   _if (l3v22z < (1)) _or (l3v22z > (47)) _then L14735( (7) );
   l3v24z := [48-l3v22z..47];
 _); (* 15020 *)
 _if (l3a1z <> (1)) _then _(
   L12520(l3v1z);
   _if _not (l3v7z.f0.i <= (1)) _then  L14735( (1) );
   _if l3v19z _then _(
     _if (l3v20z <> (0)) _then P12422('000000', 'СД', chr(100B + l3v20z), l3v1z );
   _) _else _(
     P12143( (4), l3v7z, 'ИК' );
     P12422( '000000', 'СД', chr(100B), l3v7z );
     P12665(l3v1z, l3v7z);
     l3v1z.f4 := l3v7z.f4;
   _);
   _if (l3a1z = (0)) _then _(
     curVal.b := l3v24z;
     putConst(l3v25z, false );
     mapai( l3v25z, l3v23z);
     _if _not l3v19z _or ((l3v22z + l3v20z) <> 48) _then P12422('10', 'ЛУ', chr(l3v23z), l3v1z );
   _);
   l3a2z := l3v1z;
 _) _else _( (* 15110 *)
   l3v26z := false;
   _if l3v19z _then _(
     l3v21z := -l3v20z;
     _if (l3v1z.f0.i = (0)) _then_(
       l3v26z := true;
       l3v30z :=   L7314( l3v1z.f1.a );
       l3v30z := shift(l3v30z, l3v21z);
       curVal := ;
       putConst(l3v28z, false );
       l3v1z.f1.a := l3v28z;
     _);
     l3v24z := shift(l3v24z, l3v21z);
     l3v24z := [0..47] - l3v24z;
     curVal := ;
     putConst(l3v27z, false );
   _);
   _if l3v26z _and l3v19z _and (l3a2z.f4.s = _NIL) _then _(
     l3v31z := l3a2z;
     L12635( l3a2z );
     ГГ('10СР'); ГГ( l3v28z ); putSep;
     ГГ('10ЛУ'); ГГ( l3v27z ); putSep;
     ГГ('10СР'); ГГ( l3v28z ); putSep;
     L12475(l3v31z);
   _) _else _if l3v19z _and (l3a2z.f4.s = _NIL) _then _(
     l3v31z := l3a2z;
     L12520(l3v1z);
     P12422('00000', 'СД', chr(100B - l3v20z), l3v1z);
     P11512( 19, l3v1z );
     P12741('СР', true, l3v1z, l3a2z, (0) );
     L3732( l3a2z.f4.pi );
     ГГ( '10ЛУ' ); ГГ( l3v27z ); putSep;
     putInsn( '17СР' );
     L12475(l3v31z);
   _) _else _if l3v19z _then _(
     _if (l3v1z.f2.i = (0)) _and (l3v1z.f4.s = _NIL) _then L12520(l3v1z)
     _else _(
       L12520(l3v1z);
       P12422('000000', 'СД', chr(100B - l3v20z), l3v1z);
     _);
     P11512( 19, l3v1z );
     L3732( l3v1z.f4.pi );
     l3v29z := l3a2z.f0.i;
     P11512(12, l3a2z);
     L3732( l3a2z.f4.pi );
     _if (l3v29z = (2)) _then _(
       putInsn( '15СЧ' ); putInsn( '17СР-1' )
     _) _else putInsn( '15СР' );
     ГГ( '10ЛУ' ); ГГ( l3v27z ); putSep;
     putInsn( '17СР' );
     putInsn( '15ЗЧ' );
   _) _else (sel) _(
     L12520(l3v1z);
     curVal.b := l3v24z;
     P11512(27, l3v1z );
     P11512( 19, l3v1z );
     L12520( l3v7z );
     P11512( 19, l3v7z );
     P12665(l3v1z, l3v7z );
     P11512( 12, l3a2z );
     P12665(l3v7z, l3a2z );
     gl145z[17] := 'ИА';
     L3732( l3a2z.f4.pi );
     L3712;
     L3636;
     L3667('16ПВIS' ); _exit sel
   _)
 _); (* 15361 *)
_);

(* Level 3 *) _proced L16431(* _var l3a1z:six *)+
_label 16625, 16503, 16441, 16534;
_const (*=a1*)mnojit='МНОЖИТ'; stfun='СТФУН';(*=a0*)
_var l3v1z:idptr;
l3v2z:integer; l3v3z:boolean;
l3v4z:alfa;
l3v5z:integer;
l3v6z:alfa; l3v7z, l3v8z, l3v9z, l3v10z, l3v11z:integer;

(* Level 4 *) _proced L15362(l4a1z:integer);
 _(
 _if l4a1z <> 20 _then  P4142(mnojit, l4a1z );
 L7305([0,1,2]);
 l3a1z := [1, 1, 1, intType, _NIL, 0];
 _GOTO 16625;
_);

(* Level 4 *) _proced stdCall;
_var checkMode, stProc:integer; asBitset:bitset; l4v4z:pstr; 

(* Level 5 *) _proced L15404(l5a1z:integer);
_(
  P4142(stfun, l5a1z );
  _if _not (l5a1z <> (9)) _then  L15362( (20) );
_);

_( (* stdCall *)
  stProc := ord(l3v1z@.f3);
  _if _not (lastChar = oparen) _then  L15362( (9) ); (* open paren expected *)
  _if _not (stProc _IN [19,23]) _then _(
    _select
      stProc _IN [0..13,16..21]: L20307( l3a1z );
      _not L14707( l3a1z): L15404(9)
    _end;
    l3a1z.f5.i := (0);
    l4v4z := l3a1z.f3.s;
    (sel) _select
      (l3a1z.f3.s@.f6.i = (1)): _( l3a1z.f3 := l3a1z.f3.s@.f3; _goto sel _);
      l3a1z.f3.id = realType: checkMode := (0);
      (l3a1z.f3.id = intType): checkMode := (1);
      (l3a1z.f3.id = charType): checkMode := (2);
      (l4v4z@.f6.i = (0)) _and (l3a1z.f3.id <> alfaType): checkMode := (3);
      (l4v4z@.f6.i = (2)): checkMode := (4);
      (l4v4z@.f6.i = (6)): checkMode := (5);
      (l4v4z@.f6.i = (3)): checkMode := (6);
      true: checkMode := (7)
    _end;
    asBitset := [stProc];
    _if ((checkMode <> (0)) _or ((asBitset * [0..8,15,17..19]) = []))
    _and ((checkMode <> (1)) _or ((asBitset * [0..7,9,11..13,15..17,19]) = []))
    _and (_not (checkMode _IN [2,3,4]) _or ((asBitset * [10,12,13,15]) = []))
    _and ((checkMode <> (5)) _or ((asBitset * [14,15,22]) = []))
    _and ((checkMode <> (6)) _or ((asBitset * [10,15,19,20,21]) = [])) 
    _and ((checkMode <> (7)) _or (stProc <> (15))) _then L15404( (2) );
    _if  ((asBitset * [7,12,13,17,19]) <> []) _then  l3v1z@.f5 := l3a1z.f3;
    _if  ((asBitset * [0..9,12,13,17..21]) <> []) _then  L12520( l3a1z );

  _); (* 15564 *)
  _case stProc _of
  0, 1, 2, 3, 4, 5, 6: (*15565*) _(
    _if (checkMode = (1)) _then  P11512( 18, l3a1z );
    P12143( 19, l3a1z, chr(stProc) );
  _);
  7: (*15577*) _(
    P11512( 26, l3a1z );
    l3a1z.f4.s@ := [, ((3) - ((2) * checkMode)), , 'МВ'];
  _);
  8: (*15611*) P11512( (4), l3a1z );
  9: (*15615*) _( P11512( (20), l3a1z ); l3a1z.f0.i := (2); l3a1z.f1.a := label _);
  10: (*15624*) _if (l3a1z.f3.id = boolType) _then  L12520( l3a1z );
  11, 16: (*15631*) _( _);
  12, 13: (* 15632 *) P11512( stProc + 9, l3a1z );
  14: (* 15637 *) 
    _if (l3a1z.f2.i = (0)) _then _(
      _if (l3a1z.f1.i = (7)) _then _(
        curVal.a := chr(172B);
        putConst(l3v4z, false );
        P11512( (0), l3a1z );
        l3a1z.f4.s@.f0 := [, , 1, , 7];
        P11512( (2), l3a1z );
        l3a1z.f4.s@.f4.a := l3v4z;
        l3a1z.f5.i := (1);
        l3a1z.f0.i := (2);
      _) _else _(
        l3a1z := [0, '13', 0, , _NIL, 1];
      _)
    _) _else _( (* 15700 *)
      _if (l3a1z.f5.i = (0)) _then P3606( l3a1z.f1.a, (2) )
      _else _( P12143( 23, l3a1z, 'ВИ' );
        l3a1z.f0.i := (2);
        gl145z[9] := ;
        l3a1z.f1.a := label;
      _)
    _);
  15: _( L12445( l3a1z ); l3a1z.f0.i := (3); _);
  17: _(
    P11512( 19, l3a1z );
    _if  (checkMode = (1)) _then  P11512( (16), l3a1z );
    P12143( (9), l3a1z, 'АУ' );
    l3a1z.f4.s@.f1.i := ((3) - ((2) * checkMode));
    _if  (checkMode = (1)) _then  P11512( (17), l3a1z );
  _);
  18: _( P12143( 11, l3a1z, 'АС' ); l3a1z.f4.s@.f1.i := 2; gl145z[12] := ;  _);
  20: _( P11512( 26, l3a1z ); l3a1z.f4.s@.f3.a := 'ВЧ'; _);
  21: _(
    P11512( 26, l3a1z ); l3a1z.f4.s@.f3.a := 'ВН';
    P11512( 1, l3a1z ); l3a1z.f4.s@.f3.a := 'АВ';
  _);
  22: _(
    curVal.a := chr(175B);
    putConst(l3v4z, false );
    _if (l3a1z.f2.i = (0)) _then _(
      _if (l3a1z.f1.i = (7)) _then _(
        P11512( (0), l3a1z );
        l3a1z.f4.s@ := [, , 1, , 7];
      _) _else  L15404( (3) );
    _) _else _(
      _if (l3a1z.f5.i = (1)) _then _(
        L12520( l3a1z );
        P12143( 11, l3a1z, 'ПА' );
        P11512( (0), l3a1z );
        l3a1z.f4.s@ := [, 1, '15' ];
      _) _else _(
        _if ( l3a1z.f3.s@.f7.i = (0)) _then P3606( l3a1z.f1.a, (1) );
        P12143( (4), l3a1z, 'ИК' );
        P11512( (8), l3a1z );
      _);
    _); (* 16064 *)
    P11512( (2), l3a1z );
    l3a1z.f4.s@.f4.a := l3v4z;
    l3a1z.f5.i := (1);
    l3a1z.f0.i := (2);
  _);
  23: _( P14750( (2), l3a1z ); l3v1z@.f5 := l3a1z.f3 _);
  19: P14750( (0), l3a1z )
  _end;
   _if (lastChar <> cparen) _then L15404( (1) ) _else  getToken;
_);

(* Level 4 *) _proced P16240;
_var l4v1z, l4v7z:six;
l4v13z:pstr; l4v14z:bitset; l4v15z, l4v16z:integer;

(* Level 5 *) _proced L16150(l5a1z:integer);
_(
 l4v14z := l4v14z;
 l4v14z := [l5a1z];
_);

(* Level 5 *) _proced P16156(l5a1z, l5a2z:integer);
_(
 l4v14z := l4v14z;
 l4v14z := [l5a1z..l5a2z];
_);

(* Level 5 *) _proced L16170(_var l5a1z:six);
_(
  L20307( l5a1z );
  _if l5a1z.f3.s@.f6.i = 1 _then  l5a1z.f3 := l5a1z.f3.s@.f3;
  l3v1z := l5a1z.f3.id;
  _if (l3v1z@.f6.i <> (0))
  _or (l3v1z = realType) _or (l3v1z = alfaType)
  _then P4142( mnojit, (8) ); (* bad base type for a set *)
_);
(* Level 5 *) _proced L16214;
 _(
 _if l3v3z _then _(
   P11512( (8), l3a1z );
   l4v13z := l3a1z.f4.s;
   P11512(19, l3a1z );
   l3v3z := false;
 _);
 L12520(l4v1z );
 P12665( l3a1z, l4v1z );
 _);

_( (* P16240 *)
 l3a1z := [0, 0, 0, setType, _NIL, 0];
 gl53z := 2;
 getToken;
 _if (lastChar <> cbrack) _then _(
   l3v3z := true;
   gl62z := false;
   l4v14z := [];
   _repeat
     L16170(l4v1z );
     _if (lastChar = colon) _then _(
       L16170( l4v7z );

       _if _not ((l4v1z.f0.i <> (0)) _or (l4v7z.f0.i <> (0))) _then  _(
         l4v15z :=   L7314( l4v1z.f1.a );
         l4v16z :=   L7314( l4v7z.f1.a );
         _if (l4v15z < (0)) 
         _or (l4v15z > (47)) 
         _or (l4v16z < (0)) 
         _or (l4v16z > (47)) 
         _or (l4v15z > l4v16z) _then P4142( mnojit, (9) )
         _else P16156( l4v15z, l4v16z );
       _) _else _(
         L16214;
         P11512( 19, l4v1z );
         L12520( l4v7z );
         P12665( l4v1z, l4v7z );
         P12143( 11, l4v7z, 'ЗЧ' );
         l3a1z.f4 := l4v7z.f4;
       _); (* 16343 *)
     _) _else _( (* 16344 *)
       _if (l4v1z.f0.i = (0)) _then _(
         l4v15z := L7314( l4v1z.f1.a );
         _if (l4v15z < (0)) _or (l4v15z > (47)) _then P4142(mnojit, (0) ) (* bad set element *)
          _else L16150( l4v15z );
       _) _else _(
         L16214;
         P12143(11, l4v1z, gl37z );
         l3a1z.f4 := l4v1z.f4;
       _)
     _)
   (* 16373 *) _until lastChar <> comma;
   _if _not (lastChar = cbrack) _then  L15362(10); (* no closing bracket *)
   _if (l4v14z <> []) _then _(
     curVal.b := l4v14z;
     putConst( l3v4z, false );
   _);
   _if l3v3z _then _(
     _if _not (l4v14z = []) _then  l3a1z.f1.a := l3v4z;
   _) _else _(
     _if _not (l4v14z = []) _then  l4v13z@.f4.a := l3v4z;
     P11512( (0), l3a1z );
     l3a1z.f4.s@.f2.a := '17';
     l3a1z.f4.s@.f4.i := 0;
     l3a1z.f0.i := (3);
   _)
_)_);

_( (* L16431 *)
  _case tokKind _of
  tkWord: _( (* 16433 *)
    _if (tok <> nil) _then _(
      _if (tok = not) _then _goto 16503 _else L15362( (1) ); (* wrong keyword *)
    _) _else _(
16441:
      l3v1z := _NIL;
      P7520( l3v1z, l3v4z, false );
      _if (l3v1z = _NIL) _then  L15362( (2) ); (* not a constant *)
      l3a1z := [0, l3v4z, 0, l3v1z, _NIL, 0];
      _if modeX _then  l3a1z.f2.a := '10';
      _if (l3v1z = boolType) _and (l3v4z <> '12') _then  l3a1z.f5.i := (1);
    _)
  _); 
  tk0: _(
  _if (lastChar = oparen) _then _(
    L20307( l3a1z );
    _if _not (lastChar = cparen) _then  L15362( (3) ); (* need closing paren *)
  _) _else _if (lastChar = chr(83)) _then _(
16503:
      gl53z := (2);
      getToken;
      L16431( l3a1z );
      _if _not (l3a1z.f3.id = boolType) _then  L15362( (4) ); (* not a boolean *)
      l3a1z.f5.l := odd(ord(l3a1z.f5.l)+1);
      exit
    _) _else _if (lastChar = obrack) _then P16240 _else  L15362( (5) ); (* wrong delimiter *)
  _);
  tkInt, tkStr, tkReal, tkChar: _goto 16441;
  tkField: _goto 16534;
  tkIdent: _(
    _if (curIdent = _NIL) _then L15362( (6) ) (* ident not defined *)
    _else _(
    _if (curIdent@.f4.i = (2)) _then _(
16534:
      L16714( l3a1z );
      exit
    _);
    _if (curIdent@.f4.i = (1)) _then
     _if (curIdent@.f3 = _NIL) _then _goto 16441 _else _goto 16534;
    _if _not (curIdent@.f4.i = (3)) _then  L15362( (7) ); (* id not a var, const or func *)
    l3v1z := curIdent;
    getToken;
    l3v3z := gl63z;
    gl63z := false;
    _if _not ((lastChar = oparen) _or _not l3v3z) _then _(
      l3a1z.f0.i := (0);
      exit
    _) _else _(
      _if (l3v1z@.f1.i = (0)) _then  stdCall
      _else _(
        _if _not (l3v1z@.f5.s <> _NIL) _then  L15362(10 );
        P14226( l3v1z, ref(l3a1z.f4.s) );
        l3a1z.f0.i := (3);
        l3a1z.f5.i := (0);
        _if (l3v1z@.f5.id = boolType) _then_(
          l3a1z.f0.i := (2);
          l3a1z.f1.a := label;
        _);
      _);
      l3a1z.f3 := l3v1z@.f5;
      exit;
    _);
  _)_)
  _end;
  getToken;
16625:
_);

(* Level 3 *) _proced L16714 (* _var l3a1z: six *)+
_label 16753, 17005, 17015, 17042, 17057, 17101, 17107, 17254, 17266;
_const (*=a1*)perem='ПЕРЕМ';(*=a0*)
_var l3v1z:idptr;
l3v2z:idptr;
l3v3z:idptr;
l3v4z:six;
l3v10z:alfa;
l3v11z, l3v12z, l3v13z:integer;
l3v14z:pinst;
l3v15z:pinst;
l3v16z, l3v17z, l3v18z, l3v19z:pInst;
l3v20z, l3v21z, l3v22z, l3v23z, l3v24z:integer;
l3v25z:boolean;
l3v26z:psix;

(* Level 4 *) _proced L16626(l4a1z:integer);
_(
  P4142(perem, l4a1z );
  L7305([0,1,2]);
  _GOTO 17057;
_);

(* Level 4 *) _proced L16651(l4a1z:integer);
_var l4v1z:pInst;
(* Level 5 *) _proced L16637;
 _(
 mkInst( l4v1z );
 l4v1z@.f0 := l3v16z;
 l3v16z := l4v1z;
 l4v1z@.f1 := (0);
 _);

_( (* L16651 *)
  L16637;
  _if (l4a1z = (1)) _then _(
    l4v1z@ := [, , l3v13z, 'ИК', l3v10z];
  _) _else _if (l4a1z = (3)) _then _(
    l4v1z@ := [, , l3v13z, gl37z, l3v10z];
    L16637;
    l4v1z@ := [, , '16', 'ПВ', 'ПА'];
    gl145z[8] := ;
  _) _else _(
    l4v1z@ := [, , '17', 'ЗЧ', 0];
    _if (l4a1z = (0)) _then _(
      L16637;
      l4v1z@ := [, , '17', 'ИК', 0];
    _)
  _)
_);

_( (* L16714 *)
l3v25z := true;
 _if (tokKind = tkField) _then _(
   l3v26z := ref(gl419z[gl27z]);
   l3v1z := l3v26z@.f3.id;
   l3v20z := l3v26z@.f0.i;
   l3v10z := l3v26z@.f1.a;
   l3v13z := l3v26z@.f2.i;
   l3v21z := l3v26z@.f5.i;
   _if (l3v26z@.f4.s = _NIL) _then l3v16z := _NIL
   _else _(
     mkInst( l3v16z );
     l3v17z := l3v26z@.f4.pi;
     l3v18z := l3v16z;
     _goto 16753;
     _repeat
       mkInst( l3v19z );
       l3v18z@.f0 := l3v19z;
       l3v18z := l3v19z;
16753:
       l3v18z@ := l3v17z@;
       l3v17z := l3v17z@.f0;
     _until l3v17z = _NIL;
   _); (* 16765 *)
   _goto 17042;
 _) _else (* 16766 *) _if (tokKind <> tkIdent) _then  L16626( (0) ); (* not a var or a field *)
 l3v1z := curIdent@.f5.id;
 l3v20z := (1);
 l3v10z := curIdent@.f6.a;
 l3v13z := curIdent@.f1.i;
 l3v16z := _NIL;
 l3v21z := (0);
 _if (curIdent@.f3 <> _NIL) _then _(
   _if (curIdent@.f4.i = (1)) _then _goto 17015;
17005: _if (l3v1z@.f6.i = (6)) _then  l3v21z := (1)
   _else _( L16651( (1) ); l3v10z := '0'; l3v13z := (0); _)
 _);
 l3v3z := curIdent;
 17015:
 getToken;
 _case l3v1z@.f6.i _of
 2: _(
   l3v25z := false;
   _if (lastChar = arrow) _then _( l3v1z := l3v1z@.f3; _goto 17005 _) _else _goto 17057;
 _);
 5: _(
 l3v25z := false;
 _if (lastChar <> dot) _then _goto 17057 _else _(
   gl53z := (3);
   gl77z := l3v1z;
   getToken;
   _if (tokKind <> tkField) _or (curIdent = _NIL) _then L16626( (1) ); (* not a field *)
17042:
   l3v25z := false;
   P3606( l3v10z, curIdent@.f8.i );
   l3v1z := curIdent@.f6.id;
   _goto 17015;
 _)_);
 0, 1, 3: _(
  _if l2v23z@.f7.l _and l3v25z _then  gl101z := false;
17057:
  l3a1z := [l3v20z, l3v10z, l3v13z, l3v1z, l3v16z, l3v21z];
 _if (l3v1z = boolType) _and (l3v20z = (2)) _then _(
   L16651( (1) );
   l3a1z.f1.a := label;
   l3a1z.f4.pi := l3v16z;
   l3v16z@.f3 := gl37z;
 _);
 exit;
17101: getToken; _goto 17057;
 _);
 4: _(
   l3v25z := false;
   _if (lastChar <> obrack) _then _goto 17057;
17107:
   l3v3z := l3v1z@.f7.id;
   l3v2z := l3v1z@.f3;
   L20307( l3v4z );
   _if (l3v4z.f3.id@.f6.i <> 1) _and (l3v4z.f3.id <> intType)
   _and (l3v4z.f3.id <> charType) _and (l3v4z.f3.id@.f3 = _NIL) _then L16626( 5 ); (* ??? *)
   l3v23z := l3v3z@.f7.i;
   l3v22z := 0-l3v23z*l3v2z@.f5.i;
   P3606( l3v10z, l3v22z );
   l3v23z := l3v2z@.f5.i;
   _if l3v4z.f0.i = 0 _then _(
     l3v22z :=   L7314( l3v4z.f1.a );
     _if (l3v22z < l3v3z@.f7.i) _or (l3v22z > l3v3z@.f8.i) _then P4142( perem, 3 ); (* const index out of range *)
     _if l3v23z <> 1 _then  l3v22z := l3v22z * l3v23z;
     P3606( l3v10z, l3v22z );
   _) _else _(
     _if modeT _and _not typeCheck( l3v4z.f3.id, l3v3z) _then _(
       L12520( l3v4z );
       P5340( l3v3z, true );
       P12143(22, l3v4z, l3v3z@.f0 );
     _);
     _if l3v23z <> 1 _then _(
       gl41z := l3v1z@.f8.a;
       L12520( l3v4z );
       P11512( 5, l3v4z );
       _if l3v3z@.f7.i >= 0 _then l3v4z.f4.pi@ := [, , 0, 'МР', '30'];
     _);
     _if l3v16z = _NIL _then _(
     _if l3v4z.f0.i = 3 _then _(
        l3v4z := [2, 0, '17'];
        P12143( 4, l3v4z, 'ЗЧ' );
        l3v20z := 2;
     _) _else  l3v20z := l3v4z.f0.i;
     P12143( 4, l3v4z, 'ИК' );
     l3v16z := l3v4z.f4.pi;
    _) _else _(
      l3v14z := l3v16z@.f0;
      _if (l3v14z = _NIL) _then _(
17254:
        _if l3v4z.f0.i <> 3 _then L12520( l3v4z );
        P12643( l3v4z.f4.pi, l3v16z );
        l3v16z@.f3 := 'АС';
17266:
        l3v16z@.f1 := 1;
        L16651( 0 );
        l3v20z := 2;
      _) _else _(
        l3v15z := l3v14z@.f0;
        _if l3v14z@.f3 = 'ИК' _then _(
        _if l3v20z = 1 _then _goto 17254
        _else _(
          l3v16z@.f3 := gl37z;
          _if l3v4z.f0.i <> 1 _then_(
            L16651( 2 );
            _if l3v4z.f0.i = 2 _then L12520( l3v4z );
            l3v4z := [, 0, '17'];
          _);
          P12143( 4, l3v4z, 'АС' );
          P12643( l3v16z, l3v4z.f4.pi );
          l3v16z := l3v4z.f4.pi;
          _goto 17266;
        _) 
        _) _else _( (* 17330 *)
          _if l3v4z.f0.i <> 1 _then _(
            _if l3v4z.f0.i = 2 _then L12520( l3v4z );
            l3v4z := [, l3v14z@.f4, l3v14z@.f2 ];
            mkInst( l3v15z );
            l3v15z@ := l3v14z@;
          _);
          P12143( 4, l3v4z, 'АС' );
          l3v4z.f4.pi@.f1 := (1);
          l3v14z@.f0 := l3v4z.f4.pi;
          P12643( l3v15z, l3v16z );
          l3v20z := 2;
        _)
      _)
    _)
   _); (* 17370 *)
   l3v1z := l3v2z;
   gl101z := false;
   _if (lastChar = cbrack) _then _goto 17015;
   _if (lastChar = comma) _and (l3v1z@.f6.i = (4)) _then _goto 17107;
   L16626( (2) ); (* not a comma, or var is not an array *)
   _goto 17015;
 _);
 6: _(
   l3v25z := false;
   _if (lastChar <> arrow) _then _goto 17057;
   _if (l3v13z = (0)) _then _(  l3v13z := (1); l3v1z := charType; _goto 17101 _);
   _if (l3v21z = (1)) _then _(
     L16651( (3) );
     l3v20z := (2);
     l3v10z := '0';
     l3v21z := ;
     l3v13z := 261;
     l3v1z := l3v1z@.f3;
     _goto 17015;
   _);
   _if (l3v1z@.f7.i = (0)) _then P3606( l3v10z, 1);
   l3v1z := l3v1z@.f3;
   _goto 17005;
 _)
  _end;
  L16626(13); (* unreached *)
_);
(* Level 3 *) _proced L17503(_var l3a1z:six);
_label 17511, 17636, 17676;
_const imod = 'MOD'; term = (*=a1*)'TERM'(*=a0*);
_var l3v1z, l3v2z:integer;
l3v3z, l3v4z:idptr;
l3v5z:six; l3v11z:integer;
l3v12z:bitset; 
(* Level 4 *) _proced L17446;
_(
  P4142(term, l3v1z );
_);

(* Level 4 *) _proced L17467;
(* Level 5 *) _proced L17454(_var l5a1z:six);
_(
 _if _not (l5a1z.f0.i = 3) _then  P11512( 3, l5a1z );
 P11512( 18, l5a1z );
_);

_( (* L17467 *) 
 L17454( l3a1z );
 L17454( l3v5z );
 P12741( 'АД', false, l3a1z, l3v5z, 3 );
 _);

_( (* L17503 *)
  _if gl63z _then gl63z := false _else  L16431( l3a1z );
17511:
  _if lastChar = semi _then exit;
  
  _if tokKind = tk0 _then _(
    _if lastChar = star _then l3v1z := 0
    _else _if lastChar = slash _then l3v1z := 1
    _else _if lastChar = chr(81) _then  l3v1z := 2
    _else exit;
  _) _else _( (* 17530 *)
    _if tokKind = tkWord _then _(
      _if tok = div _then l3v1z := 3
      _else _if tok = mod _then l3v1z := 4
      _else _if tok = and _then l3v1z := 2
      _else exit
    _) _else exit
  _); (* 17546 *)
  gl53z := 2;
  getToken;
  L16431( l3v5z );
  _if (l3a1z.f3.s@.f6.i = (1)) _then  l3a1z.f3 := l3a1z.f3.s@.f3;
  l3v3z := l3a1z.f3.id;
  _if (l3v5z.f3.s@.f6.i = (1)) _then  l3v5z.f3 := l3v5z.f3.s@.f3;
  l3v4z := l3v5z.f3.id;
  (case) _case l3v1z _of
  0: _(
    _if (l3v3z@.f6.i <> (3)) _then _(
    _if _not ((l3v3z <> l3v4z) _or (l3v3z <> intType)) _then _(
      L12520( l3a1z );
      _if _not (modeM  _or (l3v5z.f2.i <> (0)) _or (l3v5z.f4.s <> _NIL)) _then _(
        l3v2z :=   L7314( l3v5z.f1.a );
        l3v12z := ;
        _if (l3v2z > 0) _and (card(l3v12z) = 1) _then_(
          l3v2z := minel(l3v12z) + 17;
          mapia( l3v2z, l3v5z.f1.a );
          P12741('СД', true, l3a1z, l3v5z, 1 );
          _goto 17636;
        _)
      _);
      P11512( 16, l3a1z );
      P12741( 'АУ', true, l3a1z, l3v5z, 1 );
      P11512( 17, l3a1z );
17636:        
      l3a1z.f3.id := intType;
      _) _else _if F13134('АУ', true, l3a1z, l3v5z) _then  L17446;
    _) _else _goto 17676
  _);
  1: _if (l3v3z = l3v4z) _and (l3v3z = intType) _then _(
       L17467;
       l3a1z.f3.id := realType;
     _) _else _if F13134( 'АД', false, l3a1z, l3v5z) _then  L17446;
  2:  _if (l3v3z = l3v4z) _and (l3v3z = boolType) _then  P13176(false, l3a1z, l3v5z )
      _else 17676:  _if modeC _and _not F12677( l3v3z, l3v4z) _then L17446
      _else P12741( 'ЛУ', true, l3a1z, l3v5z, (0) );
  3: _if (l3v3z <> l3v4z) _or (l3v3z <> intType) _then L17446
     _else _(
       _if _not (modeM _or (l3v5z.f2.i <> (0)) _or (l3v5z.f4.s <> _NIL)) _then _(
         l3v2z :=   L7314( l3v5z.f1.a );
         l3v12z := ;
         _if (l3v2z > (1)) _then _(
           _if (card(l3v12z) = (1)) _then _(
             l3v2z := 111 - minel(l3v12z);
             mapia( l3v2z, l3v5z.f1.a);
             P12741( 'СД', true, l3a1z, l3v5z, (1) );
             _exit case;
           _) _else _(
             curVal.i := F3575( l3v2z );
             putConst( l3v5z.f1.a, false );
             P12741( 'АУ', true, l3a1z, l3v5z, (1) );
             _exit case;
           _)
         _)
       _);
       L17467;
       P11512( (4), l3a1z );
     _);
  4: _if (l3v3z = l3v4z) _then _(
       _if (l3v3z = intType) _then _(
         _if _not modeM _and (l3v5z.f2.i = (0)) _and (l3v5z.f4.s = _NIL) _then _(
           l3v2z :=   L7314( l3v5z.f1.a );
           l3v12z := ;
           _if (l3v2z > (1)) _and  (card(l3v12z) = (1)) _then _(
             l3v2z := 47 - minel(l3v12z);
             l3v2z := -l3v2z;
             code(УИ7=,);
             l3v2z := (0);
             code(L20014:СД/-1/=ЦС13,7СА1=7И1L20014,);
             curVal := ;
             putConst( gl41z, false );
             L12520( l3a1z );
             P11512( (28), l3a1z );
             _exit case;
         _)_);
         P12713( l3a1z, l3v5z, imod );
       _) _else _if (l3v3z@.f6.i = (3)) _then P12741( 'СР', true, l3a1z, l3v5z, (0) )
       _else (q) _( L17446; _exit q _)
     _) _else L17446
  _end; 
  _goto 17511
_);
(* Level 3 *) _proced L20070(_var l3a1z:six);
_label 20076, 20131, 20206, 20266;
_const c80=80;
_var l3v1z:boolean;
l3v2z:alfa;
l3v3z:idptr;
l3v4z:integer; l3v5z:six;
(* Level 4 *) _proced L20062(l4a1z:integer);
 _(
   P4142((*=a1*) 'SЕХРR' (*=a0*), l4a1z );
 _);
_( (* L20070 *)
 l3v1z := false;
 _if _not gl63z _then _(
   _if (lastChar = minus) _then _(
     l3v1z := true;
20076:
     gl53z := (2);
     getToken;
   _) _else  _if (lastChar = plus) _then _goto 20076;
 _);
 L17503( l3a1z );
 _if l3v1z _then _(
   _if (l3a1z.f3.id <> realType) _and _not typeCheck( l3a1z.f3.id, intType) _then  L20062( (0) );
   _if _not (l3a1z.f0.i = (3)) _then  P11512( (3), l3a1z );
   P11512( (6), l3a1z );
   _if _not (l3a1z.f3.id <> realType) _then  l3a1z.f4.s@.f1.i := (3);
 _);
20131: _if (tokKind = tk0) _then _(
   _if (lastChar = semi) _then exit
   _else _if (lastChar = plus) _then l3v4z := (0)
   _else _if (lastChar = minus) _then l3v4z := (1)
   _else _if (lastChar = chr(80)) _then l3v4z := (2)
   _else exit
 _) _else _( (* 20150 *)
   _if (tokKind <> tkWord) _then exit
   _else _if (tok = or) _then l3v4z := (2)
   _else exit
 _);
 gl53z := (2);
 getToken;
 L17503( l3v5z );
 l3v3z := l3a1z.f3.id;
 _if (l3v3z@.f6.i = (1)) _then _( l3v3z := l3v3z@.f3; l3a1z.f3 := ; _);
 l2v2z := l3v5z.f3.id;
 _if _not (l2v2z@.f6.i <> (1)) _then  l2v2z := l2v2z@.f3;
 _case l3v4z _of
 0: _(
   l3v2z := 'АС';
   l3v1z := true;
   _if (l3v3z@.f6.i = (3)) _then _goto 20266;
20206:
   _if (l3v3z = l2v2z) _and (l3v3z = intType) _then P12741( l3v2z, l3v1z, l3a1z, l3v5z, (1) )
   _else _if F13134( l3v2z, l3v1z, l3a1z, l3v5z) _then  L20062( (1) );
 _);
 1: 
 _if (l3v3z@.f6.i <> (3)) _then _( l3v2z := 'АВ'; l3v1z := false; _goto 20206 _)
 _else _if F12677( l3v3z, l2v2z) _then _(
   L12520( l3v5z ); P12143( (17), l3v5z, 'ИА' ); P12741( 'ЛУ', true, l3a1z, l3v5z, (0) );
 _) _else  L20062( (2) );
 2: _if (l3v3z = l2v2z) _and (l3v3z = boolType) _then  P13176(true, l3a1z, l3v5z )
 _else  20266:
 _if F12677( l3v3z, l2v2z) _then  P12741( 'ЛС', true, l3a1z, l3v5z, (0) )
 _else L20062( (3) )
 _end;
 _goto 20131;
_);

(* Level 3 *) _proced L20307(* _var l3a1z:six *)+
_label 20317, 20547, 20651, 20621, 20626;
_const (*=a1*)expr='EXPR';(*=a0*)
_var l3v1z, l3v2z:integer; l3v3z, l3v4z:boolean;
l3v5z, l3v6z:alfa;
l3v7z, l3v8z:idptr; l3v9z:six;
_(
 _if gl62z _then _(  gl53z := (2); getToken _) _else gl62z := true;
 L20070( l3a1z );
20317:
 _if (tokKind = tk0) _then _(
   _if (lastChar = semi) _then exit
   _else _if (lastChar = eq) _then l3v1z := (1)
   _else _if (lastChar = neq) _then l3v1z := (0)
   _else _if (lastChar = lt) _then l3v1z := (2)
   _else _if (lastChar = chr(78)) _then l3v1z := (5)
   _else _if (lastChar = gt) _then l3v1z := (4)
   _else _if (lastChar = chr(79)) _then l3v1z := (3)
   _else exit
 _) _else _if (tokKind = tkWord) _and (tok = in) _then l3v1z := (6) _else exit;
 gl53z := (2);
 getToken;
 _if _not ((l3v1z <> (6)) _or (tokKind <> tkIdent)
 _or (curIdent = _NIL) _or (curIdent@.f4.i <> (0))) _then _(
   _if _not (curIdent@.f6.i <> 7) _then  curIdent := curIdent@.f3;
   _if _not (l3a1z.f3.s@.f6.i <> 6) _then  P4142( expr, (20) );
   _if _not (curIdent@.f6.i = 1) _then  P4142( expr, (0) );
   P5340( curIdent, true );
   L12520( l3a1z );
   TNL(l3v5z);
   P12143( (8), l3a1z, l3v5z );
   l3a1z.f4.s@.f1.i := (1);
   P12143( (5), l3a1z, curIdent@.f0 );
   l3a1z.f0.i := (3);
   l3a1z.f3.id := boolType;
   l3a1z.f1.a := l3v5z;
   l3a1z.f5.i := (0);
   getToken;
 _) _else _(
   L20070( l3v9z );
   _if  l3a1z.f3.s@.f6.i = (1) _then  l3a1z.f3 := l3a1z.f3.s@.f3;
   l3v7z := l3a1z.f3.id;
   _if (l3v9z.f3.s@.f6.i = (1)) _then  l3v9z.f3 := l3v9z.f3.s@.f3;
   l3v8z := l3v9z.f3.id;
   l3v3z := (l3v7z = realType) _or (l3v8z = realType);
   _if (l3v1z <> (6)) _then _( 
     _if (l3v7z <> intType) _and (l3v8z <> intType)
     _or _not l3v3z _then _if _not typeCheck( l3v7z, l3v8z) _then  P4142(expr, (1) );
   _) _else _if (l3v8z@.f6.i <> (3)) _or
  (l3v7z@.f6.i <> (0)) _or
  (l3v7z = alfaType) _or
  (l3v7z = realType) _or
  (l3v1z = (2)) _or
  (l3v1z = (4)) _then P4142( expr, (2) );
 
  _if l3v7z = boolType _then
  _case l3v1z _of
  0, 1: _(
   L12520( l3v9z );
   P11512( 19, l3v9z );
   L12520( l3a1z );
   P11512( 19, l3a1z );
   l3a1z.f4.s@.f3.a := 'СР';
   P12665( l3v9z, l3a1z );
   l3a1z := [2, , , , , l3v1z];
  _);
  2, 3: _(
   l3a1z.f5.l := odd(ord(l3a1z.f5.l) + 1);
20547:
   P13176( false, l3a1z, l3v9z );
   _if (l3v1z = (3)) _or (l3v1z = (5)) _then  l3a1z.f5.l := odd(ord(l3a1z.f5.l) + 1);
  _);
 4, 5: _(
  l3v9z.f5.l := odd(ord(l3v9z.f5.l) + 1);
  _goto 20547;
 _);
 6: _goto 20651
 _end _else (* 20601 *) _if (l3v8z@.f6.i <= (3)) _then _( l3v2z := 3;
  _case l3v1z _of
  0, 1: _( l3v6z := '14'; l3v5z := 'СР'; l3v4z := true; l3v2z := (1); _);
  2, 3: _if (l3v8z@.f6.i = (3)) _then _(
    L12520( l3a1z );
    P12143( (17), l3a1z, 'ИА' );
20621:
    l3v4z := true;
    l3v5z := 'ЛУ';
    l3v1z := (1);
  _) _else _(
    l3v5z := 'АВ';
20626:
    l3v4z := false;
    l3v6z := '12';
    l3v1z := l3v1z - 2;
  _);
 4, 5: 
   _if (l3v8z@.f6.i = (3)) _then _(
     L12520( l3v9z );
     P12143( (17), l3v9z, 'ИА' );
     _goto 20621;
   _) _else _(
     l3v5z := 'ОВ';
     l3v1z := l3v1z - 2;
     _goto 20626;
   _);
 6:  20651: _(
   L12520( l3a1z );
   P11512( 19, l3a1z );
   L12520( l3v9z );
   P12665( l3a1z, l3v9z );
   l3a1z.f4 := l3v9z.f4;
   P12143( 11, l3a1z, 'ИК' );
   l3a1z.f4.s@.f1.i := 2;
  _)
 _end;
 _if (l3v1z = (6)) _then l3v1z := (0)
 _else _if l3v3z _then _(
   L13104( l3a1z );
   L13104( l3v9z );
   _if modeR _then _(
     P12713( l3a1z, l3v9z, l3v5z );
     l3a1z.f4.s@.f1.i := (2);
     l3a1z.f4.s@.f2.a := l3v6z;
     _if (l3v5z = 'СР') _then  l3a1z.f1.a := label;
   _) _else _(
     P12741( l3v5z, l3v4z, l3a1z, l3v9z, l3v2z );
     _if (l3v2z = (3)) _then  P11512( (15), l3a1z );
   _)
  _) _else _(
     P12741( l3v5z, l3v4z, l3a1z, l3v9z, (1) );
   _);
   l3a1z := [2, , , boolType, , l3v1z];
   _) _else (* 20761 *) P4142( expr, (3) );
 _);
 _goto 20317;
_);
(* Level 3 *) _proced P23373;
_label 23710, 23711;
_var l3v1z:integer;
l3v2z:alfa;
l3v3z, l3v4z, l3v5z:integer;
l3v6z:alfa;
l3v7z, l3v8z, l3v9z, l3v10z:integer;
l3v11z:pstr;
l3v12z:idptr; l3v13z:idptr;
l3v14z, l3v20z:six;
l3v26z, l3v27z, l3v28z, l3v29z, l3v30z, l3v31z, l3v32z:integer;

(* Level 4 *) _function L20765(l4a1z:alfa):boolean;
_(
 L20765 := true;
 _if (tokKind = tkIdent) _or (l4a1z = '1') _then _(
   l3v11z := l2v27z;
   l3v7z := (1);
 _while (l3v11z <> _NIL) _do _(
 _if (l3v11z@.f1.i = (1)) _then l3v7z := (l3v7z - (1))
 _else _if (l3v11z@.f1.i = (0)) _and (l3v11z@.f4.a = tok) _then_(
   _if (l3v7z <> (1)) _then _(
     mapia( l3v7z, l3v2z);
     P4357( 11, l3v2z );
     l3v7z := 10;
   _);
   _if (l4a1z = goto) _then P4357( l3v7z, l3v11z@.f2.a )
   _else  P4357( l3v7z, l3v11z@.f3.a );
   _if (l3v7z <> (1)) _then putInsn( 'ПБFАМ' );
    exit
   _) _else ; (* 21037 *)
   l3v11z := l3v11z@.f0.s;
  _); (* 21041 *)
  _if (l4a1z = '1') _then _(
    _if (l3v7z <> (1)) _then _(
      mapia( l3v7z, l3v2z);
      P4357( 11, l3v2z );
      write('12ПВFАМ');
      putSep;
      align;
    _);
    L4225( (1) );
  _) _else  P4142( l3v6z, (2) );
 _) _else L20765 := false;
_);
(* Level 4 *) _proced standProc;
_label 21410, 21412, 21420, 21731, 22054, 22177, 22235, 22254, 22500;
_const zun='UN';zia='IА';zai='АI';ztnl='ТNL';zgg='ГГ';zga='ГА';zyaga='ЯГА';ziaca='1ИАСА';
zpvro='16ПВRО';zpvpo='16ПВРО';zpvgi='16ПВGI';zpvri='15ПВRI';zpvpr='16ПВРR';zpvsl='16ПВSL';
(*=a1*)wri='WRITE'(*=a0*);
_var l4v1z:integer; l4v2z:alfa;
l4v3z:alfa;
l4v4z:alfa; l4v5z:integer; l4v6z:alfa;
l4v7z, l4v8z, l4v9z, l4v10z, l4v11z:boolean;

(* Level 5 *) _proced L21070(l5a1z:integer);
 _(
 P4142( l3v6z, l5a1z );
 _GOTO 23711;
 _);
 (* Level 5 *) _proced P21077(l5a1z:integer; l5a2z:boolean);
_var l5v1z:alfa; _(
  gl102z := false;
  _if (lastChar = colon) _then _(
    L20307( l3v20z );
    l4v11z := false;
    _if ((l3v20z.f3.s@.f6.i <> (1))  _or (l3v20z.f3.s@.f3.id <> intType))
    _and _not (l3v20z.f3.id = intType) _then  P4142(wri, (0) );
    L12635( l3v20z );
 _) _else _(
   _if l5a2z _then exit;
   mapia( l5a1z, l5v1z);
   ГГ( '15ПА' );
   ГГ( l5v1z );
   putSep;
   putInsn( 'ВИ15' );
 _);
 putInsn( '17ЗЧ' );
_);

(* Level 5 *) _proced L21145(l5a1z:alfa);
 _(
 _if l4v9z _then _(
   _if modeI _and (l5a1z = 'WL') _then _( L3667('16ПВРR' ); exit _)
   _else _(
     _if (l5a1z = 'WС') _and l4v11z _then _( putInsn('1ЗЧ10' ); L3667('16ПВРО' ); exit _);
     _if l5a1z = 'WJ' _then  L3636;
     ГГ('16ПВО' );
   _);
 _) _else _(
   _if _not l4v10z _then _(
     ГГ( l4v4z ); ГГ( l4v6z ); ГГ( l4v5z ); putSep;
     ГГ( '16ПВ' ); ГГ( 'F' ); gl145z[11] := 'ИА';
   _) _else _(
     _if (l5a1z = 'WС') _and l4v11z _then _(
       ГГ( l4v4z ); ГГ( 'ИК' ); ГГ( l4v5z ); putSep;
       putInsn( 'ЗЧ' );
       ГГ( l4v4z ); ГГ( 'ИА' ); ГГ( l4v5z ); putSep;
       putInsn( '15ПА' );
       ГГ( '16ПВ' ); L3667( 'РF' );
       exit
     _);
     ГГ( l4v4z ); ГГ( 'ИА' ); ГГ( l4v5z ); putSep;
     putInsn( '15ПА' );
     _if (l5a1z = 'WJ') _then  L3636;
      ГГ( '16ПВ' );
   _)
 _);
 L3667( l5a1z );
_);
(* Level 5 *) _proced P21247(l5a1z:integer; l5a2z:alfa);
_(
 l4v11z := true;
 _if (l5a2z = 'WС') _then P21077( l5a1z, true) _else P21077( l5a1z, false);
 L12635( l3v14z );
 _if gl102z _and (l5a2z = 'WI') _then _( l5a2z := 'WJ'; gl103z := true _);
 gl102z := false;
 L21145( l5a2z );
 _);
 
(* Level 5 *) _proced L21277;
_(
  getToken;
  _if (tokKind <> tkIdent) _or (curIdent = _NIL) _then L21070( (9) );
_);

(* Level 5 *) _proced P21311(_var l5a1z:six; l5a2z:idptr);
_label 21335;
 _(
 gl53z := (2);
 getToken;
 _if (tokKind = tkIdent) _then _(
   _if (curIdent = _NIL) _then _(
     L21070( 16 );
   _) _else _(
   _if ((curIdent@.f4.i = (1)) _and (curIdent@.f3 <> _NIL)) _or (curIdent@.f4.i = (2)) _then _(
21335:
     L16714( l5a1z );
     _if modeC _and (l5a2z <> _NIL) _and _not typeCheck( l5a1z.f3.id, l5a2z) _then  L21070( 12 );
   _) _else
     L21070( 11 );
   _)
 _) _else _goto 21335;
_);

_( (* standProc *)
 l4v1z := ord(l3v12z@.f3);
 l3v6z := l3v12z@.f0;
 l4v10z := lastChar = oparen;
 _if _not l4v10z _and _not (l4v1z _IN [7,8,9,20,30]) _then  L21070( (5) );
 _case l4v1z _of
 0: _(
   L21277;
   l4v3z := 'РF';
   _if (curIdent = inFile) _then P4142( l3v6z, 10 )
   _else _if (curIdent = outFile) _then _(
     L3667( '16ПВРО' );
21410:
     getToken;
21412:
     _if (lastChar <> cparen) _then  L21070( (7) );
     getToken;
     exit
   _) _else 21420: _(
     _if (curIdent@.f4.i <> (2)) _or (curIdent@.f5.s@.f6.i <> (6)) _then L21070( (8) );
     l4v7z := curIdent@.f3 <> _NIL;
     _if modeDe _and (curIdent@.f0 = (*=a1*)'INР'(*=a0*)) _and (l4v3z = 'GF') _then _(
        ГГ( '16ПВ' );
        L3667( '76312' );
     _) _else _(
        ГГ( curIdent@.f1.a );
        _if l4v7z _then ГГ( gl37z ) _else  ГГ( 'ИА' );
        putInsn( curIdent@.f6.a );
       _if _not l4v7z _then  putInsn( '15ПА' );
       ГГ( '16ПВ' );
       _if l4v7z _then _( gl145z[10] := 'ИА'; ГГ( 'F' ) _);
       L3667( l4v3z );
     _);
     _goto 21410;
   _);
 _);
 1: _(
   L21277;
   l4v3z := 'GF';
   _if (curIdent = inFile) _then _( L3667( '16ПВGI' ); _goto 21410 _)
   _else _if (curIdent = outFile) _then P4142( l3v6z, 14 )
   _else _goto 21420;
 _);
 2: _(
   L21277;
   l4v3z := 'RWF';
   _if (curIdent <> outFile) _then _(
     _if (curIdent = inFile) _then P4142( l3v6z, (15) ) _else _goto 21420;
   _);
   L3667('16ПВRО' );
   _goto 21410;
 _);
 3: _(
   L21277;
   l4v3z := 'RF';
   _if (curIdent = inFile) _then _(
     L3667( '15ПВRI' );
     _goto 21410;
   _) _else _(
     _if (curIdent = outFile) _then P4142( l3v6z, (17) ) _else _goto 21420;
   _);
 _);
 4, 21: _(
   P21311( l3v14z, _NIL );
   l4v7z := true;
   gl33z := gl33z + 1;
   _if l3v14z.f3.s@.f6.i <> 2 _then _GOTO 23710;
   l3v12z := l3v14z.f3.s@.f3.id;
   l3v7z := l3v12z@.f5.i;
   _if (lastChar = eq) _then _(
     L20307( l3v20z );
     _if _not typeCheck( l3v20z.f3.id, intType)  _then  P4142( l3v6z, (4) );
     l4v7z := false;
   _) _else _( (* 21574 *)
     _if (l3v12z@.f6.i = (5)) _then _(
       _if (lastChar = semi) _then _(
         gl77z := l3v12z;
         gl53z := (3);
         getToken;
         _if (curIdent = _NIL) _then P4142( l3v6z, 18 )
         _else _( l3v7z := (curIdent@.f8.i + (1)); getToken; _)
       _) _else _(
         l3v12z := l3v12z@.f3;
        _while (lastChar = comma) _and (l3v12z <> _NIL) _do _(
          l3v13z := _NIL;
          getToken;
          P7520( l3v13z, l4v2z, true );
          _if (l3v13z = _NIL) _then _(  l3v7z := 19; _GOTO 23711; _);
          getToken;
          _while (l3v12z <> _NIL) _and (l3v12z@.f4.i <> (5)) _do l3v12z := l3v12z@.f5.id;
          _if (l3v12z <> _NIL) _then _(
            l3v13z := l3v12z@.f5.id;
            _while (l3v13z <> _NIL) _and (l4v2z <> l3v13z@.f1.a) _do l3v13z := l3v13z@.f5.id;
             _if (l3v13z = _NIL) _then _(
               l3v7z := (l3v12z@.f8.i + (1));
               l3v12z := _NIL;
             _) _else _(
               l3v7z := l3v13z@.f6.i;
               l3v12z := l3v13z@.f2;
             _)
           _)
        _)
    _)_)_);
    P12143( (16), l3v14z, '14' );
    mapia( l3v7z,  l4v2z);
    _if l4v7z _then_( ГГ( '12ПА' ); putInsn( l4v2z ) _)
    _else _( L12635( l3v20z ); putInsn('УИ12' )  _);
    _if (l4v1z = (4)) _then L3667( '16ПВАL' )
    _else _( L3667( '16ПВDS' ); gl145z[1] := 'ИА'; _);
    _goto 21412;
 _);
 5: _( l4v7z := false; l4v2z := 'UN'; _goto 21731; _);
 6: _( l4v7z := true; l4v2z := 'РА'; 21731:
   l3v12z := charType;
   l3v13z := alfaType;
   l4v8z := modeT;
   modeT := false;
   P21311( l3v14z, l3v12z );
   _if (lastChar <> comma) _then  L21070( 13 );
   P21311( l3v20z, l3v13z );
   _if l4v7z _then _(
     P11512( 12, l3v14z );
     P12143( 11, l3v14z, l4v2z );
     l3v14z.f0.i := (3);
     gl101z := true;
     P13734( l3v20z, l3v14z );
   _) _else _(
     P11512( 12, l3v14z );
     L12520( l3v20z );
     P12665( l3v14z, l3v20z );
     P12143( 11, l3v20z, l4v2z );
     L3732( l3v20z.f4.pi );
   _);
   modeT := l4v8z;
   _goto 21412;
 _);
 7: _(
   _if modeF _and (l2v12z <> '0') _then _(
     putInsn('12ПА2' );
     L3656( '15ПА', l2v12z );
     mapia( lineNum, gl41z);
     L3656( '14ПА', gl41z );
     L3667( '16ПВЖЬ' );
   _);
   l4v2z := tok;
   tok := '0';
   l4v7z :=   L20765( '1' );
   tok := l4v2z;
 _);
 8: L3667( '16ПВРR' );
 9: _( L3667( '16ПВПБ' ); gl145z[13] := 'ПА' _);
 10: _( l4v2z := 'IА'; l3v12z := _NIL; l3v13z := alfaType;
22054:
   L20307( l3v14z );
   _if (l3v12z <> _NIL) _and _not typeCheck( l3v14z.f3.id, l3v12z) _then  L21070( 12 );
   _if _not (lastChar = comma) _then  L21070( 13 );
   P21311( l3v20z, l3v13z );
   L12635( l3v14z );
   ГГ( '16ПВ' );
   L3667( l4v2z );
   L12475( l3v20z );
   _goto 21412;
 _);
 11: _( l4v2z := 'АI'; l3v12z := alfaType; l3v13z := intType; _goto 22054 _);
 12: _(
   P21311( l3v14z, alfaType );
   _if (l3v14z.f3.id = alfaType) _then _(
     P4357( 12, 'ТNL' );
     L12475( l3v14z );
     _goto 21412;
   _) _else _(
     L12520( l3v14z );
     L3667( '16ПВSL' );
     _goto 21412;
   _)
 _);
 13: _(
   l4v2z := 'ГГ';
   _repeat 
     L20307( l3v14z );
     L12520( l3v14z );
     P12143( (15), l3v14z, l4v2z );
     L3732( l3v14z.f4.pi );
   _until (lastChar <> comma);
   _goto 21412;
 _);
 14: _( l4v2z := 'ГА'; l3v12z := charType; l3v13z := l3v12z; _goto 22054 _);
 15: _( l4v2z := 'ЯГА'; l3v12z := alfaType; l3v13z := l3v12z; _goto 22054 _);
 16: _(
   _if (input@ = eq) _then _( get(input); _if leftInsn _then  ГГ( 'ИА=' ) _)
   _else align;
   _repeat
   _goto 22177;
   _repeat
     get(input);
22177:
     _if (input@ = endl) _then _( lineNum := (lineNum + (1)); gl23z := (0) _)
     _else _( MAPГA(input@, output@); put(output) _);
   _until (input@ _IN [comma,eq,semi,chr(26),colon]);
   leftInsn := input@ <> eq;
   get(input);
   _until (input@ = cparen);
   get(input);
   gl42z := '0';
   getToken;
 _);
 17: _(
   P21311( l3v14z, _NIL );
   putInsn( '1ИАСА' );
   putInsn( gl37z );
   L12475( l3v14z );
22235:
   _if (l3v14z.f3.s@.f6.i <> (2)) _then L21070( (6) );
   _goto 21412;
 _);
 18: _(
   P21311( l3v14z, _NIL );
   L12635( l3v14z );
   putInsn( '1ИАСА' );
   putInsn( 'ЗЧ' );
   _goto 22235;
 _);
 19: 22254: _(
   l4v7z := true;
   l4v9z := ;
   _repeat
   gl53z := (2);
   gl58z := true;
   getToken;
   gl58z := false;
   l4v6z := 'СМ';
   _if (tokKind = tkStr) _then _(
     l4v2z := tok;
     getToken;
     _if (lastChar <> colon) _and l4v9z _then _(
       mapia( gl30z, l4v3z);
       P4511( (6), l4v2z, l4v3z );
     _) _else _(
       P21077( gl30z, false );
       mapia( gl30z, l4v3z);
       ГГ('12ПА' ); ГГ( l4v3z ); putSep;
       _if modeX _then _(  ГГ( '10ИА' ); putSep; _);
       ГГ( '11ПА' ); ГГ( l4v2z ); putSep;
       l4v6z := gl37z;
       L21145( 'WS' );
     _)
   _) _else _( (* 22324 *)
     gl62z := false;
     L20307( l3v14z );
     _if l4v7z _and (l3v14z.f3.s@.f6.i = (6)) _then _(
       _if (l3v14z.f2.i <> (0)) _then _(
         _if typeCheck( l3v14z.f3.id, textFile) _then _(
           l4v9z := false;
           l4v4z := l3v14z.f2.a;
           l4v5z := l3v14z.f1.i;
           l4v10z := l3v14z.f5.i = 0;
         _) _else P4142(wri, (3) );
       _) _else _(
         _if _not (l3v14z.f1.i <> (7)) _then  P4142(wri, (1) );
       _)
     _) _else _( (* 22363 *)
       _if (l3v14z.f3.s@.f6.i = (1)) _then  l3v14z.f3 := l3v14z.f3.s@.f3;
       _if (l3v14z.f3.id = charType) _then P21247( (1), 'WС' )
       _else _if (l3v14z.f3.id = alfaType) _then P21247( (6), 'WА' )
       _else _if (l3v14z.f3.id = boolType) _then P21247( (6), 'WВ' )
       _else _if (l3v14z.f3.id = intType) _then P21247( 10, 'WI' )
       _else _if (l3v14z.f3.id = realType) _then _( P21077( 14, false ); P21247( (4), 'WR' ) _)
       _else _if (l3v14z.f3.s@.f6.i = (0)) _then _(
         L5425( l3v14z.f3.id );
         P21077( (6), false );
         L12635( l3v14z );
         putInsn( 'УИ14' ); ГГ( '14СА' ); ГГ( l3v14z.f3.s@.f8.a ); putSep;
         L3636;
         putInsn( '14СЧ' );
         L21145( 'WА' );
       _)
       _else P4142( wri, (2) );
   _)_); (* 22453 *)
   gl36z := (1);
   l4v7z := false;
   _until (lastChar <> comma);
   l4v6z := gl37z;
   _if (l4v1z = (20)) _then  L21145( 'WL' );
   _goto 21412;
 _);
 20: _(
   _if l4v10z _then _goto 22254
   _else _if modeI _then L3667( '16ПВРR' )
   _else _( ГГ( '16ПВО' ); L3667( 'WL' ) _)
 _);
 22, 23: L21070( (0) );
 25, 26, 28: _(
   l4v7z := true;
22500:
   mapia(l4v1z - 22, l4v3z);
   _repeat
   L20307( l3v14z );
   _if  (l3v14z.f3.s@.f6.i >= (4)) _then  P4142( l3v6z, (0) );
   L12635( l3v14z );
   putInsn( 'ИК5' ); putInsn( '11ПА' ); putInsn( '11ЗЧ10' );
   _if l4v7z _then _(
     _if (lastChar <> comma) _then  L21070( (1) );
     _if _not L14707( l3v14z) _then  L21070( (2) );
     curVal := l3v14z.f3.s@.f5;
     putConst( l4v2z, false );
     L12445( l3v14z );
     L3732( l3v14z.f4.pi );
     putInsn( '11ЗЧ13' );
     _if (lastChar = eq) _then _(
       L20307( l3v20z );
       _if _not (l3v20z.f3.id = intType) _then  P4142( l3v6z, (3) );
       L12635( l3v20z );
     _) _else _( ГГ( gl37z ); putInsn( l4v2z ); _);
     putInsn( '11ЗЧ15' );
   _);
   P4357( 11, l4v3z );
   P4357( 12, 'ВD' );
   gl36z := (0);
   L3712;
   _until (lastChar <> comma);
   gl145z[15] := 'ИК';
   gl145z[13] := ;
   gl145z[14] := ;
   _goto 21412;
 _);
 24, 27: _( l4v7z := false; _goto 22500 _);
 29: L21070( (3) );
 30: _(
   L3636;
   write('15ПА');
   _if l4v10z  _then_(
     gl58z := true;
     getToken;
     gl58z := false;
     _if (tokKind = tkStr) _then _(
       _if  (gl30z > 60) _then  P4142( l3v6z, (0) );
       ГГ( tok );
       getToken;
     _) _else P4142( l3v6z, (1) );
   _);
   putSep;
   L3667( '12ПВФ' );
   _if l4v10z _then _goto 21412;
 _);
 31: _(
   P21311( l3v14z, _NIL );
   L14742;
   P14750( (1), l3v14z );
   _goto 21412;
 _)
 _end
_);
(* Level 4 *) _proced P22731(_var l4a1z:six; l4a2z:alfa);
_label 22750;
_(
 _case l4a1z.f0.i _of
 0:  _if (l4a1z.f5.i = (0)) _then  P4357( (1), l4a2z );
 2: _goto 22750;
 1: _(
   P11512( (3), l4a1z );
22750:
   L3732( l4a1z.f4.pi );
   P4357(3 - l4a1z.f5.i, l4a2z );
 _);
 3: _if (l4a1z.f5.i = (0)) _then _(
   P11450( l4a1z.f4.s, l4a1z.f1.i, l4a2z );
   L3732( l4a1z.f4.pi );
 _) _else _(
   L3732( l4a1z.f4.pi );
   P4357( (1), l4a2z );
   P4357( (0), l4a1z.f1.a );
 _)
 _end
_);

_( (* P23373 *)
23710:;
23711:
_);
(* Level 3 *) _proced L26177(_var table:_array [0..127] _of idptr);
 _(
 l2v13z := (0);
 _while (l2v13z <= (127)) _do _(
   l2v2z := table[l2v13z];
   _while (l2v2z <> _NIL) _and (l2v2z >= l2v21z) _do l2v2z := l2v2z@.f2;
   table[l2v13z] := l2v2z;
   l2v13z := l2v13z + 1;
 _);
 _);
_( (* P26222 *)
 getToken;
 L26177(idTable);
_);
_function time:integer;
_( code(Э0634=,); time :=; _);
_(
  prepErr(4); P3110(getDate, 5); P3330; printOct(0); P26222(tok, curIdent);
  (*=a0*)
  write('Д=0000,ЗАГР=77040,LОАD,UNLОАD,СН,Ч=12,LI=4,ИА=74000,УРЕГ=ИА(3),Z0=УРЕГ(2),ПБИ15,ЕF,Н,Т,Е,ОС=Е(5),SL=ОС(2),Z64,РR=SL(10),МОD=РR(3),VR,СПТ,СПЛ,RF=VR(5),ЧМ1,ГТ=RF(5),RС=ГТ(6),СР=RС(4),АВ,ОВ,RWF,СТХТ=ОВ(5),WS,WС,WА,WВ,WI,WR,WL,ОWS,ОWС,ОWА,ОWВ,ОWI,ОWR,ОWL,ИК=ОWL(2),СЧ,ЗЧ,ЦУ=74136,ТR=74141,D=74145,N=74151,РА=74173,R=74202,АL=74206,GI=74222,RI=74251,РО=74257,RО=74313,МI=74323,UN=74337,РF=74715,GF=74760,СL=75075,ГА=75104,ЯГА=75115,ТNL=75165,ОV=75241,IА=75361,АI=75363,ГГ=75365,Ф=75675,RSR=75714,');
  write('DS=СН(3),Z1Z,Z2,Z3,Z4,Z5,Z6,Z7,ПА,ВИ,FРF,FGF,FRWF,FRF,FWS,FWС,FWА,FWВ,FWI,FWR,FWL,АС,ПБ,NА,ВА,ЕА,FА,ВD,Z8,ВП,ВП6,ВП7,ПВ,ОRF,');
  write('Н;КД,К;');
  write('К;ЩРWR:ИАZРR0=ЗЧ,ВИ16=ВМ7,17ЗЧ=7ПА-17,ZРR1:ИАZРR0=СЧ,СД75=ИАZРR0,ЗЧ=СЧ13,17ЗЧ=МР,16ПВОWI=,7КЦZРR1=17СЧ,УИ7=17СЧ,УИ16=16ПБ,ZРR0:ЗЧ=ЗЧ,ZРR2:ЗЧ=ЗЧ42,');
 write('К;ZQ:ВИ16=16ПА4,ВМ16=ВМ12,ВМ16=ВМ14,17ЗЧ=1СЧ10,16ПАZQ1=16СР2,У0ZQ0=16ПВРR,ZQ0:17СЧ=16ПВОWI,12ПА-1=15ПАZQ1(1),14ПВГТ=,12ПА-6=15ПАZQ1,14ПВГТ=,17СЧ=16ПВОWI,17СЧ=УИ16,ПБРR=,ZQ1:1ИА40456=3ВИ7017,Э3612417=,ЗЧ=ЗЧ304,');

  write('К;ЖЬ:ВИ16=ВМ7,ВМ6=ВМ12,ВМ15=17ЗЧ,15ПА4=ВИ15,ВМ14=17ЗЧ,1СЧ10=16ПАЖЛОК,16СР2=У0ЖЬ0,16ПВРR=,ЖЬ0:17СЧ=16ПВОWI,12ПА-1=15ПАВХОД(3),14ПВГТ=,17СЧ=УИ7,17СЧ=17ЗЧ,УИ12=15ПАВХОД,12СИ15=12ПА-6,14ПВГТ=,7ПИ15=12ПА-6,14ПВГТ=,7СЧ2=У0WЗВR,7ИК2=ВИ,УИ6=7СЧ1,У0ПАRМ=6СА1,ПАRМ:7СЧ3=У1ПАRМ1,ПАRМ3:17СЧ=17ЗЧ,У0WЗВR=7СЧ1,У0WЗВR=15ПАВХОД(3),12ПА-3=14ПВГТ,6ИА2=16ПА,ВИ16=,');
  write('ИАЖЛОК=ЗЧ,16ПАWЗВR=ВИ16,ИАВХОД(10)=ЗЧ,7СЧ1=ИАZРR0,ЗЧ=ИАВХОД(6),ЛУ=У1ПАRМ10,7СЧ1=ПБНАЧПЕR,ПАRМ1:15ПАВХОД(4)=12ПА-3,14ПВГТ=,СЧ12=ЗЧ1,ПАRМ5:ИК1=7СЧ3,ИАZРR0=ЗЧ,ИК1=6ИА3,14ПА=ИАZРR0,СЧ=СД77,МР=У0ПАRМ0,14ИК=14ПА,ПАRМ4:ВИ14=ИАЖЛОК,ЗЧ=16ПАВЗВТ,ВИ16=ИАВХОД(10),ЗЧ=ИАZРR0,СЧ=ИАВХОД(6),ЛУ=У1ПАRМ10,ИАZРR0=СЧ,');
  write('НАЧПЕR:УИ14=14ПБНАЧПЕR,10ПБЖIN=,10ПБЖRЕ=,10ПБЖВО=,10ПБЖСН=,10ПБЖАL=,10ПБЖРW=,ИАЖЛОК=СЧ,16ПВIА=,СД70=ИАЖЛОК,ЗЧ=15ПАЖЛОК,12ПА-5=14ПВГТ,СЧ13=17ЗЧ,ИАZРR2=СЧ,16ПАВЗВТ=ПБОWС,ЖIN:СЧ13=17ЗЧ,ИКЖЛОК=СЧ,ПБОWI=,ЖRЕ:15ПА4=ВИ15,17ЗЧ=17ЗЧ,ИКЖЛОК=СЧ,ПБОWR=,ЖВО:15ПА6=ВИ15,17ЗЧ=ИКЖЛОК,СЧ=ПБОWВ,');
  write('ЖСН:СЧ13=17ЗЧ,ИКЖЛОК=СЧ,ПБОWС=,ЖАL:ИКЖЛОК=15ПА,12ПА-6=ИАВХОД(10),СЧ=УИ14,ПБГТ=,ЖРW:ИКЖЛОК=СЧ,ПБЩРWR=,ПАRМ10:15ПА6=ВИ15,17ЗЧ=ИКЖЛОК,СЧ=ИАZРR0,ЦС=УИ14,14СЧ=ПБОWА,ПАRМ2:15ПАВХОД(5)=12ПА-2,14ПВГТ=,ПБПАRМ3=,');
  write('ВЗВТ:СЧ13=ЦС1,ЗЧ1=ИК1,7СЧ3=У0ПАRМ2,12ПА-3=15ПАВХОД(7),14ПВГТ=,ПБПАRМ5=,WЗВR:ЗЧ=17СЧ,17СЧ=УМ6,УИ7=17СЧ,УИ16=ПБРR,ПАRМ0:17СЧ=17ЗЧ,У0ПАRМ4=15ПАЖЛОК(1),12ПА-3=14ПАВЗВТ,ПБГТ=,ВХОД:2Э0432456=2Э1007417,2Э0435065=2Э3422017,2Э1232502=3Э0407417,Э3617417=,Э3611017=,Э3611417=,7КЦ77777=17КЦ77770,Э3606417=,ЗЧ=,ЖЛОК:ЗЧ=,1Э2214431=,ЗЧ=ЗЧ304,');

  write('ЩП:ВМ16=ВМ12,ВМ15=16ПА4,ВМ16=ВМ14,17ЗЧ=16ПАРАВ,1СЧ10=16СР1,У0ЩП1=16ПВРR,ЩП1:17СЧ=16ПВОWI,12ПА-1=15ПАРАВ,14ПВГТ=,17СЧ=УИ15,12ПА-6=14ПВГТ,12ПА-3=15ПАРАВ,14ПВГТ=,16ПАВОЗВR=17СЧ,УИ14=,ПЕR:14ПБПЕR=,10ПБЩАL=,10ПБЩRЕ=,10ПБЩВО=,10ПБЩСН=,10ПБЩIN=,10ПБЩРW=,10ПБЩУК=,ЩSR:15ПА6=ВИ15,17ЗЧ=17СЧ-3,17ЦС-4=УИ14,14СЧ=ПБОWА,ЩАL:17ИА-2=15ПА,12ПА-6=14ПАВОЗВR,ПБГТ=,ЩRЕ:15ПА4=ВИ15,17ЗЧ=17ЗЧ,17СЧ-4=ПБОWR,ЩВО:15ПА6=ВИ15,17ЗЧ=17СЧ-3,ПБОWВ=,ЩСН:10СЧ13=17ЗЧ,17СЧ-3=ПБОWС,');
  write('ЩIN:10СЧ13=17ЗЧ,17СЧ-3=ПБОWI,ЩРW:17СЧ-2=ПБЩРWR,ЩУК:17СЧ-2=16ПВIА,СД70=ИАZРR0,ЗЧ=15ПАZРR0,12ПА-5=14ПВГТ,10СЧ13=17ЗЧ,10ИАZРR2=СЧ,16ПАВОЗВR=ПБОWС,ВОЗВR:16ПВРR=,17СЧ=УИ16,17СЧ=16ПБ,РАВ:Э3612417=,ЗЧ=ЗЧ304,ВСS:1ИА30440=4Э2022417,');

  write('К;ОWJ:10ИА=12ПВОСТL,ПБОWI=,WJ:10ИА=12ПВОСТL,ПБWI=,ОСТL:10ИА=14ПАЯЧ,14ЗЧ=10СЧ13,14ЗЧ1=СЧ,14ЗЧ3=,ПОВЬ:14СЧ=14ЛУ4,14ЗЧ2=ЛСZ64,14АУ1=МР30,14АС3=14ЗЧ3,14СЧ=14АВ2,СД103=10У0КН1,14ЗЧ=14СЧ1,СД77=17ЗЧ,СД76=17ЦС,14ЗЧ1=10ПБПОВЬ,КН1:14СЧ3=12ПБ,ЯЧ:ЗЧ=ЗЧ,ЗЧ=ЗЧ,ЗЧ=ЗЧ,ЗЧ=ЗЧ,ЗЧ=ЗЧ7,');

write('############################################################################################');
write('############################################################################################');
write('############################################################################################');
write('############################################################################################');
write('############################################################################################');
write('############################################################################################');

% write('################################################');
% write('########################');
% write('############');
% write('######');
% write('######');
27721:;
_).
