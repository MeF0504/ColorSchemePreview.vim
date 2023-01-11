# ColorSchemePreview.vim

Vim plugin to review installed color schemes.
<img src=images/csp.gif width="70%">

## Usage
```vim
ColorSchemePreview [pat]
```
- selecting: j/k
- select & close: Enter/Space
- close: x/Escape

`pat` is an optional argument.
If specified, only items matching `pat` are shown.

## Requirements

## Installation

For [vim-plug](https://github.com/junegunn/vim-plug) plugin manager:

```vim
Plug 'MeF0504/ColorSchemePreview.vim'
```

## Options

Please use `ColorScheme` or `ColorSchemePre` event to set something.
`g:csp_active` is set to 1 during the ColorSchemePreview window is shown.  
e.g.;
```vim
function! s:csp_solarized() abort
    if exists('g:csp_active') && g:csp_active
        set background=light
    endif
endfunction
autocmd ColorSchemePre solarized call <SID>csp_solarized()
```

## License
[MIT](https://github.com/MeF0504/ColorSchemePreview.vim/blob/main/LICENSE)

## Author
[MeF0504](https://github.com/MeF0504)
