scriptencoding utf-8

let s:bid = -1
function! csp#csp(pat='')
    let cs_list = getcompletion(a:pat, 'color')
    if empty(cs_list)
        echo 'no matching color scheme'
        return
    endif
    let max_width = &columns/2
    let max_height =  &lines/2
    let row = &lines-&cmdheight-1
    let col = &foldcolumn+&numberwidth+3
    let cur_cs = g:colors_name
    let cur_bg = &background

    if has('popupwin')
        let config = {
                    \ 'line': row,
                    \ 'col': col,
                    \ 'maxheight': max_height,
                    \ 'maxwidth': max_width,
                    \ 'pos': 'botleft',
                    \ 'border': [],
                    \ 'zindex': 200,
                    \ 'cursorline': v:true,
                    \ }
        let wid = popup_create(cs_list, config)
    elseif has('nvim')
        let width = 1
        for str in cs_list
            if len(str) > width
                let width = len(str)
            endif
        endfor
        let width += 1
        if width > max_width
            let width = max_width
        endif
        let height = len(cs_list)
        if height > max_height
            let height = max_height
        endif

        let config = {
                    \ 'relative': 'editor',
                    \ 'row': row,
                    \ 'col': col,
                    \ 'width': width,
                    \ 'height': height,
                    \ 'style': 'minimal',
                    \ 'anchor': 'SW',
                    \ 'border': 'single',
                    \ 'zindex': 200,
                    \ }
        if s:bid < 0
            let s:bid = nvim_create_buf(v:false, v:true)
        endif
        call nvim_buf_set_lines(s:bid, 0, -1, 0, cs_list)
        let wid = nvim_open_win(s:bid, v:false, config)
        call win_execute(wid, 'setlocal winhighlight=CursorLine:PmenuSel')
        call win_execute(wid, 'setlocal cursorline')
    endif
    call win_execute(wid, 'setlocal nowrap')
    call win_execute(wid, 'setlocal nofoldenable')
    call win_execute(wid, 'normal! gg')
    let g:csp_active = 1
    echo "j/k:select h:light l:dark space/enter:select x/esc:exit"
    execute 'colorscheme '..cs_list[0]
    while 1
        redraw
        let key = getcharstr()
        if key == "j" || key == "\<Down>"
            call win_execute(wid, 'normal! j')
            execute "colorscheme "..cs_list[line('.', wid)-1]
            redraw
        elseif key == "k" || key == "\<Up>"
            call win_execute(wid, 'normal! k')
            execute "colorscheme "..cs_list[line('.', wid)-1]
            redraw
        elseif key == "h" || key == "\<Left>"
            set background=light
        elseif key == "l" || key == "\<Right>"
            set background=dark
        elseif key == "\<Enter>" || key == "\<Space>"
            " call s:close_win(wid)
            execute "colorscheme "..cs_list[line('.', wid)-1]
            break
        elseif key == "\<esc>" || key == 'x'
            " call s:close_win(wid)
            let &background = cur_bg
            execute 'colorscheme '..cur_cs
            break
        endif
    endwhile
    call s:close_win(wid)
    let g:csp_active = 0
endfunction

function! s:close_win(wid) abort
    if has('popupwin')
        call popup_close(a:wid)
    elseif has('nvim')
        call nvim_win_close(a:wid, v:false)
    endif
endfunction
