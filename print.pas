_program print;
_const eof='{172';eol='{175';
_var i:integer;b:boolean;
_(
  i := 1;
  writeln('СИСТЕМА ПАСКАЛЬ ВЕРСИИ 1.7.76':40);
  _repeat
    write(i:10, '. ');
    _while (input@ <> eof) & (input@ <> eol) _do _begin
      _if (input@ > chr(128)) _then _(
        write(' ':ord(input@)-128);
      _) _else _(
	write(input@);
      _);
      get(input);
    _);
    writeLN;
    b := input@ = eof;
    get(input);
    i := i + 1;
  _until b;
_).
