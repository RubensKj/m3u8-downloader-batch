@echo off

setlocal
for /f "skip=8 tokens=2,3,4,5,6,7,8 delims=: " %%D in ('robocopy /l * \ \ /ns /nc /ndl /nfl /np /njh /XF * /XD *') do (
  set "year=%%G"
  set "HH=%%H"
  set "MM=%%I"
  set "SS=%%J"
)

:ask-url
set /p "url=Enter the m3u8 url: "

if not x%url:http://=%==x%url% goto ask-filename
if not x%url:https://=%==x%url% goto ask-filename

goto ask-url

:ask-filename

set /p "fileName=Enter the file name (leave empty for auto generated): "

IF [%fileName%] == [] (
  set "fileName=video_%HH%-%MM%-%SS%-%year%"
)

echo URL: %url%
echo File name: %fileName%.mp4

ffmpeg -protocol_whitelist file,http,https,tcp,tls,crypto -i %url% -c copy %fileName%.mp4