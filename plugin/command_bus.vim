let g:command_bus#defaultEventName = 'default'

function! command_bus#sendCommand(...)
    let event = (a:0 >= 2) ? a:2 : g:command_bus#defaultEventName
    let path = command_bus#getEventPath(event)
    let command = 'touch '.path
    let output = system(command)
endfunc

function! command_bus#writeAndSend(...)
    let event = (a:0 >= 2) ? a:2 : g:command_bus#defaultEventName

    " Save the file.
    execute "w"

    let result = command_bus#sendCommand(event)
endfunc

function! command_bus#getEventDirectory()
    let tmpdir = $TMPDIR

    if len(tmpdir) > 0
        return tmpdir
    else
        return '/tmp/'
endfunc

function! command_bus#getEventPath(event)
    return command_bus#getEventDirectory().'vim-command-bus_'.a:event
endfunc

command! -nargs=* CommandBus call command_bus#sendCommand(<f-args>)
command! -nargs=* CommandBusWriteAndSend call command_bus#writeAndSend(<f-args>)
