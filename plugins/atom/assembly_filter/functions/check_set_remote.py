from tide.config.config import Config

def check_set_remote(command_args):
    if 'target remote' in command_args["process_command"].lower():
        binary_loaded = False
        symbols_found = True
        for line in command_args["lines"]:
            if 'Reading symbols from' in line or '(no debugging symbols found)' in line:
                binary_loaded = True
            if '(no debugging symbols found)' in line:
                symbols_found = False
        Config().set_variable('remote_target', 1)
        Config().set_variable('binary_loaded', int(binary_loaded))
        Config().set_variable('symbols_loaded', int(symbols_found and binary_loaded))
