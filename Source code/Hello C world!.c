/* 以「正斜線，米字符號」與「米字符號，正斜線」包住的內容為Ｃ語言的多行註解（C89 標準 - LANGUAGE - LEXICAL ELEMENTS - Comments）
   注意：C89 不支援 // 開頭的單行註解！ */

/* 命令Ｃ程式語言工具鍊的預處理器(proprocessor)引入函式庫的標頭檔案(header file)，其包含該函式庫提供的函式(function)與常數(constant)等東西的宣告(declaration) */
	/* 引入標準Ｃ函式庫的資料輸出／輸入（C89 標準 - LIBRARY - INPUT/OUTPUT <stdio.h>）相關的宣告內容
	程式中使用到的定義：puts(), printf() */
	#include <stdio.h>

	/* 引入標準Ｃ函式庫的一般工具(general utilities)（C89 標準 - LIBRARY - GENERAL UTILITIES <stdlib.h>）相關的宣告內容
	程式中使用到的定義：EXIT_SUCCESS */
	#include <stdlib.h>

	/* 引入標準Ｃ函式庫本地化(localication)（C89 標準 - LIBRARY - LOCALIZATION <locale.h>）相關的定義
	程式中使用到的定義：setlocale() */
	#include <locale.h>

	/* 引入標準Ｃ函式庫 errno 錯誤代碼變數（C89 標準 - LIBRARY - Errors <errno.h>）的定義
	程式中用到了：errno */
	#include <errno.h>

	/* 引入標準Ｃ函式庫字串處理部份（C89 標準 - LIBRARY - STRING HANDLING <string.h>）的定義
	本程式中用到了：strerror() */
	#include <string.h>

	/* 引入 GNU Gettext 國際化函式庫的定義內容 */
	#include <libintl.h>

/* main 函式 - Ｃ語言程式執行時期(runtime)的進入點(entry point)（最先執行的函式）（C89 標準 - ENVIRONMENT - Execution environments - Hosted environment）
   函式參數
     argc
       執行此程式的命令列參數數量
     argv
       保存了可執行檔路徑與執行此程式的各個命令列參數的 */
int main(int argc, char* argv[]){
	/* 初始化 Gettext 國際化(Internationalization)支援 */{
		char *function_call_result = NULL;
		/* 將程式的語系設定為當前的系統語系 */{
			function_call_result = setlocale(LC_ALL, "");
			if(function_call_result == NULL){
				printf("【錯誤】setlocale() 子程式呼叫失敗！\n");
			}else{
/* #ifndef(IF Not DEFined)、#endif 前期處理器命令包住的內容會於後面提到的常數(constant)未被定義的時候被引入。
   NDEBUG(Not DEBUG mode) 常數被定義時表示現在不在除錯階段，故不需要印出除錯用的訊息，於整合式開發環境的軟體建構解決方案中此常數於「Release」建構目標的編譯器設定中被設定，故以「Release」建構目標建構出來的可執行檔於執行時就不會輸出多餘的訊息給軟體使用者 */
#ifndef NDEBUG
				printf("【除錯用】程式正在以「%s」語系運行。\n", function_call_result);
#endif
			}
		}

		/* 強制指定「Ｃ程式設計世界哈囉！(Hello C World!)」訊息域名(message domain)的翻譯資料為 UTF-8 字元編碼 */{
			function_call_result = bind_textdomain_codeset("Ｃ程式設計世界哈囉！(Hello C World!)", "UTF8");
			if(function_call_result == NULL){
				printf(
					"【錯誤】bind_textdomain_codeset() 子程式呼叫失敗！\n"
					"　　　　系統回傳的失敗原因為：「%s」。\n", strerror(errno));
			}else{
#ifndef NDEBUG
				printf("【除錯用】程式的語系資料字元編碼為「%s」。\n", function_call_result);
#endif
			}
		}

		/* 設定含有「Ｃ程式設計世界哈囉！(Hello C World!)」訊息域名的翻譯資料的目錄 */{
		function_call_result = bindtextdomain("Ｃ程式設計世界哈囉！(Hello C World!)", "./Resources/Translations");
			if(function_call_result == NULL){
				printf(
					"【錯誤】bindtextdomain() 子程式呼叫失敗！\n"
					"　　　　系統回傳的失敗原因為：「%s」。\n", strerror(errno));
			}else{
#ifndef NDEBUG
				printf("【除錯用】程式的語系資料基底目錄為「%s」。\n", function_call_result);
#endif
			}
		}

		/* 設定接下來的 gettext() 函式呼叫應自「Ｃ程式設計世界哈囉！(Hello C World!)」的訊息域名中取得 */{
		function_call_result = textdomain ("Ｃ程式設計世界哈囉！(Hello C World!)");
			if(function_call_result == NULL){
				printf(
					"【錯誤】textdomain() 子程式呼叫失敗！\n"
					"　　　　系統回傳的失敗原因為：「%s」。\n", strerror(errno));
			}else{
#ifndef NDEBUG
				printf(
					"【除錯用】當前的訊息域名為(message domain)為「%s」。\n",
					function_call_result);
#endif
			}
		}
	}

	/* gettext() 函式負責取得「"Ｃ程式設計世界哈囉！"」字串的翻譯（如果存在的話）。
	標準Ｃ函式庫提供之負責輸出指定字串到標準輸出裝置(stdout)並自己再輸出一個換列字元的 puts 函式（C89 標準 - LIBRARY - INPUT/OUTPUT <stdio.h> - Character input/output functions - The puts function）負責將 gettext() 回傳的字串印出來 */
	puts(gettext("Ｃ程式設計世界哈囉！"));

	/* 於 main 函式中 return 語句的功能為回傳結束狀態代碼(exit status code)回母進行中程式(?)（C89 標準 - LANGUAGE - STATEMENTS - The return statement） */
	/* EXIT_SUCCESS 為標準Ｃ函式庫提供之會展開為當前系統平台中代表程式成功結束的代碼的巨集(macro)（C89 標準 - LIBRARY - GENERAL UTILITIES <stdlib.h>） */
	return EXIT_SUCCESS;
}
