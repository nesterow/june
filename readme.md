JUNE
----
A starter template for building GUI applications with [Julia](https://julialang.org/) and [QML.jl](https://github.com/barche/QML.jl)

> Currently supported system is MacOS.  

## Dependencies

#### On MacOS
XCode tools and Brew are required
```bash
brew install qt gcc
git clone https://github.com/nesterow/june <ProjectName>
cd <ProjectName>
make mac
```

## Running program

#### 1. From Atom/REPL
Inside Julia REPL press `]` then input `activate .`
Then open `main.jl` and press start `▶️` button.

Alternatively in REPL:
```
julia> include("src/main.jl")
```

#### 2. From make
```
make run
```

## TODO
- Add build recipe for Debian
- Add build recipe for Linux ARM32


## ❤️ Contribute
Got a build recipe for your system? Please share!
- Fork repository
- Add bash script to `lib/build`
- Push your fix into a separate branch
- Make pull request to the `development` branch
