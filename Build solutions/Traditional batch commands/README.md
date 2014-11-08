# Build solutions/Traditional batch commands/
## 這是什麼？<br />What is this?
這是「傳統批次執行命令」軟體建構解決方案的目錄

## 本目錄底下內容適用之授權條款<br />License of the content under this directory
同上層目錄內容採用的授權條款

## 本目錄下的項目說明<br />Description of the items under this directory
### [Built software/](Built software/)
放置建構好的軟體的目錄

### [Files generated during building process/](Files generated during building process/)
放置在軟體建構過程中產生的檔案的目錄

### [README.md](README.md)
本說明文件

### [buildSoftware.bash.sh](buildSoftware.bash.sh)
軟體建構 GNU Bash 殼程式腳本程式

## 用本軟體建構解決方案建構軟體所需的軟體<br />Prerequisites for using this build solution to build software
### GNU Bourne-Again 殼程式(bash)<br />GNU Bourne-Again Shell(bash)
#### 相容於 Unix 的作業系統散佈版本
通常已經內建，如果沒有的話自該作業系統散佈版本的軟體管理系統中搜尋「bash」並安裝

#### Microsoft Windows 作業系統
可以或取並安裝包含但不限於下列之 Bash 殼程式的移植版本

* [win-bash - bash port for Windows](http://win-bash.sourceforge.net/)
* [MinGW | Minimalist GNU for Windows 提供的 MSYS](http://goo.gl/362f)

## 如何用本軟體建構解決方案建構軟體？
在命令列介面中切換當前工作目錄(current working directory)到「Hello C world!」專案來源程式碼根目錄下的「Build solutions/Traditional batch commands/」目錄，然後執行下列命令：
```
$ bash buildSoftware.bash.sh
```

## 如何執行建構出來的程式
在命令列介面中切換當前工作目錄(current working directory)到「Ｃ程式設計世界哈囉！(Hello_C_world!)」專案來源程式碼根目錄下，然後執行下列命令：
```
$ './Build solutions/Traditional batch commands/Built software/Ｃ程式設計世界哈囉！(Hello C world!).exe'
```

## 已知問題<br />Known issues
請瀏覽本專案的議題追蹤系統。  
Please browse our project's issue tracker.  
[Issues · Vdragon/Hello_C_world_](https://github.com/Vdragon/Hello_C_world_/issues)