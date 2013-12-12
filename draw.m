#!/usr/bin/octave

function retval = average(m)
	retval = mean(m, 2);
endfunction

function retval = confidence(m)
	retval = 1.96 * std(m, [], 2) / sqrt(size(m, 2));
endfunction

function retval = readResult(name)
	result = [];

	num = 0;

	for i = 0 : 49
		fileName = [name, ".", num2str(i)];
		disp(["Open: ", fileName]);
		if (exist(fileName) == 0)
			disp(["Missing: ", fileName]);
			continue;
		endif

		rawData = dlmread(fileName);
		data = rawData(44: 10 : 1041, 1);

		result = [result, data];
	endfor

	retval = [average(result), confidence(result)];
endfunction

% =============== main ===============
% file name and # of files
% prosumebly, [$1.0, $1.1, ..., $1.($2-1)]
result = readResult("ast_gen_c45/gen");
x = 0 : 10 : 990;
errorbar(x, result(:, 1), result(:, 2), "#r");
hold on;

result = readResult("ast_gen_selfsepa/out");
x = 0 : 10 : 990;
errorbar(x, result(:, 1), result(:, 2), "#y");
hold on;

result = readResult("ast_spe/out");
x = 0 : 10 : 990;
errorbar(x, result(:, 1), result(:, 2), "#b");
hold on;

result = readResult("ast_selfandsamerow/out");
x = 0 : 10 : 990;
errorbar(x, result(:, 1), result(:, 2), "#m");

% decorate graph
%axis([0 1000 -600 0]);
xlabel("Iterations");
ylabel("Reward Per Step");
legend("Feature Set 1", "Feature Set 2", "Feature Set 3", 'location', 'northeast');

print("ast.png", '-S700,550');
