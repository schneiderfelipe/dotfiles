_fnm() {
    local i cur prev opts cmd
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    cmd=""
    opts=""

    for i in ${COMP_WORDS[@]}
    do
        case "${cmd},${i}" in
            ",$1")
                cmd="fnm"
                ;;
            fnm,alias)
                cmd="fnm__alias"
                ;;
            fnm,completions)
                cmd="fnm__completions"
                ;;
            fnm,current)
                cmd="fnm__current"
                ;;
            fnm,default)
                cmd="fnm__default"
                ;;
            fnm,env)
                cmd="fnm__env"
                ;;
            fnm,exec)
                cmd="fnm__exec"
                ;;
            fnm,help)
                cmd="fnm__help"
                ;;
            fnm,install)
                cmd="fnm__install"
                ;;
            fnm,list)
                cmd="fnm__list"
                ;;
            fnm,list-remote)
                cmd="fnm__list__remote"
                ;;
            fnm,ls)
                cmd="fnm__list"
                ;;
            fnm,ls-remote)
                cmd="fnm__list__remote"
                ;;
            fnm,unalias)
                cmd="fnm__unalias"
                ;;
            fnm,uninstall)
                cmd="fnm__uninstall"
                ;;
            fnm,use)
                cmd="fnm__use"
                ;;
            fnm__help,alias)
                cmd="fnm__help__alias"
                ;;
            fnm__help,completions)
                cmd="fnm__help__completions"
                ;;
            fnm__help,current)
                cmd="fnm__help__current"
                ;;
            fnm__help,default)
                cmd="fnm__help__default"
                ;;
            fnm__help,env)
                cmd="fnm__help__env"
                ;;
            fnm__help,exec)
                cmd="fnm__help__exec"
                ;;
            fnm__help,help)
                cmd="fnm__help__help"
                ;;
            fnm__help,install)
                cmd="fnm__help__install"
                ;;
            fnm__help,list)
                cmd="fnm__help__list"
                ;;
            fnm__help,list-remote)
                cmd="fnm__help__list__remote"
                ;;
            fnm__help,unalias)
                cmd="fnm__help__unalias"
                ;;
            fnm__help,uninstall)
                cmd="fnm__help__uninstall"
                ;;
            fnm__help,use)
                cmd="fnm__help__use"
                ;;
            *)
                ;;
        esac
    done

    case "${cmd}" in
        fnm)
            opts="-h -V --node-dist-mirror --fnm-dir --multishell-path --log-level --arch --version-file-strategy --corepack-enabled --resolve-engines --help --version list-remote list install use env completions alias unalias default current exec uninstall help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 1 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --node-dist-mirror)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --fnm-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --multishell-path)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --log-level)
                    COMPREPLY=($(compgen -W "quiet error info" -- "${cur}"))
                    return 0
                    ;;
                --arch)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --version-file-strategy)
                    COMPREPLY=($(compgen -W "local recursive" -- "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        alias)
            opts="-h -V --node-dist-mirror --fnm-dir --multishell-path --log-level --arch --version-file-strategy --corepack-enabled --resolve-engines --help --version list-remote list install use env completions alias unalias default current exec uninstall help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 1 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --node-dist-mirror)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --fnm-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --multishell-path)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --log-level)
                    COMPREPLY=($(compgen -W "quiet error info" -- "${cur}"))
                    return 0
                    ;;
                --arch)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --version-file-strategy)
                    COMPREPLY=($(compgen -W "local recursive" -- "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        completions)
            opts="-h -V --node-dist-mirror --fnm-dir --multishell-path --log-level --arch --version-file-strategy --corepack-enabled --resolve-engines --help --version list-remote list install use env completions alias unalias default current exec uninstall help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 1 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --node-dist-mirror)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --fnm-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --multishell-path)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --log-level)
                    COMPREPLY=($(compgen -W "quiet error info" -- "${cur}"))
                    return 0
                    ;;
                --arch)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --version-file-strategy)
                    COMPREPLY=($(compgen -W "local recursive" -- "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        current)
            opts="-h -V --node-dist-mirror --fnm-dir --multishell-path --log-level --arch --version-file-strategy --corepack-enabled --resolve-engines --help --version list-remote list install use env completions alias unalias default current exec uninstall help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 1 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --node-dist-mirror)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --fnm-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --multishell-path)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --log-level)
                    COMPREPLY=($(compgen -W "quiet error info" -- "${cur}"))
                    return 0
                    ;;
                --arch)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --version-file-strategy)
                    COMPREPLY=($(compgen -W "local recursive" -- "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        default)
            opts="-h -V --node-dist-mirror --fnm-dir --multishell-path --log-level --arch --version-file-strategy --corepack-enabled --resolve-engines --help --version list-remote list install use env completions alias unalias default current exec uninstall help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 1 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --node-dist-mirror)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --fnm-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --multishell-path)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --log-level)
                    COMPREPLY=($(compgen -W "quiet error info" -- "${cur}"))
                    return 0
                    ;;
                --arch)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --version-file-strategy)
                    COMPREPLY=($(compgen -W "local recursive" -- "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        env)
            opts="-h -V --node-dist-mirror --fnm-dir --multishell-path --log-level --arch --version-file-strategy --corepack-enabled --resolve-engines --help --version list-remote list install use env completions alias unalias default current exec uninstall help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 1 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --node-dist-mirror)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --fnm-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --multishell-path)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --log-level)
                    COMPREPLY=($(compgen -W "quiet error info" -- "${cur}"))
                    return 0
                    ;;
                --arch)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --version-file-strategy)
                    COMPREPLY=($(compgen -W "local recursive" -- "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        exec)
            opts="-h -V --node-dist-mirror --fnm-dir --multishell-path --log-level --arch --version-file-strategy --corepack-enabled --resolve-engines --help --version list-remote list install use env completions alias unalias default current exec uninstall help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 1 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --node-dist-mirror)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --fnm-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --multishell-path)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --log-level)
                    COMPREPLY=($(compgen -W "quiet error info" -- "${cur}"))
                    return 0
                    ;;
                --arch)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --version-file-strategy)
                    COMPREPLY=($(compgen -W "local recursive" -- "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        fnm__help)
            opts="list-remote list install use env completions alias unalias default current exec uninstall help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        fnm__help__alias)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        fnm__help__completions)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        fnm__help__current)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        fnm__help__default)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        fnm__help__env)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        fnm__help__exec)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        fnm__help__help)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        fnm__help__install)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        fnm__help__list)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        fnm__help__list__remote)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        fnm__help__unalias)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        fnm__help__uninstall)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        fnm__help__use)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        install)
            opts="-h -V --node-dist-mirror --fnm-dir --multishell-path --log-level --arch --version-file-strategy --corepack-enabled --resolve-engines --help --version list-remote list install use env completions alias unalias default current exec uninstall help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 1 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --node-dist-mirror)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --fnm-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --multishell-path)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --log-level)
                    COMPREPLY=($(compgen -W "quiet error info" -- "${cur}"))
                    return 0
                    ;;
                --arch)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --version-file-strategy)
                    COMPREPLY=($(compgen -W "local recursive" -- "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        list)
            opts="-h -V --node-dist-mirror --fnm-dir --multishell-path --log-level --arch --version-file-strategy --corepack-enabled --resolve-engines --help --version list-remote list install use env completions alias unalias default current exec uninstall help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 1 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --node-dist-mirror)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --fnm-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --multishell-path)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --log-level)
                    COMPREPLY=($(compgen -W "quiet error info" -- "${cur}"))
                    return 0
                    ;;
                --arch)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --version-file-strategy)
                    COMPREPLY=($(compgen -W "local recursive" -- "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        list__remote)
            opts="-h -V --node-dist-mirror --fnm-dir --multishell-path --log-level --arch --version-file-strategy --corepack-enabled --resolve-engines --help --version list-remote list install use env completions alias unalias default current exec uninstall help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 1 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --node-dist-mirror)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --fnm-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --multishell-path)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --log-level)
                    COMPREPLY=($(compgen -W "quiet error info" -- "${cur}"))
                    return 0
                    ;;
                --arch)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --version-file-strategy)
                    COMPREPLY=($(compgen -W "local recursive" -- "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        unalias)
            opts="-h -V --node-dist-mirror --fnm-dir --multishell-path --log-level --arch --version-file-strategy --corepack-enabled --resolve-engines --help --version list-remote list install use env completions alias unalias default current exec uninstall help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 1 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --node-dist-mirror)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --fnm-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --multishell-path)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --log-level)
                    COMPREPLY=($(compgen -W "quiet error info" -- "${cur}"))
                    return 0
                    ;;
                --arch)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --version-file-strategy)
                    COMPREPLY=($(compgen -W "local recursive" -- "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        uninstall)
            opts="-h -V --node-dist-mirror --fnm-dir --multishell-path --log-level --arch --version-file-strategy --corepack-enabled --resolve-engines --help --version list-remote list install use env completions alias unalias default current exec uninstall help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 1 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --node-dist-mirror)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --fnm-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --multishell-path)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --log-level)
                    COMPREPLY=($(compgen -W "quiet error info" -- "${cur}"))
                    return 0
                    ;;
                --arch)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --version-file-strategy)
                    COMPREPLY=($(compgen -W "local recursive" -- "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        use)
            opts="-h -V --node-dist-mirror --fnm-dir --multishell-path --log-level --arch --version-file-strategy --corepack-enabled --resolve-engines --help --version list-remote list install use env completions alias unalias default current exec uninstall help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 1 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --node-dist-mirror)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --fnm-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --multishell-path)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --log-level)
                    COMPREPLY=($(compgen -W "quiet error info" -- "${cur}"))
                    return 0
                    ;;
                --arch)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --version-file-strategy)
                    COMPREPLY=($(compgen -W "local recursive" -- "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
    esac
}

complete -F _fnm -o bashdefault -o default fnm
