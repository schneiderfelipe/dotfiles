atreplinit() do repl
    for package in [:OhMyREPL, :Revise]
        try
            @eval using $(package)
        catch e
            @warn "error while importing $(package)" e
        end
    end
end
