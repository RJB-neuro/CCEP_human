function MP_label = importfile_MPlabels(workbookFile, sheetName, dataLines)
%IMPORTFILE Import data from a spreadsheet
%  EL016LOOKUPS2 = IMPORTFILE(FILE) reads data from the first worksheet
%  in the Microsoft Excel spreadsheet file named FILE.  Returns the data
%  as a table.
%
%  EL016LOOKUPS2 = IMPORTFILE(FILE, SHEET) reads from the specified
%  worksheet.
%
%  EL016LOOKUPS2 = IMPORTFILE(FILE, SHEET, DATALINES) reads from the
%  specified worksheet for the specified row interval(s). Specify
%  DATALINES as a positive scalar integer or a N-by-2 array of positive
%  scalar integers for dis-contiguous row intervals.
%
%  Example:
%  EL016lookupS2 = importfile("T:\EL_experiment\Patients\EL016\infos\EL016_lookup.xlsx", "Channels", [2, 116]);
%
%  See also READTABLE.
%
% Auto-generated by MATLAB on 20-Sep-2022 17:24:25

%% Input handling

% If no sheet is specified, read first sheet
if nargin == 1 || isempty(sheetName)
    sheetName = 1;
end

% If row start and end points are not specified, define defaults
if nargin <= 2
    dataLines = [2, 116];
end

%% Set up the Import Options and import the data
opts = spreadsheetImportOptions("NumVariables", 7);

% Specify sheet and range
opts.Sheet = sheetName;
opts.DataRange = "A" + dataLines(1, 1) + ":G" + dataLines(1, 2);

% Specify column names and types
opts.VariableNames = ["Var1", "Var2", "Natus", "Var4", "type", "label", "EDF"];
opts.SelectedVariableNames = ["Natus", "type", "label", "EDF"];
opts.VariableTypes = ["char", "char", "double", "char", "categorical", "string", "string"];

% Specify file level properties
opts.ImportErrorRule = "omitrow";
opts.MissingRule = "omitrow";

% Specify variable properties
opts = setvaropts(opts, ["Var1", "Var2", "Var4", "label", "EDF"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Var1", "Var2", "Var4", "type", "label", "EDF"], "EmptyFieldRule", "auto");
opts = setvaropts(opts, "Natus", "TreatAsMissing", '');

% Import the data
MP_label = readtable(workbookFile, opts, "UseExcel", false);

for idx = 2:size(dataLines, 1)
    opts.DataRange = "A" + dataLines(idx, 1) + ":G" + dataLines(idx, 2);
    tb = readtable(workbookFile, opts, "UseExcel", false);
    MP_label = [MP_label; tb]; %#ok<AGROW>
end

end