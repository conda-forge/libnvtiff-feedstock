
if not exist %PREFIX% mkdir %PREFIX%

move lib\*.lib %LIBRARY_LIB%
move bin\*.dll %LIBRARY_BIN%
move include\* %LIBRARY_INC%
