(*=p-,t-,k8*)_program compil;
_label 27721;(*=a0*)
_const c0=0; c1=1; c2=2; c3=3; c4=4; c5=5;c6=6;c7=7;c8=8;c9=9;c10=10;c11=11;
c12=12;c13=13;c14=14;c15=15;c16=16;c17=17;c18=18;c19=19;c20=20;c21=21;c22=22;c23=23;
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
word=_record _case integer _of
0:(a:alfa);
1:(b:bitset);
2:(l:boolean);
3:(i:integer);
4:(p:@word);
5:(s:pstr1);
6:(id:idptr)
_end;
 struc1=_record
 f0:@struc1; f1:integer;f2,f3:alfa;f4,f5,f6,f7,f8,f9,f10:word
_end;
 pstr1=@struc1;
 len9 = _record f0,f1,f2,f3,f4,f5,f6,f7,f8: word _end;
 len6 = _record f0,f1,f2,f3,f4,f5: word _end;
 ident = _record
    f0:alfa;
    f1, f2:word;
    f3:idptr; (* base type of derived type *)
    f4: word;
    f5: word; (* variable type *)
    f6, f7, f8: word
 _end;
 idptr = @ident;
_var
   gl10z, gl11z, gl12z, gl13z, gl14z, gl15z, un16z, gl17z, gl18z, gl19z : char;
   gl20z: boolean;
          gl21z, gl22z, gl23z, gl24z, gl25z, gl26z, gl27z, gl28z, gl29z,
   gl30z, gl31z, gl32z, gl33z, gl34z, gl35z, gl36z:integer;
   gl37z, gl38z, gl39z:alfa;
   gl40z, gl41z, gl42z:word;
   gl43z:integer; gl44z:alfa; gl45z:integer;
   gl46z:alfa;
   gl47z:@word;
   gl48z:char;
   gl49z, gl50z:alfa;
   gl51z, gl52z, gl53z, gl54z, gl55z, gl56z:integer;
   gl57z, gl58z, gl59z,
   gl60z, gl61z, gl62z, gl63z, gl64z, gl65z, gl66z, gl67z, gl68z, gl69z,
   gl70z, gl71z, gl72z, gl73z, gl74z: boolean;
   curType:idptr; 
   gl76z, gl77z,
   textFile, inFile,  outFile, nilPtr, undef,
   boolType, intType, realType, charType, alfaType: idptr;
   gl88z, gl89z,
   gl90z, gl91z, gl92z, gl93z, gl94z, gl95z, gl96z, gl97z:integer;
   gl98z, gl99z, gl100z, gl101z, gl102z, gl103z, gl104z, gl105z, gl106z, gl107z, gl108z, gl109z:integer;
   gl91a: _array [3..8] _of sixwords;
   gl145z: _array [1..17] _of alfa;
   idTable, gl291z: _array[0..127] _of idptr;
   gl419z, gl420z, gl421z:integer; gl422z: _array [0..100] _of char;
   dummy:_array [1..14] _of char;
   gl536z: _array[1..4096] _of word;
   gl4633z, gl4634z:char; gl4635z, gl4736z:_array [0..100] _of char;
   gl4837z, gl4838z:integer;
_proced L3013(i:integer);   
_(   
  write(i:0)
_);

_proced P3020;
_(
  _if gl20z _then _(
    ГГ( '*ФАЙЛ ' ); ГГ( gl46z );
    writeLN
  _)
_);
   _proced P3027(l2a1z:integer);
_(
 rewrite(output);
 P3020;
 _select
 (l2a1z = 0):  write('ВСТРЕТИЛСЯ КОНЕЦ ФАЙЛА');
 (l2a1z = 1): _( write('НЕ ЗАКРЫТА УСЛ СЕКЦИЯ'); ГГ( ' СТР.=' ); L3013( gl26z ); _);
 (l2a1z = 2): _( write('ВЛОЖЕННОСТЬ !'); ГГ( ' СТР.=' ); L3013( gl24z ); _);
 (l2a1z = (3C)): write('НЕ ЗАКРЫТ КОММЕНТАРИЙ');
 (l2a1z = (4C)): _( ГГ( 'ФАЙЛ ' ); ГГ( gl46z ); write(' НЕ НАЙДЕН') _);
 (l2a1z = (5C)): _( ГГ( 'В '); L3013( gl24z ); write(' СТРОКАХ ОБНАРУЖЕНО ');
         L3013( gl21z ); ГГ( ' ОШИБ.' ) _);
  true: _( write('ОШ ПРЕПРОЦЕССОРА'); ГГ( ' СТР.=' ); L3013( gl24z ) _)
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
    (l2a2z = (3C)): _(  write(' УЖЕ ОПРЕД В СТРОКЕ '); L3013( gl56z ) _);
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
_if gl74z _then _(
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
 ГГ( gl40z.a );
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

_procedure P26222(_var l2a1z, l2a2z:struc1);
_const block=(*=a1*)'БЛОК'(*=a0*);c259=259;c258=258;e48=4T;
_var l2arra:_array [1..13] _of integer;
l2v14z, l2v15z, l2v16z, l2v17z, l2v18z:integer;
l2v19z:boolean;
l2arrb:_array [20..30] _of integer;
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
(* Level 3 *) _proced L3620; _(
 _if gl61z _then  output@ := ieq _else output@ := icomma;
 gl61z := _not gl61z;
 gl42z.i := 0;
 put(output);
 _);
 _proced L3631(l3a1z:alfa); _(
 ГГ( l3a1z );
 L3620;
 _);
(* Level 3 *) _proced L3636; _(
 _if gl74z _then L3631( '10ИА' );
 _);
(* Level 3 *) _proced L3644; _(
 _if gl74z _then ГГ( '10' );
 _);
_proced L3651(l3a1z:alfa); _(
 L3644;
 L3631( l3a1z );
 _);
 _proced L3656(l3a1z, l3a2z:alfa); _(
 ГГ( l3a1z );
 ГГ( l3a2z );
 L3620;
 _);
(* Level 3 *) _proced L3667(l3a1z:alfa);
 _(
 ГГ( l3a1z );
 _if gl61z _then  write('=,')
 _else _( write(icomma); gl61z := true; _);
 gl42z.i := 0;
 _);
(* Level 3 *) _proced L3703;
 _(
 _if _not gl61z _then _( write(icomma); gl61z := _not gl61z _)
 _);
(* Level 3 *) _proced L3712;
 _(
 _if (gl36z <> (1)) _then _( L3631( 'РА7' ); gl36z := (1) _)
 _);
(* Level 3 *) _proced L3721(l3a1z:alfa);
 _(
 L3703;
 ГГ( l3a1z );
 write(icolon);
 L3712;
 gl42z.a := l3a1z;
 _);
(* Level 3 *) _proced L3732(l3a1z:@struc1);
_const mask='070000';
_var l3v1z:alfa; l3v2z:@struc1; _(
 _if (l3a1z = _nil) _then exit;

 _if (l3a1z@.f0 <> _nil) _then _(
 _if (l3a1z@.f3 = gl37z) _and (l3a1z@.f0@.f3 = 'ЗЧ') _and
  (l3a1z@.f0@.f2 = '17') _and (l3a1z@.f0@.f4.i = 0) _then _(
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
  1: _if (gl36z <> (1)) _then _( L3631( 'РА3' ); gl36z := (1) _);
  2: gl36z := 1;
  3: _if (gl36z <> (2)) _then _(  L3631( 'РА' ); gl36z := (2) _);
  4: gl36z := 2
 _end; (* 4050 *)
 _if (l3a1z@.f2 = (*=a1*)'LАВЕL'(*=a0*)) _then _(
 _if l3a1z@.f4.i <> 0 _then L3721( l3a1z@.f4.a ) _else _(
  TNL(l3v1z);
 L3703;
 write('10ПВУРЕГ=,');
 ГГ( l3v1z );
 ГГ( ':10СА-' );
 L3631( l3v1z );
 _);
 _) _else _(
 _if (l3a1z@.f2 <> '00') _then  ГГ( l3a1z@.f2 );
 _if ((l3a1z@.f4.b * [13..15]) <> []) _and
     ((l3a1z@.f4.b * [0..12]) = []) _and
     ((l3a1z@.f4.b * [13,14,15]) <> [13..15]) _and
     (l3a1z@.f3 <> 'СА') _and
     (l3a1z@.f3 <> 'ИА') _and
     (l3a1z@.f3 <> 'ИК') _then _(
    ГГ( 'ИА' );
    _if l3a1z@.f4.i<>0 _then (q) L3631( l3a1z@.f4.a );
   ГГ( l3a1z@.f3 );
 _) _else _(
   ГГ( l3a1z@.f3 );
 _if l3a1z@.f4.i<>0 _then  ГГ( l3a1z@.f4 );
 _);
 L3620;
 _if (l3a1z@.f3 = 'ПВ') _or (l3a1z@.f3 = 'Э050') _then L3703;
 _); (* 4141 *)
_);
(* Level 3 *) _proced P4142(l3a1z:alfa; l3a2z:integer);
 _(
 _if gl71z _then exit;
 P3110( l3a1z, l3a2z );
 (*=a1 error messages *)
 ГГ( '***ОШ.' ); ГГ( l3a1z ); ГГ( '=' ); L3013( l3a2z );
 ГГ( ' СТР.=' ); L3013( gl24z ); ГГ( '.NLЕХ=' ); L3013( gl23z );
 ГГ( '.ИД=' ); ГГ( gl38z ); ГГ( '.СИМ=' ); ГГ( gl51z );
 writeln('.КОНТЕКСТ');
 code(16ПВСТХТ=,);
 gl64z := true;
 gl21z := (gl21z + (1));
 _if (gl21z > gl22z) _then (q) _GOTO 27721;
 _);(*=a0*)
(* Level 3 *) _proced P4205(l3a1z:alfa; l3a2z:integer);
 _(
 gl71z := false;
 P4142( l3a1z, l3a2z );
 _GOTO 27721;
_);

(* Level 3 *) _proced L4220(l3a1z:integer);
 _(
 P4205( (*=a1*)'SУS'(*=a0*), l3a1z );
 _);
(* Level 3 *) _proced L4225(l3a1z:integer);
_var l3v1z:alfa; l3v2z:@struc1; _(
 gl42z.i := (0);
 _case l3a1z _of
 1: _(  ГГ( 'ПБЕ' ); _if (l2v31z <> (0)) _then ГГ( 'F' ); _);
 0: _(
 l3v2z := l2a2z.f0;
 L3703;
 _if (gl39z <> '1') _then _(
    mapai( gl39z, l3a1z );
   gl145z[l3a1z] := 'ИА';
 _);
 _if _not l2v19z  _then _( output@ := '*'; put(output) _);
 ГГ( l3v2z@.f9 );
 write(icolon);
 (*=c-*)MAPЯГА( l3v2z@.f0, l3v1z);(*=c+*)
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
 (*=c-*)MAPЯГА( l3v2z@.f0, l3v1z);(*=c+*)
 ГГ( '`' );
 ГГ( l3v1z );
 ГГ( '`17СА' );
 ГГ( l3v2z@.f8.a );
 gl36z := (1);
 _)
 end;
 L3620;
 _);
(* Level 3 *) _proced P4357(l3a1z:integer; l3a2z:alfa);
_label 4412, 4424, 4431;
_var l3v1z:word; _(
 _if gl74z _then _(
 _if (l3a1z < (4)) _then _(
   _if (l3a1z <> (0)) _then ГГ( '10' );
 _) _else _(
   _if (l3a1z = 11) _or (l3a1z = 10) _or (l3a1z = (8)) _then L3631( '10ИА' );
 _)
 _);
 _case l3a1z _of
0: _(
 L3703;
 ГГ( l3a2z );
 write(icolon);
gl42z.a := l3a2z;
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
4,5,6,7,9: P4205(in, l3a1z );
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
 ГГ( '15ПА-' ); ГГ( l3a2z ); L3620; TNL(l3v1z.a); L3721( l3v1z.a );
 write('12ИА=15СЧ'); ГГ( l3a2z ); write(',16ИА=15ЗЧ'); ГГ( l3a2z );
 write(icomma);
 _if gl74z _then _(
 write('10ИА=15КЦ');
 ГГ( l3v1z.a );
 write(icomma);
 exit
 _) _else _(
 ГГ( '15КЦ' ); ГГ( l3v1z.a );
 _)
_)
_end;
 L3620;
_);
(* Level 3 *) _proced P4511(l3a1z, l3a2z, l3a3z:integer);
 _(
 _select
 (l3a1z = 5): _(
 L3703; L3636;
 ГГ( '15ПА' ); ГГ( l3a2z ); write('=ВИ15,СД'); ГГ( l3a3z );
 write('=13ЛС1,13ЗЧ1'); L3620;
 _);
 (l3a1z = 6): _(
 ГГ( '12ПА-' ); ГГ( l3a3z ); L3620; L3636;
 ГГ( '15ПА' ); ГГ( l3a2z ); L3620; L3667( '14ПВГТ' );
 _);
 true: _(
 ГГ( 'Э;' ); ГГ( l3a2z ); ГГ( icolon ); ГГ( l3a3z ); ГГ( ',К;' );
 _)
 _end
 _);
_proced P4646;
 _const mask='177';
_var l3v1z:integer;
(* Level 4 *) _proced preDecl(l4a1z:alfa; _var l4a2z:idptr);
_var l4v1z:integer; l4v2z:idptr; _(
 new(l4v2z);
 (*=c-*)mapai(l4a1z _and mask, l4v1z);(*=c+*)
 l4v2z@ := [l4a1z, 0, idTable[l4v1z], _NIL, 0, 1, 0];
 idTable[l4v1z] := l4v2z; l4a2z := l4v2z;
 _);
(* Level 4 *) _proced P4605(l4a1z:alfa; l4a2z:integer);
_var l4v1z:idptr; _(
 preDecl( l4a1z, l4v1z );
 l4v1z@.f4.i := (1);
 l4v1z@.f5.id := curType;
 l4v1z@.f6.i := l4a2z;
 _);
(* Level 4 *) _proced declStandFun(l4a1z:alfa);
_const mask='177';
_var l4v1z:@len6; _(
 new(l4v1z);
 (*=c-*)mapai(l4a1z _and mask, l3v1z );(*=c+*)
 l4v1z@ := [l4a1z, 0, idTable[l3v1z], , 3, curType];
 l4v1z@.f3.i := gl26z;
 gl26z := gl26z + 1;
 (*=c-*)idTable[l3v1z] := l4v1z;(*=c+*)
 _);

_( (* P4646 *)
gl4837z := 75B; gl4838z := 313B;
l3v1z := (0);
 _while l3v1z <= 127 _do _(
   idTable[l3v1z] := _NIL;
   gl291z[l3v1z] := _NIL;
   l3v1z := l3v1z + 1;
 _);
 gl55z := 1;  gl10z := ; gl24z := ; gl39z := ; gl59z := ; gl61z := ; gl62z := ; gl69z := ;
 gl101z := ;
 gl68z := ; gl66z := ; gl67z := ; gl36z := ;
 gl46z := spaces;
 gl35z := (0); gl65z := ; gl33z := ; gl28z := ; gl53z := ; gl23z := ; gl106z := ;
 gl40z := ; gl64z := ; gl71z := ; gl12z := ; gl13z := ; gl45z := ; gl73z := ; gl14z := ; gl15z := ;
 gl98z := ; gl99z := ; gl107z := ; gl108z := ; gl109z := ;
 gl17z := ; gl18z := ; gl19z := ; gl102z := ; gl103z := ;
 gl20z := ; gl70z := ; gl63z := ; gl58z := ; gl74z := ; gl44z := ;
 gl37z := 'СЧ';
 gl48z := chr(175B);
 gl89z := -1; gl90z := ;
 gl34z := (100);
 gl31z := ord(ref(gl536z[9]));
 gl32z := gl31z - 9;
 gl47z := _NIL;
 gl4634z := ;
 curType := ;
 gl77z := ;
 gl4633z := ;
 gl105z := ;
 gl21z := (0);
 gl22z := 10;
 gl43z := 257;
 gl536z[9].p := _NIL;
 gl536z[9 + 1].i := 0;
 gl536z[9 + 2].i := 1;
 gl29z := 11;
 (*=a1*) gl49z := 'А';
 MAPГA( gl49z, gl50z );
 reset(input);
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
 preDecl( '000000', undef );
 undef@ := [,,,intType,,,3];
 preDecl( 'RЕАL', realType );
 preDecl( '00АLFА', alfaType );
 preDecl( '0УКNIL', nilPtr );
 nilPtr@.f6.i := (2);
 curType := boolType;
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
 curType := _NIL;
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
 curType := realType;
 declStandFun( '00SQRТ' );
 declStandFun( '000SIN' );
 declStandFun( '000СОS' );
 declStandFun( 'АRСТАN' );
 declStandFun( 'АRСSIN' );
 declStandFun( '0000LN' );
 declStandFun( '000ЕХР' );
 declStandFun( '000АВS' );
 curType := intType;
 declStandFun( '0ТRUNС' );
 curType := boolType;
 declStandFun( '000ОDD' );
 curType := intType;
 declStandFun( '000ОRD' );
 curType := charType;
 declStandFun( '000СНR' );
 declStandFun( '00SUСС' );
 declStandFun( '00РRЕD' );
 curType := boolType;
 declStandFun( '000ЕОF' );
 curType := nilPtr;
 declStandFun( '000RЕF' );
 declStandFun( '000РТR' );
 curType := intType;
 declStandFun( '000SQR' );
 declStandFun( '0RОUND' );
 declStandFun( '000SЕL' );
 declStandFun( '00САRD' );
 declStandFun( '0МINЕL' );
 curType := boolType;
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
 i := (1);
 _while (i <= (6)) _do _(
 _if (a[i] <> chr(0)) _then _(
    pck(a[i], l3a1z);
    L5172 := l3a1z;
  exit;
 _);
 i := (i + (1));
 _)
 _);
(* Level 3 *) _proced P5215(l3a1z:integer; _var l3a2z:integer);
 _( code(=15ПА15,ВИ15=СД/4/,MP=3ИК3,ЛС=); l3a2z := ;
 _);
(* Level 3 *) _proced P5226(_var l3a1z:alfa; l3a2z:boolean);
_var l3v1z:integer; _(
 _if _not l3a2z _then _(
 gl31z := gl31z;
 code(=УИ5,);
 l3v1z := ((9) - gl29z);
 code(=УИ4,);
 gl56z := gl56z;
 code(ЗЧ1=,find:СЧ1=5CP,Y0done=5CA1,4КЦfind=);
 _);
 gl29z := (gl29z + (1));
 _if (gl29z >= (4096)) _then L4220(23);

 gl536z[gl29z].i := gl56z;
 mapia( gl29z, l3a1z );
 exit; code(done:ВИ5=);
 l3v1z := ;
 l3v1z := (l3v1z - gl32z);
 mapia( l3v1z, l3a1z );
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
 gl56z := l3v15z.i;
 P5226( gl41z.a, true );
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
 gl56z := l3v15z.i;
 P5226( gl41z.a, false );
 _);
(* Level 3 *) _proced P5340(l3a1z: idptr; l3a2z:boolean);
_var l3v1z:alfa; l3v2z:alfa; l3v3z, l3v4z:alfa; _(
 _if (l3a1z@.f0 = '000000') _then _(
 _if (l3a2z) _then _(
 TNL(l3v1z);
 L3644;
 L3656( 'ПБ', l3v1z );
 L3703;
 _);
 TNL(l3v2z);
 L3721( l3v2z );
 L3651( 'ЗЧ1' );
 l3a1z@.f0 := l3v2z;
 gl56z := l3a1z@.f7.i;
 P5226( l3v3z, false );
 gl56z := l3a1z@.f8.i - gl56z;
 P5226( l3v4z, false );
 L3644;
 L3656( 'АВ', l3v3z );
 L3631( '15У1' );
 L3644;
 L3656( 'ОВ', l3v4z );
 L3631( '15У1' );
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
 l3a1z@.f8 := gl41z;
 (loop) _(
 l3v1z := l3v1z@.f7.id;
 _if (l3v1z = _NIL) _then exit;
 L5264( l3v1z@.f0 );
 _goto loop _)
 _);
_);

_( (* P26222 *)

_);
_(
  P3027(4); P3110(getDate, 5); P3330; printOct(0);
write('############################################################################################');
write('############################################################################################');
write('############################################################################################');
write('############################################################################################');
write('############################################################################################');
write('############################################################################################');
write('############################################################################################');
write('############################################################################################');
write('############################################################################################');
write('############################################################################################');
write('############################################################################################');
write('############################################################################################');
write('############################################################################################');
write('############################################################################################');
write('############################################################################################');
write('############################################################################################');
write('############################################################################################');
write('############################################################################################');
write('############################################################################################');
write('############################################################################################');
write('############################################################################################');
write('############################################################################################');
write('############################################################################################');
write('############################################################################################');
write('############################################################################################');
write('############################################################################################');
write('############################################################################################');
write('############################################################################################');
write('############################################################################################');
write('############################################################################################');
write('############################################################################################');
write('############################################################################################');
write('############################################################################################');
write('############################################################################################');
write('############################################################################################');
write('############################################################################################');
write('############################################################################################');
write('############################################################################################');
write('############################################################################################');
write('############################################################################################');
write('############################################################################################');
write('############################################################################################');
write('############################################################################################');
write('############################################################################################');
write('############################################################################################');
write('############################################################################################');
write('############################################################################################');
write('############################################################################################');
write('############################################################################################');
write('############################################################################################');
%write('################################################');
%write('########################');
write('############');
%write('######');
27721:;
_).
