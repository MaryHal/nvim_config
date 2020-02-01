if has('nvim')
    if exists('g:GuiLoaded')
        set guifont=Iosevka\ TermLig\ SS05:h9
        GuiLinespace 1
        GuiTabline 1
        GuiPopupmenu 1
    endif
else
    set guifont=Sarasa_Mono_J:h9
    set guioptions=acg
endif

" set background=light
colors base16-tomorrow-night
