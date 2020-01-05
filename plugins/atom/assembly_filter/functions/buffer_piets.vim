function! buffer_piets#set_piets(...)
   let l:args = get(a:, 1, {})
   let l:event_args = get(l:args, "event_input_args", {})
   let l:piet_match_array_variable = get(l:event_args, "piet_match_array_variable", '')
   let l:buffer_name = l:event_args["current_filename_variable"]
   if l:piet_match_array_variable != '' && bufwinnr(l:buffer_name) > 0
      if l:piet_match_array_variable != ''
          let l:piet_match_list = g:vg_config_dictionary["variables"][l:piet_match_array_variable]
          if len(l:piet_match_list) > 0
              for l:piet_match in l:piet_match_list
                  let l:line_counter = 1
                  for l:line in g:vg_config_dictionary["internal"]["buffer_caches"][l:buffer_name]
                      if l:line =~ l:piet_match
                          execute "sign place 3 line=" . l:line_counter . " name=piet file=" . expand("%:p")
                      endif
                      let l:line_counter += 1
                  endfor
              endfor
          endif
      endif
   endif
endfunction
