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
    let l:contents = getline(1, '$')
    
    "reading default (enter) settings from init file
    let l:default = get(g:, 'replacetemp_default', 'no') ==? 'yes'

    "take input from user 
    let l:prompt = a:name . " already exists, overwrite? [" . (l:default ? "Y/n" : "y/N") . "]: "
    let l:ans = input(l:prompt)

    "deletion logic
    if l:ans ==# ''
        let l:do_overwrite = l:default
    elseif l:ans =~? '^y$'
        let l:do_overwrite = 1
    else
        let l:do_overwrite = 0
    endif

    "result message
    if l:do_overwrite
        "write to template
        call writefile(l:contents, l:destination)
        echom "\n" . "Saved template: " . a:name
    else
        echom "\n" . "Canceled"
    endif

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
    call append(line('.')-1, readfile(l:source))
    echom "Loaded template: " . a:name
endfunction

function! DeleteTemp(name) abort
    "plugin and root directories
    let l:plugin_root = expand('<sfile>:p:h:h')
    let l:templates_dir = l:plugin_root . '/templates'

    "delete templates as .txt files unless specified
    if fnamemodify(a:name, ':e') ==# ''
        let l:filename = a:name . '.txt'
     else
        let l:filename = a:name
    endif

    "template source
    let l:source = l:templates_dir . '/' . l:filename

    if !filereadable(l:source)
        echom "\nTemplate not found: " . l:source
        return
    endif
    
    "reading default (enter) settings from init file
    let l:default = get(g:, 'rmtemp_default', 'no') ==? 'yes'

    "take input from user 
    let l:prompt = "Delete " . l:source . "? [" . (l:default ? "Y/n" : "y/N") . "]: "
    let l:ans = input(l:prompt)
    
    "deletion logic
    if l:ans ==# ''
        let l:do_delete = l:default
    elseif l:ans =~? '^y$'
        let l:do_delete = 1
    else
        let l:do_delete = 0
    endif

    "result message
    if l:do_delete
        if delete(l:source) == 0
            echom "\n" . "Deleted: " . a:name
        else
            echohl ErrorMsg | echom "\nFailed to delete: " . a:name | echohl None
        endif
    else
        echom "\n" . "Canceled"
    endif
endfunction

command! -nargs=1 SaveTemp call SaveTemp(<f-args>)
command! -nargs=1 VimTemp call LoadTemp(<f-args>)
command! -nargs=1 RmTemp call DeleteTemp(<f-args>)
