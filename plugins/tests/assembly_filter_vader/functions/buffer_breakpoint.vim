function! buffer_breakpoint#set_highlight_line(...)
   let l:args = get(a:, 1, {})
   let l:event_args = get(l:args, "event_input_args", {})
   if len(l:event_args) > 0
     let l:highlight_line_variable = l:event_args["highlight_line_variable"]
     let l:buffer_name = l:event_args["current_filename_variable"]
     if l:highlight_line_variable != '' && g:vg_config_dictionary['variables'][l:highlight_line_variable] != ''
         let l:local_buffer_input_variable = []
         let l:line_counter = 1
         let l:highlight_line = -1
         let l:line_to_match = g:vg_config_dictionary['variables'][l:highlight_line_variable]
         for l:line in g:vg_config_dictionary["internal"]["buffer_caches"][l:buffer_name]
             if l:line =~ l:line_to_match
                if bufwinnr(l:buffer_name) > 0
                  execute "sign unplace 2"
                  execute "sign place 2 line=" . l:line_counter . " name=wholeline_breakpoint file=" . l:buffer_name
                endif
                return
             endif
             let l:line_counter += 1
         endfor
     endif
   endif
endfunction
