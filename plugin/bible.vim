function Bible(...)
    if !exists('a:1') && !exists('g:BibleTranslation')
        echo "You must set the first argument or the default g:BibleTranslation before using this plugin!"
        return
    endif
    if !exists('a:2') && !exists('g:BibleFormat')
        let g:BibleFormat = ""
    endif
    if !exists('a:3') && !exists('g:BibleLocale')
        let g:BibleLocale = "en"
    endif
    if !exists('a:4') && !exists('g:BibleDelimiter')
        let g:BibleDelimiter = "\\n"
    endif
    if !exists('a:5') && !exists('g:BibleOmitModuleName')
        let g:BibleOmitModuleName = 0
    endif

    let translation = (a:0 >= 1) && exists('a:1') ? a:1 : g:BibleTranslation
    let format = exists('a:2') ? a:2 : g:BibleFormat
    let locale = exists('a:3') ? a:3 : g:BibleLocale
    let delimiter = exists('a:4') ? a:4 : g:BibleDelimiter
    let omitmodulename = exists('a:5') ? a:5 : g:BibleOmitModuleName

    if (a:0 >= 6)
        let query = a:6
    else
        let query = input("Query: ")
    endif

    let command = "diatheke -b " . translation . " -l " . locale . " -k " . query

    if format != ''
        let command .= " | sed -E \"s/^(.*) ([0-9]+):([0-9]+): (.*)$/" . format . "/g\""
    endif
    if omitmodulename == 1
        let command .= " | sed -E \"s/^\\(.*\\)$//\""
    endif
    if delimiter != ''
        let command .= " | tr '\\n' '" . delimiter . "'"
    endif

    let text = system(command)
    if text !~ "^Diatheke" && text !~ "^[\s\n\r]*$"
        put = text
    else
        echo "Invalid query!"
    endif
endfunction
