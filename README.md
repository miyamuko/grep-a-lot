## grep-a-lot - 複数の grep バッファを使う

* Home URL: http://miyamuko.s56.xrea.com/xyzzy/grep-a-lot/intro.htm
* Version: 1.1.0


### SYNOPSIS

1. grep したり、grep-dialog したり、ggrep したりするだけ


### DESCRIPTION

grep-a-lot は grep バッファの名前を自動的に変更して、
grep バッファを複数保存できるようにします。

grep バッファのバッファ名には以下のように検索キーワードが含まれます。

    *grep:<foo>*
    *ggrep:<tiger AND bunny>*

詳細は Emacs の [grep-a-lot.el] の説明 (PDF) などを参照してください
（といいつつ、grep-a-lot.el を使ったこと無いので、一部動作が違う部分があるかもしれません）。

OHKUBO Hiroshi さんの [ggrep] にも対応しています。

  [grep-a-lot.el]: http://www.rubyist.net/~rubikitch/archive/Emacs-162-163.pdf
  [ggrep]: http://ohkubo.s53.xrea.com/xyzzy/#ggrep


### INSTALL

1. [NetInstaller] で grep-a-lot をインストールします。

2. ni-autoload を利用していない場合は、
   ~/.xyzzy または site-lisp/siteinit.l に以下のコードを追加します。

   ```lisp
   (require "grep-a-lot")
   ```

   ※ ni-autoload を利用している場合は設定は不要です。

3. 必要ならキーバインドを定義

   ```lisp
   ;; Emacs の grep-a-lot と同じキーバインドを定義。
   ;; M-g goto-line がつぶれるので注意。
   (grep-a-lot-setup-keys)
   ```

4. 設定を反映させるため xyzzy を再起動してください。

   ※siteinit.l に記述した場合には再ダンプが必要です。

  [NetInstaller]: http://www7a.biglobe.ne.jp/~hat/xyzzy/ni.html


### COMMANDS

  * `grep-a-lot-goto-next`

    次の grep バッファを開く。

  * `grep-a-lot-goto-prev`

    前の grep バッファを開く。

  * `grep-a-lot-pop-stack`

    現在の grep バッファを削除する。

  * `grep-a-lot-clear-stack`

    全 grep バッファを削除する。

  * `grep-a-lot-restart-context`

    最後に F10 (first-error) した grep バッファを開く。

  * `grep-a-lot-setup-keys`

    Emacs の grep-a-lot と同じキーバインドを定義する。
    M-g goto-line は使えなくなるので注意すること。


### TODO

なし。


### KNOWN BUGS

なし。

要望やバグは [GitHub Issues] か [@miyamuko] まで。

  [GitHub Issues]: http://github.com/miyamuko/grep-a-lot/issues
  [@miyamuko]: http://twitter.com/home?status=%40miyamuko%20%23xyzzy%20grep-a-lot%3a%20


### AUTHOR

みやむこ かつゆき (<mailto:miyamuko@gmail.com>)


### COPYRIGHT

grep-a-lot は MIT/X ライセンスに従って本ソフトウェアを使用、再配布することができます。

    Copyright (c) 2011-2012 MIYAMUKO Katsuyuki.

    Permission is hereby granted, free of charge, to any person obtaining
    a copy of this software and associated documentation files (the
    "Software"), to deal in the Software without restriction, including
    without limitation the rights to use, copy, modify, merge, publish,
    distribute, sublicense, and/or sell copies of the Software, and to
    permit persons to whom the Software is furnished to do so, subject to
    the following conditions:

    The above copyright notice and this permission notice shall be
    included in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
    EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
    NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
    LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
    OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
    WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
