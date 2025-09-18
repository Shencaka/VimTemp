function! SaveTemp(name) abort
    "plugin and root directories
    let l:plugin_root = expand('<sfile>:p:h:h')
    let l:templates_dir = l:plugin_root . '/templates'

    if !isdirectory(l:templates_dir)
        call mkdir(l:templates_dir, 'p')
    endif

    "store templates as .txt files unless specified
    if fnamemodify(a:name, ':e') ==# ''
        let l:filename = a:name . '.txt'
     else
        let l:filename = a:name
    endif

    "template desitination
    let l:destination = l:templates_dir . '/' . l:filename

    "reads current file and get its contents
    let l:source = expand('%:p')
    let l:contents = readfile(l:source)

    "write to templates
    call writefile(l:contents, l:destination)
    echom "Saved templat: " . l:name
endfunction

function! LoadTemp(name) abort
    "plugin and root directories
    let l:plugin_root = expand('<sfile>:p:h:h')
    let l:templates_dir = l:plugin_root . '/templates'

    "store templates as .txt files unless specified
    if fnamemodify(a:name, ':e') ==# ''
        let l:filename = a:name . '.txt'
     else
        let l:filename = a:name
    endif

    "template source
    let l:source = l:templates_dir . '/' . l:filename

    "check if templates exists
    if !filereadable(l:source)
        echom "Template not found: " . l:source
        return
    endif

    "insert template to current cursor position
    call append(line(.), readfile(l:source))
    echom "Loaded template: " . l:filename
endfunction

command! -nargs=1 SaveTemp call SaveTemp(<f-args>)
command! -nargs=1 VimTemp call LoadTemp(<f-args>)

