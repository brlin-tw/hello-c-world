/* 以「/*（正斜線，米字符號）」與「米字符號，正斜線」包住的內容為Ｃ語言的多行註解（C89 標準 - LANGUAGE - LEXICAL ELEMENTS - Comments）
   注意：C89 不支援 // 開頭的單行註解！ */

/* 命令Ｃ程式語言工具鍊的預處理器(proprocessor)引入函式庫的標頭檔案(header file)，其包含該函式庫提供的函式(function)與常數(constant)等東西的宣告(declaration) */
	/* 引入標準Ｃ函式庫的資料輸出／輸入（C89 標準 - LIBRARY - INPUT/OUTPUT <stdio.h>）相關的宣告內容，其提供了用於在標準輸出裝置(stdout)輸出字元串列（字串）(string)的 puts 函式雛型(function prototype) */
	#include <stdio.h>
	
	/* 引入標準Ｃ函式庫的一般工具(general utilities)（C89 標準 - LIBRARY - GENERAL UTILITIES <stdlib.h>）相關的宣告內容，其提供了程式結束時回報給母進行中程式(process)的成功結束狀態碼(status code) macro EXIT_SUCCESS */
	#include <stdlib.h>

/* main 函式 - Ｃ語言程式執行時期(runtime)的進入點(entry point)（最先執行的函式）（C89 標準 - ENVIRONMENT - Execution environments - Hosted environment）
   函式參數
     argc
       執行此程式的命令列參數數量 
     argv
       保存了可執行檔路徑與執行此程式的各個命令列參數的 */
int main(int argc, char* argv[]){
	/* 標準Ｃ函式庫提供之負責輸出指定字串到標準輸出裝置(stdout)並自己再輸出一個換列字元的 puts 函式（C89 標準 - LIBRARY - INPUT/OUTPUT <stdio.h> - Character input/output functions - The puts function） */
	puts("Ｃ程式語言世界哈囉！");
	
	/* 於 main 函式中 return 語句的功能為回傳結束狀態代碼(exit status code)回母進行中程式(?)（C89 標準 - LANGUAGE - STATEMENTS - The return statement） */
	return EXIT_SUCCESS;
}
