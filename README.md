vim-bible
=========

Vim-bible is a simple vim plugin that makes it easy to insert a Bible passage
into vim. The plugin is inspired by [this plugin][1].

To use the plugin, run `:call Bible("KJV")` in vim and enter your query. You can also
map the command like described in [Using the plugin](#using-the-plugin).

**Note:** You need to have Diatheke/Sword installed. This is the backend being
    used to extract the Bible text.


Installation
------------

With [Pathogen][2]:

    cd ~/.vim/bundle
    git clone git://github.com/roggan87/vim-bible.git


Settings
--------

There are a few settings, which of some are required for the plugin to work.

### g:BibleTranslation

This setting is required. Specify the name of the module here. If you're not
sure about the correct abbreviation, you can run:

    diatheke -b system -k modulelist

In your ~/.vimrc specify the translation like this:

    let g:BibleTranslation = "KJV"


### g:BibleFormat

This is how you want the text to be formatted before inserted into the document.
It is formatted like a `sed` replacement string, with a few backreferences
available:

  1. The name of the book
  2. The chapter
  3. The verse
  4. The text itself

Here are some examples of how it may look like. Note how the backreferences are
double escaped.

    :let g:BibleFormat = "\\3. \\4"
    16. For God so loved the world...

    :let g:BibleFormat = "(\\2:\\3) \\4"
    (3:16) For God so loved the world...

    :let g:BibleFormat = "> (\\3) \\4"
    > (16) For God so loved the world...

    :let g:BibleFormat = "\\4"
    For God so loved the world...


### g:BibleLocale

The locale specifies your language (mainly used for names on books, references
etc.). It consists of two characters. You may try your own locale with the
following command:

    # Note how the query is language specific (swedish/sv)
    diatheke -b KJV -l sv -k 1 Mos 1:1

In the ~/.vimrc file:

    let g:BibleLocale = "sv"


### g:BibleOmitModuleName

Diatheke ends the passage with the name of the translation inside parenthesis.
By default vim-bible removes it. If you want to include the module name, use the
following setting:

    let g:BibleOmitModuleName = 0


### g:BibleDelimiter

If you want another character than a newline between every verse, specify it
here. The most useful alternative is probably a regular blankspace. Might be
specified like this:

    let g:BibleDelimiter = " "


Using the plugin
----------------

If you don't use several translations the easiest way to configure the plugin
is by setting up the global defaults. Here is an example:
```
let g:BibleTranslation = "nlt-se"
let g:BibleFormat = "\\4"
let g:BibleLocale = "en"
let g:BibleDelimiter = " "

nnoremap <leader>v y :call Bible()<CR>
```

If you use several translations, you need to expand the prior global values as
arguments. In the following examples you can use how to use the plugin directly
(which might not be very comfortable) and how to map the `Bible()`.


#### Example 1:

Input:
```
:call Bible('KJV')
```

Explanation: This type of settings will use the defaults. It will prompt for a
`Query` passage. In this example we used `John 3:16-17`.

Output:
```
John 3:16: For God so loved the world, that he gave his only begotten Son, that whosoever believeth in him should not perish, but have everlasting life.
John 3:17: For God sent not his Son into the world to condemn the world; but that the world through him might be saved.
(KJV)
```

Example of mappings using `ctrl+i` + `k`:
```
nnoremap <C-I>k y :call Bible('KJV')<CR>
vnoremap <C-I>k y :call Bible('KJV', '', 'en', '', 0, @*)<CR>
```


#### Example 2:

Input:
```
:call Bible('nlt-se', '\\4', 'en', ' ', 0, 'John 3:16-17')
```

Explanation: This type of settings will print the verses together as a full
paragraph without querying for a Bible passage. It will also append the bible
version. The example uses the `nlt-se` (New Living Translation, Second Edition)
Bible translation in English. Example:

Output:
```
For God loved the world so much that he gave his one and only Son, so that everyone who believes in him will not perish but have eternal life. God sent his Son into the world not to judge the world, but to save the world through him. (nlt-se)
```

Example mappings using `ctrl-i` + `n`:
```
nnoremap <C-I>n y :call Bible('nlt-se', '\\4', 'en', ' ', 0)<CR>
vnoremap <C-I>n y :call Bible('nlt-se', '\\4', 'en', ' ', 0, @*)<CR>
```

With those mappings you can type `<C-I>n` in normal mode, enter the
query, and the text is inserted. You may also select a query in visual
mode and run `<C-I>n` to insert the corresponding Bible passage.


#### Example 3:

Input:
```
:call Bible('jfa-rc', '\\4', 'pt', ' ', 1, 'John 3:16-17')
```

Explanation: This type of call is similar to the prior, except that it will
remove the module name. The example uses the `jfa-rc` (João Ferreira de
Almeida, versão revisada corrigida) Bible translation in Portuguese. Example:

Output:
```
Porque Deus amou o Mundo de tal maneira que deu o seu Filho unigénito, para que todo aquele que nele crê não pereça, mas tenha a vida eterna. Porque Deus enviou o seu Filho ao mundo, não para que condenasse o mundo, mas para que o mundo fosse salvo por ele.
```

Example of mappings using `ctrl-i` + `j`:
```
nnoremap <C-I>j y :call Bible('jfa-rc', '\\4', 'pt', ' ', 1)<CR>
vnoremap <C-I>j y :call Bible('jfa-rc', '\\4', 'pt', ' ', 1, @*)<CR>
```


#### Example 4:

Input:
```
:call Bible('SpaRV', 'Verse \\3. \\4', 'es', '\n', 0, 'John 3:16-17')
```

Explanation: This type of call is similar to the prior, except that it will
change the formatting. It will show the module name also. The example uses the
`SpaRV` (Reina Valera 1909) Bible translation in Spanish. Example

Output:
```
Verse 16. Porque de tal manera amó Dios al mundo, que ha dado á su Hijo unigénito, para que todo aquel que en él cree, no se pierda, mas tenga vida eterna.
Verse 17. Porque no envió Dios á su Hijo al mundo, para que condene al mundo, mas para que el mundo sea salvo por él.
(SpaRV)
```

Example of mappings using `ctrl-i` + `r`:
```
nnoremap <C-I>r y :call Bible('SpaRV', '> \\3. \\4', 'es', ' ', 0)<CR>
vnoremap <C-I>r y :call Bible('SpaRV', '> \\3. \\4', 'es', ' ', 0, @*)<CR>
```


Copyright & license
-------------------

(c) Robert Rosman 2014

Licensed under [GNU GPL v3][3].


[1]: http://pastebin.com/pVgEpnJz
[2]: https://github.com/tpope/vim-pathogen
[3]: http://www.gnu.org/licenses/gpl.txt
