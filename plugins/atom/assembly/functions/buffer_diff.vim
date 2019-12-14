function! buffer_diff#check_do_buffer_diff(...)
    let l:args = get(a:, 1, {})
    let l:event_args = get(l:args, "event_input_args", {})
    if len(l:event_args) > 0
      let l:cache_variable = l:event_args["buffer_cache_variable"]
      let l:buffer_name = get(l:event_args, "buffer_name", {})
      if len(l:buffer_name) > 0
        let l:current_buffer = get(g:vg_config_dictionary["internal"]["buffer_caches"], l:buffer_name)
        let l:cache_buffer = get(g:vg_config_dictionary["variables"], l:cache_variable, '')
        let l:unplaced_diffs = 0
        if bufwinnr(l:buffer_name) > 0
          if len(l:cache_buffer) > 0 && len(l:current_buffer) <= len(l:cache_buffer)
              let l:line_index = 0
              for l:line in l:current_buffer
                  if l:line !=? l:cache_buffer[l:line_index]
                      let l:line_number = l:line_index + 1
                      if l:unplaced_diffs == 0
                        execute "sign unplace * file=" . l:buffer_name
                        let l:unplaced_diffs = 1
                      endif
                      execute "sign place 3 line=" . l:line_number . " name=wholeline_diff file=" . l:buffer_name 
                  endif
                  let l:line_index += 1
              endfor
          endif
        endif
        let g:vg_config_dictionary["variables"][l:cache_variable] = l:current_buffer
      endif
    endif
endfunction
