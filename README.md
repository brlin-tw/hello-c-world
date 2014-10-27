# Ｃ語言世界哈囉！<br />Hello C world!
這是個最簡單的「Ｃ程式語言世界哈囉！」程式  
[https://github.com/Vdragon/Hello_C_world_](https://github.com/Vdragon/Hello_C_world_)

## 本目錄下的目錄與檔案說明
### Source code/
軟體的來源程式碼目錄

### Built software(for traditional build configuration)/
使用 buildSoftware.bash.sh 程式建構軟體時放置建構出來的軟體的目錄

### README.md
專案說明文件（您現在看到的內容就是從這個檔案來的）

### buildSoftware.bash.sh
軟體建構 GNU Bash 殼程式腳本程式

## 建構本軟體所需的軟體<br />Prerequisites for building this software
### GNU Bourne-Again 殼程式(bash)<br />GNU Bourne-Again Shell(bash)
#### 相容於 Unix 的作業系統散佈版本
通常已經內建，如果沒有的話自該作業系統散佈版本的軟體管理系統中搜尋「bash」並安裝

#### Microsoft Windows 作業系統
可以或取並安裝包含但不限於下列之 Bash 殼程式的移植版本

* [win-bash - bash port for Windows](http://win-bash.sourceforge.net/)
* [MinGW | Minimalist GNU for Windows 提供的 MSYS](http://goo.gl/362f)

### 一個相容 C89 標準的建構工具鍊(build toolchain)
#### 相容於 Unix 的作業系統散佈版本
通常已經內建，如果沒有的話自該作業系統散佈版本的軟體管理系統中搜尋「gcc」並安裝

#### Microsoft Windows 作業系統
* [MinGW | Minimalist GNU for Windows 提供的 minGW](http://goo.gl/362f)

## 如何建構軟體
本軟體支援下列幾種軟體建構解決方案(Build solutions)：

### 傳統命令集合<br />Traditional batch commands
在命令列介面中切換當前工作目錄(current working directory)到「Hello C world!」專案來源程式碼根目錄下的「Build solutions/Traditional batch commands/」目錄，然後執行下列命令：
```
$ bash buildSoftware.bash.sh
```

## 如何執行建構出來的程式
在命令列介面中切換當前工作目錄(current working directory)到「Hello C world!」專案來源程式碼根目錄下的「Build solutions/〈您所選擇的軟體建構解決方案〉/Built software」目錄，然後執行下列命令：
```
$ './Hello C world!.exe'
```

## 最新版本來源程式碼的建構狀態
[![Build Status](https://travis-ci.org/Vdragon/Hello_C_world_.svg)](https://travis-ci.org/Vdragon/Hello_C_world_)

## 智慧財產授權條款
Ｖ字龍放棄此專案的一切權利，將其釋出到公有領域(public domain)。

