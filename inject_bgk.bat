:: ####### �������� #########
:: a copied script for windows.
:: made by hazukie
:: date: 2024.5.12
:: JUST FOR LEARNING PURPOSES, DON'T USE THIS TO CRACK SOFTWARE.
:: ֻ�ǳ���ѧϰĿ�ģ������������ƽ�������������Ը����û���Ϊ���뱾��Ŀ�����޹أ�

@echo off
call :warning ��ǰ�ű��������� windows ƽ̨���ҽ��� windows10 �汾��ͨ������
call :warning ����ִ�й����г������⣬�뼰ʱ����Ŀ���߷���
call :infos ��ʼִ�нű�
:: ####### �������� #########


:: ####### �������� #########
:: ��ע�������ļ�·��
set CUR_HOOK_JS_PATH=src\hooklog.js
:: ####### �������� #########
:: Typora ��װ·��
set TYPORA_INSTALLED_PATH="C:\Program Files\Typora\resources"

::set INJECT_ASAR_PATH=%TYPORA_INSTALLED_PATH:"=%\node_modules.asar

set CUR_INJECT_ASAR_PATH=build\node_modules.asar
set CUR_PACKED_ASAR_PATH=build\node_modules.asar.pack

set CUR_INJECT_JS_DIR_PATH=build\node_modules
set CUR_HOOK_JS_WRITE_PATH=%CUR_INJECT_JS_DIR_PATH%\raven\hook.js
set CUR_INJECT_JS_PATH=%CUR_INJECT_JS_DIR_PATH%\raven\index.js

:: ####### ִ������ #########

:: Node ��װ·��
set NODE_INSTALLED_PATH=C:\Users\hazukie\AppData\Roaming\nvm\v20.10.0\node.exe

:: ASAR ��ѹ����ִ�г�������Ŵ�
:: Yproject ��Ŀ�� asar_modules/node_modules/@electron/asar/bin/
:: �˴�ʹ����Ե�ַ,���������ִ�е�λ�ã�
:: asar ��ѹ�����򽫻ᱻ �ű����� asar_zip ����
set ASAR_BIN=./asar_modules/node_modules/@electron/asar/bin/asar.js
:: ####### ִ������ #########



:: ####### ִ�п�ʼ #########
call :warning "�ýű����� sudo ָ��,����ȷ��֪Ϥ��Σ����ִ�еĺ���ҳе���ش���"
call :warning "��ִ���^���У�������ϸȷ�������ʾ������ʾ������ִ�и�Σ���ʱ����ô�������ν����������ж���"
call :infos  "Typora ��װ·��: " %TYPORA_INSTALLED_PATH%
call :askif "Typora ��װ·���Ƿ���ȷ?"
if %ret% equ "0" (
	echo �������ִ�� ) else (
	call :ask "����ȷ�Ļ�����Գ��������µ�·��" )

if %ret% neq "0" (
	set TYPORA_INSTALLED_PATH=
	set TYPORA_INSTALLED_PATH=%ret: =%)

call :infos "��ȷ�ϵ�ǰ��װ·��Ϊ: " %TYPORA_INSTALLED_PATH%
set INJECT_ASAR_PATH=
set INJECT_ASAR_PATH=%TYPORA_INSTALLED_PATH:"=%\node_modules.asar
call :infos %INJECT_ASAR_PATH%

:: ��� node �Ƿ����
call :ask "������ Node ��װ·��"
call :infos "��Ϊ���ⷴ��ȷ��,����ֱ�Ӹ� NODE_INSTALLED_PATH ��ֵ����"
set NODE_INSTALLED_PATH=
set NODE_INSTALLED_PATH=%ret: =%
call :infos "Node ��װ·��Ϊ: " %NODE_INSTALLED_PATH%

call :checkf %NODE_INSTALLED_PATH%
:: ���ڲ��� node �Ƿ����...
call :checkf %NODE_INSTALLED_PATH%
%NODE_INSTALLED_PATH% -v

:: ��� Typora ��װ·���Ƿ����
call :checkf  %TYPORA_INSTALLED_PATH%

:: ǰ�������Ѿ�׼�����
:: ��ʽ��ʼ��ʼ��
call :mkinit "%INJECT_ASAR_PATH%"

:: ��ʼ��ѹ��
call :asar_zip "%INJECT_ASAR_PATH%"
goto :eof
:: ####### ִ�н��� #########




:: ####### �������� #########

@rem ��ӡ������־
@echo off
:warning
echo ## ����: %~1%~2
goto :eof

@rem ��ӡ��־
@echo off
:infos
echo ��ʾ: %~1%~2
goto :eof


@rem ѯ�����뺯��
@echo off
:ask
set ret=
set /p ret=%~1:
if "%ret%" equ "" (
	call :warning "������Ϊ��...�����ԣ�" 
	goto :ask )
goto :eof


@rem ѯ���Ƿ���
@rem ����1: ����,����2: �Ƚ�����(��ѡ)
@echo off
:askif
set /p ret=%~1 (y/n): 
if "%ret:~0,1%" neq "y" (
	call :infos "���Ļظ�: %ret%"
	set ret=
	set ret="1" ) else (
	call :infos "���Ļظ�: %ret%"
	set ret=
	set ret="0" )
goto :eof


@rem �ļ���ʼ������
@echo off
:mkinit
call :infos "���ڳ�ʼ��..."
if exist build (
	call :infos "build �ļ����Ѿ�����"
	call :warning "����ɾ�� build �ļ���"
	rd /s /q build ) else (
	call :infos "δ���� build �ļ���"
	)
call :infos "���ڴ��� build �ļ���"
mkdir build
call :infos "build �ļ��д������"

if exist build\node_modules (
	call :infos "build/node_modules �ļ����Ѿ�����"
	call :warning "����ɾ�� build �ļ���"
	rd /s /q build\node_modules ) else (
	call :infos "δ���� build/node_modules �ļ���"
	)
call :infos "���ڴ��� build/node_modules �ļ���"
mkdir build\node_modules
call :infos "build/node_modules �ļ��д������"

call :infos "���ڸ��� node_modules.asar �� build �ļ�����..."
copy %1  "%CUR_INJECT_ASAR_PATH%"

goto :eof

@rem �ļ����ں���
@echo off
:checkf
call :infos "���ڼ�� %1 �Ƿ���ڻ����..."
if exist  %1 (
	call :infos  %1 "�ļ�����"  ) else (
	call :warning %1 "�ļ�������!"
	call :infos "�ű��������˳�..."
	exit 0)
goto :eof


@rem ��� hook.js
:write_js2file
:: ���������� hook.js �ļ�
type "%CUR_HOOK_JS_PATH%" > "%CUR_HOOK_JS_WRITE_PATH%"
goto :eof


@rem ��� hook.js ������ index.js
:append_require2file
:: ��������� index.js �ļ�
echo /* append hook!*/ >> "%CUR_INJECT_JS_PATH%"
echo require('./hook') >> "%CUR_INJECT_JS_PATH%"
goto :eof



@rem ��ѹ��ִ�к���
@rem ����0��unpack/pack
@rem ����1��Դ
@rem ����2��Ŀ�ĵ�
@echo off
:asar_zip
::call :checkf %ASAR_BIN% 
:: ��ѹ node_modules �� ��ǰ build �ļ�����
echo %NODE_INSTALLED_PATH% %ASAR_BIN% extract "%CUR_INJECT_ASAR_PATH%" "%CUR_INJECT_JS_DIR_PATH%"

%NODE_INSTALLED_PATH% %ASAR_BIN% extract "%CUR_INJECT_ASAR_PATH%" "%CUR_INJECT_JS_DIR_PATH%"

:: ��� hook.js
call :write_js2file
:: ��� index.js
call :append_require2file

:: ���´�� node_modules Ϊ node_modules.asar.pack
echo %NODE_INSTALLED_PATH% %ASAR_BIN% pack %CUR_INJECT_JS_DIR_PATH% %CUR_PACKED_ASAR_PATH%
%NODE_INSTALLED_PATH% %ASAR_BIN% pack %CUR_INJECT_JS_DIR_PATH% %CUR_PACKED_ASAR_PATH%


:: ���Ƶ� typora ��װ����
call :infos "���ڸ��� node_modules.asar.pack �� Typora �ļ�����..."
copy "%CUR_PACKED_ASAR_PATH%" %1
goto :eof
