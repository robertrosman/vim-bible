vim-bible
=========

Vim-bible is a simple vim plugin that makes it easy to insert a Bible passage
into vim. The plugin is inspired by [this plugin][1].

To use the plugin, run `:call Bible()` in vim and enter your query. You can also
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

You can map the `Bible()` function as you wish. Here is an example:

    nnoremap <leader>n y :call Bible("nlt-se", "\\4", "en", " ", 0)<CR>
    vnoremap <leader>n y :call Bible("nlt-se", "\\4", "en", " ", 0, @*)<CR>

    nnoremap <leader>k y :call Bible("KJV", "\\4", "en", " ", 1)<CR>
    nnoremap <leader>k y :call Bible("KJV", "\\4", "en", " ", 1, @*)<CR>

    nnoremap <leader>j y :call Bible("jfa-rc", "\\4", "en", " ", 0)<CR>
    nnoremap <leader>j y :call Bible("jfa-rc", "\\4", "en", " ", 0, @*)<CR>

With those mappings you can type `<leader>n` in normal mode, enter the
query, and the text is inserted. You may also select a query in visual
mode and run `<leader>n` to insert the corresponding Bible passage.


Copyright & license
-------------------

(c) Robert Rosman 2014

Licensed under [GNU GPL v3][3].


[1]: http://pastebin.com/pVgEpnJz
[2]: https://github.com/tpope/vim-pathogen
[3]: http://www.gnu.org/licenses/gpl.txt
