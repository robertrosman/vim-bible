function Bible(...)
    if !exists('g:BibleTranslation')
        echo "You must set g:BibleTranslation before using this plugin!"
        return
    endif
    if !exists('g:BibleOmitModuleName')
        let g:BibleOmitModuleName = 1
    endif

    let translation = exists('a:1') ? a:1 : g:BibleTranslation
    let format = exists('a:2') ? a:2 : g:BibleFormat
    let locale = exists('a:3') ? a:3 : g:BibleLocale
    let delimiter = exists('a:4') ? a:4 : g:BibleDelimiter
    let omitmodulename = exists('a:5') ? a:5 : g:BibleOmitModuleName
    let query = exists('a:6') ? a:6 : input("Query: ")

    let command = "diatheke -b " . translation . " -l " . locale . " -k " . query

    if exists('g:BibleFormat')
        let command .= " | sed -E \"s/^(.*) ([0-9]+):([0-9]+): (.*)$/" . format . "/g\""
    endif

    if g:BibleOmitModuleName
        let command .= " | sed -E \"s/^\\(.*\\)$//\""
    endif
    if exists('g:BibleDelimiter')
        let command .= " | tr '\\n' '" . g:BibleDelimiter . "'"
    endif
    let text = system(command)
    if text !~ "^Diatheke" && text !~ "^[\s\n\r]*$"
        put =text
    else
        echo "Invalid query!"
    endif
endfunction
