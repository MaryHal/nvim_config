if has('nvim')
    if exists('g:GuiLoaded')
        set guifont=Iosevka\ Term\ SS05:h9
        GuiLinespace 2
        GuiTabline 0
        GuiPopupmenu 0
    endif
    if exists('g:neovide')
        set guifont=Iosevka\ Term\ Slab:h13
        let g:neovide_cursor_antialiasing = v:true
    endif
else
    set guifont=Sarasa_Mono_J:h9
    set guioptions=acg
endif

colors plain
set background=light

hi link ClapCurrentSelection DiffAdd
hi StatusLine gui=NONE
hi StatusLineNC gui=NONE
hi StatusLineError gui=NONE
hi StatusLineOk gui=NONE
hi StatusLineNC gui=NONE
