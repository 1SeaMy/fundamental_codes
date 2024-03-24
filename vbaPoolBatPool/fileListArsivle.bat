@echo off
cls
dir /b *.* > fileListArsivle.txt
copy *.txt Arsiv
del *.txt
exit