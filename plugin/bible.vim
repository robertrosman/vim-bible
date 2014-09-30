nnoremap <leader>b y :call Bible()<CR>
vnoremap <leader>b y :call Bible(@*)<CR>


function Bible(...)
    if !exists('g:BibleTranslation')
        echo "You must set g:BibleTranslation before using this plugin!"
        return
    endif
    if !exists('g:BibleOmitModuleName')
        let g:BibleOmitModuleName = 1
    endif
    let locale = exists('g:BibleLocale') ? " -l " . g:BibleLocale : ""
    let query = exists('a:1') ? a:1 : input("Query: ")
    let command = "diatheke -b " . g:BibleTranslation . locale . " -k " . query 
    if exists('g:BibleFormat')
        let command .= " | sed -E \"s/^(.*) ([0-9]+):([0-9]+): (.*)$/" . g:BibleFormat . "/g\""
    endif

    if g:BibleOmitModuleName
        let command .= " | sed -E \"s/^\\(.*\\)$//\""
    endif
    if exists('g:BibleDelimiter')
        let command .= " | tr '\\n' '" . g:BibleDelimiter . "'"
    endif
    if query != ""
        execute "r! " . command
    endif
endfunction
