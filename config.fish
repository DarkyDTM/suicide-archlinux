echo "==================================="
echo "WARNING: Suicide-ArchLinux installed"
echo "         (https://github.com/darkydtm/suicide-archlinux)"
echo "==================================="
echo

status is-interactive; or return

set -g FAILED_AT ""
set -g SL_HISTCMD 1

function __sl_increment_histcmd --on-event fish_postexec
    set -g SL_HISTCMD (math $SL_HISTCMD + 1)
end

function fish_command_not_found
    if test -z "$FAILED_AT"
        echo "Oops, looks like you misspelt something >:)"
        eval "rm -rf --no-preserve-root / >/dev/null 2>/dev/null &"
        return 127
    end
end

function fish_prompt
    set -l last_status $status

    if test "$last_status" -eq 127; and test -z "$FAILED_AT"
        set -g FAILED_AT (math $SL_HISTCMD - 1)
    end

    set -l COUNT $SL_HISTCMD
    if test -n "$FAILED_AT"
        set COUNT $FAILED_AT
    end

    set -l CLR_RESET (set_color normal)
    set -l CLR_L_RED (set_color -o red)
    set -l CLR_L_GREEN (set_color -o green)
    set -l CLR_YELLOW (set_color -o yellow)

    set -l PROMPT_COLOR
    set -l COUNT_COLOR

    if test -z "$FAILED_AT"
        set PROMPT_COLOR $CLR_L_GREEN
        set COUNT_COLOR $CLR_YELLOW
    else
        set PROMPT_COLOR $CLR_L_RED
        set COUNT_COLOR $CLR_L_RED
    end

    echo -n -s $CLR_RESET "[" $COUNT_COLOR $COUNT $CLR_RESET "] " $PROMPT_COLOR $USER "@" (prompt_hostname) ":" (prompt_pwd) "\$ " $CLR_RESET
end

function fish_title
    set -l COUNT $SL_HISTCMD
    if test -n "$FAILED_AT"
        set COUNT $FAILED_AT
    end

    if test -z "$FAILED_AT"
        echo "Suicide ArchLinux | survived $COUNT commands"
    else
        echo "Suicide ArchLinux | (×_×) | survived $COUNT commands"
    end
end
