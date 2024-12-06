using Plots

life_grid = nothing
height = nothing
width = nothing

function main()
    global height, width = parseints()
    file_name = parsestring()
    global life_grid = reduce(hcat, [parseints() for _ ∈ 1:height])

    animation = @animate for i = 1:100
        heatmap(
            life_grid,
            colorbar = false,
            ticks = false,
            axis = false,
            fillcolor = cgrad(:pink),
        )

        life_grid = next()
    end

    gif(animation, "$(file_name).gif", fps = 1000)
end

function next()
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
