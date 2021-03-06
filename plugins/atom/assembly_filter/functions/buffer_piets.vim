function! buffer_piets#set_piets(...)
   let g:vg_debug_functions = get(g:, "vg_debug_functions", 0)
   let l:args = get(a:, 1, {})
   let l:event_args = get(l:args, "event_input_args", {})
   let l:piet_match_array_variable = get(l:event_args, "piet_match_array_variable", '')
   let l:buffer_name = l:event_args["current_filename_variable"]

   if l:piet_match_array_variable != '' && bufwinnr(l:buffer_name) > 0
      execute "sign unplace * group=breakpoint_piets"
      if l:piet_match_array_variable != ''
          let l:piet_match_list = g:vg_config_dictionary["variables"][l:piet_match_array_variable]
          if g:vg_debug_functions
            echom "piet match array list: " . string(l:piet_match_list)
          endif
          if len(l:piet_match_list) > 0
              for l:piet_match in l:piet_match_list
                  let l:line_counter = 1
                  for l:line in g:vg_config_dictionary["internal"]["buffer_caches"][l:buffer_name]
                      if l:line =~ l:piet_match
                          if g:vg_debug_functions
                            echom "match on line: ->" . l:line
                            echom "piet match: ->" . l:piet_match
                            echom "line_counter: " . l:line_counter
                          endif
                          execute "sign place 3 line=" . l:line_counter . " group=breakpoint_piets name=piet file=" . l:buffer_name
                          break
                      endif
                      let l:line_counter += 1
                  endfor
              endfor
          endif
      endif
   endif
endfunction
