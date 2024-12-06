file_name = readline()

lines = readlines(file_name)

heigth, width = split(lines[begin]) |> x -> parse.(Int, x)

@show heigth, width

for line in lines[2:end]  # ファイルが2行未満でも安全
    name, x, y = split(line)
    x = parse(Int, x)
    y = parse(Int, y)

    @show name, x, y

    println(line)
end
