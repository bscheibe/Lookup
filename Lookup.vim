""" Lookup
""" Bruce Scheibe
""" Configure Exuberant tag and Cscope database lookup.


" Configure behavior.
set nocscopetag
setnotagrelative


" Perform a Cscope search for the token under cursor.
map <C-n> :call CscopeSearch(expand("<cword>"))<CR>


" Allows importing a directory of tagfiles.
if exists("g:tag_dir")
        set tags=""
endif
for t in split(glob(g:tag_dir."/*"), '\n')
        execute "set tags+=".t
endfor


function! CscopeSearch(name)
        " Opening a Cscope database makes startup sluggish. Instead, use lazy initialization.
        if !exists('g:scope_set')
                if !exists("g:cscope_dir")
                        echo "No Cscope database specified! Set with g:ccope_dir."
                        return
                endif
                exec("cscope_add ".g:cscope_dir."/cscope.out")
                let g:cscope_set=1
        endif
        exe "cscope f s ". a:name
endfunction
