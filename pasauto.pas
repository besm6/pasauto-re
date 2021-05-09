(*=p-,t-,m-,k8*)_program compil;
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
letter = 'a'..'z';
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
    f1:word;
    f2:idptr; (* next *)
    f3:idptr; (* base type of derived type *)
    f4: word;
    f5: word; (* variable type *)
    f6, f7, f8: word
 _end;
 idptr = @ident;
_var
   gl10z:integer;
   gl11z:real;
   gl12z, gl13z, gl14z,
   gl15z, gl16z, gl17z, gl18z, gl19z : boolean;
   gl20z: boolean;
          gl21z, gl22z, gl23z, gl24z, gl25z, gl26z, gl27z, gl28z, gl29z,
   gl30z, gl31z, gl32z, gl33z, gl34z, gl35z, gl36z:integer;
   gl37z, tok, gl39z:alfa;
   gl40z, gl41z, gl42z:word;
   gl43z:integer; gl44z:alfa; gl45z:alfa;
   gl46z:alfa;
   gl47z:@word;
   gl48z:char;
   gl49z, gl50z:alfa;
   gl51z: char;
   gl52z, gl53z, gl54z, modeA, gl56z:integer;
   gl57z, gl58z, gl59z,
   gl60z, gl61z, gl62z, gl63z, gl64z, gl65z, gl66z, gl67z, gl68z, gl69z,
   gl70z, gl71z, gl72z, gl73z, gl74z: boolean;
   curIdent:idptr; 
   gl76z, gl77z,
   textFile, inFile,  outFile, nilPtr, undef,
   boolType, intType, realType, charType, alfaType: idptr;
   gl88z, gl89z,
   gl90z, gl91z, gl92z, gl93z, gl94z, gl95z, gl96z, gl97z:integer;
   gl98z, gl99z: boolean;
   gl100z, gl101z, gl102z: boolean;
   gl103z, gl104z, gl105z, gl106z, gl107z, gl108z, gl109z:integer;
   gl91a: _array [3..8] _of sixwords;
   gl145z: _array [1..17] _of alfa;
   idTable, idTabA: _array[0..127] _of idptr;
   gl419z, gl420z, gl421z:integer; gl422z: _array [0..16] _of sixwords;
   dummy:_array [1..13] _of char;
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

_procedure P26222(_var l2a1z:alfa; l2a2z:@struc1);
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
 (align)_if (l3a1z = _nil) _then exit;

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
 ГГ( '.ИД=' ); ГГ( tok ); ГГ( '.СИМ=' ); ГГ( gl51z );
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
 l3v2z := l2a2z@.f0;
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
 _select
 (l3a1z < (4)): _if (l3a1z <> (0)) _then ГГ( '10' );
 (l3a1z = 11) _or (l3a1z = 10) _or (l3a1z = (8)): L3631( '10ИА' )
 _end
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
_var l3v1z:integer;
(* Level 4 *) _proced preDecl(l4a1z:alfa; _var l4a2z:idptr);
_var l4v1z:integer; l4v2z:idptr; _(
 new(l4v2z);
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
_var l4v1z:@len6; _(
 new(l4v1z);
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
 modeA := 1;  gl10z := ; gl24z := ; gl39z := ; gl59z := ; gl61z := ; gl62z := ; gl69z := ;
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
 curIdent := ;
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
 curIdent := nilPtr;
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

(* Level 3 *) _proced P6157;
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
     gl51z := l4a2z; get(input);
 _) _else  gl51z := l4v1z;
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
_proced D5517; (* not called *)
_var b: bitset;
_(
b := [0..card(b),minel(b)..47] * [0..minel(b),card(b)..47];
b := [47] * [0..minel(b),47]; (q) _exit q;(q) _exit q;(q) _exit q;(q) _exit q;

_);
(* Level 4 *) _proced P5550(l4a1z, l4a2z:integer);
_var l4v1z:integer; _(
 l4v1z := 001034T;
 code(=4цс3,зч75211=4сч4,ав13=зч75212,)
 _);

(* Level 4 *)

 _proced P5561;
 _var l4v1z, l4v2z, l4v3z : integer; l4v4z: alfa;
_(
%gl93z                      : = C/1211;
%gl94z                      : = C/1212;
%gl95z                      : = C/0221;
%gl96z                      : = C/0220;
%gl97z                      : = C/1225;
code(=сч75211,1зч135=сч75212,1зч136=сч74221,1зч137=сч74220,1зч140=сч75225,1зч141=);
 gl92z := gl24z;
gl24z := 1;
 L5512( (270037C) );
 code(сч71776=СД/-36/,СД/36/=);
 l4v1z := ;
 L5512( l4v1z );
 code(11ПА70001=12ПА77600,L5601:11СЧ=);
 l4v4z :=;
 _if (l4v4z = gl46z) _then _(
 code(=11СЧ1,СД/30/=4ЗЧ4,MP=СД/30/,4ЗЧ5=);
 P5550( (l4v2z + l4v1z), l4v3z );
 reset(input);
 exit;
 _);
 code(11CA2=12КЦL5601,);
 P3027( (4) );
_);
 (* Level 4 *) _proced P5617;
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
 (* Level 4 *) _proced P5643;
_var l4v1z:word; l4v2z:integer; _(
 l4v1z.a := '000000';
 l4v2z := (1);
  _while (input@ _in letter) _or (ord(input@) < 10) _do _(
 _if (l4v2z < (7)) _then _(
    l4v2z := (l4v2z + (1));
    (* TODO add -> or *)l4v1z.i := (l4v1z.i * 256) + ord(input@);
 _);
 get(input);
 _);
 tok := l4v1z.a;
_);
(* Level 4 *) _proced L5671;
 _(
   _while (input@ = chr(15)) _or (input@ > chr(128)) _do get(input);
 _);
(* Level 4 *) _proced P5702;
_label 5704;
_var l4v1z:char; _(
 5704:
 l4v1z := input@;
 _if (l4v1z = chr(172B)) _then P3027( (3) );
 get(input);(*=a1*)
 _if (l4v1z = '*') _and (input@ = ')') _then _(
 get(input);
 exit
 _) _else _if (l4v1z = '(') _and (input@ = '*') _then _(
 get(input);
 P5702;
 _) _else _if (l4v1z = gl48z) _then _(
 gl24z := (gl24z + (1));
 gl23z := (0);
 _) _else _( _);
 _goto 5704
_);

(* Level 4 *)_proced P5776;
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
 'L': L5760(gl70z);
 'F': _( L5760(gl14z); _if gl14z _then  gl107z := (1); _);
 'P': L5760(gl66z);
 'G': _( L5760(gl15z); _if gl15z _then  gl108z := (1); _);
 'T': L5760(gl67z ); 
 'V': _( L5760(gl98z); _if gl98z _then gl109z := (1); _);
 'A': P5733(modeA, (1) );
 'S': _( L5760(gl99z); _if gl99z _then  gl109z := (1); _);
 'C': L5760(gl59z);
 'R': L5760(gl68z);
 'M': L5760(gl69z);
 'Ч': L5760(gl18z);
 'X': L5760(gl74z);
 'B': P5733(gl10z, 4);
 'K': P5733(gl34z, 25);
 'Д': L5760(gl17z);
 'Л': L5760(gl19z);
 'I': L5760(gl72z);
 'E': L5760(gl65z)
 _end;
 _if l4v1z _then L5462(13);
 _until input@ <> ',';
 _);
 P5702;
 _GOTO 6161;
_);
_( (* P6157 *)
6161:
 L5671;
 _if (input@ = '%') _then _(
 _while (input@ <> gl48z) _and (input@ <> chr(172B)) _do  get(input);
_) _else _if (input@ = '$') _then _(
 get(input);
 (a) _if  (input@ _in letter) _then _(
 P5643;
 _if (tok = 'ЕND') _then _(
 gl73z := false;
 _) _else _(
 l3v21z := tok;
 L5671;
 _if _not (input@ _in letter) _then _exit a; _(
   P5643;
   _select
  (l3v21z = 'DЕF'): _(
   gl73z := false;
   gl45z := tok;
 _);
 (l3v21z = 'ВЕG'): _(
    gl73z := tok <> gl45z;
    gl26z := gl24z;
 _); 
 (l3v21z = 'INС') _and _not gl73z: _(
 _if gl20z _then  P3027( (2) );
 gl46z :=   L5172( tok );
 P5561;
 gl20z := true;
 _);
 true:  _exit a
 _end
 _);
 _);
 _goto 6161;
 _);
 P3027( (6) );
_) _else (block) _( (*6244*)
  _if (input@ = gl48z) _then _(
     gl24z := (gl24z + (1));
     gl23z := 0;
     get (input);
   _) _else _( _if gl73z _then _(
     _if (input@ = chr(172B)) _then  P3027(1) _else _(
       _if (input@ = '''') _then _(
         get(input);
         _while (input@ <> '''') _and (input@ <> chr(172B)) _do get(input);
         _if (input@ = '''') _then  get(input);
       _) _else _(
          _if (input@ = '(') (*)*) _then _(
            get(input); _if (input@ = '*') _then P5702;
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
 gl52z := (1);
 P5643;
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
 _if (gl422z[l3v14z][1] = l3v16z.a) _then _(
 gl52z := (7);
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
 gl52z := (7);
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
 gl52z := 2;
 _if _not (input@ _in letter ) _then _(
 _if (* ( *) (input@ = ')') _or (input@ = '(') (* ) *) _then _(
   _if (input@ = '(') (* ) *)_then tok := 'ВЕGIN' _else tok := 'ЕND';
    get(input);
 _) _else _(
    gl52z := 0;
    exit
 _)
 _) _else
   P5643;
 6462:
 gl53z := 1;
 gl51z := chr(254);
 exit
 _); (* 6465 *)
 _if input@ <= '9' _then _(
 gl52z := 3;
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
 gl11z := gl26z;
 gl52z := (5);
 _if (input@ > '9') _then L5462( (8) ) _else _(
 _repeat
   gl11z := 10.0 * gl11z + ord(input@);
   l3v43z := l3v43z - 1;
   get(input);
 _until (input@ > '9');
 _)
 _); (* 6620 *)
 _if (input@ = 'E') _then _(
 _if (l3v43z = (0)) _then _( gl11z := gl26z; gl52z := (5); _);
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
    _if l3v18z _then gl11z := gl11z / l3v20z _else gl11z := gl11z * l3v20z;
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
   _if (input@ = chr(125B)) _then P5617 _else _(
      _if (input@ = '''') _then _( get(input); _if (input@ <> '''') _then _exit loop; _);
      _if (modeA = 0) _then MAPГA( input@,  input@);
   _);
   _if (l3v14z = 12) _then _( L5462( (4) ); _exit loop _);
   l3v1z[l3v14z] := input@;
   l3v14z := (l3v14z + (1));
  _goto loop;
  _); (* 6755 *)
  pck(l3v1z[l3v14z-6], tok);
  _if (l3v14z > (7)) _then  gl52z := (4) _else  gl52z := (6);
  _goto 6462;
  _) _else _( (* 6767 *)
     gl52z := (4);
     gl30z := (0);
    gl60z := false;
    l3v15z := (0);
    _while (l3v15z <= (250)) _do _(
    l3v21z := '000000';
    unpck(l3v1z[0], l3v21z);
    l3v14z := (0);
    (* 7001 *)
    _);
    L5462(1);
    _);
 _); (* 7060 *)
 gl52z := 0;
 _if (input@ = chr(253)) _then _(
    get(input); gl51z := chr(128);
    exit
  _); (* 7065 *)
_);
_( (* P26222 *)
P6157;
_);

_(
  P3027(4); P3110(getDate, 5); P3330; printOct(0); P26222(tok, ptr(ord(curIdent)));
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
write('############################################################################################');
write('############################################################################################');
write('############################################################################################');
write('############################################################################################');
write('############################################################################################');
write('############################################################################################');

write('################################################');
write('########################');
write('############');
 write('######');
% write('######');
27721:;
_).
