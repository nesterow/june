base_path = joinpath(dirname(@__FILE__), "..", "..", "local", "share", "julia")
ENV["JULIA_DEPOT_PATH"] = base_path

using Pkg; Pkg.activate(joinpath(base_path, "june"));
include(joinpath(base_path, "june", "src", "main.jl"))
exit(0)
