echo off

echo STEP1.xcopy walle
xcopy %~dp0..\..\demo-js-vue\1.platform\static %~dp0..\fbi\static\ /s /y

pause>null