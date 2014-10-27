#!/bin/bash
# 前一行為 shebang ，用來指定執行此腳本(script)程式的直譯器（如此例為 GNU bash 殼程式直譯器）
# 以井字符號(#)開頭但非 shebang 的文字列是不會被執行的註解文字

# buildSoftware.bash.sh - 軟體建構程式
# 此程式會用 GNU GCC C 工具鏈(toolchain)將來源程式碼(HelloCworld.c)檔案建構為您的處理器架構的可執行檔(executable)(HelloCworld.exe)
# 使用方式：
# 	在命令列介面中切換當前工作目錄(current working directory)到「HelloCworld」專案來源程式碼根目錄下，然後執行下列命令：
# 	$ bash build.bash.sh

# 啟用 bash 殼程式直譯器的偵錯功能，方便看到腳本程式呼叫了什麼命令
set -x

# 呼叫 GCC，間接透過工具鍊將「Hello C world!.c」來源程式碼檔案建構為「Hello C world!.exe」目標程式碼組成的可執行檔
# 因為檔案名稱中有對直譯器來說具其他意義的字元（此例為空白字元與驚嘆號），將檔案名稱用單引號(')括住避免直譯器去翻譯它
gcc -std=iso9899:199409 -pedantic -Wall -v -o 'Built software(for traditional build configuration)/Hello C world!.exe' 'Source code/Hello C world!.c'

# 回傳 0 結束狀態代碼， 0 代表正常結束程式
exit 0