
# This script will generate a `userimg.jl` file.
# Append the generated `userimg.jl` file to your base/userimg.jl
# and build julia in order to add this package to your system image.

using SnoopCompile

compiles_csv = "compiles.csv"
SnoopCompile.@snoop compiles_csv begin
    include(Pkg.dir("BusinessDays", "test", "runtests.jl"))
end

blacklist = ["Base.Test", "yyyy-mm-dd", "CustomCalendar", "TestCalendar", "mm"]

data = SnoopCompile.read(compiles_csv)
pc = SnoopCompile.format_userimg(reverse!(data[2]), blacklist=blacklist)
unshift!(pc, "using BusinessDays")
SnoopCompile.write("userimg.jl", pc)
rm(compiles_csv)
