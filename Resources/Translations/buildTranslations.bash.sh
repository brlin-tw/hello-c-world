#!/bin/bash
# 前一行為 shebang ，用來指定執行此腳本(script)程式的直譯器（如此例為 GNU bash 殼程式直譯器）
# 以井字符號(#)開頭但非 shebang 的文字列是不會被執行的註解文字

# buildTranslations.bash.sh - 軟體界面翻譯建構程式
# 使用方式：
# 	在命令列介面中切換當前工作目錄(current working directory)到「Ｃ程式設計世界哈囉！(Hello C World!)」專案來源程式碼根目錄下的「Resources/Translations/」目錄，然後執行下列命令：
# 	$ bash buildTranslations.bash.sh
# 程式回傳代碼：
# 	0 - 成功執行
# 	1 - 發生錯誤

# 啟用 bash 殼程式直譯器的偵錯功能，方便看到腳本程式呼叫了什麼命令
# set -x

# 檢查當前工作目錄(current working directory)是否在正確
if [ "$(basename "$(pwd)")" != "Translations" ] 
	then
		printf "您的當前工作目錄錯誤，您需要先切換到「Resources/Translations/」目錄底下才能執行本程式。\n"
		exit 1
fi

# 建構軟體界面翻譯
printf "正在建構軟體界面翻譯……\n"

set -x
msgfmt --check --statistics  --verbose 'en/LC_MESSAGES/Ｃ程式設計世界哈囉！(Hello C World!).po' --output-file='en/LC_MESSAGES/Ｃ程式設計世界哈囉！(Hello C World!).mo'
printf "正在建構軟體界面翻譯……\n"
msgfmt --check --statistics  --verbose 'zh_CN/LC_MESSAGES/Ｃ程式設計世界哈囉！(Hello C World!).po' --output-file='zh_CN/LC_MESSAGES/Ｃ程式設計世界哈囉！(Hello C World!).mo'
set +x

printf "軟體界面翻譯建構程序結束。\n"
printf "如果沒有印出錯誤訊息代表軟體界面翻譯建構成功！\n"

# 回傳 0 結束狀態代碼， 0 代表正常結束程式
exit 0
