#!/bin/bash
# 前一行為 shebang ，用來指定執行此腳本(script)程式的直譯器（如此例為 GNU bash 殼程式直譯器）
# 以井字符號(#)開頭但非 shebang 的文字列是不會被執行的註解文字
# buildSoftware.bash.sh - 軟體建構程式
# 此程式會用 GNU GCC C 工具鏈(toolchain)將來源程式碼(HelloCworld.c)檔案建構為您的處理器架構的可執行檔(executable)(HelloCworld.exe)
# 使用方式：
# 	在命令列介面中切換當前工作目錄(current working directory)到「HelloCworld」專案根目錄下，然後執行下列命令：
# 	$ bash build.bash.sh

gcc -o HelloCworld.exe HelloCworld.c

# 正常結束程式
exit 0