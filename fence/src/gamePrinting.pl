printing(Lines, Columns) :-
	printing(Lines, Columns, 1).

printing(Lines, _, LineNo):-
	dimensions(NoLines, _),
	LineNo = NoLines,
	nth1(LineNo, Lines, Line),
	replace(1, '---', Line, NewLine),
	replace(0, '   ', NewLine, ParsedLine),
	printSingleLine(ParsedLine).

printing(Lines, Columns, I):-
	nth1(I, Lines, Line),
	replace(1, '---', Line, NewLine),
	replace(0, '   ', NewLine, ParsedLine),
	printSingleLine(ParsedLine),
	nth1(I, Columns, Column),
	replace(1, '|', Column, NewColumn),
	replace(0, ' ', NewColumn, ParsedColumn),
	printSingleColumn(ParsedColumn, I),
	NewI is I + 1,
	printing(Lines, Columns, NewI).

replace(_, _, [], []).
replace(Replaced, Replacement, [Replaced|Tail], [Replacement|Tail2]) :-
	replace(Replaced, Replacement, Tail, Tail2).
replace(Replaced, Replacement, [Head|Tail], [Head|Tail2]) :-
	Head \= Replaced,
	replace(Replaced, Replacement, Tail, Tail2).

printSingleLine([Cell]):-
	write('+'),
	write(Cell),
	write('+'),
	nl.
printSingleLine([Cell|More]):-
	write('+'),
	write(Cell),
	printSingleLine(More).

printSingleColumn(ParsedColumn, I) :-
	printSingleColumn(ParsedColumn, I, 1). 

printSingleColumn([Cell], _, _):-
	write(Cell),
	nl.
printSingleColumn([Cell|More], I, J):-
	write(Cell),
	(
		cell(Digit, I, J),
		write(' '),
		write(Digit),
		write(' ')
		;
		write('   ')
	),
	NewJ is J + 1,
	printSingleColumn(More, I, NewJ).