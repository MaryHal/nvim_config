if has('nvim')
    if exists('g:GuiLoaded')
        set guifont=Iosevka\ TermLig\ SS05:h9
        GuiLinespace 2
        GuiTabline 0
        GuiPopupmenu 0
    endif
else
    set guifont=Sarasa_Mono_J:h9
    set guioptions=acg
endif

set background=light
colors plain
