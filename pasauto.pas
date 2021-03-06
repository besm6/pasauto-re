(*=p-,t-,m-,c-,k8*)_program compil;
_label 27721;
_const spaces='      ';sp=' ';
asg='≡200';                     % The character escape symbol is a la CDC 6600
c4096=4096;T=true;F=false;O='0';
branch='branch';back='back';kexit='exit';select='select';not='not';and='and';or='or';
label='label';type='type';with = 'with';downto='downto';for='for';repeat='repeat';
until='until';while='while';do='do';to='to';go='go';if='if';then='then';else='else';
goto='goto';begin='begin';in='in';kdiv='div';mod='mod';extern='extern';const='const';
var='var';functi='functi';proced='proced';nil='nil';record='record';case='case';
of='of';end='end';array='array';file='file';set='set';
(*=a0*)
icomma=',';icolon=':';ieq='=';e050='Э050';asn='СД';vm='ВМ';yta='МР';xts='СМ';
mv='МВ';utm='СА';pi='ПИ';aox='ЛС';wtc='ИК';ntr='РА';mul='АУ';div='АД';add='АС';
rsub='ОВ';xxta='СЧ';utc='ИА';sub='АВ';vtm='ПА';ita='ВИ';uj='ПБ';u1a='У1';uza='У0';avx='ИЗ';
aex='СР';vjm='ПВ';atx='ЗЧ';aax='ЛУ';z64='Z64';bp='10';bputc='10ИА';istar='*';
(*=a1*)zz='z';c127=127;i6=6400000000000006C;c100=100;
auANY=0;auINT=1;auSETINT=2;auFL=3;auSETFL=4;
_type
bitset=_set _of 0..47;
letter = 'a'..'z';
int=integer;bool=boolean;
word=_record _case int _of
0:(a:alfa);
1:(b:bitset);
3:(i:int);
6:(id:idptr);
8:(r:real)
_end;
 typchain = _record
    nxt:@typchain;
    t1,t2:idptr
 _end;
 labels = _record num, line:int; lev, lab:alfa; nxt: @labels; def: bool _end;
 class = (cType, cConst, cVar, cFun, cField, cCase, c6);
 kind = (kSc, kRng, kPtr, kSet, kArr, kRec, kFile, kAlias);
%
% For variable size record allocation, a hack "new(ptr; up_to_field)" is used.
%
 ident = _record
    nm, lev:alfa;
    nxt:idptr;                                                  % next in hash
    bas:idptr;                                                  % std proc/func: index
                                                                % scalar: list of enums
    _case cl:class _of
    cType:(sz:int;                                              % type: size in words
      _case k:kind _of                                          % type kind
      kRng: (lo, hi: int);                                      % range: bounds
      kSc: (max: int;                                           % scalar: maxval
            lstoff: alfa);                                      % offset of enum names
      kArr: (rng:idptr;                                         % array: range(s) list
             eszoff:alfa);                                      % offset of elt size constant
      kFile:(pck:int)                                           % file: packed flag
    );
    cVar:(vty:idptr;                                            % variable: type
    off:alfa;                                                   % offset within frame
    trace:bool);                                                % tracing requested
    cConst:(ety:idptr;                                          % enum: type
    eoff:alfa;                                                  % offset in constants
    nxtelt:idptr);                                              % next contained object
    cField:(fld5, fld6, fld7, fld8:idptr);
    cCase:(cs5:word;
    cs6:int;
    cs7, cs8:word);
    cFun:(fty:idptr;                                            % proc/func: return type
    desc:alfa;                                                  % offset of parameter descriptor
    alist:idptr;                                                % arg list
    lbl, orignm:alfa;                                           % autocode label, orig name
    args:int;                                                   % arg count
    chain, setup: idptr)                                        % siblings; setup looks unused
 _end;
 idptr = @ident;
 ekind = (ekCONST, ek1, ek2, ek3);
 expr = _record ek:ekind; off, reg:alfa; ty:idptr; in:pInst; inv: int _end;
 aumode = int;
 inst = _record nxt:pInst; au:aumode; m, op, a:alfa _end;
 pInst = @inst;
 tkind = (tk0, tkIdent, tkWord, tkInt, tkStr, tkReal, tkChar, tkField);
 extFile = _record nm:alfa; nuz, len:int; def: bool; nxt: @extFile _end;
_var
   modeB:int;
   rval:real;
   hasFiles, hasExtFiles, modeF,
   modeG, u16z, modeDe, modeCH, modeeL,
   inInclude: bool;
          errcnt, maxerr, nLex, lineNum, hash, ival, curWith, nWith, poolIdx,
   strLen, poolStart, poolAddr, dynMem, modeK, reqAU, curAU:int;
   XTA, tok, level,
   two, curOff, curLab,
   nilOff, basReg, defSection,
   fname:alfa;
   u47z: @int;
   endl, seqGOST, seqITM, prev: char;
   tokKind:tkind;
   lookup, undefCnt, modeA:int; cv:word;
   allowUndef, allowLong, modeC,
   known, leftInsn, needToken, unsigned, errSeen, modeE, modeP, modeT, modeR, modeM,
   modeL, silent, modeI, skipping, modeX: bool;
   curId, fwdProcList, curRec,
   textFile, inFile,  outFile, ptrType, setType,
   boolType, intType, realType, charType, alfaType,
   dummyId:idptr; extCnt,
   entrCnt, elapsed, savedNum:int;
   stdin:_array[0..4] _of int;                           % saved state of stdin
   modeV, modeS: bool;
   g100z, noDisplay, octal, doOctal: bool;
   curExtF, extFList:@extFile; extFcnt:alfa; funcHelper, gotoHelper, varHelper:bool;
   rets: _array [3..8,1..6] _of alfa;
   extras: _array [1..17] _of alfa;
   idTable, idTabA: _array[0..127] _of idptr;
   withs: _array [0..18] _of expr;
   dummy:_array [1..4] _of char;
   pool: _array[1..4096] _of int;
   labList:@labels; tchain:@typchain; extSym, entryS:_array [0..100] _of char;
   u4837z, u4838z:int;
(*=c+*)
_proced wrInt(i:int);
_(
  write(i:0)
_);

_proced wrFName;
_(
  _if inInclude _then _(
    ГГ('*ФАЙЛ ', fname);
    writeLN
  _)
_);
(*=c-*)_proced fatal(i:int);(*=c+*)
_(
 rewrite(output);
 wrFName;
 _select
 i = 0:  write('ВСТРЕТИЛСЯ КОНЕЦ ФАЙЛА');
 i = 1: _( write('НЕ ЗАКРЫТА УСЛ СЕКЦИЯ'); ГГ(' СТР.='); wrInt(ival)_);
 i = 2: _( write('ВЛОЖЕННОСТЬ !'); ГГ(' СТР.='); wrInt(lineNum)_);
 i = 3: write('НЕ ЗАКРЫТ КОММЕНТАРИЙ');
 i = 4: _( ГГ('ФАЙЛ ', fname); write(' НЕ НАЙДЕН') _);
 i = 5: _( ГГ('В '); wrInt(lineNum); write(' СТРОКАХ ОБНАРУЖЕНО ');
         wrInt(errcnt); ГГ(' ОШИБ.') _);
  T: _( write('ОШ ПРЕПРОЦЕССОРА'); ГГ(' СТР.='); wrInt(lineNum) _)
  _end;
 writeLN;
 code(ПБ76002=,);
_);
(*=c-*)_proced errMsg(a:alfa; i: int);(*=c+*)
_(
rewrite(output);
wrFName;
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
   wrInt(ival);
   _select
    i = 2: write(' ОТСУТСТ В СПИСКЕ МЕТОК');
    i = 3: _(  write(' УЖЕ ОПРЕД В СТРОКЕ '); wrInt(cv.i) _);
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
  (i = 2)| (i = 3): write('ТРЕБУЮТСЯ ДРУГИЕ ТИПЫ ОПЕРАНДОВ')
  _end
_)
_end
_);
(*=A0,c- code generation *)
_proced P3330;
_var i, j, ii, m:int; a: alfa;(*=c+*)
_proced varF1(a31:alfa);
_(
 ГГ('F', a31);
 write(':УИ15=15И1');
 ГГ(a31);
 write(',ЛУZ64=У');
 _if (j _IN [13,15]) _then output@ := '0' _else output@ := '1';
 put(output);
 ГГ('O', a31);
 write(',15ПА');
 write(j:0);
 write('=ПБМI,');
 _if j = 15 _then
 write('Э;ОРF:РО,ОGF:GI,ОRWF:RО,К;ОRF:16ПИ15=ПБRI,')
 _else j := j+1
_);
_proced varF2(a31:alfa);
_(
 ГГ('F', a31, ':12ПА', a31, '=14ПАО', a31);
 write(icomma);
 _if j = 25 _then
 write('FW:УИ15=15И0FW(2),17СЧ=12ПБ,ЛУZ64=У0FW(4),17СЧ=14ПБ,15ПА21=ПБМI,')
 _else ГГ('ПБFW=,');
 j := j+1;
_);
_( (* P3330 *)
 write('У;А1,К;');
 _for i := 3 _to 8 _do _for j := 1 _to i-2 _do _(
   a := rets[i,j];
   _if a # O _then _(
     ГГ(a);
     write(icolon);
     ii := i;
     ГГ('13ПИ');
     mapia(i, a);
     ГГ(a);
     _while ii >= j+2 _do _(
       ГГ('=', a, 'СЧ2,УИ');
       m := ii-1;
       mapia(m, a);
       ГГ(a);
       ii := ii-1;
     _);
     ГГ('=16ПБ,')
   _)
 _);
_if extras[17] # O _then
% INS
 write('IS:17СЧ=ИЗЧМ1,УМ11=11СД100,СРИА=17СМ-2,11СД100=17ЗЧ-2,15СР=17ЛУ,17СР=15ЗЧ,16ПБ=,');
_if modeX _then _(
 ГГ('Э;Z1:');
 _if extras[15] # UTC _then ГГ('Z8,') _else ГГ('Z1Z,');
 write('ОРF:РО,ОGF:GI,ОRWF:RО,К;');
_) _else _(
  i := 1;
  _while i <= 16 _do _(
   _if extras[i] # O _then _case i-1 _of
   0: write('Э;СОС:ИА(1236),СОЯ:СОС(1),К;DS:14СЧ=УИ14,ВИ12=СР13,У0DS(6)=СЧСОС,14ЗЧ=ВИ12,14ЗЧ1=ВИ14,ЗЧСОС=16ПБ,СЧСОЯ=14ЗЧ,ВИ14=ЗЧСОЯ,16ПБ=,');
% Proc/func entry helpers
   1,2,3,4,5,6:write('Z', i:0,':РА3=ВИ13,17ПИ13=17ПИ',i:0,',ВМ16=ВМ',(i-1):0,',13ЗЧ2=14ПБ,');
   7: write('ПА:УИ15=15И0ПА(4),15СЧ=У1ПА(3),15СЧ1=ИА,УИ15=16ПБ,ЛУZ64=У0ПА(7),1ИА10=15ПА,16ПБ=,1ИА7=15ПА,16ПБ=,');
   8: _( write('ВИ:УИ15=15И0ВИ(2),'); write('15СЧ2=16ПБ,ЛУZ64=16У0,СЧ13=16ПБ,') _);
% Basic routines for formal parameters-files
   9: _( j := 12; varF1('РF'); varF1('GF');varF1('RWF');varF1('RF') _);
% Write routines for formal parameters-files
  10: _( j := 20; varF1('WS'); varF2('WС');varF2('WА');varF2('WВ');varF2('WI');varF2('WR');varF1('WL')_);
% ROUND
  11: write('АС:РА=15ПААС+2,15АС=ПБТR,Ч;0.5,К;');
  12: write('ПБ:1ПИ15=16ПВRС,13СЧ1=СД117,СД37=У0Е,ПБЕF=,');
% BRANCH
  13: write('ТОШ:17ЗЧ=16ПВRО,11СЧ=14ПВГГ,СЧ=17СМ-2,16ПВОWI=,16ПВРR=,1СЧLI=У076002,17СЧ=ПБВА,ЕА:ВМ15=1СМLI,17ПИ15=ВМ15,1ЗЧLI=РА3,16ПБ=,NА:ВИ15=1ИКLI,ЗЧ-1=16ПБ,FА:1ИКLI=17ПА-2,17СЧ2=1ЗЧLI,РА3=16ПБ,ВА:РА3=ВМ13,1АВLI=У1ВА1,ВА3:13СЧ1=СД117,17ЗЧ=14ПА77777,ВИ14=17ЛУ,У0ВА2=УИ14,14ИА=14ПВ,ВА2:13СЧ=УИ13,ВА6:1АВLI=У0ВА3,15ПАВА4=16ПВВА8,ВА7:1ИКLI=СЧ,У0ВА5=1ЗЧLI,ВИ13=ПБВА6,ВА5:15ПАВА9=16ПВ76005,ПБПБ=,А;ВА9:ВЫХОД
,ПО АLТ,С;3640000000000000,К;ВА8:17СЧ-1=15У0,1ИКLI=СР-2,15У0=1ИКLI,СЧ-2=15У0,16ПБ=,ВА4:ВИ13=14ПВRSR,ВА10:1ИКLI=17ПА1,17ИК-2=ПБ,ВА1:15ПАВА10=16ПВВА8,ПБВА7=,FАМ:16ПВFА=,15КЦFАМ=12ПБ,');
% Database procedures (OPEND, GETD, PUTD, etc.)
  14: _( _if extras[15] = UTC _then write('Z1:РА3=СЧ5,') _else
         write('ВDОШ:ЗЧ1=16ПИ15,16ПВ76005=,11ПАВDТ=ПБТОШ,А;ВDТ:ОШВD= ,К;ВD:ВИ4=11ЗЧ33,11ПИ4=15ИАВDVЕС,СЧ=4ЗЧ3,4ПБ2=,С;ВDVЕС:0,0,2512141131,26211511,221411,27231411,201411,К;Z1:РА3=СЧ6,СД66=УИ4,СД54=ЛС74014,ЗЧ2=Э0702,ИК5=СЧСЧ1,ЗЧ1=4ПИ5,ВИ4=ЗЧ5,5СА2000=ВИ5,4ЗЧ16=5СА2000,ВИ5=4ЗЧ17,5СА2000=СЧ1,5ЗЧ1=2ПАВDОШ,ВИ2=4ЗЧ11,ВИ5=,');
      write('УИ1=1ПИ17,1ПИ13=15ПВRI,СЧ=1ЗЧLI,14ПИ16=ПБRО,');
  _);
% Parameter count/type checking for formal parameters-routines
  15: _(
   write('ПВ:ВИ15=ВМ13,СД61=17ЛС,16ПБ=,ВП7:ВИ16=ВМ13,12СМ=СД117,17ЗЧ=12ИК,ПБ=,ВП6:17СЧ=УМ13,УИ16=16ПБ,ВП:17СИ11=11ПИ13,ВП1:12СЧ=У0ВП2,11СР3=У0ВП3,12СЧ=СР13,У1ВПШ=11СЧ3,СР');
 ГГ(two);
 write('=У0ВП4,СР13=У1ВПШ,17СА100=ВИ11,ВМ12=ВМ13,ВМ14=ВМ15,17ЗЧ=11ИА2,12ПА=12ИК,СЧ4=У1ВПШ,12СЧ=СД117,14ПВRSR=,12ИК=16ПВ,17СЧ=УМ15,УМ14=УМ13,УМ12=УИ11,17СЧ10=17СА-100,ПБВП5=,ВП4:11ИК2=СЧ,ВП5:13ЗЧ2=13СА1,12СА1=11СА2,ПБВП1=,ВП3:11СЧ2=ПБВП5,ВП2:11СЧ3=У1ВПШ,17СЧ=ПБRSR,ВПШ:17СЧ=14ПВRSR,11ПАВПТ=СЧ13,ПБТОШ=,А;ВПТ:ФПАРОШ,К;');
  _)
   _end; i := i+1
  _);
_);
_);
_function getDate:alfa;
_var k:int;l:alfa;
_(
  k:=00003777776Т;l:='3 1   ';
  СОDЕ(Э050114=,2СБ4=2РБ5,СД120=2ЗЧ4,МР=СД70,2ЗЧ5=МР,2СМ5=СД140,17ЛС=2СМ4,СД60=17ЛС,);
  getDate:=;
_);
_procedure printOct(v:alfa);
_(
  code(=11ПА-17,qqq1:2СЧ3=СД/-3/,2ЗЧ3=МР,); output@:=;put(output);code(11КЦqqq1=)
_);

(*=c- L 2*)_procedure programme(_var a21:alfa; _var a22:idptr);
_label 26505, 26607, 26631, 27117, 27375, 27404, 27420;
_const (*=a1*)block='БЛОК';
arrow='@';dot='.';oparen='(';colon=':';semi=';';lt='<';gt='>';
star='*';slash='/';minus='-'; plus='+';eq='=';neq='#';qu='''';
comma=',';cparen=')'; obrack='[';cbrack=']';(*=a0*)
one='13';zero='12';e48=4T;
% for form1
fLD=3;fTRUNC=4;fNEG=6;fSUB=7;fZERO=8;fLDSTK=10;fLEA=11;fUVTM15=12;fVTM11=13;
fAU23=15;fORZ64=16;fIMUL=17;fTOREAL=18;fPSH=19;fMOD2=20;fADD1=21;fSUB1=22;
fCHKPARM=24;fWTC=25;fEMPTY=26;
fXTS=27;
% for form2
fLAB=0;fGOTO=1;fU1A=2;fUZA=3;fCMD=4;fBCALL=5;fVTM15=7;fBVTM15=8;fSTKOP=9;
fPUSH=10;fCALL=11;fFIXRT=12;fST11=14;fVJM14=15;fSETREG=16;fEQ=17;fMATH=19;
fMVSTK=20;fOVFL=22;fCALL1=23;
% for cmd
cLAB=0;cGOTO=1;call14=8;cLEA=11;call16=12;cCOPY=14;
_type oneinsn=_record next:@oneinsn; mode: int; ir, op, addr:alfa _end;
_var obj1, obj2, v23,v24, v25:idptr;
v26, v27, v28, v29, v2A, v2B, v2C:alfa;
v2D,v2E:int;
v2F, v2G:ekind; v2H, v2I:int;
v2J, isFunc:bool;
v2L, v2M, lhs, newConst:idptr;
v2P, v2Q:@labels; stLabs:pInst;
v2S, constOp, constVal: int;
v2V, v2W:alfa;
(*=c+*)
_function inverse(i:int):int;
_var v31:int;v32,v33:real;
_(
v31 := e48; v33 := i; v32 := 1.0;
code(PA3=3АД7,3АC5=ЦС13,); inverse:=;
_);
_procedure alfAdd(_var ret:alfa; val:int);
_var i:int;
_(
  mapai(ret, i);
  mapia(val+i, ret);
_);
(* L 3 *) _proced putSep; _(
 _if leftInsn _then  output@ := ieq _else output@ := icomma;
 leftInsn := ~leftInsn;
 curLab := O;
 put(output);
 _);
 _proced putInsn(a31:alfa); _(
 ГГ(a31);
 putSep;
 _);
(* L 3 *) _proced modBase; _(
 _if modeX _then putInsn(BPUTC);
 _);
(* L 3 *) _proced idxBase; _(
 _if modeX _then ГГ(BP);
 _);
_proced basInsn(a31:alfa); _(
 idxBase;
 putInsn(a31);
 _);
 _proced putIarg(a31, a32:alfa); _(
 ГГ(a31, a32);
 putSep;
 _);
(* L 3 *) _proced putAlign(a31:alfa);
 _(
 ГГ(a31);
 _if leftInsn _then  write('=,')
 _else _( write(icomma); leftInsn := T_);
 curLab := O;
 _);
(* L 3 *) _proced align;
 _(
 _if ~leftInsn _then _( write(icomma); leftInsn := ~leftInsn _)
 _);
(* L 3 *) _proced setAUInt;
 _(
 _if curAU # 1 _then _( putInsn('РА7'); curAU := 1 _)
 _);
(* L 3 *) _proced metka(a31:alfa);
 _(
 align;
 ГГ(a31);
 write(icolon);
 setAUInt;
 curLab := a31;
 _);
(* L 3 *) _proced dump(K:pInst);
_const mask='070000';
_var T:alfa; N:pInst; _(
 (q)_if K = _nil _then exit;

 _with K@ _do _if nxt # _nil _then _(
   _if (op = XTA) & (nxt@.op = ATX) &
       (nxt@.m = '17') & (nxt@.a = O) _then _(
     op := XTS;
     _if m = O _then m := basReg;
     N := nxt;
     nxt := nxt@.nxt;
   _) _else _if ((nxt@.op = WTC) | (nxt@.op = UTC)) & (au # auANY) _then _(
     N := nxt;
     (loop) _while N@.nxt # _nil _do _(
       T := N@.nxt@.op;
       _if (T = UTC) | (T = WTC) _then N := N@.nxt
       _else _exit loop;
     _);
     N@.au := au;
   _);
   dump(nxt);
 _);(* 4017 *)
 _case K@.au _of
  auANY:;
  auINT: _if curAU # 1 _then _( putInsn('РА3'); curAU := 1 _);
  auSETINT: curAU := 1;
  auFL: _if curAU # 2 _then _(  putInsn('РА'); curAU := 2 _);
  auSETFL: curAU := 2
 _end; (* 4050 *)
 _if K@.m = label _then
   _if K@.a # O _then metka(K@.a) _else _(
     TNL(T);
     align;
     write('10ПВУРЕГ=,');
     ГГ(T, ':10СА-');
     putInsn(T);
 _) _else _(
 _if (K@.m # O) _then  ГГ(K@.m);
 % There is a way to write the condition below without resorting to
 % disabling type checking, by using unions and bit sets;
 % it results in differences using const 0 in location 0 vs the constant pool.
 _if (*=c-*)(K@.a & mask # 0) &
     (K@.a & 77774T = 0) &
     (K@.a & mask # mask) & (*=c+*)
     (K@.op # UTM) &
     (K@.op # UTC) &
     (K@.op # WTC) _then _(
   ГГ(UTC);
   _if K@.a # O _then putInsn(K@.a);
   ГГ(K@.op);
 _) _else _(
   ГГ(K@.op);
   _if K@.a # O _then  ГГ(K@.a);
 _);
 putSep;
 _if (K@.op = VJM) | (K@.op = 'Э050') _then align;
 _); (* 4141 *)
_);
(* L 3 *) _proced prErr(a31:alfa; a32:int);
 _(
 _if silent _then exit;
 errMsg(a31, a32);
 (*=a1 error messages *)
 ГГ('***ОШ.', a31, '='); wrInt(a32);
 ГГ(' СТР.='); wrInt(lineNum); ГГ('.NLЕХ='); wrInt(nLex);
 ГГ('.ИД=', tok, '.СИМ=', prev);
 writeln('.КОНТЕКСТ');
 code(16ПВСТХТ=,);
 errSeen := T;
 errcnt := errcnt+1;
 _if errcnt > maxerr _then _GOTO 27721;
 _);
(* L 3 *) _proced error(a31:alfa; a32:int);
 _(
 silent := F;
 prErr(a31, a32);
 _GOTO 27721;
_);

(* L 3 *) _proced sysErr(n:int);
 _(
 error('SУS', n);
 _);
(*=a0,c- L 3 *) _proced L4225(a31:int);
_var v31:alfa; v32:idptr; (*=c+*) _(
 curLab := O;
 _case a31 _of
 1: _(  ГГ('ПБЕ'); _if v2V # O _then ГГ('F')_);
 0: _(
 v32 := a22;
 align;
 _if level # '1' _then _(
   mapai(level, a31);
   extras[a31] := UTC;
 _);
 _if ~v2J  _then write(istar);
 ГГ(v32@.orignm);
 write(icolon);
 MAPЯГА(v32@.nm, v31);
 _if (v31 = v32@.orignm) _then _(
 write('10ПВУРЕГ=,10СА-');
 ГГ(v32@.orignm);
 write('(1)=14ПВСН,');
 _);
 _if v32@.vty = _NIL _then a31 := 3 _else  a31 := 4;
 v31 := ;
 _if v32@.args > 1 _then _(
  mapia(-(a31+v32@.args), v31);
  mapai(level, a31);
 _);

 _select
 v32@.args = 0: _( ГГ('14ПВZ'); putAlign(level); _);
 v32@.args = 1: _( ГГ('17ЗЧ', v31, '=14ПВZ', level); write(icomma); _);
 T: _(
 write('ВМ13=17СА');
 ГГ(v31);
 write(',РА3=17ПИ13,17ПИ', a31:0, '=ВМ16,ВМ', (a31-1):0, '=13ЗЧ2,');
 _)
 _end;
 MAPЯГА( v32@.nm, v31);
 ГГ('`', v31, '`17СА', v32@.lbl);
 curAU := 1;
 _)
 end;
 putSep;
 _);
(*=c- L 3 *) _proced cmd(a31:int; a32:alfa);
_label 4412, 4424, 4431;
_var v31:alfa; (*=c+*) _(
 _if modeX _then _select
   (a31 < 4): _if (a31 # 0) _then ГГ(BP);
   (a31 = 11) | (a31 = 10) | (a31 = 8): putInsn(BPUTC)
 _end;
 _case a31 _of
cLAB: _(
 align;
 ГГ(a32);
 write(icolon);
 curLab := a32;
 exit;
_);
cGOTO: _(
 ГГ(UJ);
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
cCOPY: _(
 ГГ('15ПА-', a32); putSep; TNL(v31); metka(v31);
 write('12ИА=15СЧ'); ГГ(a32); write(',16ИА=15ЗЧ'); ГГ(a32);
 write(icomma);
 _if modeX _then _( write('10ИА=15КЦ'); ГГ(v31); write(icomma); exit _)
 _else _( ГГ('15КЦ', v31); _)
_)
_end;
 putSep;
_);
(* L 3 *) _proced P4511(a31:int; a32, a33:alfa);
 _(
 _select
 a31 = 5: _(
 align; modBase;
 ГГ('15ПА', a32); write('=ВИ15,СД'); ГГ(a33);
 write('=13ЛС1,13ЗЧ1'); putSep;
 _);
 a31 = 6: _(
 ГГ('12ПА-', a33); putSep; modBase;
 ГГ('15ПА', a32); putSep; putAlign('14ПВГТ');
 _);
 T: ГГ('Э;', a32, icolon, a33, ',К;')
 _end
 _);
(*=c- L 3 *)_proced init;
_var i:int;
(*=c+*)
(* L 4 *) _proced preDecl(a41:alfa; _var a42:idptr);
_var v41:int; v42:idptr; _(
 new(v42; lstoff);                              % predeclared objectsare made of same size 9
 (*=c-*)mapai(a41 & '177', v41);(*=c+*)
 v42@ := [a41, 0, idTable[v41], _NIL, 0, 1, 0];
 idTable[v41] := v42; a42 := v42;
 _);
(* L 4 *) _proced declConst(a41, a42:alfa);
_var v41:idptr; _(
 preDecl(a41, v41);
 v41@.cl := cConst;
 v41@.vty := curId;
 v41@.off := a42;
 _);
(* L 4 *) _proced declStFun(name:alfa);
_var p:idptr; _(
 new(p; fty);
 (*=c-*)mapai(name & '177', i);(*=c+*)
 p@ := [name, 0, idTable[i], , cFun, curId];
 p@.bas := ptr(ival);
 ival := ival+1;
 idTable[i] := p;
 _);

_( (* init *)
u4837z := 75B; u4838z := 313B;
i := 0;
 _while i <= 127 _do _(
   idTable[i] := _NIL;
   idTabA[i] := _NIL;
   i := i+1;
 _);
 modeA := 1;  modeB := ; lineNum := ; level := ; modeC := ; leftInsn := ; needToken := ; modeM := ;
 noDisplay := ;
 modeR := ; modeP := ; modeT := ; curAU := ;
 fname := spaces;
 reqAU := 0; modeE := ; dynMem := ; nWith := ; lookup := ; nLex := ; extFcnt := ;
 two := ; errSeen := ; silent := ; hasFiles := ; hasExtFiles := ; defSection := ; skipping := ; modeF := ; modeG := ;
 modeV := ; modeS := ; funcHelper := ; gotoHelper := ; varHelper := ;
 modeDe := ; modeCH := ; modeeL := ; octal := ; doOctal := ;
 inInclude := ; modeL := ; unsigned := ; allowLong := ; modeX := ; basReg := ;
 XTA := xxta;
 endl := chr(175B);
 extCnt := -1; entrCnt := ;
 modeK := 100;
 poolStart := ord(ref(pool[9]));
 poolAddr := poolStart-9;
 u47z := _NIL;
 tchain := ;
 curId := ;
 curRec := ;
 labList := ;
 extFList := ;
 errcnt := 0;
 maxerr := 10;
 nilOff := '11';
 pool[9] := ord(_NIL);
 pool[9+1] := 0;
 pool[9+2] := 1;
 poolIdx := 11;
 (*=a1*) seqGOST := 'А';
 MAPГA(seqGOST, seqITM);
 TNL(seqITM);
 i := 1;
 _while i <= 17 _do _(
   extras[i] := O;
    i := i+1;
 _);
  (*=a0*)extras[15] := UTC;
 i := 3;
 _while i <= 8 _do _(
 v2E := 1;
 _while v2E <= i-2 _do _(
   rets[i,v2E] := O;
 v2E := v2E+1;
 _);
 i := i+1;
 _);
 (*=a1*)
 preDecl('ВООLЕА', boolType);
 preDecl('INТЕGЕ', intType);
 preDecl('СНАR',   charType);
 preDecl(O, setType);
 setType@ := [,,,intType,,,kSet];
 preDecl('RЕАL', realType);
 preDecl('00АLFА', alfaType);
 preDecl('0УКNIL', ptrType);
 ptrType@.k := kPtr;
 curId := boolType;
 declConst('FАLSЕ', zero);
 declConst('ТRUЕ', one);
 preDecl('ТЕХТ', textFile);
 textFile@.bas := charType;
 textFile@.k := kFile;
 textFile@.sz := 30;
 textFile@.pck := 8;
 preDecl('INРUТ', inFile);
 inFile@.cl := cVar;
 inFile@.vty := textFile;
 inFile@.off := '7';
 preDecl('ОUТРUТ', outFile);
 outFile@.cl := cVar;
 outFile@.vty := textFile;
 outFile@.off := '10';
 fwdProcList := intType;
 curId := _NIL;
 ival := 0;
 declStFun('РUТ');    % 0
 declStFun('GЕТ');    % 1
 declStFun('RЕWRIТ'); % 2
 declStFun('RЕSЕТ');  % 3
 declStFun('NЕW');    % 4
 declStFun('UNРСК');  % 5
 declStFun('РСК');    % 6
 declStFun('ЕХIТ');   % 7
 declStFun('РRINТО'); % 8
 declStFun('НАLТ');   % 9
 declStFun('МАРIА');  % 10
 declStFun('МАРАI');  % 11
 declStFun('ТNL');    % 12
 declStFun('ГГ');     % 13
 declStFun('МАРГА');  % 14
 declStFun('МАРЯГА'); % 15
 declStFun('СОDЕ');   % 16
 declStFun('SЕТUР');  % 17
 declStFun('RОLLUР'); % 18
 declStFun('WRIТЕ');  % 19
 declStFun('WRIТЕL'); % 20
 declStFun('DISРОS'); % 21
 declStFun('RЕАD');   % 22
 declStFun('RЕАDLN'); % 23
 declStFun('ОРЕND');  % 24
 declStFun('РUТD');   % 25
 declStFun('GЕТD');   % 26
 declStFun('DЕLD');   % 27
 declStFun('МОDD');   % 28
 declStFun('NЕWD');   % 29
 declStFun('ВIND');   % 30
 declStFun('INS');    % 31
 ival := 0;
 curId := realType;
 declStFun('SQRТ');   % 0
 declStFun('SIN');    % 1
 declStFun('СОS');    % 2
 declStFun('АRСТАN'); % 3
 declStFun('АRСSIN'); % 4
 declStFun('LN');     % 5
 declStFun('ЕХР');    % 6
 declStFun('АВS');    % 7
 curId := intType;
 declStFun('ТRUNС');  % 8
 curId := boolType;
 declStFun('ОDD');    % 9
 curId := intType;
 declStFun('ОRD');    % 10
 curId := charType;
 declStFun('СНR');    % 11
 declStFun('SUСС');   % 12
 declStFun('РRЕD');   % 13
 curId := boolType;
 declStFun('ЕОF');    % 14
 curId := ptrType;
 declStFun('RЕF');    % 15
 declStFun('РТR');    % 16
 curId := intType;
 declStFun('SQR');    % 17
 declStFun('RОUND');  % 18
 declStFun('SЕL');    % 19
 declStFun('САRD');   % 20
 declStFun('МINЕL');  % 21
 curId := boolType;
 declStFun('ЕОLN');   % 22
 declStFun('SНIFТ');  % 23
_);
(*=a0*)
(*=c- L 3 *) _function withSp(a31:alfa):alfa;
_var a:_array [0..12] _of char; i:int; (*=c+*)
_(
 unpck(a[1], a31);
 a31 := spaces;
 unpck(a[7], a31);
 i := 1;
 _while i <= 6 _do _(
 _if a[i] # chr(0) _then _(
    pck(a[i], a31);
    withSp := a31;
  exit;
 _);
 i := i+1;
 _)
 _);
(* L 3 *) _proced orExp64(_var a31:int; _var a32:int);
 _( code(=15ПА15,ВИ15=СД/4/,MP=3ИК3,ЛС=); a32 := ;
 _);
(* L 3 *) _proced putConst(_var offset:alfa; force:bool);
_var i:int; _(
 _if ~force _then _(
 poolStart := poolStart;
 code(=УИ5,);
 i := 9-poolIdx;
 code(=УИ4,);
 cv := cv;
 code(ЗЧ1=,find:СЧ1=5CP,У0done=5CA1,4КЦfind=);
 _);
 poolIdx := poolIdx+1;
 _if poolIdx >= 4096 _then sysErr(23);

 pool[poolIdx] := cv.i;
 mapia(poolIdx, offset);
 exit; code(done:ВИ5=);
 i := ;
 i := i-poolAddr;
 mapia(i, offset);
 _);
(* L 3 *) _proced forceName(arg:alfa);
_var dum:char; a: _array[1..12] _of char;
 i:int; res:alfa; _(
 unpck(a[6], arg);
 i := 6;
 _while a[i] = chr(0) _do i := i+1;
 arg := spaces;
 unpck(a[i-6], arg);
 pck(a[6], res);
 cv.a := res;
 putConst(curOff, T);
 _);
(* L 3 *) _proced putName(arg:alfa);
_var dum:char; a:_array [1..12] _of char;
 i:int; res:alfa;  _(
 unpck(a[6], arg);
 i := 6;
 _while a[i] = chr(0) _do i := i+1;
 arg := spaces;
 unpck(a[i-6], arg);
 pck(a[6], res);
 cv.a := res;
 putConst(curOff, F);
 _);
(* L 3 *) _proced mkCheck(typ: idptr; inline:bool);
_var over, check, lo, span:alfa; _(
 _if typ@.nm = O _then _(
   _if inline _then _(
     TNL(over);
     idxBase;
     putIarg(UJ, over);
     align;
   _);
   TNL(check);
   metka(check);
   basInsn('ЗЧ1');
   typ@.nm := check;
   cv.i := typ@.lo;
   putConst(lo, F);
   cv.i := typ@.hi-cv.i;
   putConst(span, F);
   idxBase; putIarg(SUB, lo);
   putInsn('15У1');
   idxBase; putIarg(RSUB, span);
   putInsn('15У1');
   basInsn('СЧ1');
   putAlign('16ПБ');
   _if (inline) _then  metka(over);
 _);
_);
(* L 3 *) _proced dumpNames(obj:idptr);
_var p:idptr; _(
 _if obj@.lstoff = O _then _(
   p := obj@.bas;
   forceName(p@.nm);
   obj@.lstoff := curOff;
   (loop) _(
     p := p@.nxtelt;
     _if p = _NIL _then exit;
     forceName(p@.nm);
     _goto loop
   _)
 _)
_);

(*=c- L 3 *) _proced getT;
_label 6161, 6304, 6335, 6462;
_const max = 1000000000000;
_var v31:_array [0..12] _of char;
v3E, l3v15z:int;
l3v16z,
l3v17z:idptr;
l3v18z:bool;
l3v19z, l3v20z:real;
l3obj1z:alfa;
l3a21z: _array [1..20] _of char;
l3v42z, l3v43z:int;
(*=c+*)
(* L 4 *) _proced digraph(x, y:char);
_var c:char; _(
 c := input@; get(input);
 _if (input@ = x) _then _(
     prev := y; get(input);
 _) _else  prev := c;
_);
(* L 4 *) _proced L5462(a41:int);
 _( (*=a1*)
 prErr('SСАN', a41);
 _if a41 < 5 _then _(
 _case a41 _of
 0:;
 1: ival := 1;
 2, 3, 4: _(
 _while input@ # qu _do get(input);
 get(input);
 _GOTO 6462;
 _)
 _end
 _)
 _); (*=a0*)
(* L 4 *) _proced readZone(nuz:int);
 _(
 nuz := 001034T+nuz; code(4Э0703=,)
_);
_proced closeFile; _var p:@int; _(
 lineNum := savedNum;
 p := ref(stdin);
 code(=УИ11,11СЧ=ЗЧ75211,11СЧ1=ЗЧ75212,11СЧ2=ЗЧ74221,ЦC75211=17ЗЧ1,17Э0701=,11СЧ3=ЗЧ74220,11СЧ4=ЗЧ75225,ИК75225=СЧ,ЗЧ74217=СЧ74215,17ЗЧ1=CP74220,У1qne=СЧ75225,УИ15=15СЧ-1,ЛУ74330=);
 input@ := ;
 exit;
 code(qne:СЧ74217=СД/-10/,ЗЧ74217=MP,);
 input@ := ;
code(=17СЧ1,СД/1/=17ЗЧ1,CP74220=У1qne,);
_);
(* L 4 *) _proced setFile(a41, a42:int);
_var v41:int; _(
 v41 := 001034T;
 code(=4цс3,зч75211=4сч4,ав13=зч75212,)
 _);

(* L 4 *) _proced openFile;
 _var nuz, v42, v43 : int; v44: alfa;
_(
%stdin[0]                  : = *75211;
%stdin[1]                  : = *75212;
%stdin[2]                  : = *74221;
%stdin[3]                  : = *74220;
%stdin[4]                  : = *75225;
code(=сч75211,1зч135=сч75212,1зч136=сч74221,1зч137=сч74220,1зч140=сч75225,1зч141=);
 savedNum := lineNum;
lineNum := 1;
 readZone(270037C);
 code(сч71776=СД/-36/,СД/36/=);
 nuz := ;
 readZone(nuz);
 code(11ПА70001=12ПА77600,L5601:11СЧ=);
 v44 :=;
 _if v44 = fname _then _(
 code(=11СЧ1,СД/30/=4ЗЧ4,MP=СД/30/,4ЗЧ5=);
 setFile(v42+nuz, v43);
 reset(input);
 exit;
 _);
 code(11CA2=12КЦL5601,);
 fatal(4);
_);
 (* L 4 *) _proced escChar;
_var i:int; _(
 get(input);
 _if input@ > '3' _then  L5462(2);

 ival := ord(input@);
 i := 1;
 _while i <= 2 _do _(
   get(input);
  _if input@ > '7' _then _(
   L5462(3);
    exit;
  _);
 (*=m-*)ival := ord(input@)+ival*8;
 i := i+1;
_);
 input@ := chr(ival);
 _);
 (* L 4 *) _proced getId;
_var t:alfa; i:int; _(
 t := O;
 i := 1;
  _while (input@ _in letter) | (ord(input@) < 10) _do _(
 _if i < 7 _then _(
    i := i+1;
    code(4СЧ3=СД/-10/,1ЛС7=4ЗЧ3,) (* t := (t << 8) | input@ *)
 _);
 get(input);
 _);
 tok := t;
_);
(* L 4 *) _proced skipSp;
 _(
   _while (input@ = sp) | (input@ > asg) _do get(input);
 _);
(* L 4 *) _proced skipComment;
_label 5704;
_var c:char; _(
 5704:
 c := input@;
 _if c = chr(172B) _then fatal(3);
 get(input);
 _select
 (c = star) & (input@ = cparen): _( get(input); exit _);
 (c = oparen) & (input@ = star): _( get(input); skipComment _);
 c = endl                      : _( lineNum := lineNum+1; nLex := 0 _)
 _end;
 _goto 5704
_);

(* L 4 *)_proced doComment;
_var bad:bool;
(* L 5 *) _proced intRange(_var res:int; lim:int);
 _(
 get(input);
 res := 0;
 bad := T;
 _if input@ <= '9' _then
 _while input@ <= '9' _do _(
 res := res*10+ord(input@);
 get(input);
 bad := F;
 _);
 _if res > lim _then  bad := T;
_);
(* L 5 *) _proced plmin(_var v:bool);
 _(
 get(input);
 _if (input@ = minus) | (input@ = plus) _then _(
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
 'F': _( plmin(modeF); _if modeF _then  funcHelper := T_);
 'P': plmin(modeP);
 'G': _( plmin(modeG); _if modeG _then  gotoHelper := T_);
 'T': plmin(modeT);
 'V': _( plmin(modeV); _if modeV _then varHelper := T_);
 'A': intRange(modeA, 1);
 'S': _( plmin(modeS); _if modeS _then  varHelper := T_);
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
 _until input@ # comma;
 _);
 skipComment;
 _GOTO 6161;
_);
_( (* getT *)
6161:
 skipSp;
 _if input@ = '%' _then _(
 _while (input@ # endl) & (input@ # chr(172B)) _do  get(input);
_) _else _if input@ = '$' _then _(
 get(input);
 (a) _if  input@ _in letter _then _(
 getId;
 _if tok = end _then _(
 skipping := F;
 _) _else _(
 l3obj1z := tok;
 skipSp;
 _if ~(input@ _in letter) _then _exit a; _(
   getId;
   _select
  (l3obj1z = 'DЕF'): _(
   skipping := F;
   defSection := tok;
 _);
 (l3obj1z = 'ВЕG'): _(
    skipping := tok # defSection;
    ival := lineNum;
 _);
 (l3obj1z = 'INС') & ~skipping: _(
 _if inInclude _then  fatal(2);
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
 fatal(6);
_) _else (block) _( (*6244*)
  _if input@ = endl _then _(
     lineNum := lineNum+1;
     nLex := 0;
     get (input);
   _) _else _( _if skipping _then _(
     _if input@ = chr(172B) _then  fatal(1) _else _(
       _if input@ = qu _then _(
         get(input);
         _while (input@ # qu) & (input@ # chr(172B)) _do get(input);
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
nLex := nLex+1;
_if input@ _in letter _then _(
 tokKind := tkIdent;
 getId;
 known := F;
 (*=c-*)mapai(tok & '000177', hash);(*=c+*)
_case lookup _of
 0: _( (* 6315 *)
 curId := idTable[hash];
 _while curId # _NIL _do _(
 _if curId@.lev = level _then _(
 _if curId@.nm # tok _then_(
    curId := curId@.nxt;
 _) _else _(
   known := T;
   _goto 6462;
 _)
 _) _else _goto 6462;
 _);
_);
 1: 6335: _( (* 6335 *)
 curId := idTable[hash];
 _while curId # _NIL _do _(
    _if curId@.nm # tok _then
       curId := curId@.nxt
    _else _goto 6462;
 _);
_);
 2: _( (* 6350 *)
 _if nWith = 0 _then _goto 6335;
 curId := idTabA[hash];
 curWith := -1;
_while curId # _NIL _do _(
 _if curId@.nm = tok _then _(
 l3v16z := curId@.nxtelt;
 v3E := nWith;
 _while v3E >= 1 _do _(
 _if withs[v3E].ty = l3v16z _then _(
 tokKind := tkField;
 _if v3E > curWith _then _(
 curWith := v3E;
 l3v17z := curId;
 _);
 v3E := 0;
 _);
 v3E := v3E-1;
 _) _);
 curId := curId@.nxt;
 _); (* 6402 *)
  _if curWith = -1 _then _goto 6335 _else curId := l3v17z;
 _);
 3: _( (* 6407 *)
 curId := idTabA[hash];
 tokKind := tkField;
 _while curId # _NIL _do _(
   _if curId@.nm # tok _then _(
     curId := curId@.nxt
   _) _else _if curRec = curId@.nxtelt _then
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
 _if ~(input@ _in letter ) _then _(
 _if (input@ = cparen) | (input@ = oparen) _then _(
   _if input@ = oparen _then tok := begin _else tok := end;
    get(input);
 _) _else _(
    tokKind := tk0;
    exit
 _)
 _) _else
   getId;
 6462:
 lookup := 1;
 prev := chr(254);
 exit
 _); (* 6465 *)
 _if input@ <= '9' _then _(
 tokKind := tkInt;
 v3E := 0;
 _repeat
  v3E := v3E+1;
 _if v3E <= 17 _then l3a21z[v3E] := input@
 _else _( L5462(0);  v3E := 1_);
 get(input);
 _until input@ > '9';
 ival := 0;
 _if (input@ = 'B') | (input@ = 'C') | (input@ = 'T') _then _(
 l3v15z := 1;
 _while l3v15z <= v3E _do _(
   _if l3a21z[l3v15z] > '7' _then  L5462(5);
   l3v15z := l3v15z+1;
 _); (* 6521 *)
 _if input@ = 'T' _then _(
 l3v15z := v3E;
 _while l3v15z >= 1 _do _(
   ival := ival; code(СД/3/=17ЗЧ,);
   ival := ord(l3a21z[l3v15z]);
   code(СД/3/=MP,17CP=);
   ival := ;
   l3v15z := l3v15z-1;
 _)
 _) _else _( (* 6537 *)
  l3v15z := 1;
   _while l3v15z <= v3E _do _(
   ival := ival; code(СД/-3/=17ЗЧ,);
   ival := ord(l3a21z[l3v15z]);
   code(17CP=);
   ival := ;
   l3v15z := l3v15z+1;
  _)
 _); (* 6551 *)
 octal := input@ = 'B';
 get(input);
 _) _else _( (* 6557 *)
 l3v15z := 1;
 _while l3v15z <= v3E _do _(
 _if ival <= max _then _(
  ival := 10*ival+ord(l3a21z[l3v15z]);
 _) _else _(
 L5462(7);
 ival := 0;
 _);
 l3v15z := l3v15z+1;
 _);
 l3v43z := 0;
_if input@ = dot _then _(
 get(input);
 _if input@ = dot _then _( input@ := colon; _goto 6462_);
 rval := ival;
 tokKind := tkReal;
 _if input@ > '9' _then L5462((8) ) _else _(
 _repeat
   rval := 10.0*rval+ord(input@);
   l3v43z := l3v43z-1;
   get(input);
 _until (input@ > '9');
 _)
 _); (* 6620 *)
 _if input@ = 'E' _then _(
 _if l3v43z = 0 _then _( rval := ival; tokKind := tkReal_);
   l3v18z := F;
   get(input);
   _case input@ _of
    '+': get(input);
    '-': _( l3v18z := T; get(input) _)
   _end;
   l3v42z := 0;
   _if input@ > '9' _then  L5462(9) _else _(
   _repeat
   l3v42z := 10*l3v42z+ord(input@);
    get(input);
 _until input@ > '9';
  _); (* 6655 *)
  _if l3v18z _then l3v43z := (l3v43z-l3v42z) _else l3v43z := (l3v43z+l3v42z);
 _); (* 6662 *)
 _if l3v43z # 0 _then _(
    l3v20z := 1.0;
    l3v18z := l3v43z < 0;
    l3v43z := abs(l3v43z);
    l3v19z := 10.0;
    _if l3v43z > 18 _then _( l3v43z := 1; L5462(10) _);
    _repeat
     _if odd(l3v43z) _then l3v20z := l3v20z*l3v19z;
      l3v43z := l3v43z _div 2;
     _if l3v43z # 0 _then l3v19z := l3v19z*l3v19z;
    _until l3v43z = 0;
    _if l3v18z _then rval := rval/l3v20z _else rval := rval*l3v20z;
 _);
  _);
 _goto 6462;
 _); (* 6722 *)
 _if input@ = qu _then _(
  _if ~allowLong _then _(
  tok := O;
  unpck(v31[0], tok);
  v3E := 6;
  (loop) _(
   get(input);
   _if input@ = chr(125B) _then escChar _else _(
      _if input@ = qu _then _( get(input); _if (input@ # qu) _then _exit loop_);
      _if modeA = 0 _then MAPГA(input@,  input@);
   _);
   _if v3E = 12 _then _( L5462(4); _exit loop _);
   v31[v3E] := input@;
   v3E := v3E+1;
  _goto loop;
  _); (* 6755 *)
  pck(v31[v3E-6], tok);
  _if v3E > 7 _then  tokKind := tkStr _else  tokKind := tkChar;
  _goto 6462;
  _) _else _( (* 6767 *)
     tokKind := tkStr;
     strLen := 0;
    known := F;
    l3v15z := 0;
    _while l3v15z <= 250 _do _(
    l3obj1z := O;
    unpck(v31[0], l3obj1z);
    v3E := 0;
    (* 7001 *) (oneword)_while v3E <= 5 _do _(
    get(input);
    _if (input@ = endl) & modeCH _then _( get(input); lineNum := lineNum+1_);
    _if (input@ = chr(125B)) _then escChar _else _(
     _if (input@ = qu) _then _(
         get(input);
        _if input@ # qu _then _(
       _if v3E # 0 _then _( known := T; _exit oneword _);
        _goto 6462;
      _);
 _) _else _(
     _if input@ = endl _then  lineNum := lineNum+1;
     _if modeA = 0 _then  MAPГA(input@, input@);
   _)
    _); (* 7033 *)
     v31[v3E] := input@;
     strLen := strLen+1;
     v3E := v3E+1;
    _); (* 7040 *)
    pck(v31[0], l3obj1z);
    cv.a := l3obj1z;
    putConst(l3obj1z, T);
    _if allowLong_then _(  allowLong := F; tok := l3obj1z_);
    _if known _then _goto 6462;
    l3v15z := l3v15z+1;
    _);
    L5462(1);
    _);
 _); (* 7060 *)
 tokKind := tk0;
 _if input@ = chr(253) _then _(
    get(input); prev := asg;
    exit
  _); (* 7065 *)
  _if (input@ _IN [dot,oparen,lt,gt,colon]) _then _(
  _case input@ _of
  ':': digraph(eq, asg);
  '.': digraph(dot, colon);
  '>': digraph(eq, chr(79));
  '<': _(
     digraph(eq, chr(78));
    _if (prev = lt) & (input@ = gt) _then _(  get(input); prev := neq_);
  _);
  '(': _(
     get(input);
     _if input@ = star _then doComment _else prev := oparen;
   _)
  _end
  _) _else _( (* 7130*)
  _if input@ = chr(172B) _then _(
    _if inInclude _then _(
     closeFile;
     inInclude := F;
     _goto 6161;
    _) _else  fatal(0);
  _) _else  prev := input@;
  get(input);
  _); (* 7142 *)
_);
(* L 3 *) _function tokInSet(a31:bitset):bool;
_var v31, v32:bool; v33:int; _(
 v31 := F;
 v33 := 0;
 _while v33 <= 4 _do _(
   _if v33 _IN a31 _then _case v33 _of
    0: v32 := ((tokKind = tk0) & (prev = semi)) |
    (((tok = then) | (tok = else) | (tok = until) | (tok = end) | (tok = do)) & (tokKind = tkWord));
    1: v32 := ((tok=begin)|(tok=functi)|(tok=proced)|(tok=type)|(tok=const)|(tok=label)|(tok=var))&(tokKind=tkWord);
    2: v32 := ((tok=begin)|(tok=go)|(tok=if)|(tok=goto)|(tok=with)|(tok=while)|(tok=repeat)|(tok=for)|(tok=select)|(tok=back)|(tok=branch))&(tokKind=tkWord);
    3: v32 := (tokKind = tk0) & (prev = comma);
    4: v32 := tokKind = tkIdent;
    5: v32 := (tokKind = tk0) & (prev = semi)           % unreachable
   _end;
   v31 := v31 | v32;
   tokInSet := v31;
   _if v31 _then exit;
   v33 := v33+1;
 _);
_);
(* L 3 *) _proced skipTo(a31:bitset);
 _(
  _while ~tokInSet(a31) _do getT;
 _);

(* L 3 *) _function getConst(a31:alfa):int;
_var v31:int; _(
 _if a31 = O _then getConst := 0 _else _(
    mapai(a31, v31);
    getConst := pool[v31];
 _)
_);
(* L 3 *) _function typeCheck(t1, t2:idptr):bool;
_label 7355;
_var v31:@typchain; v32, v33:idptr;
(* L 4 *) _proced chain;
 _(
 new(v31);
 v31@ := [tchain, v32, v33];
 tchain := v31;
 typeCheck := typeCheck(v32, v33);
 _);

_( (* typeCheck *)
(align) _if (~modeC) | (t1 = t2)
_then _( 7355: typeCheck := T; exit _) _else
 _if t1@.k = t2@.k _then _case t1@.k _of
kSc: _(
    _if ((t1 = alfaType) & (t2 = charType))
    | ((t1 = charType) & (t2 = alfaType))
    _then _goto 7355;
_);
kRng:_if (t1@.lo = t2@.lo) & (t1@.hi = t2@.hi)
  & typeCheck(t1@.bas, t2@.bas)
  _then _goto 7355;
kPtr: _(
 _if (t1 = ptrType) | (t2 = ptrType) _then _goto 7355 _else _(
   v32 := t1@.bas;
   v33 := t2@.bas;
   _if tchain # _NIL _then _(
     v31 := tchain;
     _while v31 # _NIL _do _(
       _if (v31@.t1 = v32) & (v31@.t2 = v33)
       | (v31@.t2 = v32) & (v31@.t1 = v33) _then _goto 7355
       _else v31 := v31@.nxt;
     _);
     chain;
   _) _else _( setup(t1); chain; tchain := _NIL; rollup(t1) _);
   exit
  _)
_);
kSet: _goto 7355;
kArr: _if typeCheck(t1@.bas, t2@.bas) & typeCheck(t1@.rng, t2@.rng)
   _then _goto 7355;
kAlias: sysErr(2);
kFile:_if typeCheck(t1@.bas, t2@.bas) & (t1@.pck = t2@.pck)
  _then _goto 7355;
kRec:
_end;
typeCheck := F
_);

(* L 3 *) _proced litConst(_var ret:idptr; _var off:alfa;  signed:bool);
_label 7531, 7567, 7570, 7601, 7666;
_var p:idptr; c:char; _(
  p := ret;
 _case tokKind _of
tkWord: _(
 _if tok # 'NIL' _then _goto 7666;
 7531:
 ret := ptrType;
 off := nilOff;
_);
tkIdent: _(
 _if curId = _NIL _then _goto 7666;
 _if (curId@.cl # cConst) | (curId@.bas # _NIL) _then _goto 7666;
 _if curId@.vty@.k # kSc _then _(
     _if curId@.vty = ptrType _then _goto 7531 _else _goto 7666;
 _); (* 7554 *)
  ret := curId@.vty;
  off := curId@.off;
  cv.i := getConst(off);
_);
tkField: _goto 7666;
tkStr: _( ret := alfaType;
  7567: cv.a := tok;
  7570: putConst(off, F);
  _);
tkInt: _(
  ret := intType;
  cv.i := ival;
  _goto 7570;
 _);
tkReal: _(
 ret := realType;
 7601: cv.r := rval;
 _goto 7570;
 _);
tkChar: _(  ret := charType; _goto 7567 _);
tk0: _(
 _if ~signed _then _goto 7666;
 _if (prev = '+') | (prev = '-') _then c := prev _else _goto 7666;
 getT;
 litConst(ret, off, F);
 _if ret = _NIL _then _goto 7666;
 _if c = '-' _then _(
   _if ret = intType _then _( cv.i := -ival; _goto 7570 _)
   _else _(
  _if ret = realType _then _( rval := -rval; _goto 7601 _)
  _else _goto 7666;
 _)
 _);
_)
_end;
 _if (p = _NIL) | typeCheck(p, ret)
 _then exit;
 7666: ret := _NIL; (q)
_);
_proced parseType(restrict:int; tname:alfa; _var ret:idptr; bckt:int);
_label 10503, 10505, 10507, 10527, 11022, 11126;
(*=a1*)_const packed='PACKED';
_var baseType, curType, v33 :idptr;
isPacked:bool;
v35:alfa; v36:word;  cnt, sz: int;
(* L 4 *) _proced typeErr(a41:int);
 _(
 error('ТИП', a41);
 _);
(* L 4 *) _function bitWidth(a41:idptr):int;
_label 7703;
_var i:int; _(
 _if a41@.sz # 1 _then 7703: _(
 bitWidth := 0;
 _) _else _if a41@.k = kRng _then _(
 i := a41@.lo;
 _if i < 0 _then _goto 7703;
 i := a41@.hi;
 _if i >= 48 _then _goto 7703;
 code(4СЧ5=BH,4ЗЧ5=,);
 bitWidth := 49-i;
 _) _else _if a41@.k = kPtr _then  bitWidth := 15
 _else  _if a41@.k = kSc _then _(
   _if a41 = boolType _then bitWidth := 1
   _else _if a41 = charType _then bitWidth := 8
   _else _goto 7703;
 _) _else
  _goto 7703;
 _);
(* L 4 *) _proced doFields(_var sz:int; rec, head:idptr);
_label  7776, 10065;
_var v41, v42, v43, v44, v45, l4v6z, l4id7z, l4v8z:idptr;
cursz, l4v10z: int;
l4v11z, l4v12z: alfa;
l4v13z, l4v14z: bool;
(* L 5 *) _proced flistErr(e:int);
_(
 error('FLISТ', e);
_);
_( (* doFields *)
 l4v13z := T;
 v41 := _NIL;
_repeat
 l4v8z := _NIL;
 lookup := 3;
 getT;
 _if tokKind = tkField _then _goto 7776 _else _goto 10065;
 _repeat
 lookup := 3;
 getT;
 _if tokKind # tkField _then flistErr(0);               % no id
7776:
 _if curId # _NIL _then flistErr(1);                    % id already defined in this record 
 new(v42; fld8);
 v42@ := [tok, level, idTabA[hash], head, cField, _NIL, ,rec];
 idTabA[hash] := v42;
 _if l4v13z _then _(
   _if head = _NIL _then rec@.bas := v42
   _else head@.nxt := v42;
   l4v13z := F;
 _);
 _if l4v8z = _NIL _then  l4v8z := v42
 _else v41@.vty := v42;
 v41 := v42;
 getT;
 _until prev # comma;
 _if prev # colon _then flistErr(2);                    % need colon after a list of fields
 parseType(1, O, v43, 0);
 cursz := v43@.sz;
 curRec := rec;
 _while l4v8z # _NIL _do _(
 l4v8z@.fld6 := v43;
 l4v8z@.hi := sz;
 sz := sz+cursz;
 l4v8z := l4v8z@.vty;
 _);
_until prev # semi;
exit;
 10065:
 _if (tokKind # tkWord) | (tok # case) _then flistErr(3); % no case
 lookup := 3;
 getT;
 _if tokKind # tkField _then  flistErr(4);            % after case should be a field or a type
 l4v12z := tok;
 l4v10z := hash;
 l4id7z := curId;
 new(v42; fld8);
 v42@ := [tok, level, , head, cCase, _NIL, , rec, sz];
 _if l4v13z _then_(
  l4v13z := F;
  _if head = _NIL _then  rec@.bas := v42
  _else head@.nxt := v42;
 _) _else
  v42@.vty := v42;
 getT;
 _if prev = colon _then _(
  _if l4id7z # _NIL _then flistErr(11);                 % selector id already used
  v42@.nxt := idTabA[l4v10z];
  idTabA[l4v10z] := v42;
  parseType(2,O, v43, 0);
  l4v10z := 1;
 _) _else _(
  l4id7z := idTable[l4v10z];
  l4v10z := 0;
  _while l4id7z # _NIL _do _(
   _if l4id7z@.nm # l4v12z _then l4id7z := l4id7z@.nxt
   _else _(
    _if l4id7z@.cl # cType _then flistErr(12)           % no type id
    _else _(
     _if l4id7z@.k = kAlias _then l4id7z := l4id7z@.bas;
     _if l4id7z@.k # kSc _then flistErr(13);            % must be a discrete type
    _);
    v43 := l4id7z;
    l4id7z := _NIL;
    l4v12z := O;
   _)
  _); (* 10202 *)
  _if l4v12z # O _then _( flistErr(14); v43 := ptrType _)
 _); (* 10206 *)
 v42@.fld6 := v43;
 sz := sz+l4v10z;
 _if (tokKind # tkWord) | (tok # of) _then flistErr(6); % need "of"
 v41 := _NIL;
 l4v10z := sz;
 _repeat
  l4v6z := _NIL;
  cursz := l4v10z;
  getT;
  _repeat
   v44 := v43;
   litConst(v44, l4v11z, F);
   _if v44 = _NIL _then flistErr(-1);                   % bad or missing selector value
   new(v45; fld6);
   v45@ := [0, l4v11z, _NIL, , c6, _NIL];
   _if l4v6z = _NIL
   _then v45@.bas := v42
   _else v45@.bas := l4v6z;
   l4v6z := v45;
   v44 := v41;
   (loop) _while v44 # _NIL _do _(
    l4v12z := v44@.lev;
    _if l4v11z > l4v12z _then _(
     v45@.vty := v44;
     _exit loop
    _) _else _(
     _if l4v11z < l4v12z _then _(
      l4id7z := v44;
      v44 := v44@.vty;
     _) _else flistErr(8);                              % repeated selector value
    _)
   _);  (*10276 *)
   _if v41 = v44
   _then v41 := v45
   _else l4id7z@.vty := v45;
   getT;
   _if (prev # comma) & (prev # colon) _then flistErr(7); % need comma or colon
   l4v14z := prev = colon;
   getT;

  _until l4v14z;
  _if prev # oparen _then flistErr(10);                 % need open paren
  doFields(cursz, rec, l4v6z);
  _if prev # cparen _then flistErr(9);                  % need close paren
  _if cursz > sz _then  sz := cursz;

  _while l4v6z # v42 _do _(
   l4v6z@.cs6 := cursz;
   l4v6z := l4v6z@.bas;
  _);

  getT;
 _until prev # semi;
 v42@.vty := v41;
_);

_( (* parseType *)
 getT;
 isPacked := F;
 _case tokKind _of
tk0: _( (* 10360 *)
 _if prev = oparen _then _(
 baseType := _NIL;
 new(curType; lstoff);
 curType@ := [tname, , , , cType, 1, kSc];
 _if tname # O _then _(
   curType@ := [, level, idTable[bckt] ];
   idTable[bckt] := curType;
 _); (* 10402 *)
 cnt := 0;
 ret := curType;
 _repeat
   lookup := 0;
   getT;
   _if tokKind # tkIdent _then typeErr(1);
   _if known _then  typeErr(2);
   new(v33; nxtelt);
   cv.i := cnt;
   putConst(v35, F);
   v33@ := [ tok, level, idTable[hash], _NIL, cConst, curType, v35];
   idTable[hash] := v33;
   cnt := cnt+1;
   _if baseType = _NIL _then curType@.bas := v33 _else  baseType@.nxtelt := v33;
   baseType := v33;
   getT;
 _until prev # comma;
 _if prev # cparen _then typeErr(4);
 v33@.nxtelt := _NIL;
 curType@.max := cnt;
 curType@.lstoff := O;
_) _else _( (* 10460 *)
_if prev = arrow _then _(
 parseType(1, O, baseType, 0);
 new(ret; k);
 ret@ := [tname, level, , baseType, cType, 1, kPtr];
 _goto 11126;
_); _goto 10527;
_); 10503: getT; exit;
  10505:
  getT;
  10507: ret := curType;
  _if tname = O _then _( exit; _goto 10527 _);
  new(v33; k) ;
  v33@ := [tname, level, idTable[bckt], curType, cType, , kAlias];
  idTable[bckt] := v33;
  exit;
10527:
   baseType := _NIL;
   litConst(baseType, v35, T);
   _if baseType = _NIL _then typeErr(13);       % not a constant
   cnt := cv.i;
   getT;
   _if prev # colon _then typeErr(14);          % no : or ..
   getT;
   litConst(baseType, v36.a, T);
   _if baseType = _NIL _then  typeErr(15);      % not a constant or of a wrong type
   sz := cv.i;
   _if (baseType # intType) & (baseType # charType) & (baseType@.bas = _NIL)
   | (baseType@.k # kSc) _then typeErr(16);     % bad constant for a range type
   new(curType; hi);
   curType@ := [0, level, _NIL, baseType, cType, 1, kRng, cnt, sz];
   _if modeT _then  mkCheck(curType, F);
   _goto 10505
_);
tkIdent: _( (* 10613 *)
 _if curId = _NIL _then _(
  _if allowUndef  & (tname = O) _then _(
   new(ret; k);
   undefCnt := undefCnt+1;
   ret@ := [tok, level, idTable[hash], _NIL, cType, 1, kPtr];   % forward decl
   idTable[hash] := ret;
   _goto 10503;
  _) _else typeErr(19);
 _);
 _if curId@.cl # cType _then _goto 10527;
 _if curId@.k = kAlias _then curId := curId@.bas;
 _if (restrict = 1) & (curId@.k = kFile) _then  typeErr(20);
 _if (restrict = 2) & (curId@.k # kSc) & (curId@.k # kRng)
 _then typeErr(21);
 curType := curId;
 _goto 10505;
 _);
tkWord: _( (* 10666 *)
 _if restrict = 2 _then typeErr(22);
 _if tok = packed _then _(
   isPacked := T;
   getT;
   _if tokKind # tkWord _then typeErr(40);
 _);
 _if tok = record _then _(
 new(baseType; k);
 cnt := 0;
 baseType@ := [ tname, , , ,cType, , kRec];
 baseType@ := [, level, idTable[bckt] ];
 idTable[bckt] := baseType;
 curRec := baseType;
 doFields(cnt, baseType, _NIL);
 _if (tokKind # tkWord) | (tok # end) _then  typeErr(23);
 baseType@.sz := cnt;
 ret := baseType;
 _goto 10503;
 _);
 _if tok = array _then _(
  getT;
  _if prev # obrack _then typeErr(24);
  curType := _NIL;
  _repeat
  parseType(2, O, baseType, 0);
  new(v33; eszoff);
  v33@ := [tname, , curType, , cType, , kArr, baseType];
  _if curType = _NIL _then_(
   ret := v33;
   _if tname # O _then _(
    v33@ := [, level, idTable[bckt] ];
    idTable[bckt] := v33;
   _)
 _) _else curType@.bas := v33;
 curType := v33;
 _until prev # comma;
 _if prev # cbrack _then typeErr(25);
 getT;
 _if (tokKind # tkWord) | (tok # of) _then typeErr(26);
 parseType(1, O, baseType, 0);
 v33@.bas := baseType;
 cnt := baseType@.sz;
 _goto 11022;
 _repeat
 curType := curType@.nxt;
 11022:
 v33 := curType@.rng;
 _if v33@.k = kRng
 _then sz := v33@.hi-v33@.lo+1
 _else  typeErr(28);
 _if cnt = 1 _then curType@.eszoff := O
 _else _(
   v36.i := cnt;
   orExp64(v36.i, cv.i);
   putConst(v36.a, F);
   curType@.eszoff := v36.a;
 _);
 (*=m+*)
 cnt := cnt*sz;
 curType@.sz := cnt;
 _until curType = ret;
 exit
 _); (* 11060 *)
 _if tok = file _then _(
  getT;
 _if (tokKind # tkWord) | (tok # of) _then typeErr(29);
 parseType(1, O, baseType, 0);
 sz := 22;
 _if isPacked _then  cnt := bitWidth(baseType) _else  cnt := 0;
 _if (cnt # 0) & (cnt <= 24) _then
 sz := trunc(48/cnt)+sz
 _else cnt := 0;
 new(ret; pck);
 ret@ := [0, , , baseType, cType, sz, kFile, cnt];
 11126:
 _if tname # O _then _(
 ret@ := [tname, level, idTable[bckt]];
 idTable[bckt] := ret;
 _);
 exit
_); (* 11140 *)
_if tok = set _then _(
 getT;
 _if tok # of _then  typeErr(-1);
  parseType(2, O, baseType, 0);
 _if ((baseType@.k # kRng) | (baseType@.lo < 0) | (baseType@.hi > 47)) &
  (((baseType@.lev # O) | ~typeCheck(baseType, boolType)) &
  ((baseType@.lev = O) | (baseType@.lo > 47)) | (baseType@.k # kSc)) _then
    prErr('ТИП', 0);
  curType := setType;
 _goto 10507;
 _);
  typeErr(33);
 _);
  tkInt, tkStr, tkReal, tkChar: _goto 10527;
  tkField: sysErr(3)
 _end;
 sysErr(4);
_);
(* L 3 *) _proced forPar(_var ret:idptr; _var a32:alfa);
_label 11266;
_const fp='ФОРПАР';
_var v31, v32:idptr;
  v33:idptr;
  v34:int; v35:(val, ref, fun, proc); v36:bool; v37:kind; _(
 ret@.alist := _NIL;
 _repeat
 v33 := _NIL;
 lookup := 0;
 v35 := val;
 getT;
 _if tokKind = tkIdent _then _goto 11266;
 _if tokKind # tkWord _then prErr(fp, 0);
 _if tok = var _then v35 := ref
 _else _if tok = functi _then v35 := fun
 _else _if tok # proced _then prErr(fp, 1)
 _else v35 := proc;
 _repeat
 lookup := 0;
 getT;
 11266:
 ret@.args := ret@.args+1;
 _if (tokKind # tkIdent) | known _then prErr(fp, 2);
 _case v35 _of
 val: _( new(v31; trace); v31@.cl := cConst_);
 ref: _( new(v31; trace); v31@.cl := cVar_);
 fun,proc: _( new(v31; setup); v31@.cl := cFun_)
 _end;
 v31@ := [tok, level, idTable[hash] ];
 idTable[hash] := v31;
 _if ret@.alist = _NIL _then ret@.alist := v31
 _else v32@.bas := v31;
 v32 := v31;
 _if v33 = _NIL _then v33 := v31;
 getT;
_until prev # comma;
 v34 := 1;
 _if v35 = proc _then v31 := _NIL
 _else _(
 _if prev # colon _then prErr(fp, 3);
 parseType(0, O, v31, 0);
 v37 := v31@.k;
 _if v35 = val _then v34 := v31@.sz;
 _if ((v35 = val) & (v34 # 1))
 | ((v35 = fun) & (v37 > kSet)) _then prErr(fp, 4);
 _); (* 11404 *)
 _repeat
 _if v35 < fun _then _(
  v33@.vty := v31;
  v33@.off := a32;
  _if modeV & (v37 < kArr) _then  v33@.trace := T _else v33@.trace := F
 _) _else _(
  v33@.vty := v31;
  v33@.lbl := a32;
 _);
 alfAdd(a32, v34);
 v36 := v32 = v33;
 v33 := v33@.bas;
 _until v36;
 _until prev # semi;
 _if prev # cparen _then prErr(fp, 5);
 getT;
 v32@.bas := ret;
_);
   (* L 3 *) _proced replace(list:pInst; src, dst:alfa);
_var p:pInst; _(
 p := list;
 _while p # _NIL _do _with p@ _do _(
   _if a = src _then a := dst;
   p := nxt;
 _)
_);
(* L 3 *) _proced mkInst(_var i:pInst);
 _(
 new(i);
 _if i = _NIL _then sysErr(0);
_);
(* L 3 *) _proced form1(n:int; _var ret:expr);
_label 11523, 11525, 11631, 11703, 11735;
_var v31, cur:pInst; v33:alfa;
(* L 4 *) _proced addInst;
_(
 mkInst(cur);
 cur@ := [ ret.in, reqAU ];
 ret.in := cur;
_);
_( (* form1 *) (*=a0*)
(a) addInst;
_with cur@ _do _case n _of
0: _( a := zero;
11523: op := XTA;
11525: m := basReg;
_);
1: _(a := one; _goto 11523 _);
2: _(a := one; au := auINT; op := AEX; _goto 11525 _); (* ineff *)
3: _(
 cur@ := [, , ret.reg, XTA, ret.off];
 ret.ek := ek3;
 _if (ret.reg = O)
 & (ret.off # O)
 & (nxt@.op # UTC)
 & (nxt@.op # WTC) _then m := basReg;
_);
4: _(
 a := 'ТR';
 au := auSETINT;
 _goto 11703;
_);
5: _(
cur@ := [, 1, basReg, MUL, curOff];
 form1(fIMUL, ret);
_);
6: cur@ := [, 1, 0, AVX, 'ЧМ1'];
7: cur@ := [, , ret.reg, SUB, ret.off];
8: cur@ := [, , 0, XTA, 0];
9, 14: sysErr(5);
10: cur@ := [, , '17', XTA, ret.off];
11: 11631: _( cur@ := [, , '15', VTM, 0]; addInst; cur@ := [, , 0, ITA, '15'] _);
12: _( cur@ := [, , ret.reg, UTC, ret.off]; addInst; cur@ := [, , '15', VTM, 0] _);
13: cur@ := [, , '11', VTM, 0];
15: cur@ := [, 2, 0, 'РА', '23'];
16: _( op := AOX; a := 'Z64'; m := O_); (* inefficient *)
17: _if modeM _then _(
   cur@ := [, 1, , , 'ЦУ'];
   11703:
   cur@ := [, , '16', VJM];
 _) _else cur@ := [, , 0, YTA, '30'];
18: _(   cur@ := [, 4, , , 'R']; _goto 11703 _);
19: cur@ := [, , '17', ATX, 0];
20: cur@ := [, , basReg, AAX, one];
21: _( v33 := ADD;
11735:
cur@ := [, 1, 0, v33, one] _);
22: _( v33 := SUB; _goto 11735_);
23: _(
  _if (ret.reg # O) | (ret.off # O) _then _(
   cur@ := [, , ret.reg, UTC, ret.off];
   addInst;
 _) _else _if (ret.in@.nxt # _NIL) & (ret.in@.nxt@.op = WTC) _then_(
 v31 := ret.in;
 ret.in := v31@.nxt;
 ret.in@.op := XTA;
 ret.ek := ek3;
 v31 := ret.in;
 _if (v31@.m = '17') & (v31@.a = O) _then _(
   v31 := v31@.nxt;
   _if (v31@.m = '17') & (v31@.a = O) & (v31@.op = ATX) _then
    ret.in := v31@.nxt;
 _);
 exit
 _);
 _goto 11631
_);
24: _(
 cur@ := [,2, ret.ty@.lev, UTC, ret.ty@.hi];
 addInst;
 cur@ := [, , '12', VTM, 0];
 addInst;
 cur@ := [, , '16', VJM, 'ВП7'];
_);
25:cur@ := [, , level, WTC, v2B];
26:cur@ := [, , 0, 0, 0];
27: _( op := XTS;
putConst(a, F);
m := basReg _);
28: cur@:= [, , basReg, AAX, curOff]
_end; (* 12127 *)
_);
(* L 3 *) _proced form2(f:int; _var ret:expr; arg:alfa);
_label 12164, 12166, 12205, 12211, 12240, 12242, 12355;
_var cur:pInst; v32:alfa; curlev, tolev:int;
(* L 4 *) _proced addInst;
 _(
 mkInst(cur);
 cur@ := [ret.in, 0];
 ret.in := cur;
 _);
_( (* form2 *)
 _if (f > 23) _then sysErr(4);
 _if (f # fFIXRT) _then addInst;
 _with cur@ _do _case f _of
 fLAB:cur@ := [, , label, , arg];
 fGOTO: _(
  op := UJ;
12164:
 m := basReg;
12166:
 a := arg;
 _);
 fU1A:_( op := 'У1'; _goto 12164 _);
 fUZA:_( op := 'У0'; _goto 12164 _);
 fCMD: cur@ := [, reqAU, ret.reg, arg, ret.off];
 fVTM15: 12205: _( m := '15'; op := VTM; _goto 12166 _);
 fBCALL: 12211: _(
   _if modeX _then _( m := BP; op := UTC; a := O; addInst_); (*ineff*)
   _if f = 8 _then _goto 12205 _else _goto 12240;
 _);
 6, 13, 18, 21: sysErr(f);
 fBVTM15: _goto 12211;
 fSTKOP: cur@ := [, ,  '17', arg, 0];
 fPUSH: _( m := '17'; op := ATX; _goto 12166 _);
 fCALL: 12240: _( m := '16'; 12242: op := VJM; _goto 12166 _);
 fFIXRT: _if level = arg _then exit
 _else _(
   mapai(level, curlev);
   mapai(arg, tolev);
   addInst;
   _if tolev+1 = curlev _then cur@ := [, , '13', 'ПИ', level]
   _else _(
     arg := rets[curlev,tolev];
     _if arg = O _then _(
       TNL(arg);
       rets[curlev,tolev] := arg;
     _);
     _goto 12211
   _)
 _);
 fST11: _( m := '11'; op := ATX; _goto 12166 _);
 fVJM14: _( m := '14'; _goto 12242 _);
 fSETREG: _(                                     % immediate
  cur@ := [, , ret.reg, UTC, ret.off];
  addInst;
  cur@ := [, , arg, VTM, 0];
  dump(ret.in);
 _);
 fEQ:_( op := AEX; m := O; _goto 12166_);
 fMATH: cur@ := [, ,0, 'Э050', arg];
 fMVSTK:cur@ := [, , '17', UTM, arg];
 fOVFL: _(
  cur@ := [,1, '15', VTM, 'ОV'];
   addInst;
   mapia(lineNum, v32);
   cur@ := [, , '14', VTM, v32];
 12355: addInst;
 _goto 12211;
 _);
 fCALL1: _(
 cur@ := [, , ret.reg, XTA, ret.off];
 ret.ek := ek3;
 _goto 12355
 _)
 _end; (* 12421 *)
_);
(* L 3 *) _proced P12422(a31, a32:alfa; a33: int; _var ret:expr);
_var v31:pInst; v32:alfa; _(
 mkInst(v31);
 mapia(a33, v32);
 v31@ := [ ret.in, 0, a31, a32, v32];
 ret.in := v31;
_);
(* L 3 *) _proced L12445(_var ret:expr);
_var v31:int; _(
 v31 := 23;
 _with ret _do _if ty@.k = kFile _then _(
   _if inv = 1 _then  v31 := 3
   _else _if reg = O _then _(
     _if off = '7' _then v31 := 0
     _else _if off = BP _then _(
       v31 := 3;
       reg := O;
       off := 'Z64';
     _)
   _)
 _);
  form1(v31, ret);
 _);
(* L 3 *) _proced store(_var ret:expr);
_(
 _if ret.ek = ek2 _then _(
   putInsn('17ЗЧ');
   form2(fSETREG, ret, '15');
   putInsn('17СЧ'); putInsn('15ЗЧ');
   exit
 _);
 form2(fCMD, ret, ATX);
 dump(ret.in);
_);
(* L 3 *) _proced load(_var ret:expr);
_label 12556, 12557;
_var v31, v32:alfa;  v33:int; _(
 _with ret _do _if ty = boolType _then _case ek _of
 ekCONST: _if inv = 0 _then form1(0, ret) _else form1(1, ret);
 ek1: _(  form1(fLD, ret); _if inv # 0 _then form1(2, ret) _);
 ek2:  _if off # label _then _(
   TNL(v31);
   form2(fUZA-inv, ret, v31);
   12556: v33 := 1;
   12557: TNL(v32);
   form1(v33, ret);
   form2(fGOTO, ret, v32);
   form2(fLAB, ret, v31);
   form1(1-v33, ret);
   form2(fLAB, ret, v32);
  _) _else _if inv # 0 _then form1(2, ret);
 ek3: _(
   v31 := off;
   _if inv = 0 _then _goto 12556
   _else v33 := 0;
   _goto 12557
 _)
 _end _else _( (* 12624 *)
   _if ek # ek3 _then _(
    form1(fLD, ret);
    ek := ek3;
    exit
   _)
  _);
 ret.ek := ek3
 _);
(* L 3 *) _proced L12635(_var ret:expr);
_(
 load(ret);
 dump(ret.in);
_);
(* L 3 *) _proced append(what:pinst; _var where:pinst);
_var i:pinst; _(
 _if where = _NIL _then where := what
 _else _(
   i := where;
   _while i@.nxt # _NIL _do i := i@.nxt;
   i@.nxt := what;
 _)
_);
(* L 3 *) _proced appInst(_var src, dst:expr);
_(
  append(src.in, dst.in);
_);
(* L 3 *) _function bothSet(a31, a32:idptr):bool;
 _(
 bothSet := (a31@.k = kSet) & (a32@.k = kSet);
_);
(* L 3 *) _proced P12713(_var a31, a32: expr; a33:alfa);
_(
  load(a31);
  form1(fPSH, a31);
  load(a32);
  form2(fVJM14, a32, a33);
  append(a31.in, a32.in);
  a31.in := a32.in;
_);
(* L 3 *) _proced apply(arg:alfa; stack:bool; _var e1, e2:expr; au:int);
_label 12747, 12752, 12775, 13013, 13045;
 _(
 _case e1.ek _of
 ekCONST, ek1: _case e2.ek _of
   ekCONST, ek1: 12747: _(
   form1(fLD, e1);
 12752:
 append(e1.in, e2.in);
 reqAU := au;
 form2(fCMD, e2, arg);
 e1 := [3, , , , e2.in, 0];
   _);
   ek2: _(
   form1(fLD, e2);
   _if stack _then _(
  12775:
   append(e2.in, e1.in);
 reqAU := au;
 form2(fCMD, e1, arg);
 e1 := [3, , , , , 0];
 _) _else 13013: _(
  form1(fPSH, e2);
  _if e1.ek # ek3 _then  form1(fLD, e1);
  e1.off := O;
  e1.reg := '17';
  _goto 12775;
 _); (* 13027 *)
   _);
   ek3:_if stack _then _goto 12775 _else _goto 13013
 _end;
 ek2: _case e2.ek _of
   ekCONST,ek1: _goto 12747;
   ek2: 13045: _( form1(fLD, e2); _goto 13013 _);
   ek3: _goto 13013 _end;
 ek3: _case e2.ek _of
   ekCONST, ek1: _goto 12752;
   ek2: _goto 13045;
   ek3: _goto 13013
   _end
 _end;
 reqAU := 0
_);
(* L 3 *) _proced toReal(_var a31:expr);
 _(
 _if a31.ty = intType _then _(
 _if a31.ek = ekCONST _then _(
   rval := getConst(a31.off);
   cv := ;
   putConst(a31.off, F);
 _) _else _(
  _if a31.ek # ek3 _then form1(fLD, a31);
  form1(fTOREAL, a31);
 _)
 _)
_);
(* L 3 *) _function F13134(a31:alfa; a32:bool; _var a33, a34:expr):bool;
_label 13153, 13155;
_var v31, v32:idptr; _(
 v31 := a33.ty;
 v32 := a34.ty;
 _if v31 = realType _then _(
% The roundabout if statement is needed to achieve the 100% binary matching 
 _if v32 = realType _then _goto 13155;
 _if v32 = intType _then toReal(a34)
 _else 13153: _( F13134 := T;  exit _);
 13155:
 _)_else _if v31 # intType _then _goto 13153
 _else _if v32 = realType _then _(
    toReal(a33);
    a33.ty := realType;
 _) _else _goto 13153;

 apply(a31, a32, a33, a34, 3);
 F13134 := F;
 _);
(* L 3 *) _proced P13176(a31:bool; _var a32, a33:expr);
_label 13246, 13261, 13323, 13462;
_var v31:alfa; v32:int; v33:expr; _(
 _if a31 _then _(
   a32.inv := ord(odd(a32.inv+1));
   a33.inv := ord(odd(a33.inv+1));
 _);
 _case a32.ek _of
 ekCONST: (* 13213 *) _case a33.ek _of
   ekCONST: _if a32.inv+a33.inv # 2 _then a32.inv := 0;
   ek1, ek2, ek3: _if a32.inv = 0 _then a33.in := _NIL _else a32 := a33
 _end;
 ek1: (* 13245 *) _case a33.ek _of
   ekCONST: 13246: _if a33.inv = 0 _then a32 := [0, , , , _NIL, 0];
   ek1, ek2: _( form1(fLD, a32);
     13261: _if a32.inv = 0 _then v32 := 3 _else v32 := 2;
     TNL(v31);
     form2(v32, a32, v31);
     _if a33.ek = ek1 _then form1(fLD, a33);
     _if a33.inv = 0 _then v32 := 3 _else v32 := 2;
     form2(v32, a33, v31);
     appInst(a32, a33);
     a32.in := a33.in;
     a32 := [3, v31, , , , 0];
   _);
   ek3: 13323: _(
   _if a32.inv = 0 _then v32 := 3 _else v32 := 2;
   _if a33.inv = 0 _then _(
    _if a32.ek = ek1 _then form1(fLD, a32);
    form2(v32, a32, a33.off);
    a32.off := a33.off;
   _) _else _(
    TNL(v31);
    form2(fGOTO, a33, v31);
    form2(fLAB, a33, a33.off);
    _if a32.ek = ek1 _then form1(fLD, a32);
    form2(v32, a32, v31);
    a32.off := v31;
   _);
   appInst(a33, a32);
   a32 := [3, , , , , 0];
  _)
 _end;
 ek2: (* 13407 *) _case a33.ek _of
   ekCONST: _goto 13246;
   ek1, ek2: _goto 13261;
   ek3: _goto 13323
 _end;
 ek3: (* 13422 *) _case a33.ek _of
   ekCONST: _goto 13246;
   ek1, ek2: _(
   v33 := a32;
   a32 := a33;
   a33 := v33;
   _goto 13323;
   _);
   ek3:
   _if a33.inv = a32.inv _then _(
    _if a33.inv = 0 _then _(
     replace(a33.in, a33.off, a32.off);
     13462:
     appInst(a32, a33);
     a32.in := a33.in;
    _) _else _(
     TNL(v31);
     form2(fGOTO, a32, v31);
     form2(fLAB, a32, a32.off);
     form2(fLAB, a33, v31);
     appInst(a32, a33);
     a32 := [, a33.off, , , a33.in];
 _)
 _) _else _(
  _if a32.inv = 0 _then _(
   form2(fGOTO, a33, a32.off);
   form2(fLAB, a33, a33.off);
  _) _else _(
   form2(fGOTO, a32, a33.off);
   form2(fLAB, a32, a32.off);
   a32.off := a33.off;
  _);
  a32.inv := 0;
  _goto 13462;
 _)
 _end
 _end;
 _if a31 _then a32.inv := ord(odd(a32.inv+1));
_);
(* L 3 *) _proced L13566(_var a31:alfa);
 _(
 _if curLab # O _then a31 := curLab
 _else _(
   TNL(a31);
   cmd(cLAB, a31);
 _)
 _);
(* L 3 *) _proced display(a31:idptr; a32:bool);
_label 13625;
_var v31:idptr; v32:alfa; _( _with a31@ _do _(
 _if noDisplay | ~varHelper _then exit;
 _if k = kRng _then a31 := bas;
 _if a32 _then v31 := vty
 _else  v31 := a31;
 _if v31 = alfaType _then _(
   v32 := '12ПА1';
 13625:
 putInsn(v32);
 mapia(v2S, v32);
 putIarg('14ПА', v32);
 _if a32 _then putName(nm)
_else  curOff := 'ВСS';
 putIarg('15ПА', curOff);
 putAlign('16ПВЩП');
 _) _else _select (* ineff *)
  v31 = intType: _( v32 := '12ПА5'; _goto 13625 _);
  v31 = charType: _( v32 := '12ПА4'; _goto 13625 _);
  v31 = boolType: _( v32 := '12ПА3'; _goto 13625 _);
  v31 = realType: _( v32 := '12ПА2'; _goto 13625 _);
  v31@.k = kSet: _( v32 := '12ПА6'; _goto 13625 _);
  v31@.k = kSc: _(
 putInsn('17ЗЧ');
 dumpNames(v31);
 putIarg('14ПА', v31@.lbl);
 putInsn('ВИ14');
 v32 := '12ПА10';
 putInsn(v32);
 mapia(v2S, v32);
 putIarg('14ПА', v32);
 _if a32 _then  putName(nm)
 _else curOff := 'ВСS';
 putIarg('15ПА', curOff);
 putAlign('16ПВЩП');
 putInsn('17СЧ');
 _);
 T: _( v32 := '12ПА7'; _goto 13625  _)
  _end;  (* 13732 *)
 noDisplay := T
_)_);
(* L 3 *) _proced P13734(_var a31, a32:expr);
_var v31:int; v32:alfa; v33, v34:pinst; _(
 _if modeC _then v31 := a31.ty@.sz
 _else v31 := 1;
 _if (v31 = 1) _then _(
  _if (a31.ek = ek2) & (a31.in@.op = WTC) _then _(
   v33 := a31.in;
  _while (v33@.op = WTC) _do _( v34 := v33; v33 := v33@.nxt _);
  append(v33, a32.in);
  L12635(a32);
  v34@.nxt := _NIL;
  a31.ek := ek1;
  _if lhs@.trace _then display(lhs, T);
  store(a31);
 _) _else _( (* 14002 *)
  L12635(a32);
 _if lhs@.trace _then display(lhs, T);
  store(a31);
 _)
 _) _else _( (* 14013 *)
  v31 := v31-1;
  mapia(v31, v32);
  form2(fSETREG, a32, '12');
  form2(fSETREG, a31, '16');
  cmd(cCOPY, v32);                               % multi-word copy
 _) (* 14030 *)
_);

_proced factor(_var ret:expr);+
_proced doExpr(_var ret:expr);+

(* L 3 *) _proced actPar(a31:idptr; _var a32:pinst);
_label 14357, 14370, 14374;
(*=a1*)_const param='ПАРАМ';(*=a0*)
_var v31:expr;
v37:alfa; l3v8z:bool;
isProc, noParam:bool;
l3v11z, l3v12z, v3D, v3E:int;
l3v15z, l3v16z, l3v17z:idptr;  l3v18z:pInst; l3v19z:int;

(* L 4 *) _proced formDesc(proc:idptr);
_var v41, v42, v43, v44:alfa; v45:idptr; l4v6z:int; _(
 _if proc@.bas # _NIL _then _(
  form1(0, v31);
  v31.in@ := [, , proc@.lev, , proc@.hi ];
 _) _else _(
 _if proc@.desc = O _then _(
 _if two = O _then _(  cv.i := 2; putConst(two, F) _);
 extras[14] := UTC; extras[16] := UTC; extras[13] := UTC; (* ineff *)
 TNL(v41); TNL(v42);
 cmd(cGOTO, v41); align;
 proc@.desc := v42;
 v45 := proc@.alist;
 metka(v42); TNL(v44); modBase; ГГ('12ПА');
 putInsn(v44); ГГ('11ПА');
 _if proc@.vty # _NIL _then  ГГ(1);
 putSep; putAlign('14ПВВП'); ГГ('17СЧ');
 l4v6z := proc@.args+2;
 _if proc@.vty # _NIL _then  l4v6z := l4v6z+1;
 mapia(l4v6z, v42);
 putInsn(v42); ГГ('17СА');
 _if proc@.args > 1 _then  ГГ(v42);
 putSep; modBase; ГГ('16ПАВП', 6);
 putSep; modBase; ГГ(UJ, proc@.orignm);
 align; ГГ('С;', v44); write(icolon);
_if v45 # _NIL _then_(
_repeat
 l4v6z := ord(v45@.cl);
 _if (l4v6z = 3) & ~(v45@.vty # _NIL) _then  l4v6z := 4;
 write(l4v6z:0, icomma);
 v45 := v45@.bas;
 _until proc = v45;
 _);
 ГГ(',К;');
 cmd(cLAB, v41);
 _); (* 14202 *)
 _if modeX _then _(
 form2(fGOTO, v31, O);
 v31.in@.op := UTC;
 _);
 form2(fVTM15, v31, curId@.off);
 form2(fCALL, v31, VJM);
_) (* 14225 *)
_);
_( (* actPar *)
  noParam := a31@.bas = _NIL;
  isProc := a31@.vty = _NIL;
  v3E := 0;
  _if isProc _then  l3v11z := 3 _else  l3v11z := 4;
  _if ~noParam  _then  l3v11z := l3v11z+2;
  _if noParam & (a31@.args >= 2) | ~noParam _then _(
    v31.in := _NIL;
    mapia(l3v11z, v37);
    form2(fMVSTK, v31, v37);
    a32 := v31.in;
  _) _else a32 := _NIL;
  _if prev = oparen _then _(
    _if noParam  _then _(
      l3v16z := a31@.alist;
      _if l3v16z = _NIL _then _( l3v11z := 0; prErr(param, l3v11z);exit _)
    _);
   _repeat
    v3E := v3E+1;
    l3v8z := T;
    _if noParam & (a31 = l3v16z) _then _( prErr(param, 1); skipTo([0,1,2]); exit _);
    lookup := 2;
    getT;
    v31.in := _NIL;
    _if (tokKind = tkIdent)  & (curId # _NIL) & (curId@.cl = cFun) _then _(
      l3v17z := curId@.vty;
      l3v19z := 3;
      _if l3v17z = _NIL _then _(
        _if curId@.lev = O _then prErr(param, 2) _else _(
          formDesc(curId);
          v3D := 4;
          getT;
        _)
      _)  _else _(
        l3v15z := curId;
        _if ~noParam _then _(
          unsigned := T;
          factor(v31);
          _if v31.ek = ekCONST _then _(
14357:
            _if l3v15z@.lev = O _then  prErr(param, 3)
            _else _( formDesc(l3v15z); v3D := 3_)
          _) _else _( (* 14367 *)
            unsigned := T;
14370:
            needToken := F;
            doExpr(v31);
14374:
            load(v31);
            l3v19z := 1;
            l3v17z := v31.ty;
          _)
        _) _else _( (* 14402 *)
          _if l3v16z@.cl = cFun _then _( getT; _goto 14357 _) _else _goto 14370;
        _)
      _)
    _) _else _( (* 14411 *)
      needToken := F;
      doExpr(v31);
      _if (v31.ek _IN [ek1,ek2]) _then _(
        l3v19z := 2;
        l3v17z := v31.ty
      _) _else _goto 14374;
    _); (* 14422 *)
    _if noParam _then _(
      _if (ord(l3v16z@.cl) # l3v19z) _then _(
        _if (l3v16z@.cl = cConst) & (l3v19z = 2) _then _(
          l3v19z := 1;
          load(v31);
        _) _else  prErr(param, 4);
      _); (* 14440 *)
      _if (l3v17z # _NIL) _then _(
        _if (l3v19z = 3) _then l3v15z := l3v16z@.vty _else l3v15z := l3v16z@.vty; (* ??? *)
        _if ~typeCheck(l3v17z, l3v16z@.vty) _then  prErr(param, 5);
      _);
    _); (* 14457 *)
    _if (l3v19z = 2) _then_(
      l3v18z := v31.in;
      L12445(v31);
      _if (l3v18z = _NIL) & (v31.in@.op = ITA) & (v3E > 1) _then _(
        v31.in@.op := 'ВМ';
        l3v8z := F;
      _)
    _); (* 14474 *)
    _if ~noParam _then _(
      _if ~(l3v19z = 3) _then  v3D := l3v19z;
      cv.i := v3D;
      form1(fXTS, v31);
    _) _else  l3v16z := l3v16z@.bas;
    _if l3v8z & (v3E # 1) _then _(
      l3v18z := v31.in;
      v31.in := a32;
      form1(fPSH, v31);
      a32 := v31.in;
      v31.in := l3v18z;
    _);
    append(a32, v31.in);
    a32 := v31.in;
   _until prev # comma;
    _if (noParam & (l3v16z # a31)) | (prev # cparen) _then prErr(param, 6)
    _else getT;
  _) _else _( (* 14545 *)
    _if noParam & ~(a31@.alist = _NIL) _then  prErr(param, 7);
  _); (* 14553 *)
  v31.in := a32;
  MAPЯГА(a31@.nm, v37);
  _if a31@.orignm = v37 _then form1(fPSH, v31);
  _if noParam _then _(
    form2(5, v31, a31@.orignm);
    v31.in@.au := auSETINT;
    v37 := a31@.lev;
    _if a31@.lbl = extern _then _(
      form1(fEMPTY, v31);
      v31.in@.m := label;
    _)
  _) _else _( (* 14607 *)
    _if v3E = 0 _then _(
      v31.in@ := [, , 0, XTA, 0];
      v3D := l3v11z+1;
      mapia(v3D, v37);
      form2(fPUSH, v31, v37);
    _) _else _(
      form1(fEMPTY, v31);
      v31.in@.op := XTS;
      form2(fPUSH, v31, '1');
      v3D := -(2*v3E+l3v11z); (* ineff *)
      mapia(v3D, v37);
      form2(fMVSTK, v31, v37);
    _); (* 14651 *)
    mapia(lineNum, v37);
    form2(fVTM15, v31, v37);
    v31.ty := a31;
    form1(fCHKPARM, v31);
    v37 := '1';
  _); (* 14665 *)
  form2(fFIXRT, v31, v37);
  _if ~isProc _then _(
    mapia(l3v11z-1, v31.off);
    form1(10, v31);
  _);
  a32 := v31.in;
  _if isProc _then  dump(a32);
_);

(* L 3 *) _proced LValue(_var ret:expr);+

(* L 3 *) _function L14707(_var ret:expr):bool;
 _(
 lookup := 2;
 getT;
 L14707 := T;
 _if (tokKind = tkIdent) & (curId # _NIL)
 & (((curId@.cl = cConst) & (curId@.bas # _NIL)) | (curId@.cl = cVar))
 | (tokKind = tkField) _then LValue(ret)
 _else L14707 := F;
 _);

(* L 3 *) _proced oshibka(a31:int);
 _( (*=a1*) prErr('ОШИБКА', a31); (*=a0*)_);

(* L 3 *) _proced chkComma; _( _if prev # comma _then  oshibka(0); _);

(* L 3 *) _proced twoarg(what:int; _var a32:expr);
_const bpaex='10СР';bpaax='10ЛУ';spaex='17СР';c4='15СЧ';c5='17СР-1';c6='15СР';c7='16ПВIS';
sel=0;ins=1;shft=2;
_var v31, v37, v3D:expr;
isConst:bool;
l3v20z,
l3obj1z, l3obj2z, l3v23z:int;
l3v24z:bitset;
l3v25z:alfa;
cnstAmt:bool;
l3v27z, l3v28z:alfa;
l3v29z:ekind; l3v30z:int; l3v31z:expr; _(
 doExpr(v31);
 chkComma;
 doExpr(v37);
 isConst := v37.ek = ekCONST;
 _if isConst _then  l3v20z := getConst(v37.off);
 _if what # shft _then _(
   doExpr(v3D);
   _if v3D.ek # ekCONST _then  oshibka(2);
   l3obj2z := getConst(v3D.off);
   _if (l3obj2z < 1) | (l3obj2z > 47) _then oshibka(7);
   l3v24z := [48-l3obj2z..47];
 _); (* 15020 *)
 _if what # ins _then _(
   load(v31);
   _if v37.ek > ek1 _then  oshibka(1);
   _if isConst _then _(
     _if l3v20z # 0 _then P12422(O, ASN, 100B+l3v20z, v31);
   _) _else _(
     form2(fCMD, v37, WTC);
     P12422(O, ASN, 100B, v37);
     appInst(v31, v37);
     v31.in := v37.in;
   _);
   _if what = sel _then _(
     cv.b := l3v24z;
     putConst(l3v25z, F);
     mapai(l3v25z, l3v23z);
     _if ~isConst | (l3obj2z+l3v20z # 48) _then P12422(BP, AAX, l3v23z, v31);
   _);
   a32 := v31;
 _) _else _( (* 15110 *)
   cnstAmt := F;
   _if isConst _then _(
     l3obj1z := -l3v20z;
     _if v31.ek = ekCONST _then_(
       cnstAmt := T;
       l3v30z := getConst(v31.off);
       l3v30z := shift(l3v30z, l3obj1z);
       cv := ;
       putConst(l3v28z, F);
       v31.off := l3v28z;
     _);
     l3v24z := shift(l3v24z, l3obj1z);
     l3v24z := [0..47]-l3v24z;
     cv := ;
     putConst(l3v27z, F);
   _);
   _if cnstAmt & isConst & (a32.in = _NIL) _then _(
     l3v31z := a32;
     L12635(a32);
     ГГ('10СР', l3v28z); putSep;
     ГГ('10ЛУ', l3v27z); putSep;
     ГГ('10СР', l3v28z); putSep;
     store(l3v31z);
   _) _else _if isConst & (a32.in = _NIL) _then _(
     l3v31z := a32;
     load(v31);
     P12422(O, ASN, 100B-l3v20z, v31);
     form1(fPSH, v31);
     apply(AEX, T, v31, a32, 0);
     dump(a32.in);
     ГГ('10ЛУ', l3v27z); putSep;
     putInsn('17СР');
     store(l3v31z);
   _) _else _if isConst _then _(
     _if (v31.reg = O) & (v31.in = _NIL) _then load(v31)
     _else _(
       load(v31);
       P12422(O, ASN, 100B-l3v20z, v31);
     _);
     form1(fPSH, v31);
     dump(v31.in);
     l3v29z := a32.ek;
     form1(fUVTM15, a32);
     dump(a32.in);
     _if l3v29z = ek2 _then _(
       putInsn('15СЧ'); putInsn('17СР-1')
     _) _else putInsn('15СР');
     ГГ('10ЛУ', l3v27z); putSep;
     putInsn('17СР');
     putInsn('15ЗЧ');
   _) _else (sel) _(
     load(v31);
     cv.b := l3v24z;
     form1(fXTS, v31);
     form1(fPSH, v31);
     load(v37);
     form1(fPSH, v37);
     appInst(v31, v37);
     form1(fUVTM15, a32);
     appInst(v37, a32);
     extras[17] := UTC;
     dump(a32.in);
     setAUInt;
     modBase;
     putAlign('16ПВIS'); _exit sel
   _)
 _); (* 15361 *)
_);

(* L 3 *) _proced factor(* _var ret:expr *)+
_label 16625, 16503, 16441, 16534;
_const (*=a1*)mnojit='МНОЖИТ'; stfun='СТФУН';(*=a0*)
_var v31:idptr;
v32:int; v33:bool;
v34:alfa;
v35:int;
v36:alfa; v37, l3v8z, l3v9z, l3v10z, l3v11z:int;

(* L 4 *) _proced factErr(a41:int);
 _(
 _if a41 # 20 _then  prErr(mnojit, a41);
 skipTo([0,1,2]);
 ret := [1, 1, 1, intType, _NIL, 0];
 _GOTO 16625;
_);

(* L 4 *) _proced stdCall;
_var checkMode, stProc:int; asBitset:bitset; v44:idptr;

(* L 5 *) _proced stFerr(err:int);
_(
  prErr(stfun, err);
  _if err = 9 _then  factErr(20);
_);

_( _with ret _do _( (* stdCall *)
  stProc := ord(v31@.bas);
  _if prev # oparen _then  factErr(9); (* open paren expected *)
  _if ~(stProc _IN [19,23]) _then _(
    _select
      stProc _IN [0..13,16..21]: doExpr(ret);
      ~L14707(ret): stFerr(9)
    _end;
    inv := 0;
    v44 := ty;
    (sel) _select
      ty@.k = kRng: _( ty := ty@.bas; _goto sel _);
      ty = realType: checkMode := 0;
      ty = intType: checkMode := 1;
      ty = charType: checkMode := 2;
      (v44@.k = kSc) & (ty # alfaType): checkMode := 3;
      v44@.k = kPtr: checkMode := 4;
      v44@.k = kFile: checkMode := 5;
      v44@.k = kSet: checkMode := 6;
      T: checkMode := 7
    _end;
    asBitset := [stProc];
    _if ((checkMode # 0) | (asBitset*[0..8,15,17..19] = []))
    & ((checkMode # 1) | (asBitset*[0..7,9,11..13,15..17,19] = []))
    & (~(checkMode _IN [2..4]) | (asBitset*[10,12,13,15] = []))
    & ((checkMode # 5) | (asBitset*[14,15,22] = []))
    & ((checkMode # 6) | (asBitset*[10,15,19,20,21] = []))
    & ((checkMode # 7) | (stProc # 15)) _then stFerr(2);
    _if  asBitset*[7,12,13,17,19] # [] _then  v31@.vty := ty;
    _if  asBitset*[0..9,12,13,17..21] # [] _then  load(ret);

  _); (* 15564 *)
  _case stProc _of
  0, 1, 2, 3, 4, 5, 6: (*15565*) _(           % SQRT, SIN, COS, ARCTAN, ARCSIN, LN, EXP
    _if checkMode = 1 _then  form1(fTOREAL, ret);
    form2(fMATH, ret, chr(stProc));
  _);
  7: (*15577*) _(                             % ABS
    form1(fEMPTY, ret);
    in@ := [, 3-2*checkMode, , 'МВ'];
  _);
  8: (*15611*) form1(fTRUNC, ret);                % TRUNC
  9: (*15615*) _(                             % ODD
    form1(20, ret);
    ek := ek2; off := label
  _);
  10: (*15624*)                               % ORD
    _if ty = boolType _then  load(ret);
  11, 16: (*15631*) _( _);                    % CHR, PTR
  12, 13: (* 15632 *) form1(stProc+9, ret);  % SUCC, PRED
  14: (* 15637 *)                             % EOF
    _if reg = O _then _(
      _if off = '7' _then _(
        cv.a := chr(172B);
        putConst(v34, F);
        form1(0, ret);
        in@ := [, , 1, , 7];
        form1(2, ret);
        in@.a := v34;
        inv := 1;
        ek := ek2;
      _) _else _(
        ret := [0, '13', 0, , _NIL, 1];
      _)
    _) _else _( (* 15700 *)
      _if inv = 0 _then alfAdd(off, 2)
      _else _( form2(fCALL1, ret, ITA);
        ek := ek2;
        extras[9] := ;
        off := label;
      _)
    _);
  15: _( L12445(ret); ek := ek3 _);       % REF
  17: _(                                      % SQR
    form1(fPSH, ret);
    _if  checkMode = 1 _then  form1(fORZ64, ret);
    form2(fSTKOP, ret, MUL);
    in@.au := auFL-2*checkMode;
    _if checkMode = 1 _then  form1(fIMUL, ret);
  _);
  18: _(                                      % ROUND
    form2(fCALL, ret, ADD);
    in@.au := auSETINT;
    extras[12] := ;
  _);
  20: _(                                      % CARD
    form1(fEMPTY, ret);
    in@.op := 'ВЧ'
  _);
  21: _(                                      % MINEL
    form1(fEMPTY, ret); in@.op := 'ВН';
    form1(1, ret); in@.op := SUB;
  _);
  22: _(                                      % EOLN
    cv.a := chr(175B);
    putConst(v34, F);
    _if reg = O _then _(
      _if off = '7' _then _(
        form1(0, ret);
        in@ := [, , 1, , 7];
      _) _else  stFerr(3);
    _) _else _(
      _if inv = 1 _then _(
        load(ret);
        form2(fCALL, ret, VTM);
        form1(0, ret);
        in@ := [, 1, '15' ];
      _) _else _(
        _if ty@.pck = 0 _then alfAdd(off, 1);
        form2(fCMD, ret, WTC);
        form1(fZERO, ret);
      _);
    _); (* 16064 *)
    form1(2, ret);
    in@.a := v34;
    inv := 1;
    ek := ek2;
  _);
  23: _(                                      % SHIFT
    twoarg(2, ret);
    v31@.vty := ty
  _);
  19: twoarg(0, ret)                          % SEL
  _end;
   _if prev # cparen _then stFerr(1) _else  getT;
_)_);

(* L 4 *) _proced doSet;
_var v41, l4v7z:expr;
l4v13z:pInst; bits:bitset; l4v15z, l4v16z:int;

(* L 5 *) _proced mkElem(x:int);
_(
 bits := bits;                  % ???
 bits := [x];
_);

(* L 5 *) _proced mkRng(x, y:int);
_(
 bits := bits;                  % ???
 bits := [x..y];
_);

(* L 5 *) _proced L16170(_var a51:expr);
_(
  doExpr(a51);
  _if a51.ty@.k = kRng _then  a51.ty := a51.ty@.bas;
  v31 := a51.ty;
  _if (v31@.k # kSc) | (v31 = realType) | (v31 = alfaType)
  _then prErr(mnojit, 8); (* bad base type for a set *)
_);
(* L 5 *) _proced L16214;
 _(
 _if v33 _then _(
   form1(fZERO, ret);
   l4v13z := ret.in;
   form1(fPSH, ret);
   v33 := F;
 _);
 load(v41);
 appInst(ret, v41);
 _);

_( (* doSet *)
 ret := [0, 0, 0, setType, _NIL, 0];
 lookup := 2;
 getT;
 _if prev # cbrack _then _(
   v33 := T;
   needToken := F;
   bits := [];
   _repeat
     L16170(v41);
     _if prev = colon _then _(
       L16170(l4v7z);

       _if (v41.ek = ekCONST) & (l4v7z.ek = ekCONST) _then  _(
         l4v15z := getConst(v41.off);
         l4v16z := getConst(l4v7z.off);
         _if (l4v15z < 0)
         | (l4v15z > 47)
         | (l4v16z < 0)
         | (l4v16z > 47)
         | (l4v15z > l4v16z) _then prErr(mnojit, 9)
         _else mkRng(l4v15z, l4v16z);
       _) _else _(
         L16214;
         form1(fPSH, v41);
         load(l4v7z);
         appInst(v41, l4v7z);
         form2(fCALL, l4v7z, ATX);
         ret.in := l4v7z.in;
       _); (* 16343 *)
     _) _else _( (* 16344 *)
       _if v41.ek = ekCONST _then _(
         l4v15z := getConst(v41.off);
         _if (l4v15z < 0) | (l4v15z > 47) _then prErr(mnojit, 0) (* bad set element *)
          _else mkElem(l4v15z);
       _) _else _(
         L16214;
         form2(fCALL, v41, XTA);
         ret.in := v41.in;
       _)
     _)
   (* 16373 *) _until prev # comma;
   _if prev # cbrack _then  factErr(10); (* no closing bracket *)
   _if bits # [] _then _(
     cv.b := bits;
     putConst(v34, F);
   _);
   _if v33 _then _(
     _if bits # [] _then  ret.off := v34;
   _) _else _(
     _if bits # [] _then  l4v13z@.a := v34;
     form1(0, ret);
     ret.in@.m := '17';
     ret.in@.a := O;
     ret.ek := ek3;
   _)
_)_);

_( (* factor *)
  _case tokKind _of
  tkWord: _( (* 16433 *)
    _if tok # nil _then _(
      _if tok = not _then _goto 16503 _else factErr(1);         % wrong keyword
    _) _else _(
16441:
      v31 := _NIL;
      litConst(v31, v34, F);
      _if v31 = _NIL _then  factErr(2); (* not a constant *)
      ret := [0, v34, 0, v31, _NIL, 0];
      _if modeX _then  ret.reg := BP;
      _if (v31 = boolType) & (v34 # zero) _then  ret.inv := 1;
    _)
  _);
  tk0: _(
  _if prev = oparen _then _(
    doExpr(ret);
    _if prev # cparen _then  factErr(3);                        % need closing paren
  _) _else _if prev = chr(83) _then _(
16503:
      lookup := 2;
      getT;
      factor(ret);
      _if ret.ty # boolType _then  factErr(4);                  % not a bool
      ret.inv := ord(odd(ret.inv+1));
      exit
    _) _else _if prev = obrack _then doSet _else  factErr(5);   % wrong delimiter
  _);
  tkInt, tkStr, tkReal, tkChar: _goto 16441;
  tkField: _goto 16534;
  tkIdent: _if curId = _NIL _then factErr(6)                    % ident not defined
    _else _(
    _if curId@.cl = cVar _then _(
16534:
      LValue(ret);
      exit
    _);
    _if curId@.cl = cConst _then
      _if curId@.bas = _NIL _then _goto 16441 _else _goto 16534;
    _if curId@.cl # cFun _then  factErr(7);                     % id not a var, const or func
    v31 := curId;
    getT;
    v33 := unsigned;
    unsigned := F;
    _if (prev # oparen) & v33 _then _(
      ret.ek := ekCONST;
      exit
    _) _else _(
      _if v31@.lev = O _then  stdCall
      _else _(
        _if v31@.vty = _NIL _then  factErr(10);
        actPar(v31, ret.in);
        ret.ek := ek3;
        ret.inv := 0;
        _if v31@.vty = boolType _then_(
          ret.ek := ek2;
          ret.off := label;
        _);
      _);
      ret.ty := v31@.vty;
      exit;
    _);
  _)
  _end;
  getT;
16625:
_);

(* L 3 *) _proced LValue (* _var ret: expr *)+
_label 16753, 17005, 17015, 17042, 17057, 17101, 17107, 17254, 17266;
_const (*=a1*)perem='ПЕРЕМ';(*=a0*)
_var v31:idptr;
v32:idptr;
v33:idptr;
v34:expr;
l3v10z:alfa;
l3v11z, l3v12z:int; v3D:alfa;
v3E:pinst;
l3v15z:pinst;
l3v16z, l3v17z, l3v18z, l3v19z:pInst;
l3v20z:ekind; l3obj1z, l3obj2z, l3v23z, l3v24z:int;
l3v25z:bool;

(* L 4 *) _proced LvalErr(a41:int);
_(
  prErr(perem, a41);
  skipTo([0,1,2]);
  _GOTO 17057;
_);

(* L 4 *) _proced L16651(a41:int);
_var v41:pInst;
(* L 5 *) _proced L16637;
 _(
 mkInst(v41);
 v41@.nxt := l3v16z;
 l3v16z := v41;
 v41@.au := auANY;
 _);

_( (* L16651 *)
  L16637;
  _if a41 = 1 _then _(
    v41@ := [, , v3D, WTC, l3v10z];
  _) _else _if a41 = 3 _then _(
    v41@ := [, , v3D, XTA, l3v10z];
    L16637;
    v41@ := [, , '16', VJM, VTM];
    extras[8] := ;
  _) _else _(
    v41@ := [, , '17', ATX, 0];
    _if (a41 = 0) _then _(
      L16637;
      v41@ := [, , '17', WTC, 0];
    _)
  _)
_);

_( (* LValue *)
l3v25z := T;
 _if tokKind = tkField _then _with withs[curWith] _do _(
   v31 := ty;
   l3v20z := ek;
   l3v10z := off;
   v3D := reg;
   l3obj1z := inv;
   _if in = _NIL _then l3v16z := _NIL
   _else _(
     mkInst(l3v16z);
     l3v17z := in;
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
 _) _else (* 16766 *) _if tokKind # tkIdent _then  LvalErr(0); (* not a var or a field *)
 v31 := curId@.vty;
 l3v20z := ek1;
 l3v10z := curId@.off;
 v3D := curId@.lev;
 l3v16z := _NIL;
 l3obj1z := 0;
 _if curId@.bas # _NIL _then _(
   _if curId@.cl = cConst _then _goto 17015;
17005: _if v31@.k = kFile _then  l3obj1z := 1
   _else _( L16651(1); l3v10z := O; v3D := O_)
 _);
 v33 := curId;
 17015:
 getT;
 _case v31@.k _of
 kPtr: _(
   l3v25z := F;
   _if prev = arrow _then _( v31 := v31@.bas; _goto 17005 _) _else _goto 17057;
 _);
 kRec: _(
 l3v25z := F;
 _if prev # dot _then _goto 17057 _else _(
   lookup := 3;
   curRec := v31;
   getT;
   _if (tokKind # tkField) | (curId = _NIL) _then LvalErr(1); (* not a field *)
17042:
   l3v25z := F;
   alfAdd(l3v10z, curId@.hi);
   v31 := curId@.fld6;
   _goto 17015;
 _)_);
 kSc, kRng, kSet: _(
  _if lhs@.trace & l3v25z _then  noDisplay := F;
17057:
  ret := [l3v20z, l3v10z, v3D, v31, l3v16z, l3obj1z];
 _if (v31 = boolType) & (l3v20z = ek2) _then _(
   L16651(1);
   ret.off := label;
   ret.in := l3v16z;
   l3v16z@.op := XTA;
 _);
 exit;
17101: getT; _goto 17057;
 _);
 kArr: _(
   l3v25z := F;
   _if prev # obrack _then _goto 17057;
17107:
   v33 := v31@.alist;
   v32 := v31@.bas;
   doExpr(v34);
   _if (v34.ty@.k # kRng) & (v34.ty # intType)
   & (v34.ty # charType) & (v34.ty@.bas = _NIL) _then LvalErr(5); (* ??? *)
   l3v23z := v33@.pck;
   l3obj2z := 0-l3v23z*v32@.sz;
   alfAdd(l3v10z, l3obj2z);
   l3v23z := v32@.sz;
   _if v34.ek = ekCONST _then _(
     l3obj2z :=   getConst(v34.off);
     _if (l3obj2z < v33@.lo) | (l3obj2z > v33@.hi) _then prErr(perem, 3); (* const index out of range *)
     _if l3v23z # 1 _then  l3obj2z := l3obj2z*l3v23z;
     alfAdd(l3v10z, l3obj2z);
   _) _else _(
     _if modeT & ~typeCheck(v34.ty, v33) _then _(
       load(v34);
       mkCheck(v33, T);
       form2(fOVFL, v34, v33@.nm);
     _);
     _if l3v23z # 1 _then _(
       curOff := v31@.lbl;
       load(v34);
       form1(5, v34);
       _if v33@.pck >= 0 _then v34.in@ := [, , 0, YTA, '30'];
     _);
     _if l3v16z = _NIL _then _(
     _if v34.ek = ek3 _then _(
        v34 := [2, 0, '17'];
        form2(fCMD, v34, ATX);
        l3v20z := ek2;
     _) _else  l3v20z := v34.ek;
     form2(fCMD, v34, WTC);
     l3v16z := v34.in;
    _) _else _(
      v3E := l3v16z@.nxt;
      _if (v3E = _NIL) _then _(
17254:
        _if v34.ek # ek3 _then load(v34);
        append(v34.in, l3v16z);
        l3v16z@.op := ADD;
17266:
        l3v16z@.au := auINT;
        L16651(0);
        l3v20z := ek2;
      _) _else _(
        l3v15z := v3E@.nxt;
        _if v3E@.op = WTC _then _(
        _if l3v20z = ek1 _then _goto 17254
        _else _(
          l3v16z@.op := XTA;
          _if v34.ek # ek1 _then_(
            L16651(2);
            _if v34.ek = ek2 _then load(v34);
            v34 := [, 0, '17'];
          _);
          form2(fCMD, v34, ADD);
          append(l3v16z, v34.in);
          l3v16z := v34.in;
          _goto 17266;
        _)
        _) _else _( (* 17330 *)
          _if v34.ek # ek1 _then _(
            _if v34.ek = ek2 _then load(v34);
            v34 := [, v3E@.a, v3E@.m ];
            mkInst(l3v15z);
            l3v15z@ := v3E@;
          _);
          form2(fCMD, v34, ADD);
          v34.in@.au := auINT;
          v3E@.nxt := v34.in;
          append(l3v15z, l3v16z);
          l3v20z := ek2;
        _)
      _)
    _)
   _); (* 17370 *)
   v31 := v32;
   noDisplay := F;
   _if prev = cbrack _then _goto 17015;
   _if (prev = comma) & (v31@.k = kArr) _then _goto 17107;
   LvalErr(2); (* not a comma, or var is not an array *)
   _goto 17015;
 _);
 kFile: _(
   l3v25z := F;
   _if prev # arrow _then _goto 17057;
   _if v3D = O _then _( v3D := '1'; v31 := charType; _goto 17101 _);
   _if l3obj1z = 1 _then _(
     L16651(3);
     l3v20z := ek2;
     l3v10z := O;
     l3obj1z := ;
     v3D := '15';
     v31 := v31@.bas;
     _goto 17015;
   _);
   _if v31@.pck = 0 _then alfAdd(l3v10z, 1);
   v31 := v31@.bas;
   _goto 17005;
 _)
  _end;
  LvalErr(13); (* unreached *)
_);
(* L 3 *) _proced term(_var ret:expr);
_label 17511, 17636, 17676;
_const imod = 'MOD'; term = (*=a1*)'TERM'(*=a0*);
_var op:(oMUL, oDIVR, oAND, oDIVI, oMOD); v32:int;
v33, v34:idptr;
v35:expr; v3B:int;
l3v12z:bitset;
(* L 4 *) _proced termErr;
_(
  prErr(term, ord(op));
_);

(* L 4 *) _proced doDIVI;
(* L 5 *) _proced LDreal(_var a51:expr);
_(
 _if a51.ek # ek3 _then  form1(fLD, a51);
 form1(fTOREAL, a51);
_);

_( (* doDIVI *)
 LDreal(ret);
 LDreal(v35);
 apply(DIV, F, ret, v35, auFL);
 _);

_( (* term *)
  _if unsigned _then unsigned := F _else  factor(ret);
17511:
  _if prev = semi _then exit;

  _if tokKind = tk0 _then _(
    _if prev = star _then op := oMUL
    _else _if prev = slash _then op := oDIVR
    _else _if prev = chr(81) _then  op := oAND
    _else exit;
  _) _else _( (* 17530 *)
    _if tokKind = tkWord _then _(
      _if tok = kdiv _then op := oDIVI
      _else _if tok = mod _then op := oMOD
      _else _if tok = and _then op := oAND
      _else exit
    _) _else exit
  _); (* 17546 *)
  lookup := 2;
  getT;
  factor(v35);
  _if ret.ty@.k = kRng _then  ret.ty := ret.ty@.bas;
  v33 := ret.ty;
  _if v35.ty@.k = kRng _then  v35.ty := v35.ty@.bas;
  v34 := v35.ty;
  (case) _case op _of
  oMUL: _(
    _if v33@.k # kSet _then _(
    _if ~((v33 # v34) | (v33 # intType)) _then _(
      load(ret);
      _if ~(modeM  | (v35.reg # O) | (v35.in # _NIL)) _then _(
        v32 :=   getConst(v35.off);
        l3v12z := ;
        _if (v32 > 0) & (card(l3v12z) = 1) _then_(
          v32 := minel(l3v12z)+17;
          mapia(v32, v35.off);
          apply(ASN, T, ret, v35, 1);
          _goto 17636;
        _)
      _);
      form1(fORZ64, ret);
      apply(MUL, T, ret, v35, 1);
      form1(fIMUL, ret);
17636:
      ret.ty := intType;
      _) _else _if F13134(MUL, T, ret, v35) _then  termErr;
    _) _else _goto 17676
  _);
  oDIVR: _if (v33 = v34) & (v33 = intType) _then _(
       doDIVI;
       ret.ty := realType;
     _) _else _if F13134(DIV, F, ret, v35) _then  termErr;
  oAND:  _if (v33 = v34) & (v33 = boolType) _then  P13176(F, ret, v35 )
      _else 17676:  _if modeC & ~bothSet(v33, v34) _then termErr
      _else apply(AAX, T, ret, v35, 0);
  oDIVI: _if (v33 # v34) | (v33 # intType) _then termErr
     _else _(
       _if ~(modeM | (v35.reg # O) | (v35.in # _NIL)) _then _(
         v32 :=   getConst(v35.off);
         l3v12z := ;
         _if  v32 > 1 _then _(
           _if card(l3v12z) = 1 _then _(
             v32 := 111-minel(l3v12z);
             mapia(v32, v35.off);
             apply(ASN, T, ret, v35, 1);
             _exit case;
           _) _else _(
             cv.i := inverse(v32);
             putConst(v35.off, F);
             apply(MUL, T, ret, v35, 1);
             _exit case;
           _)
         _)
       _);
       doDIVI;
       form1(fTRUNC, ret);
     _);
  oMOD: _if v33 = v34 _then _(
       _if v33 = intType _then _(
         _if ~modeM & (v35.reg = O) & (v35.in = _NIL) _then _(
           v32 :=   getConst(v35.off);
           l3v12z := ;
           _if (v32 > 1) &  (card(l3v12z) = 1) _then _(
             v32 := 47-minel(l3v12z);
             v32 := -v32;
             code(УИ7=,);
             v32 := 0;
             code(L20014:СД/-1/=ЦС13,7СА1=7И1L20014,);
             cv := ;
             putConst(curOff, F);
             load(ret);
             form1(28, ret);
             _exit case;
         _)_);
         P12713(ret, v35, imod);
       _) _else _if v33@.k = kSet _then apply(AEX, T, ret, v35, 0)
       _else (q) _( termErr; _exit q _)
     _) _else termErr
  _end;
  _goto 17511
_);
(* L 3 *) _proced sexpr(_var ret:expr);
_label 20076, 20131, 20206, 20266;
_const c80=80;
_var neg:bool;
v32:alfa;
v33:idptr;
op:(oADD, oSUB, oOR); v35:expr;
(* L 4 *) _proced sexpErr(a41:int);
 _(
   prErr((*=a1*) 'SЕХРR' (*=a0*), a41);
 _);
_( (* sexpr *)
 neg := F;
 _if ~unsigned _then _(
   _if prev = minus _then _(
     neg := T;
20076:
     lookup := 2;
     getT;
   _) _else  _if prev = plus _then _goto 20076;
 _);
 term(ret);
 _if neg _then _(
   _if (ret.ty # realType) & ~typeCheck(ret.ty, intType) _then  sexpErr(0);
   _if ret.ek # ek3 _then  form1(fLD, ret);
   form1(fNEG, ret);
   _if ret.ty = realType _then  ret.in@.au := auFL;
 _);
20131: _if tokKind = tk0 _then _(
   _if prev = semi _then exit
   _else _if prev = plus _then op := oADD
   _else _if prev = minus _then op := oSUB
   _else _if prev = chr(80) _then op := oOR
   _else exit
 _) _else _( (* 20150 *)
   _if tokKind # tkWord _then exit
   _else _if tok = or _then op := oOR
   _else exit
 _);
 lookup := 2;
 getT;
 term(v35);
 v33 := ret.ty;
 _if v33@.k = kRng _then _( v33 := v33@.bas; ret.ty :=; _);
 obj2 := v35.ty;
 _if obj2@.k = kRng _then  obj2 := obj2@.bas;
 _case op _of
 oADD: _(
   v32 := ADD;
   neg := T;
   _if v33@.k = kSet _then _goto 20266;
20206:
   _if (v33 = obj2) & (v33 = intType) _then apply(v32, neg, ret, v35, 1 )
   _else _if F13134(v32, neg, ret, v35) _then  sexpErr(1);
 _);
 oSUB:
 _if v33@.k # kSet _then _( v32 := SUB; neg := F; _goto 20206 _)
 _else _if bothSet(v33, obj2) _then _(
   load(v35); form2(fEQ, v35, UTC); apply(AAX, T, ret, v35, 0);
 _) _else  sexpErr(2);
 oOR: _if (v33 = obj2) & (v33 = boolType) _then  P13176(T, ret, v35 )
 _else  20266:
 _if bothSet(v33, obj2) _then  apply(AOX, T, ret, v35, 0 )
 _else sexpErr(3)
 _end;
 _goto 20131;
_);

(*=c- L 3 *) _proced doExpr(* _var ret:expr *)+
_label 20317, 20547, 20651, 20621, 20626;
_const (*=a1*)eErr='EXPR';(*=a0*)
_var op, v32:int; v33, v34:bool;
v35, v36:alfa;
v37, l3v8z:idptr; l3v9z:expr;(*=c+*)
_(
 _if needToken _then _(  lookup := 2; getT _) _else needToken := T;
 sexpr(ret);
20317:
 _if tokKind = tk0 _then _(
   _if prev = semi _then exit
   _else _if prev = eq _then op := 1
   _else _if prev = neq _then op := 0
   _else _if prev = lt _then op := 2
   _else _if prev = chr(78) _then op := 5
   _else _if prev = gt _then op := 4
   _else _if prev = chr(79) _then op := 3
   _else exit
 _) _else _if (tokKind = tkWord) & (tok = in) _then op := 6 _else exit;
 lookup := 2;
 getT;
 _if (op = 6) & (tokKind = tkIdent) & (curId # _NIL) & (curId@.cl = cType) _then _(
   _if curId@.k = kAlias _then  curId := curId@.bas;
   _if ret.ty@.k = kFile _then  prErr(eErr, 20);
   _if curId@.k # kRng _then  prErr(eErr, 0);
   mkCheck(curId, T);
   load(ret);
   TNL(v35);
   form2(8, ret, v35);
   ret.in@.au := auINT;
   form2(5, ret, curId@.nm);
   ret.ek := ek3;
   ret.ty := boolType;
   ret.off := v35;
   ret.inv := 0;
   getT;
 _) _else _(
   sexpr(l3v9z);
   _if  ret.ty@.k = kRng _then  ret.ty := ret.ty@.bas;
   v37 := ret.ty;
   _if l3v9z.ty@.k = kRng _then  l3v9z.ty := l3v9z.ty@.bas;
   l3v8z := l3v9z.ty;
   v33 := (v37 = realType) | (l3v8z = realType);
   _if op # 6 _then _(
     _if (v37 # intType) & (l3v8z # intType)
     | ~v33 _then _if ~typeCheck(v37, l3v8z) _then  prErr(eErr, 1);
   _) _else _if (l3v8z@.k # kSet) |
  (v37@.k # kSc) |
  (v37 = alfaType) |
  (v37 = realType) |
  (op = 2) |
  (op = 4) _then prErr(eErr, 2);

  _if v37 = boolType _then
  _case op _of
  0, 1: _(
   load(l3v9z);
   form1(fPSH, l3v9z);
   load(ret);
   form1(fPSH, ret);
   ret.in@.op := AEX;
   appInst(l3v9z, ret);
   ret := [2, , , , , op];
  _);
  2, 3: _(
   ret.inv := ord(odd(ret.inv+1));
20547:
   P13176(F, ret, l3v9z);
   _if (op = 3) | (op = 5) _then ret.inv := ord(odd(ret.inv+1));
  _);
 4, 5: _(
  l3v9z.inv := ord(odd(l3v9z.inv+1));
  _goto 20547;
 _);
 6: _goto 20651
 _end _else (* 20601 *) _if l3v8z@.k <= kSet _then _( v32 := 3;
  _case op _of
  0, 1: _( v36 := '14'; v35 := AEX; v34 := T; v32 := 1_);
  2, 3: _if l3v8z@.k = kSet _then _(
    load(ret);
    form2(fEQ, ret, UTC);
20621:
    v34 := T;
    v35 := AAX;
    op := 1;
  _) _else _(
    v35 := SUB;
20626:
    v34 := F;
    v36 := zero;
    op := op-2;
  _);
 4, 5:
   _if l3v8z@.k = kSet _then _(
     load(l3v9z);
     form2(fEQ, l3v9z, UTC);
     _goto 20621;
   _) _else _(
     v35 := RSUB;
     op := op-2;
     _goto 20626;
   _);
 6:  20651: _(
   load(ret);
   form1(fPSH, ret);
   load(l3v9z);
   appInst(ret, l3v9z);
   ret.in := l3v9z.in;
   form2(fCALL, ret, WTC);
   ret.in@.au := auSETINT;
  _)
 _end;
 _if op = 6 _then op := 0
 _else _if v33 _then _(
   toReal(ret);
   toReal(l3v9z);
   _if modeR _then _(
     P12713(ret, l3v9z, v35);
     ret.in@.au := auSETINT;
     ret.in@.m := v36;
     _if v35 = AEX _then  ret.off := label;
   _) _else _(
     apply(v35, v34, ret, l3v9z, v32);
     _if v32 = 3 _then  form1(15, ret);
   _)
  _) _else _(
     apply(v35, v34, ret, l3v9z, 1);
   _);
   ret := [2, , , boolType, , op];
   _) _else (* 20761 *) prErr(eErr, 3);
 _);
 _goto 20317;
_);
(*=c- L 3 *) _proced doStmt;
_label 23545, 23546, 23553, 23557, 23611, 23710, 23711, 24134, 24662, 24732, 25141;
_var v31, v32, v33:alfa;
v34:int;
v35, stName:alfa;
v37:int; flag, l3v9z:bool;
l3v10z, v3B:pInst;
t1, t2:idptr;
e1, e2, e3:expr;
l3v32z:@labels;
(*=c+*)
(* L 4 *) _function doTarget(a41:alfa):bool;
_(
 doTarget := T;
 _if (tokKind = tkIdent) | (a41 = '1') _then _(
   v3B := stLabs;
   v37 := 1;
 _while v3B # _NIL _do _(
 _if v3B@.au = auINT _then v37 := v37-1
 _else _if (v3B@.au = auANY) & (v3B@.a = tok) _then_(
   _if v37 # 1 _then _(
     mapia(v37, v32);
     cmd(cLEA, v32);
     v37 := 10;
   _);
   _if a41 = goto _then cmd(v37, v3B@.m)
   _else  cmd(v37, v3B@.op);
   _if v37 # 1 _then putInsn('ПБFАМ');
    exit
   _) _else ; (* 21037 *)
   v3B := v3B@.nxt;
  _); (* 21041 *)
  _if a41 = '1' _then _(
    _if v37 # 1 _then _(
      mapia(v37, v32);
      cmd(cLEA, v32);
      write('12ПВFАМ');
      putSep;
      align;
    _);
    L4225(1);
  _) _else  prErr(stName, 2);
 _) _else doTarget := F;
_);
(*=c- L 4 *) _proced standProc;
_label 21410, 21412, 21420, 21731, 22054, 22177, 22235, 22254, 22500;
_const zun='UN';zia='IА';zai='АI';ztnl='ТNL';zgg='ГГ';zga='ГА';zyaga='ЯГА';ziaca='1ИАСА';
zpvro='16ПВRО';zpvpo='16ПВРО';zpvgi='16ПВGI';zpvri='15ПВRI';zpvpr='16ПВРR';zpvsl='16ПВSL';
(*=a1*)wri='WRITE'(*=a0*);
_var v41:int; v42:alfa;
v43:alfa;
v44, v45, l4v6z:alfa;
flag, savT, l4v9z, hasArgs, l4v11z:bool;
(*=c+*)
(* L 5 *) _proced stPrErr(a51:int);
 _(
 prErr(stName, a51);
 _GOTO 23711;
 _);
 (* L 5 *) _proced P21077(a51:int; a52:bool);
_var l5v1z:alfa; _(
  octal := F;
  _if prev = colon _then _(
    doExpr(e2);
    l4v11z := F;
    _if ((e2.ty@.k # kRng)  | (e2.ty@.bas # intType))
    & (e2.ty # intType) _then  prErr(wri, 0);
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

(* L 5 *) _proced L21145(a51:alfa);
 _(
 _if l4v9z _then _(
   _if modeI & (a51 = 'WL') _then _( putAlign('16ПВРR'); exit _)
   _else _(
     _if (a51 = 'WС') & l4v11z _then _( putInsn('1ЗЧ10'); putAlign('16ПВРО'); exit _);
     _if a51 = 'WJ' _then  modBase;
     ГГ('16ПВО');
   _);
 _) _else _if ~hasArgs _then _(
   ГГ(v44, l4v6z, v45); putSep;
   ГГ('16ПВ', 'F'); extras[11] := UTC;
 _) _else _(
   _if (a51 = 'WС') & l4v11z _then _(
     ГГ(v44, WTC, v45); putSep;
     putInsn(ATX);
     ГГ(v44, UTC, v45); putSep;
     putInsn('15ПА');
     ГГ('16ПВ'); putAlign('РF');
     exit
   _);
   ГГ(v44, UTC, v45); putSep;
   putInsn('15ПА');
   _if a51 = 'WJ' _then  modBase;
   ГГ('16ПВ');
 _);
 putAlign(a51);
_);
(* L 5 *) _proced P21247(a51:int; a52:alfa);
_(
 l4v11z := T;
 _if a52 = 'WС' _then P21077(a51, T) _else P21077(a51, F);
 L12635(e1);
 _if octal & (a52 = 'WI') _then _( a52 := 'WJ'; doOctal := T _);
 octal := F;
 L21145(a52);
 _);

(* L 5 *) _proced L21277;
_(
  getT;
  _if (tokKind # tkIdent) | (curId = _NIL) _then stPrErr(9);
_);

(* L 5 *) _proced P21311(_var a51:expr; a52:idptr);
_label 21335;
 _(
 lookup := 2;
 getT;
 _if tokKind = tkIdent _then _(
   _if curId = _NIL _then stPrErr(16)
   _else _if ((curId@.cl = cConst) & (curId@.bas # _NIL)) | (curId@.cl = cVar) _then _(
21335:
     LValue(a51);
     _if modeC & (a52 # _NIL) & ~typeCheck(a51.ty, a52) _then  stPrErr(12);
   _) _else
     stPrErr(11)
 _) _else _goto 21335
_);

_( (* standProc *)
 v41 := ord(t1@.bas);
 stName := t1@.nm;
 hasArgs := prev = oparen;
 _if ~hasArgs & ~(v41 _IN [7,8,9,20,30]) _then  stPrErr(5);
 _case v41 _of
 0: _(                                        % PUT
   L21277;
   v43 := 'РF';
   _if curId = inFile _then prErr(stName, 10)
   _else _if curId = outFile _then _(
     putAlign('16ПВРО');
21410:
     getT;
21412:
     _if prev # cparen _then  stPrErr(7);
     getT;
     exit
   _) _else 21420: _(
     _if (curId@.cl # cVar) | (curId@.vty@.k # kFile) _then stPrErr(8);
     flag := curId@.bas # _NIL;
     _if modeDe & (curId@.nm = (*=a1*)'INР'(*=a0*)) & (v43 = 'GF') _then _(
        ГГ('16ПВ');
        putAlign('76312');
     _) _else _(
        ГГ(curId@.lev);
        _if flag _then ГГ(XTA) _else  ГГ(UTC);
        putInsn(curId@.off);
       _if ~flag _then  putInsn('15ПА');
       ГГ('16ПВ');
       _if flag _then _( extras[10] := UTC; ГГ('F') _);
       putAlign(v43);
     _);
     _goto 21410;
   _);
 _);
 1: _(                                        % GET
   L21277;
   v43 := 'GF';
   _if curId = inFile _then _( putAlign('16ПВGI'); _goto 21410 _)
   _else _if curId = outFile _then prErr(stName, 14)
   _else _goto 21420;
 _);
 2: _(                                        % REWRITE
   L21277;
   v43 := 'RWF';
   _if curId # outFile _then _(
     _if curId = inFile _then prErr(stName, 15) _else _goto 21420;
   _);
   putAlign('16ПВRО');
   _goto 21410;
 _);
 3: _(                                        % RESET
   L21277;
   v43 := 'RF';
   _if curId = inFile _then _(
     putAlign('15ПВRI');
     _goto 21410;
   _) _else _if curId = outFile _then prErr(stName, 17) _else _goto 21420;
 _);
 4, 21: _(                                    % NEW, DISPOSE
   P21311(e1, _NIL);
   flag := T;
   dynMem := dynMem+1;
   _if e1.ty@.k # kPtr _then _GOTO 23710;
   t1 := e1.ty@.bas;
   v37 := t1@.sz;
   _if prev = eq _then _(
     doExpr(e2);
     _if ~typeCheck(e2.ty, intType)  _then  prErr(stName, 4);
     flag := F;
   _) _else _( (* 21574 *)
     _if t1@.k = kRec _then _(
       _if prev = semi _then _(
         curRec := t1;
         lookup := 3;
         getT;
         _if curId = _NIL _then prErr(stName, 18)
         _else _( v37 := curId@.hi+1; getT_)
       _) _else _(
         t1 := t1@.bas;
        _while (prev = comma) & (t1 # _NIL) _do _(
          t2 := _NIL;
          getT;
          litConst(t2, v42, T);
          _if t2 = _NIL _then _(  v37 := 19; _GOTO 23711_);
          getT;
          _while (t1 # _NIL) & (t1@.cl # cCase) _do t1 := t1@.vty;
          _if t1 # _NIL _then _(
            t2 := t1@.vty;
            _while (t2 # _NIL) & (v42 # t2@.lev) _do t2 := t2@.vty;
             _if t2 = _NIL _then _(
               v37 := t1@.hi+1;
               t1 := _NIL;
             _) _else _(
               v37 := t2@.cs6;
               t1 := t2@.nxt;
             _)
           _)
        _)
    _)_)_);
    form2(fSETREG, e1, '14');
    mapia(v37, v42);
    _if flag _then_( ГГ('12ПА'); putInsn(v42) _)
    _else _( L12635(e2); putInsn('УИ12')  _);
    _if v41 = 4 _then putAlign('16ПВАL')
    _else _( putAlign('16ПВDS'); extras[1] := UTC_);
    _goto 21412;
 _);
 5: _( flag := F; v42 := 'UN'; _goto 21731_);% UNPCK
 6: _( flag := T; v42 := 'РА'; 21731:        % PCK
   t1 := charType;
   t2 := alfaType;
   savT := modeT;
   modeT := F;
   P21311(e1, t1);
   _if prev # comma _then  stPrErr(13);
   P21311(e2, t2);
   _if flag _then _(
     form1(fUVTM15, e1);
     form2(fCALL, e1, v42);
     e1.ek := ek3;
     noDisplay := T;
     P13734(e2, e1);
   _) _else _(
     form1(fUVTM15, e1);
     load(e2);
     appInst(e1, e2);
     form2(fCALL, e2, v42);
     dump(e2.in);
   _);
   modeT := savT;
   _goto 21412;
 _);
 7: _(                                        % EXIT
   _if modeF & (v2C # O) _then _(
     putInsn('12ПА2');
     putIarg('15ПА', v2C);
     mapia(lineNum, curOff);
     putIarg('14ПА', curOff);
     putAlign('16ПВЖЬ');
   _);
   v42 := tok;
   tok := O;
   flag :=   doTarget('1');
   tok := v42;
 _);
 8: putAlign('16ПВРR');                       % PRINTO
 9: _(                                        % HALT
   putAlign('16ПВПБ');
   extras[13] := VTM
 _);
 10: _(                                       % MAPIA
   v42 := 'IА'; t1 := _NIL; t2 := alfaType;
22054:
   doExpr(e1);
   _if (t1 # _NIL) & ~typeCheck(e1.ty, t1) _then  stPrErr(12);
   _if ~(prev = comma) _then  stPrErr(13);
   P21311(e2, t2);
   L12635(e1);
   ГГ('16ПВ');
   putAlign(v42);
   store(e2);
   _goto 21412;
 _);
 11: _(                                       % MAPAI
 v42 := 'АI'; t1 := alfaType; t2 := intType;
 _goto 22054 _);
 12: _(                                       % TNL
   P21311(e1, alfaType);
   _if e1.ty = alfaType _then _(
     cmd(call16, 'ТNL');
     store(e1);
     _goto 21412;
   _) _else _(
     load(e1);
     putAlign('16ПВSL');
     _goto 21412;
   _)
 _);
 13: _(                                       % ГГ
   v42 := 'ГГ';
   _repeat
     doExpr(e1);
     load(e1);
     form2(fVJM14, e1, v42);
     dump(e1.in);
   _until (prev # comma);
   _goto 21412;
 _);
 14: _( v42 := 'ГА'; t1 := charType; t2 := t1; _goto 22054 _);
 15: _( v42 := 'ЯГА'; t1 := alfaType; t2 := t1; _goto 22054 _);
 16: _(                                       % CODE
   _if input@ = eq _then _( get(input); _if leftInsn _then  ГГ('ИА=') _)
   _else align;
   _repeat
   _goto 22177;
   _repeat
     get(input);
22177:
     _if input@ = endl _then _( lineNum := lineNum+1; nLex := 0 _)
     _else _( MAPГA(input@, output@); put(output) _);
   _until (input@ _IN [comma,eq,semi,chr(26),colon]);
   leftInsn := input@ # eq;
   get(input);
   _until (input@ = cparen);
   get(input);
   curLab := O;
   getT;
 _);
 17: _(                                       % SETUP
   P21311(e1, _NIL);
   putInsn('1ИАСА');
   putInsn(XTA);
   store(e1);
22235:
   _if e1.ty@.k # kPtr _then stPrErr(6);
   _goto 21412;
 _);
 18: _(                                       % ROLLUP
   P21311(e1, _NIL);
   L12635(e1);
   putInsn('1ИАСА');
   putInsn(ATX);
   _goto 22235;
 _);
 19: 22254: _(                                % WRITE
   flag := T;
   l4v9z := ;
   _repeat
   lookup := 2;
   allowLong := T;
   getT;
   allowLong := F;
   l4v6z := XTS;
   _if tokKind = tkStr _then _(
     v42 := tok;
     getT;
     _if (prev # colon) & l4v9z _then _(
       mapia(strLen, v43);
       P4511(6, v42, v43);
     _) _else _(
       P21077(strLen, F);
       mapia(strLen, v43);
       ГГ('12ПА', v43); putSep;
       _if modeX _then _(  ГГ(BPUTC); putSep_);
       ГГ('11ПА', v42); putSep;
       l4v6z := XTA;
       L21145('WS');
     _)
   _) _else _( (* 22324 *)
     needToken := F;
     doExpr(e1);
     _if flag & (e1.ty@.k = kFile) _then _(
       _if e1.reg # O _then _(
         _if typeCheck(e1.ty, textFile) _then _(
           l4v9z := F;
           v44 := e1.reg;
           v45 := e1.off;
           hasArgs := e1.inv = 0;
         _) _else prErr(wri, 3);
       _) _else _(
         _if e1.off = '7' _then  prErr(wri, 1);
       _)
     _) _else _( (* 22363 *)
       _if e1.ty@.k = kRng _then  e1.ty := e1.ty@.bas;
       _if e1.ty = charType _then P21247(1, 'WС')
       _else _if e1.ty = alfaType _then P21247(6, 'WА')
       _else _if e1.ty = boolType _then P21247(6, 'WВ')
       _else _if e1.ty = intType _then P21247(10, 'WI')
       _else _if e1.ty = realType _then _( P21077(14, F); P21247(4, 'WR') _)
       _else _if e1.ty@.k = kSc _then _(
         dumpNames(e1.ty);
         P21077(6, F);
         L12635(e1);
         putInsn('УИ14'); ГГ('14СА', e1.ty@.lbl); putSep;
         modBase;
         putInsn('14СЧ');
         L21145('WА');
       _)
       _else prErr(wri, 2);
   _)_); (* 22453 *)
   curAU := 1;
   flag := F;
   _until prev # comma;
   l4v6z := XTA;
   _if v41 = 20 _then  L21145('WL');
   _goto 21412;
 _);
 20: _(                                       % WRITELN
   _if hasArgs _then _goto 22254
   _else _if modeI _then putAlign('16ПВРR')
   _else _( ГГ('16ПВО'); putAlign('WL') _)
 _);
 22, 23: stPrErr(0);                          % READ, READLN
 25, 26, 28: _(                               % PUTD, GETD, MODD
   flag := T;
22500:
   mapia(v41-22, v43);
   _repeat
   doExpr(e1);
   _if  e1.ty@.k >= kArr _then  prErr(stName, 0);
   L12635(e1);
   putInsn('ИК5'); putInsn('11ПА'); putInsn('11ЗЧ10');
   _if flag _then _(
     _if prev # comma _then  stPrErr(1);
     _if ~L14707(e1) _then  stPrErr(2);
     cv.i := e1.ty@.sz;
     putConst(v42, F);
     L12445(e1);
     dump(e1.in);
     putInsn('11ЗЧ13');
     _if prev = eq _then _(
       doExpr(e2);
       _if e2.ty # intType _then  prErr(stName, 3);
       L12635(e2);
     _) _else _( ГГ(XTA); putInsn(v42)_);
     putInsn('11ЗЧ15');
   _);
   cmd(cLEA, v43);
   cmd(call16, 'ВD');
   curAU := 0;
   setAUInt;
   _until prev # comma;
   extras[15] := WTC;
   extras[13] := ;
   extras[14] := ;
   _goto 21412;
 _);
 24, 27: _( flag := F; _goto 22500 _);        % OPEND, DELD
 29: stPrErr(3);                              % NEWD
 30: _(                                       % BIND
   modBase;
   write('15ПА');
   _if hasArgs  _then_(
     allowLong := T;
     getT;
     allowLong := F;
     _if tokKind = tkStr _then _(
       _if  strLen > 60 _then  prErr(stName, 0);
       ГГ(tok);
       getT;
     _) _else prErr(stName, 1);
   _);
   putSep;
   putAlign('12ПВФ');
   _if hasArgs _then _goto 21412;
 _);
 31: _(                                       % INS
   P21311(e1, _NIL);
   chkComma;
   twoarg(1, e1);
   _goto 21412;
 _)
 _end;
_);
(* L 4 *) _proced condJump(_var a41:expr; a42:alfa);
_label 22750;
_(
 _case a41.ek _of
 ekCONST:  _if a41.inv = 0 _then  cmd(cGOTO, a42);
 ek2: _goto 22750;
 ek1: _(
   form1(fLD, a41);
22750:
   dump(a41.in);
   cmd(3-a41.inv, a42);
 _);
 ek3: _if a41.inv = 0 _then _(
   replace(a41.in, a41.off, a42);
   dump(a41.in);
 _) _else _(
   dump(a41.in);
   cmd(cGOTO, a42);
   cmd(cLAB, a41.off);
 _)
 _end
_);
(* L 4 *) _proced doCase;
_label 23252, 23326, 23333;
_type item = _record f0:@item; off:int; f2, f3: alfa _end;
_var v41, v42, v43, v44, v45:@item;
 l4v6z:bool; l4v7z:int; _(
 l4v7z := lineNum;
 doExpr(e1);
 _if (e1.ty@.k > kRng) | (e1.ty = realType) _then prErr(case, 0); % bad case expr type
 setAUInt;
 TNL(v31);
 cmd(cGOTO, v31);
 TNL(v35);
 v41 := _NIL;
 setup(v43);
 _if tok # of _then _(  v37 := 6; _GOTO 23711 _);
  t2 := _NIL;
  getT;
  _repeat _if (prev # semi) & (tokKind # tkWord) _then _(
    TNL(v33);
    metka(v33);
    _repeat
    curAU := 1;
    t1 := _NIL;
    litConst(t1, v32, T);
    _if t1 # _NIL _then _(
      _if t2 = _NIL _then t2 := t1
      _else _if t1 # t2 _then  prErr(case, 1);          % case constants of different types
      new(v42);
      v42@.off := getConst(v32);
      v37 := v42@.off;
      v42@.f2 := v33;
      v42@.f3 := v32;
      v44 := v41;
      (loop) _while v44 # _NIL _do _(
        _if v37 < v44@.off _then _exit loop
        _else _if v37 = v44@.off
        _then _(  prErr(case, 2); _exit loop _)
        _else _( v45 := v44; v44 := v44@.f0 _);
      _);
      _if v44 = v41 _then _(  v42@.f0 := v41; v41 := v42 _)
      _else _( v42@.f0 := v44; v45@.f0 := v42 _);
      getT;
    _) _else (* 23152 *) _( v37 := 7; _GOTO 23711 _);
    l4v6z := prev # comma;
    _if ~l4v6z  _then  getT;
    _until l4v6z;
    _if prev # colon _then _( v37 := 3; _GOTO 23711_);
    lookup := 2;
    getT;
    doStmt;
    setAUInt;
    idxBase;
    ГГ(UJ); putInsn(v35);
  _); (* 23205 *)
  l4v6z := prev # semi;
  _if ~l4v6z _then _(  getT;
    _if (tokKind = tkWord) &  (tok = end) _then_( v37 := 33; _GOTO 23711 _)
  _);
  _until l4v6z;
  _if tok # end _then_( v37 := 5; _GOTO 23711_) _else getT;
  t1 := e1.ty;
  _if t1@.k = kRng _then  t1 := t1@.bas;
  _if ~typeCheck(t1, t2) _then  prErr(case, 4);
  metka(v31);
  _if v41 = _NIL _then _(
23252:
     rollup(v43);
     exit
  _);
  L12635(e1);
  v37 := 0;
  v44 := v41;
  _while v44 # _NIL _do _(
    _if v37 = v44@.off _then _(
      v37 := v37+1;
      v44 := v44@.f0;
    _) _else _goto 23333;
 _);
 align;
 TNL(v31);
 _if modeS _then _(
   v2S := l4v7z;
   noDisplay := F;
   display(e1.ty, F);
 _);
 putInsn('УИ15');
 modBase;
 ГГ('15ПБ'); putInsn(v31);
 metka(v31);
 v44 := v41;
 _while v44 # _NIL _do _(
   ГГ( (* added in the next version: '10', *) UJ, v44@.f2, '=,');
   v44 := v44@.f0;
 _);
23326:
 metka(v35);
 setAUInt;
 _goto 23252;
23333:
 v44 := v41;
 idxBase;
 putInsn('ЗЧ1');
 _if modeS _then _(
   v2S := l4v7z;
   noDisplay := F;
   display(e1.ty, F);
 _);
 _while v44 # _NIL _do _(
   ГГ(BP, AEX); putInsn(v44@.f3);
   ГГ(BP, 'У0'); putInsn(v44@.f2);
   v44 := v44@.f0;
   _if v44 # _NIL _then _(  idxBase; putInsn('СЧ1') _);
 _);
 _goto 23326;
_);

_( (* doStmt *)
 setup(l3v10z);
 silent := F;
 noDisplay := T;
 (*=a1*)
 _if tokKind = tkInt _then _(
   l3v32z := labList;
   setAUInt;
   flag := T;
   _if v2H # 0 _then  prErr(to, 10);
   _while l3v32z # v2Q _do _(
     _if l3v32z@.num # ival _then l3v32z := l3v32z@.nxt
     _else _(
       flag := F;
       _if l3v32z@.def _then _(  cv.i := l3v32z@.line; prErr(to, 3)_)
       _else _(
         _if l3v32z@.lab = O _then  L13566(l3v32z@.lab) _else cmd(cLAB, l3v32z@.lab);
         l3v32z@.line := lineNum;
         l3v32z@.def := T;
       _);
       l3v32z := v2Q;
     _)
   _); (* 23446 *)
   _if flag _then  prErr(to, 2);
   getT;
   _if prev # colon _then prErr('НЕТ : ', 1 )
   _else _( lookup := 2;   getT_)
 _); (* 23463 *)
 _if prev = oparen _then _(
   getT;
   _if tokKind # tkIdent _then _( stName := 'НЕТ ИД'; _goto 23710 _);
   mkInst(v3B);
   L13566(v31);
   TNL(v32);
   v3B@ := [ stLabs, 0, v31, v32, tok];
   stLabs := v3B;
   getT;
   _if prev # cparen _then _( stName := 'НЕТ )'; _goto 23710 _);
   lookup := 2;
   getT;
   doStmt;
   cmd(cLAB, v32);
   stLabs := stLabs@.nxt;
   _goto 25141;
 _); (* 23525 *)
 _if tokKind = tkIdent _then _goto 24662;
 _if tokKind = tkField _then _goto 24732;
 _if tokKind # tkWord _then _goto 25141;
 stName := tok;
 _if tok = begin _then _(
   v37 := lineNum;
   _repeat
     lookup := 2;
     getT;
     doStmt;
   _until prev # semi;
   _goto 23546;
23545:
   v37 := 1;
23546:
  _if (tokKind # tkWord) | (tok # end) _then _goto 23711;
23553:
  getT;
  _goto 25141;
 _);
 _if tok = goto _then 23557: _(
   getT;
   _if tokKind # tkInt _then _if doTarget(goto) _then _goto 23553 _else _goto 23710;
   setAUInt;
   _if v2H # 0 _then  prErr(to, 10);
   l3v32z := labList;
   _while l3v32z # _NIL _do _(
     _if l3v32z@.num = ival _then _goto 23611
     _else  l3v32z := l3v32z@.nxt;
   _); prErr('ТО', 4);
23611: (*=a0*)
   _if modeG _then _(
     mapia(ival, curOff);
     putIarg('12ПА', curOff);
     mapia(lineNum, curOff);
     putIarg('14ПА', curOff);
     putAlign('16ПВZQ');
   _);
   _if l3v32z@.lab = O _then _(
     TNL(l3v32z@.lab);
     l3v32z@.line := lineNum;
   _);
   _if level = l3v32z@.lev _then _(
     cmd(cGOTO, l3v32z@.lab);
   _) _else _(
     ГГ(l3v32z@.lev); putInsn('ПИ15');
     modBase;
     ГГ('16ПА'); putInsn(l3v32z@.lab);
     putInsn('ПБRС');
   _);
   _goto 23553;
 _); (* 23656 *)
 _if tok = go _then _(
   getT;
   _if tok = to _then _goto 23557;
   v37 := 0;
   _goto 23711;
 _);
 _if tok = if _then _(
   setAUInt;
   doExpr(e1);
   _if e1.ty # boolType _then  prErr(stName, 0);
   TNL(v31);
   condJump(e1, v31);
   _if (tokKind # tkWord) | (tok # then) _then _(
23710:
     v37 := 1;
23711:
     prErr(stName, v37);
     skipTo([0,1,2]);
     _goto 25141;
   _);
   lookup := 2;
   getT;
   doStmt;
   _if (tokKind = tkWord) & (tok = else) _then _(
     lookup := 2;
     getT;
     TNL(v32);
     v37 := curAU;
     curAU := 1;
     cmd(cGOTO, v32);
     cmd(cLAB, v31);
     doStmt;
     cmd(cLAB, v32);
     _if v37 # curAU _then _( curAU := 2; setAUInt_);
   _) _else cmd(cLAB, v31);
   _goto 25141;
 _); (*23755*)
 _if tok = while _then _(
   setAUInt;
   doExpr(e1);
   _if e1.ty # boolType _then prErr(stName, 0);
   L13566(v31);
   TNL(v32);
   condJump(e1, v32);
   _if (tokKind # tkWord) | (tok # do) _then _goto 23710;
   lookup := 2;
   getT;
   doStmt;
   setAUInt;
   cmd(cGOTO, v31);
   cmd(cLAB, v32);
   curAU := 1;
   _goto 25141;
 _); (* 24017 *)
 _if tok = repeat _then _(
   L13566(v31);
   setAUInt;
   _repeat
     lookup := 2;
     getT;
     doStmt;
   _until prev # semi;
   _if (tokKind # tkWord) | (tok # until) _then _goto 23710;
   setAUInt;
   doExpr(e1);
   _if e1.ty # boolType _then  prErr(stName, 0);
   condJump(e1, v31);
   _goto 25141;
 _); (* 24054 *)
 _if tok = kexit _then _(
   getT;
   _if doTarget(kexit) _then _goto 23553 _else _goto 23710
 _);
 _if tok = for _then _(
   getT;
   setAUInt;
   _if (tokKind # tkIdent) | (curId = _NIL) _then _goto 23710;
   _if ((curId@.cl = cVar) & (curId@.bas = _NIL))
   | ((curId@.cl = cConst) & (curId@.bas # _NIL)) _then _(
     t1 := curId@.vty;
     _if t1@.k = kRng _then  t1 := t1@.bas;
     _if (t1@.k = kSc) & (t1 # realType) & (t1 # alfaType) & (t1 # boolType) _then _(
       LValue(e1);
       _goto 24134;
     _)
   _);
   prErr(stName, 0);
   e1 := [1, , , intType, _NIL, 0];
   getT;
24134:
   _if prev # asg _then _(
     e2 := [0, '13', 0, e1.ty, _NIL, 0];
     _if modeX _then  e2.reg := BP;
   _) _else _(
     doExpr(e2);
     _if e1.ty@.k = kRng _then  e1.ty := e1.ty@.bas;
     _if e2.ty@.k = kRng _then  e2.ty := e2.ty@.bas;
     _if ~typeCheck(e1.ty, e2.ty) _then  prErr(stName, 2);
   _); (* 24171 *)
   L12635(e2);
   e2 := e1;
   store(e2);
   _if tokKind # tkWord _then  prErr(stName, 3);
   _if tok = to _then v33 := RSUB
   _else _if tok = downto _then v33 := SUB
   _else _( v37 := 4; _goto 23711 _);
   doExpr(e2);
   _if e2.ty@.k = kRng _then  e2.ty := e2.ty@.bas;
   _if ~typeCheck(e1.ty, e2.ty) _then  prErr(stName, 5);
   L13566(v31);
   TNL(v32);
   e3 := e1;
   apply(v33, F, e3, e2, 1);
   e3 := [2, , , boolType, , 1];
   condJump(e3, v32);
   _if (tokKind # tkWord) | (tok # do) _then _( v37 := 6; _goto 23711 _);
   lookup := 2;
   getT;
   doStmt;
   setAUInt;
   e2 := e1;
   L12635(e1);
   idxBase;
   _if v33 = RSUB _then ГГ(ADD) _else ГГ(SUB);
   putInsn(one);
   store(e2);
   cmd(cGOTO, v31);
   cmd(cLAB, v32);
   _goto 25141;
 _); (* 24326 *)
 _if tok = select _then _(
   setAUInt;
   flag := T;
   TNL(v32);
   _repeat
     curAU := 1;
     doExpr(e1);
     _if e1.ty # boolType _then  prErr(stName, 0);
     TNL(v31);
     condJump(e1, v31);
     _if prev # colon _then _( v37 := 2; _goto 23711 _);
     lookup := 2;
     getT;
     curAU := 1;
     doStmt;
     cmd(cGOTO, v32);
     flag := flag & (curAU = 1);
     cmd(cLAB, v31);
   _until prev # semi;
   cmd(cLAB, v32);
   _if ~flag _then _(  curAU := 0; setAUInt _);
   _goto 23545;
 _); (* 24403 *)
 _if tok = case _then _( doCase; _goto 25141 _);
 _if tok = with _then _(
   v37 := nWith;
   e3.ek := v2F;
   _repeat
      lookup := 2;
      getT;
      _if tokKind = tkIdent _then _(
        _if curId = _NIL _then _goto 23710
        _else _if ((curId@.cl # cConst) | (curId@.bas = _NIL))
        & ~(curId@.cl = cVar) _then  prErr(stName, 0);
      _) _else _if tokKind # tkField _then _( v37 := 2; _goto 23711 _);
      LValue(e1);
      _if e1.ty@.k # kRec _then prErr(stName, 3)
      _else _(
        nWith := nWith+1;
        _if (e1.in # _NIL) & (e1.in@.nxt # _NIL) _then _(
          form1(23, e1);
          dump(e1.in);
          e1 := [1, v2B, level, , _NIL];
          store(e1);
          e1 := [, 0, 0, , _NIL];
          form1(fWTC, e1);
          v2F := succ(v2F);
          mapia(v2F, v2B);
        _); (* 24505 *)
        withs[nWith] := e1;
      _)
   _until prev # comma;
   _if (tokKind # tkWord) | (tok # do) _then _( v37 := 4; _goto 23711 _);
   lookup := 2;
   getT;
   doStmt;
   nWith := v37;
   _if v2F > v2G _then  v2G := v2F;
   v2F := e3.ek;
   mapia(v2F, v2B);
   _goto 25141;
 _); (* 24536 *)
 _if tok = branch _then _(
   extras[14] := tok;
   extras[13] := ;
   v2H := v2H+1;
   mkInst(v3B);
   v3B@:= [stLabs, 1];
   stLabs := v3B;
   doExpr(e1);
   _if ~(e1.ty@.k _IN [kSc,kRng]) _then prErr(stName, 0);
   L12635(e1);
   TNL(v31);
   TNL(v32);
   cmd(cLEA, v31);
   putAlign('16ПВЕА');
   _if (tokKind # tkWord) |  (tok # of) _then _goto 23710;
   _repeat
     curAU := 1;
     lookup := 2;
     getT;
     doStmt;
     cmd(cGOTO, v32);
     cmd(cLAB, v31);
     flag := prev = semi;
     _if flag  _then _(
       TNL(v31);
       cmd(cLEA, v31);
       putAlign('16ПВNА');
     _)
   _until ~flag;
   cmd(cLAB, v32);
   v2H := v2H-1;
   putAlign('16ПВFА');
   curAU := 1;
   stLabs := stLabs@.nxt;
   _goto 23545;
 _); (* 24641 *)
 _if tok = back _then _(
   doExpr(e1);
   _if ~(e1.ty@.k _IN [kSc,kRng]) _then  prErr(stName, 0);
   L12635(e1);
   putInsn('ПБВА');
 _);
 _goto 25141;
24662:
 stName := to;
 _if curId = _NIL _then _( v37 := 5; _goto 23711 _);
 _if curId@.cl = cFun _then _(
   lhs := dummyId;
   t1 := curId;
   getT;
   _if t1@.lev = O _then _( standProc; _goto 25141 _);
   _if t1@.vty # _NIL _then _(
     e1.ek := ek1;
     e1.off := '3';
     mapai(t1@.lev, v37);
     mapia(v37+1, e1.reg);
     e1.ty := t1@.vty;
     e1.in := _NIL;
     e1.inv := 0;
   _) _else _( actPar(t1, v3B); _goto 25141 _)
 _) _else _(
   _if curId@.cl # cVar _then _if ((curId@.cl # cConst) | (curId@.bas = _NIL))
   _then _( v37 := 6; _goto 23711 _);
24732:
   v2S := lineNum;
   lhs := curId;
   LValue(e1);
 _); (*=a1 24737 *)
 _if prev # asg _then _( stName :='НЕТ :='; _goto 23710 _);
 lookup := 2;
 getT;
 needToken := F;
 _if (e1.ty@.k = kRec) & (prev = obrack) _then _(
   load(e1);
   e1.in@.op := UTC;
   form1(13, e1);
   dump(e1.in);
   v31 := O;
   (loop) _(
     lookup := 2;
     getT;
     (wh) _if prev # cbrack _then _(
       _if prev = comma _then _(
         alfAdd(v31, 1);
         _goto loop;
       _) _else _(
         needToken := F;
         doExpr(e2);
         load(e2);
         form2(fST11, e2, v31);
         dump(e2.in);
         _goto wh
       _);
     _)
   _);
   getT;
   _goto 25141;
 _); (* 25016 *)
 _if prev = semi _then _(
   _if lhs@.trace _then  display(lhs, T);
   store(e1);
   needToken := T;
   _goto 25141;
 _);
 l3v9z := noDisplay;
 doExpr(e2);
 noDisplay := l3v9z;
 (loop) _if typeCheck(e1.ty, e2.ty) _then _(
   _if e1.ty@.k = kFile _then  prErr(to, 0);
 _) _else _if e2.ty@.k = kRng _then _(
   e2.ty := e2.ty@.bas; _goto loop;
 _) _else _if (e1.ty = realType) & (e2.ty = intType) _then _(
   toReal(e2);
   load(e2);
 _) _else _if (e1.ty@.k = kRng) & (e1.ty@.bas = e2.ty) _then _(
   _if e2.ek = ekCONST _then _(
     v37 := getConst(e2.off);
     _if (v37 < e1.ty@.lo) | (v37 > e1.ty@.hi)
     _then prErr('ГР ДИА', 0 );
   _) _else _if modeT _then _(
     load(e2);
     form2(fOVFL, e2, e1.ty@.nm);
   _)
 _)_else
   prErr(to, 1); (* 25123 *)
 _if (e1.ek = ek2) & (e1.ty = boolType) _then _(
   v3B := e1.in;
   e1.in := v3B@.nxt;
   e1.off := v3B@.a;
   e1.reg := v3B@.m;
 _);
 P13734(e1, e2);
25141: rollup(l3v10z)
_);
(* L 3 *) _proced header;
_var prog:idptr; v32:int; v33:alfa; v34:int;
(* L 4 *) _proced hdrErr(a41:int);
_(
 prErr('ЗАГОЛ', a41);
 skipTo([1,2]);
_);
(*=c- L 4 *) _proced params;
_type nuzzzz = 100000B..671420B; len = 1..40B;
_var ef:@extFile; v42:int; (*=c+*) _(
 v42 := 0;
 _repeat
   getT;
   _if tokKind # tkIdent _then _( hdrErr(3); exit _);
   ef := extFList;
   _if (tok = 'INРUТ') | (tok = 'ОUТРUТ') _then prErr(to, 9);
   _while ef # _NIL _do _(
     _if ef@.nm = tok _then  prErr(to, 7);
     ef := ef@.nxt;
   _);
   new(ef);
   ef@ := [tok, , 0, 0, extFList];
   extFList := ef;
   getT;
   _if prev = eq _then _(
     getT;
     _if tokKind # tkInt _then  hdrErr(4);
     _if ival _IN nuzzzz _then ef@.nuz := ival _else prErr(to, 8);
     getT;
     _if tokKind # tkInt _then  hdrErr(4);
     _if ival _IN len _then ef@.len := ival _else prErr(to, 8);
     getT;
   _) _else (* 25267 *) _(
     v42 := v42+1;
     ef@.nuz := v42;
   _)
 _until prev # comma;
 mapia(v42, extFcnt);
 _if prev # cparen _then  hdrErr(5);
 getT;
_);

(*=c- L 4 *) _proced dumpConst(_var an, ak:int);(*=c+*)
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

_( (* header *)
  getT;
  new(prog; setup);
  _if modeX  _then  basReg := BP;
  _if ~modeC _then _(
   v2D := 0;
   _while v2D <= 47 _do _(
     pool[9+1+v2D] := v2D;
     v2D := v2D+1;
   _);
   poolIdx := 9+v2D;
  _);
  _if (tok # 'PROGRA') _then hdrErr(0)
  _else _(
   getT;
   _if (tokKind # tkIdent) _then hdrErr(1)
   _else _(
     prog@.nm := tok;
     getT;
     _if prev = oparen _then  params;
     _if prev # semi _then hdrErr(2) _else getT;
   _)
  _);(*=a0*)
  prog@.orignm := DIV;
  prog@.lbl := UTM;
  prog@.alist := _NIL;
  prog@.args := 0;
  v33 := zero;
  _if modeL _then ГГ('ПВ;``К') _else ГГ('В;` `К');
  write('Д=0000,ЗАГР=77040,LОАD,UNLОАD,СН,Ч=12,LI=4,ИА=74000,УРЕГ=ИА(3),Z0=УРЕГ(2),ПБИ15,ЕF,Н,Т,Е,ОС=Е(5),SL=ОС(2),Z64,РR=SL(10),МОD=РR(3),VR,СПТ,СПЛ,RF=VR(5),ЧМ1,ГТ=RF(5),RС=ГТ(6),СР=RС(4),АВ,ОВ,RWF,СТХТ=ОВ(5),WS,WС,WА,WВ,WI,WR,WL,ОWS,ОWС,ОWА,ОWВ,ОWI,ОWR,ОWL,ИК=ОWL(2),СЧ,ЗЧ,ЦУ=74136,ТR=74141,D=74145,N=74151,РА=74173,R=74202,АL=74206,GI=74222,RI=74251,РО=74257,RО=74313,МI=74323,UN=74337,РF=74715,GF=74760,СL=75075,ГА=75104,ЯГА=75115,ТNL=75165,ОV=75241,IА=75361,АI=75363,ГГ=75365,Ф=75675,RSR=75714,');
  _if modeX _then
  write('DS=СН(3),Z1Z,Z2,Z3,Z4,Z5,Z6,Z7,ПА,ВИ,FРF,FGF,FRWF,FRF,FWS,FWС,FWА,FWВ,FWI,FWR,FWL,АС,ПБ,NА,ВА,ЕА,FА,ВD,Z8,ВП,ВП6,ВП7,ПВ,ОRF,');
  write('Н;КД,К;');
  programme(v33, prog);
  P3330;
  _if funcHelper | varHelper _then
  write('К;ЩРWR:ИАZРR0=ЗЧ,ВИ16=ВМ7,17ЗЧ=7ПА-17,ZРR1:ИАZРR0=СЧ,СД75=ИАZРR0,ЗЧ=СЧ13,17ЗЧ=МР,16ПВОWI=,7КЦZРR1=17СЧ,УИ7=17СЧ,УИ16=16ПБ,ZРR0:ЗЧ=ЗЧ,ZРR2:ЗЧ=ЗЧ42,');
  _if gotoHelper _then
  write('К;ZQ:ВИ16=16ПА4,ВМ16=ВМ12,ВМ16=ВМ14,17ЗЧ=1СЧ10,16ПАZQ1=16СР2,У0ZQ0=16ПВРR,ZQ0:17СЧ=16ПВОWI,12ПА-1=15ПАZQ1(1),14ПВГТ=,12ПА-6=15ПАZQ1,14ПВГТ=,17СЧ=16ПВОWI,17СЧ=УИ16,ПБРR=,ZQ1:1ИА40456=3ВИ7017,Э3612417=,ЗЧ=ЗЧ304,');
  _if funcHelper _then _(
  write('К;ЖЬ:ВИ16=ВМ7,ВМ6=ВМ12,ВМ15=17ЗЧ,15ПА4=ВИ15,ВМ14=17ЗЧ,1СЧ10=16ПАЖЛОК,16СР2=У0ЖЬ0,16ПВРR=,ЖЬ0:17СЧ=16ПВОWI,12ПА-1=15ПАВХОД(3),14ПВГТ=,17СЧ=УИ7,17СЧ=17ЗЧ,УИ12=15ПАВХОД,12СИ15=12ПА-6,14ПВГТ=,7ПИ15=12ПА-6,14ПВГТ=,7СЧ2=У0WЗВR,7ИК2=ВИ,УИ6=7СЧ1,У0ПАRМ=6СА1,ПАRМ:7СЧ3=У1ПАRМ1,ПАRМ3:17СЧ=17ЗЧ,У0WЗВR=7СЧ1,У0WЗВR=15ПАВХОД(3),12ПА-3=14ПВГТ,6ИА2=16ПА,ВИ16=,');
  write('ИАЖЛОК=ЗЧ,16ПАWЗВR=ВИ16,ИАВХОД(10)=ЗЧ,7СЧ1=ИАZРR0,ЗЧ=ИАВХОД(6),ЛУ=У1ПАRМ10,7СЧ1=ПБНАЧПЕR,ПАRМ1:15ПАВХОД(4)=12ПА-3,14ПВГТ=,СЧ12=ЗЧ1,ПАRМ5:ИК1=7СЧ3,ИАZРR0=ЗЧ,ИК1=6ИА3,14ПА=ИАZРR0,СЧ=СД77,МР=У0ПАRМ0,14ИК=14ПА,ПАRМ4:ВИ14=ИАЖЛОК,ЗЧ=16ПАВЗВТ,ВИ16=ИАВХОД(10),ЗЧ=ИАZРR0,СЧ=ИАВХОД(6),ЛУ=У1ПАRМ10,ИАZРR0=СЧ,');
  write('НАЧПЕR:УИ14=14ПБНАЧПЕR,10ПБЖIN=,10ПБЖRЕ=,10ПБЖВО=,10ПБЖСН=,10ПБЖАL=,10ПБЖРW=,ИАЖЛОК=СЧ,16ПВIА=,СД70=ИАЖЛОК,ЗЧ=15ПАЖЛОК,12ПА-5=14ПВГТ,СЧ13=17ЗЧ,ИАZРR2=СЧ,16ПАВЗВТ=ПБОWС,ЖIN:СЧ13=17ЗЧ,ИКЖЛОК=СЧ,ПБОWI=,ЖRЕ:15ПА4=ВИ15,17ЗЧ=17ЗЧ,ИКЖЛОК=СЧ,ПБОWR=,ЖВО:15ПА6=ВИ15,17ЗЧ=ИКЖЛОК,СЧ=ПБОWВ,');
  write('ЖСН:СЧ13=17ЗЧ,ИКЖЛОК=СЧ,ПБОWС=,ЖАL:ИКЖЛОК=15ПА,12ПА-6=ИАВХОД(10),СЧ=УИ14,ПБГТ=,ЖРW:ИКЖЛОК=СЧ,ПБЩРWR=,ПАRМ10:15ПА6=ВИ15,17ЗЧ=ИКЖЛОК,СЧ=ИАZРR0,ЦС=УИ14,14СЧ=ПБОWА,ПАRМ2:15ПАВХОД(5)=12ПА-2,14ПВГТ=,ПБПАRМ3=,');
  write('ВЗВТ:СЧ13=ЦС1,ЗЧ1=ИК1,7СЧ3=У0ПАRМ2,12ПА-3=15ПАВХОД(7),14ПВГТ=,ПБПАRМ5=,WЗВR:ЗЧ=17СЧ,17СЧ=УМ6,УИ7=17СЧ,УИ16=ПБРR,ПАRМ0:17СЧ=17ЗЧ,У0ПАRМ4=15ПАЖЛОК(1),12ПА-3=14ПАВЗВТ,ПБГТ=,ВХОД:2Э0432456=2Э1007417,2Э0435065=2Э3422017,2Э1232502=3Э0407417,Э3617417=,Э3611017=,Э3611417=,7КЦ77777=17КЦ77770,Э3606417=,ЗЧ=,ЖЛОК:ЗЧ=,1Э2214431=,ЗЧ=ЗЧ304,');
  _);
  _if varHelper _then _(
  write('ЩП:ВМ16=ВМ12,ВМ15=16ПА4,ВМ16=ВМ14,17ЗЧ=16ПАРАВ,1СЧ10=16СР1,У0ЩП1=16ПВРR,ЩП1:17СЧ=16ПВОWI,12ПА-1=15ПАРАВ,14ПВГТ=,17СЧ=УИ15,12ПА-6=14ПВГТ,12ПА-3=15ПАРАВ,14ПВГТ=,16ПАВОЗВR=17СЧ,УИ14=,ПЕR:14ПБПЕR=,10ПБЩАL=,10ПБЩRЕ=,10ПБЩВО=,10ПБЩСН=,10ПБЩIN=,10ПБЩРW=,10ПБЩУК=,ЩSR:15ПА6=ВИ15,17ЗЧ=17СЧ-3,17ЦС-4=УИ14,14СЧ=ПБОWА,ЩАL:17ИА-2=15ПА,12ПА-6=14ПАВОЗВR,ПБГТ=,ЩRЕ:15ПА4=ВИ15,17ЗЧ=17ЗЧ,17СЧ-4=ПБОWR,ЩВО:15ПА6=ВИ15,17ЗЧ=17СЧ-3,ПБОWВ=,ЩСН:10СЧ13=17ЗЧ,17СЧ-3=ПБОWС,');
  write('ЩIN:10СЧ13=17ЗЧ,17СЧ-3=ПБОWI,ЩРW:17СЧ-2=ПБЩРWR,ЩУК:17СЧ-2=16ПВIА,СД70=ИАZРR0,ЗЧ=15ПАZРR0,12ПА-5=14ПВГТ,10СЧ13=17ЗЧ,10ИАZРR2=СЧ,16ПАВОЗВR=ПБОWС,ВОЗВR:16ПВРR=,17СЧ=УИ16,17СЧ=16ПБ,РАВ:Э3612417=,ЗЧ=ЗЧ304,ВСS:1ИА30440=4Э2022417,');
  _);
  _if doOctal _then
  write('К;ОWJ:10ИА=12ПВОСТL,ПБОWI=,WJ:10ИА=12ПВОСТL,ПБWI=,ОСТL:10ИА=14ПАЯЧ,14ЗЧ=10СЧ13,14ЗЧ1=СЧ,14ЗЧ3=,ПОВЬ:14СЧ=14ЛУ4,14ЗЧ2=ЛСZ64,14АУ1=МР30,14АС3=14ЗЧ3,14СЧ=14АВ2,СД103=10У0КН1,14ЗЧ=14СЧ1,СД77=17ЗЧ,СД76=17ЦС,14ЗЧ1=10ПБПОВЬ,КН1:14СЧ3=12ПБ,ЯЧ:ЗЧ=ЗЧ,ЗЧ=ЗЧ,ЗЧ=ЗЧ,ЗЧ=ЗЧ,ЗЧ=ЗЧ7,');
  _if (extCnt # -1) | (entrCnt # -1)_then _(
    write('Л;ИМЕНА:ДВНУТ,У;А1,С;77777,ВНЕШ:');
    v34 := 0;
    _while v34 <= extCnt _do _(
      ГГ('А;'); write(withSp(extSym[v34])); ГГ(',С;0,');
      v34 := v34+1;
   _);
   ГГ('С;0,'); write('ВНУТ:');
   v34 := 0;
   _while v34 <= entrCnt _do _(
     write('А;', withSp(entryS[v34]), ',Л;Д'); ГГ(entryS[v34]);
     write(icomma);
     v34 := v34+1;
   _);
   ГГ('С;0,');
  _); (* 25543 *)
  write('Х:Н;11,С;');
  dumpConst(pool[9], pool[poolIdx]);
  write('Н;1,С;');
  printOct(withSp(prog@.nm));
  write(icomma);
  printOct(getDate);
  write(icomma);
  write('Н;5,Л;ДХ,Н;7,К;10ПВУРЕГ=');
  _if modeX _then ГГ(UJ) _else ГГ(UTC);
  _if (extCnt # -1) | (entrCnt # -1) _then ГГ('ИМЕНА');
  putSep;
  write('10СА-10=10ПБАД,');
  P4511(7, UTM, v33);
  _if prev # dot _then hdrErr(6);
_);
(* L 3 *) _proced blkErr(a31:int);
_(
  prErr(block, a31);
  skipTo([1,2]);
_);
(*=c- L 3 *) _proced formPMD;
_var a:alfa; i:int; id, typ:idptr; (*=c+*)
_(
 forceName(a22@.nm);
 P4511(5, curOff, '42');
 cv.i := lineNum;
 putConst(a, T);
 i := 0;
 _while i <= 127 _do _(
   id := idTable[i];
   _while (id # _NIL) & (id > a22) _do _with id@ _do _(
     _if ((cl = cVar) & (vty@.sz = 1))
     | ((cl = cConst) & (bas # _NIL)) _then _(
       forceName(nm);
       mapai(off, cv.i);
       putConst(a, T);
       typ := vty;
       _select
       typ = realType: cv.i := 0;
       typ = alfaType: cv.i := 1;
       typ = charType: cv.i := 2;
       T: cv.i := 3
       _end;
       putConst(a, T);
     _);
     id := nxt;
   _);
   i := i+1;
 _);
 cv.i := 0;
 putConst(a, T);
_);

(*=c- L 3 *) _proced dumpInfo;
_var l3v1z, l3v2z:int; l3v3z, l3v4z:int; l3v5z, l3v6z:idptr; l3v7z:class; l3v8z:alfa;
 l3v8a: _array [1..30] _of int; (*=c+*)
_(
 l3v3z := a22@.args;
 l3v2z := 0;
 _if a22@.vty # _NIL _then _(
   l3v5z := a22@.vty;
   _if l3v5z@.k = kRng _then l3v5z := l3v5z@.bas;
   _select
   l3v5z = intType: l3v2z := 1;
   l3v5z = realType: l3v2z := 2;
   l3v5z = boolType: l3v2z := 3;
   l3v5z = charType: l3v2z := 4;
   l3v5z = alfaType: l3v2z := 5;
   l3v5z@.k = kSc: _( dumpNames(l3v5z); mapai(l3v5z@.lbl, l3v2z) _);
   l3v5z@.k = kSet: l3v2z := 6;
   T: l3v2z := 7
   _end
 _); (* 25776 *)
 _if l3v3z > 0 _then_(
   l3v5z := a22@.alist;
   l3v4z := 1;
   _while l3v4z <= l3v3z _do _(
     l3v6z := l3v5z@.vty;
     _if l3v6z@.k = kRng _then  l3v6z := l3v6z@.bas;
     _select
     l3v5z@.cl = cFun:;
     (l3v6z = intType) | (l3v6z = realType) | (l3v6z = boolType)
     | (l3v6z = charType) | (l3v6z = alfaType):;
     l3v6z@.k = kSc: _( dumpNames(l3v6z); mapai(l3v6z@.lbl, l3v1z); l3v8a[l3v4z] := l3v1z _);
     T:
     _end;
      l3v5z := l3v5z@.bas;
      l3v4z := l3v4z+1;
   _)
 _); (* 26043 *)
 forceName(a22@.nm);
 v2C := curOff;
 cv.i := l3v2z;
 putConst(curOff, T);
 _if (a22@.vty # _NIL) | (l3v3z > 0) _then _(
   l3v5z := a22@.alist;
   l3v8z := a22@.lev;
   mapai(l3v8z, l3v2z);
   mapia(l3v2z+1, l3v8z);
   l3v8z := l3v8z;
   cv := ;
   putConst(curOff, T);
 _);
 l3v2z := 0;
 l3v4z := 1;
 _while l3v4z <= l3v3z _do _(
   l3v6z := l3v5z@.vty;
   _if l3v6z@.k = kRng _then  l3v6z := l3v6z@.bas;
   l3v7z := l3v5z@.cl;
   l3v1z := 0;
   _select
   l3v6z = intType: l3v2z := 1;
   l3v6z = realType: l3v2z := 2;
   l3v6z = boolType: l3v2z := 3;
   l3v6z = charType: l3v2z := 4;
   l3v6z = alfaType: l3v2z := 5;
   l3v6z@.k = kSet: l3v2z := 6;
   l3v6z@.k = kSc: l3v2z := l3v8a[l3v4z];
   T: l3v2z := 7
   _end;
   _if l3v7z = cVar _then  l3v1z := 4T;
   code(3СЧ3=3ЦС4,); cv := ;
   putConst(curOff, T);
   l3v5z := l3v5z@.bas;
   l3v4z := l3v4z+1;
 _); (* 26156 *)
 cv.i := 0;
 putConst(curOff, T);
 putInsn('12ПА0');
 ГГ('15ПА'); putInsn(v2C);
 mapia(lineNum, curOff);
 putIarg('14ПА', curOff);
 putAlign('16ПВЖЬ');
_);

(* L 3 *) _proced trim(_var table:_array [0..127] _of idptr);
 _(
 v2D := 0;
 _while v2D <= 127 _do _(
   obj2 := table[v2D];
   _while (obj2 # _NIL) & (obj2 >= v2L) _do obj2 := obj2@.nxt;
   table[v2D] := obj2;
   v2D := v2D+1;
 _);
 _);
_( (* programme *)
 _if tok = sp _then _(  init; header; exit _);
 v2B := a21;
 v2J := modeC;
 _if ~v2J _then  ГГ('В;К;');
 allowUndef := T;
 undefCnt := 0;
 v2V := O;
 v2C := ;
 v2H := 0;
 stLabs := _NIL;
 v2M := fwdProcList;
 curAU := 1;
 v2Q := labList;
 _if tokKind # tkWord _then  blkErr(1);
 _if tok = label _then _(
   _repeat
   getT;
   _if tokKind # tkInt _then prErr(block, 24)
   _else _(
     new(v2P);
     v2P@.num := ival;
     v2P@.lev := level;
     v2P@.lab := O;
     v2P@.line := 0;
     v2P@.def := F;
     v2P@.nxt := labList;
     labList := v2P;
     getT;
   _);
   _if (prev # comma) & (prev # semi) _then _(
     prErr(block, 25);
     skipTo([1,2,3]);
   _);
   _until prev # comma;
   _if prev = semi _then  getT;
   _if tokKind # tkWord _then  blkErr(1);
 _);
 _if tok = const _then _(
   lookup := 0;
   getT;
   _if tokKind # tkIdent _then _(
     prErr(block, 2);
     skipTo([1,2,4]);
   _);
   _while tokKind = tkIdent _do _(
     _if known _then  prErr(block, 2);
     new(obj2; trace);
     obj2@ := [tok, level, idTable[hash], _NIL, cConst, intType];
     idTable[hash] := obj2;
     getT;
     _if prev = eq _then getT _else prErr(block, 3);
     obj1 := _NIL;
     litConst(obj1, obj2@.off, T);
     _if obj1 = _NIL _then prErr(block, 4) _else _( obj2@.vty := obj1; getT _);
     constOp := 0;
     _select
     prev = plus: constOp := 1;
     prev = minus: constOp := 2;
     prev = star: constOp := 3;
     prev = slash: constOp := 4
     _end;
     _if constOp > 0 _then _(
       getT;
       new(newConst; trace);
       newConst@ := [0, level, idTable[hash], _NIL, cConst, intType];
       obj1 := _NIL;
       litConst(obj1, newConst@.off, F);
       _if obj1 = _NIL _then prErr(block, 6)
       _else _if (obj1 = obj2@.vty) & (obj1 = intType) _then _(
         constVal := getConst(obj2@.off);
         _case constOp _of
         0: _goto 26505;
         1: cv.i := cv.i+constVal;
         2: cv.i := constVal-cv.i;
         3: cv.i := constVal*cv.i;
         4: _( _if cv.i = 0 _then _( prErr(block, 8); _goto 26505 _);
            cv.i := trunc(constVal/cv.i)
         _)
         _end;
         putConst(obj2@.off, F);
         getT
       _) _else 26505: prErr(block, 7);
     _); (* 26507 *)
     _if prev = semi _then _(
       lookup := 0;
       getT;
       _if ~tokInSet([1,2,4]) _then _( prErr(block, 0); skipTo([1,2,4]) _)
     _) _else prErr(block, 5);
 _)_); (* 26523 *)
 _if tok = type _then _(
   lookup := 0;
   getT;
   _repeat
    _if tokKind # tkIdent _then blkErr(2);
    _if known _then _(
      _if (curId@.cl = cType) & (curId@.k = kPtr) & (curId@.bas = _NIL) _then _(
        obj1 := curId;
        getT;
        _if prev # eq _then blkErr(3);
        getT;
        _if prev # arrow _then blkErr(30);
        undefCnt := undefCnt-1;
        lookup := 0;
        getT;
        _if (tokKind # tkIdent) | ~known | (curId@.cl # cType) _then blkErr(31);
        _if curId@.k = kAlias _then curId := curId@.bas;
        _if curId@.k > kRec _then blkErr(32);
        obj1@.bas := curId;
        getT;
        _goto 26607;
      _) _else blkErr(2);
    _); (* 26575 *)
    v26 := tok;
    v2D := hash;
    getT;
    _if prev # eq _then  blkErr(3);
    parseType(0, v26, obj1, v2D);
26607:
    _if prev # semi _then  blkErr(6);
    lookup := 0;
    getT;
   _until tokKind # tkIdent;
   _if tokKind # tkWord _then blkErr(1);
 _); (* 26620 *)
 allowUndef := F;
 _if undefCnt # 0 _then blkErr(33);                             % undefined ptr types remain
 _if tok = var _then _(
   obj2 := _NIL;
   _repeat
     lookup := 0;
     getT;
26631:
     _if (tokKind # tkIdent) | known _then blkErr(2);
     new(obj1; trace);
     obj1@ := [ tok, level, idTable[hash], _NIL, cVar, _NIL ];
     _if modeV _then obj1@.trace := T _else obj1@.trace := F; % obj1@.trace := modeV is shorter
     idTable[hash] := obj1;
     _if obj2 = _NIL _then obj2 := obj1 _else v25@.vty := obj1;
     v25 := obj1;
     getT;
   _until prev # comma;
   _if prev # colon _then  blkErr(7);
   parseType(0, O, v23, 0);
   v2D := v23@.sz;
   _if v23@.k = kFile _then_(
     mapia(modeB, v27);
     mapia(v23@.pck, v28);
     v2E := v23@.bas@.sz;
     (*=m-*)cv.i := modeB*256;
     _if cv.i >= v2E _then v2D := v2D+cv.i-cv.i _MOD v2E
     _else v2D := v2D+v2E;
     mapia(v2E, v26);
     _if v2V = O _then _( TNL(v2V); cmd(cLAB, v2V); write('ВМ14=17ЗЧ,') _)
     _else  cmd(cLAB, v2W);
     TNL(v2W);
     isFunc := (level = '1') & (extFList # _NIL);
     _if isFunc _then _(
       hasExtFiles := T;
       _if extFcnt # O _then _( ГГ('15ПА', extFcnt); write('=ВИ15,СР77765=У1Н,') _)
     _);
     _while obj2 # _NIL _do _(
       obj1 := obj2@.vty;
       obj2@.vty := v23;
       obj2@.off := v2B;
       obj2@.trace := F;
       ГГ('13',UTC,v2B); write('=15ПА,12ПА'); ГГ(v26,'=11ПА',v28,',14ПА',v27,'=СЧ');
       _if isFunc _then (a) _with curExtF@ _do _(
         curExtF := extFList;
         (b) _(
           _repeat
             _if nm = obj2@.nm _then _exit b;
              curExtF := nxt;
           _until curExtF = _NIL;
           hasFiles := T;
           _exit a;
         _);
         def := T;
         _if len = 0 _then _( (*=m+*)
           v2E := -10-3*nuz;
           mapia(v2E, v29);
           mapia(v2E+1, v2A)
         _) _else _(
           cv.i := nuz;
           putConst(v29, F);
           cv.i := len;
           putConst(v2A, F)
         _);
         ГГ(v29); write(',15ЗЧ3=СЧ'); ГГ(v2A);
       _) _else (* 27043 *) hasFiles := T;
       write(',15ЗЧ4=16ПВVR,');
       alfAdd(v2B, v2D);
       obj2 := obj1;
     _); (* 27053 *)
     ГГ(UJ, v2W); putSep; align;
   _) _else _while obj2 # _NIL _do _(
     obj1 := obj2@.vty;
     obj2@.off:= v2B;
     _if (v23@.k < kArr) & obj2@.trace _then obj2@.trace := T _else obj2@.trace := F;
     alfAdd(v2B, v2D);
     obj2@.vty := v23;
     obj2 := obj1;
   _); (* 27102 *)
   _if prev # semi _then  blkErr(8);
   lookup := 0;
   getT;
   _if tokKind = tkIdent _then _goto 26631;
   _if tokKind # tkWord _then  blkErr(1);
 _); (* 27114 *)
 (proc) _while tok = proced _do _(
   isFunc := F;
27117:
   lookup := 0;
   getT;
   _if level = '7' _then  prErr(block, 0);
   _if tokKind # tkIdent _then  blkErr(2);
   _if known _then _(
     _if curId@.cl # cFun _then _( blkErr(20); _GOTO 27721 _)
     _else _if curId@.chain = _NIL _then _( blkErr(20); _GOTO 27721 _)
     _else _if curId@.lev # level _then  blkErr(21);
     v28 := level;
     v27 := curId@.lbl;
     alfAdd(level, 1);
     obj1 := curId;
     _if fwdProcList = curId _then _( fwdProcList := curId@.chain _) _else _(
       v25 := fwdProcList;
       _while curId # v25 _do _( v24 := v25; v25 := v25@.chain _);
       v24@.chain := curId@.chain;
     _);
     curId@.chain := _NIL;
     getT;
     _if prev # plus _then  blkErr(22);
     getT;
     obj2 := obj1@.alist;
     _if obj2 = _NIL _then _goto 27375;
     _while obj2 # obj1 _do _(
       (*=c-*)mapai(obj2@.nm & '177', v2D);(*=c+*)
       obj2@.nxt := idTable[v2D];
       idTable[v2D] := obj2;
       obj2 := obj2@.bas;
     _); _goto 27375;
   _);
   new(obj1; setup);
   _if modeE _then _(
     MAPЯГА(tok, v26);
     entrCnt := entrCnt+1;
     entryS[entrCnt] := v26;
   _) _else TNL(v26);
   TNL(v27);
   obj1@ := [tok, level, idTable[hash], _NIL, cFun, _NIL, 0, _NIL, v27, v26, 0, _NIL];
   idTable[hash] := obj1;
   v28 := level;
   alfAdd(level, 1);
   _if isFunc _then v27 := '4' _else v27 := '3';
   setup(v2L);
   getT;
   _if prev = oparen _then forPar(obj1, v27);
   setup(v25);
   _if isFunc _then _(
     _if prev # colon _then  blkErr(15);
     getT;
     _if (tokKind # tkIdent) | (curId = _NIL) _then blkErr(16);
     _if curId@.cl # cType _then  blkErr(17);
     (a) _case curId@.k _of
     kSc, kRng, kPtr, kSet: obj1@.vty := curId;
     kArr, kRec, kFile: blkErr(18);
     kAlias: _( curId := curId@.bas; _goto a _)
     _end;
     getT;
   _); (* 27333 *)
   _if prev # semi _then  blkErr(9);
   isFunc := F;
   getT;
   _if tok = extern _then _(
     extCnt := extCnt+1;
     MAPЯГА(obj1@.nm, extSym[extCnt]);
     obj1@.lbl := extern;
     (*=m-*)mapia(2*extCnt, tok);
     getT;
     ГГ(obj1@.orignm); write(':15ПАВНЕШ('); ГГ(tok); write(')=ПБЗАГР,');
     _goto 27420;
   _) _else (* 27364 *) _if prev = plus _then _(
     obj1@.lbl := v27;
     obj1@.chain := fwdProcList;
     fwdProcList := obj1;
     obj1@.setup := v25;
   _) _else _(
     _goto 27404;
27375:
     TNL(v26);
     obj1@.lbl := v26;
     setup(v2L);
     v25 := v2L;
     isFunc := T;
27404:
     programme(v27, obj1);
     mapai(v27, v2D);
     mapia(v2D-2, v27);
     P4511(7, obj1@.lbl, v27);
27420:
     _if prev # semi _then  blkErr(10);
   _); (* 27423 *)
   level := v28;
   getT;
   rollup(v25);
   trim(idTable);
   trim(idTabA);
   _if isFunc _then _(
     obj2 := obj1@.alist;
     _if obj2 # _NIL _then
     _while obj2 # obj1_do _(
       (*=c-*)mapai(obj2@.nm & '177', v2D);(*=c+*)
       v23 := idTable[v2D];
       _if v23 = obj2 _then idTable[v2D] := v23@.nxt
       _else _(
         _while v23 # obj2 _do _( v24 := v23; v23 := v23@.nxt _);
         v24@.nxt := v23@.nxt;
       _);
       obj2 := obj2@.bas;
   _)_);
   _if tokKind # tkWord _then _( blkErr(11); _exit proc _)
 _);
 _if tok = functi _then _( isFunc := T; _goto 27117 _);
 _if fwdProcList # v2M _then  blkErr(23);                       % undefined routines remain
 _if tok # begin _then  blkErr(13);
 TNL(v26);
 _if (*=c-*)(v26 & 01603777T # 0)(*=c+*) & (seqGOST # chr(75)) _then _(
   seqGOST := succ(seqGOST);
   MAPГA(seqGOST, seqITM);
   TNL(seqITM)
 _);
 _if v2V # O _then  P4511(7, v2W, 'ОС');
 L4225(0);
 _if level = '1' _then _(
   _if (dynMem # 0) & (modeK = 0) _then  blkErr(40);
   isFunc := ((dynMem = 0) & (modeK = 100)) | (modeK = 0);
   _if modeK = 100 _then modeK := 4;
   _if ~isFunc _then _(
     ГГ('12ПА'); (*=m+*)mapia(modeK*1024, v26); putInsn(v26);
     cmd(call16, 'СL');
   _);
   _if hasFiles | hasExtFiles _then cmd(call16, 'СПЛ');
   _if hasFiles _then  cmd(call16, 'СПТ');
 _); (* 27560 *)
  _if v2V # O _then _(  putInsn(XTA); cmd(call14, v2V); P4511(5, v2V, '61') _);
  _if modeP _then formPMD;
  _if modeF & (level # '1') _then dumpInfo;
  curLab := O;
  (*=c-*)mapai(v2B, v2F); v2G := ;(*=c+*)
  _repeat
    _repeat lookup := 2; getT; doStmt _until prev # semi;
    isFunc := (tokKind = tkWord) & (tok = end);
    _if isFunc _then getT _else _(
      prErr(block, 14);
      skipTo([0,1]);
      isFunc := tokInSet([1]);
    _);
  _until isFunc;
  _if modeF & (v2C # O) _then _(
    putInsn('12ПА1');
    putIarg('15ПА', v2C);
    mapia(lineNum, curOff);
    putIarg('14ПА', curOff);
    putAlign('16ПВЖЬ');
  _);
  L4225(1);
  align;
  _if ~v2J _then  ГГ('Е;К;');
  isFunc := T;
  _while labList # v2Q _do _(
    _if ~labList@.def _then _(
      _if isFunc _then _(
        rewrite(output);(*=a1*)
        write('В БЛОКЕ '); ГГ(a22@.nm); write(' НЕТ ВХОЖД МЕТ');
        isFunc := F;
      _);
      ГГ(sp); wrInt(labList@.num);
   _);
   labList := labList@.nxt;
  _); _if ~isFunc _then writeln;
  mapia(v2G, a21);
_);

_function time:int;_( code(Э0634=,); time :=; _);
_(
  elapsed := time;
  code(ЗЧ75776=);
  tok := sp;
  new(dummyId; trace);
  dummyId@.trace := F;
  writeln(' ПАСКАЛЬ-АВТОКОД 9.(17.05.88)');
  programme(tok, curId);
  _if errSeen _then 27721: fatal(5);
  _if modeeL _then_( tok := 'ЛЕНТЯЙ'; code(=ЗЧ75777,); elapsed := time; code(ЗЧ75775=,) _);
  (*=a0*)write('Н;66005,Е;!≡1400000000');
  mapia(poolIdx+1, tok);code(ПБZ0=);
_).
