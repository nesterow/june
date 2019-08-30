base_path = joinpath(dirname(@__FILE__), "..", "..", "local", "share", "julia")

using Pkg; Pkg.activate(joinpath(base_path, "june"));
include(joinpath(base_path, "june", "src", "main.jl"))
exit(0)
