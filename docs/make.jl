
using Documenter
import BusinessDays

makedocs(
    sitename = "BusinessDays.jl",
    modules = [ BusinessDays ],
    pages = [
        "Home" => "index.md",
        "API Reference" => "api.md",
    ],
    checkdocs=:none,
)

deploydocs(
    repo = "github.com/JuliaFinance/BusinessDays.jl.git",
    target = "build",
)
