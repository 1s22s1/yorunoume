using Plots

const OBJECT = Dict(
    "arcon" => [[0, 0], [-2, 1], [0, 1], [-1, 3], [0, 4], [0, 5], [0, 6]],
    "beacon" => [[0, 0], [1, 0], [0, 1], [1, 1], [-2, 2], [-1, 2], [-2, 3], [-1, 3]],
    "blinker" => [[0, 0], [0, 1], [0, 2]],
    "block" => [[0, 0], [0, 1], [1, 0], [1, 1]],
    "glider" => [[0, 0], [-2, 1], [0, 1], [-1, 2], [0, 2]],
    "pentomino" => [[0, 0], [-1, 1], [0, 1], [1, 1], [-1, 2]],
    "tab" => [[0, 0], [-1, 1], [1, 1], [0, 2]],
)

function main()
    file_name = readline()
    lines = readlines(file_name)
    height, width = split(lines[begin]) |> x -> parse.(Int, x)
    life_grid = zeros(Int, height, width)

    for line ∈ lines[2:end]
        name, x, y = split(line)
        x = parse(Int, x)
        y = parse(Int, y)

        place(name, x, y, life_grid)
    end

    animation = @animate for _ = 1:200
        heatmap(
            life_grid,
            colorbar = false,
            ticks = false,
            axis = false,
            fillcolor = cgrad(["#e7c7b3", "#12364d"]),
        )

        life_grid = next(life_grid)
    end

    gif(animation, "$(file_name).gif", fps = 1200)
end

function place(name, x, y, life_grid)
    for (i, j) ∈ OBJECT[name]
        life_grid[x+i, y+j] = 1
    end
end

function next(life_grid)
    height = size(life_grid, 1)
    width = size(life_grid, 2)

    next_grid = zeros(Int, height, width)

    for i ∈ 1:height, j ∈ 1:width
        count = 0

        for x ∈ [1, 0, -1]
            for y ∈ [1, 0, -1]
                if 1 ≤ i + x ≤ height &&
                   1 ≤ j + y ≤ width &&
                   !(x == 0 && y == 0) &&
                   life_grid[i+x, j+y] == 1

                    count += 1
                end
            end
        end

        if life_grid[i, j] == 1 && count ∈ [2, 3]
            next_grid[i, j] = 1
        elseif life_grid[i, j] == 0 && count == 3
            next_grid[i, j] = 1
        end
    end

    return deepcopy(next_grid)
end

parseints() = readline() |> split |> x -> parse.(Int, x)
parsestring() = readline()

main()
