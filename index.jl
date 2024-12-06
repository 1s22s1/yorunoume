using Plots

function main()
    height, width = parseints()
    file_name = parsestring()
    life_grid = reduce(hcat, [parseints() for _ ∈ 1:height])

    animation = @animate for i = 1:100
        heatmap(
            life_grid,
            colorbar = false,
            ticks = false,
            axis = false,
            fillcolor = cgrad(["#9BFCD3", "#900091"]),
        )

        life_grid = next(life_grid)
    end

    gif(animation, "$(file_name).gif", fps = 1000)
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
