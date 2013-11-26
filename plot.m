function retval = average(m)
	retval = mean(m, 2);
endfunction

function retval = confidence(m)
	retval = 1.96 * std(m, [], 2) / sqrt(size(m, 2));
endfunction

function retval = readResult()
	result = [];

	name = "out";
	num = 50;

	for i = 50 : 99
		fileName = [name, ".", num2str(i)];
		disp(["Open: ", fileName]);
		if (exist(fileName) == 0)
			disp(["Missing: ", fileName]);
			continue;
		endif

		rawData = dlmread(fileName);
		data = rawData(44: 5 : 1041, 1);

		result = [result, data];
	endfor

	retval = [average(result), confidence(result)];
endfunction

% =============== main ===============
% file name and # of files
% prosumebly, [$1.0, $1.1, ..., $1.($2-1)]
result = readResult();
errorbar(result(:, 1), result(:, 2))
hold on;

% decorate graph
pause();
