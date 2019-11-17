function! set_buffer#for_filename(...)
   let l:args = get(a:, 1, {})
   let l:event_args = l:args["event_input_args"]
   let l:function_args = l:args["function_args"]
   let l:buffer_name = l:function_args["buffer_name"]
   let l:file_name = l:function_args["file_name"]
   let l:buffer_name_variable = l:event_args["current_buffer_name_variable"]
   if len(l:file_name) > 0 && len(l:buffer_name) > 0
     let l:buffer_number = set_buffer#get_current_buffer(l:file_name, l:buffer_name)
     if l:buffer_number > 0
         set buftype=
         set modifiable
         execute "buffer " . l:buffer_number
         execute "silent edit! " . l:file_name
     endif
   endif
endfunction

function! set_buffer#get_current_buffer(file_name, buffer_name)
  let l:buffer_number = 0
  let l:empty_number = 0
  let l:filename_number = 0

  if exists("g:cached_code_buffer_number")
    return g:cached_code_buffer_number
  endif

  let g:cached_code_buffer_number = 0

  for buf in getbufinfo()
    if buf.name == a:file_name
      let l:filename_number = buf.bufnr
    endif
  endfor

  for buf in getbufinfo()
    if buf.name == ''
      let l:empty_number = buf.bufnr
    endif
  endfor

  if l:buffer_number > 0
    let g:cached_code_buffer_number = l:buffer_number
    return l:buffer_number
  endif

  let g:cached_code_buffer_number = l:empty_number
  return l:empty_number
endfunction
