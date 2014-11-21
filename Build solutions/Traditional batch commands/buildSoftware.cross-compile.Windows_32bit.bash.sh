#!/bin/bash
# 前一行為 shebang ，用來指定執行此腳本(script)程式的直譯器（如此例為 GNU bash 殼程式直譯器）
# 以井字符號(#)開頭但非 shebang 的文字列是不會被執行的註解文字

# buildSoftware.cross-compile.Windows_32bit.bash.sh - 軟體建構程式
# 此程式會用 GNU GCC C 工具鏈(toolchain)將來源程式碼(HelloCworld.c)檔案建構為您的處理器架構的可執行檔(executable)(HelloCworld.exe)
# 使用方式：
# 	在命令列介面中切換當前工作目錄(current working directory)到「Ｃ程式設計世界哈囉！(Hello C World!)」專案來源程式碼根目錄下的「Build solutions/Traditional batch commands/」目錄，然後執行下列命令：
# 	$ bash buildSoftware.cross-compile.Windows_32bit.bash.sh
# 程式回傳代碼：
# 	0 - 成功執行
# 	1 - 發生錯誤

# 啟用 bash 殼程式直譯器的偵錯功能，方便看到腳本程式呼叫了什麼命令
# set -x

# 檢查當前工作目錄(current working directory)是否在正確
if [ "$(basename "$(pwd)")" != "Traditional batch commands" ] 
	then
		printf "您的當前工作目錄錯誤，您需要先切換到「Build solutions/Traditional batch commands/」目錄底下才能執行本程式。\n"
		exit 1
fi

printf "開始進行軟體建構……\n"
# 呼叫工具鍊(toolchain)將「Hello C world!.c」來源程式碼檔案建構為「Ｃ程式設計世界哈囉！(Hello_C_world!)」目標程式碼組成的可執行檔
# 因為檔案名稱中有對直譯器來說具其他意義的字元（此例為空白字元與驚嘆號），將檔案名稱用單引號(')括住避免直譯器去解釋它
## 決定使用的編譯器命令（要 cross-compile 的話需要用不同的編譯器命令）
if [ "${CC}" == "" ]
	then
		printf "「CC」環境變數未定義，將使用 i586-mingw32msvc-cc GNU GCC 編譯器進行建構\n"
		CC="i586-mingw32msvc-cc"
fi

## 前期處理階段
printf "正在呼叫前期處理器(preprocessor)對來源程式碼進行前期處理(preprocess)……\n"
set -x
${CC} -E -DNDEBUG "-I${HOME}/軟體/libiconv-1.9.1.bin.woe32/include" -E "-I${HOME}/軟體/gettext-runtime-0.13.1.bin.woe32/include" -o "Files generated during building process/Hello C world!.${CC}.i" '../../Source code/Hello C world!.c'
set +x

## 編譯階段
printf "正在呼叫編譯器將來源程式碼(source code)編譯(compile)為目標程式碼(object code)……\n"
set -x
${CC} -std=iso9899:199409 -pedantic -Wall -o "Files generated during building process/Hello C world!.${CC}.o" -c "Files generated during building process/Hello C world!.${CC}.i"
set +x

## 連結階段
printf "正在將目標程式碼(object code)連結(link)為可執行檔(executable)……\n"
set -x
${CC} -L"${HOME}/軟體/gettext-runtime-0.13.1.bin.woe32/lib" -o "Built software/Hello C world!.${CC}.exe" "Files generated during building process/Hello C world!.${CC}.o" -lintl
set +x

# 建構軟體界面翻譯
cd ../../Resources/Translations
printf "正在建構軟體界面翻譯……\n"
bash buildTranslations.bash.sh

printf "軟體建構程序結束。\n"
printf "如果沒有印出錯誤訊息代表軟體建構成功！\n"

# 回傳 0 結束狀態代碼， 0 代表正常結束程式
exit 0
