
function Transmissao_COERENTE_por_δ₀(delta_range,delta_min, delta_max, Transmissao)
    gr()
    theme(:vibrant)

    plot(delta_range, Transmissao, 
    size = (tamanho+100, 3*tamanho/4),
    left_margin = 10Plots.mm,
    right_margin = 12Plots.mm,
    top_margin = 5Plots.mm,
    bottom_margin = 5Plots.mm, 
    gridalpha = 0,
    label = "",
    title = L"\textrm{Transmissão x Detuning}",
    yscale = :log10,
    legendfontsize = 20,
    labelfontsize = 25,
    titlefontsize = 30,
    tickfontsize = 15, 
    xticks = collect(delta_min:5:delta_max),
    ms = 4,
    framestyle = :box,
    lw = 5,
    c = :green
    )
    xlabel!(L"$\delta_{0} $")
    ylabel!(L"$T_{Coerente}$")
end


function Transmissao_DIFUSA_por_δ₀(delta_range,delta_min, delta_max, Transmissao)
    gr()
    theme(:vibrant)

    plot(delta_range, Transmissao, 
    size = (tamanho+100, 3*tamanho/4),
    left_margin = 10Plots.mm,
    right_margin = 12Plots.mm,
    top_margin = 5Plots.mm,
    bottom_margin = 5Plots.mm, 
    gridalpha = 0,
    label = "",
    title = L"\textrm{Transmissão x Detuning}",
    yscale = :log10,
    legendfontsize = 20,
    labelfontsize = 25,
    titlefontsize = 30,
    tickfontsize = 15, 
    xticks = collect(delta_min:5:delta_max),
    ms = 4,
    framestyle = :box,
    lw = 5,
    c = :green
    )
    xlabel!(L"$\delta_{0} $")
    ylabel!(L"$T_{Difusa}$")
end


function Transmissao_BL_por_δ₀(delta_range,delta_min, delta_max, Transmissao)
    gr()
    theme(:vibrant)

    plot(delta_range, Transmissao, 
    size = (tamanho+100, 3*tamanho/4),
    left_margin = 10Plots.mm,
    right_margin = 12Plots.mm,
    top_margin = 5Plots.mm,
    bottom_margin = 5Plots.mm, 
    gridalpha = 0,
    label = "",
    title = L"\textrm{Transmissão x Detuning}",
    yscale = :log10,
    legendfontsize = 20,
    labelfontsize = 25,
    titlefontsize = 30,
    tickfontsize = 15, 
    xticks = collect(delta_min:5:delta_max),
    ms = 4,
    framestyle = :box,
    lw = 5,
    c = :green
    )
    xlabel!(L"$\delta_{0} $")
    ylabel!(L"$T_{B-L}$")
end


function Transmissoes_por_δ₀(delta_range,delta_min, delta_max, Transmissao1, Transmissao2, Transmissao3, Transmissao4)
        
    gr()
    theme(:vibrant)

    plot(delta_range, Transmissao1, 
    size = (tamanho+100, 3*tamanho/4),
    left_margin = 10Plots.mm,
    right_margin = 12Plots.mm,
    top_margin = 5Plots.mm,
    bottom_margin = 5Plots.mm, 
    gridalpha = 0,
    #title = L"\textrm{Transmissão x Detuning}",
    yscale = :log10,
    legendfontsize = 20,
    labelfontsize = 25,
    titlefontsize = 30,
    tickfontsize = 15, 
    xticks = collect(delta_min:5:delta_max),
    ms = 4,
    ylims = (10^-3,10^0),
    xlims = (0,20),
    framestyle = :box,
    lw = 2,
    label = "Coherent",
    c = :green
    )
    plot!(delta_range, Transmissao2, 
    size = (tamanho+100, 3*tamanho/4),
    left_margin = 10Plots.mm,
    right_margin = 12Plots.mm,
    top_margin = 5Plots.mm,
    bottom_margin = 5Plots.mm, 
    gridalpha = 0,
    #title = L"\textrm{Transmissão x Detuning}",
    yscale = :log10,
    legendfontsize = 20,
    labelfontsize = 25,
    titlefontsize = 30,
    tickfontsize = 15, 
    xticks = collect(delta_min:5:delta_max),
    ms = 4,
    ylims = (10^-3,10^0),
    xlims = (0,20),
    framestyle = :box,
    lw = 2,
    label = "Diffuse",
    c = :red
    )
    plot!(delta_range, Transmissao3, 
    size = (tamanho+100, 3*tamanho/4),
    left_margin = 10Plots.mm,
    right_margin = 12Plots.mm,
    top_margin = 5Plots.mm,
    bottom_margin = 5Plots.mm, 
    gridalpha = 0,
    #title = L"\textrm{Transmissão x Detuning}",
    yscale = :log10,
    legendfontsize = 20,
    labelfontsize = 25,
    titlefontsize = 30,
    tickfontsize = 15, 
    xticks = collect(delta_min:5:delta_max),
    ms = 4,
    ylims = (10^-3,10^0),
    xlims = (0,20),
    framestyle = :box,
    lw = 2,
    label = "B-L",
    c = :blue
    )
    plot!(delta_range, Transmissao4, 
    size = (tamanho+100, 3*tamanho/4),
    left_margin = 10Plots.mm,
    right_margin = 12Plots.mm,
    top_margin = 5Plots.mm,
    bottom_margin = 5Plots.mm, 
    gridalpha = 0,
    title = L"\textrm{Transmissão x Detuning}",
    yscale = :log10,
    legendfontsize = 20,
    labelfontsize = 25,
    titlefontsize = 30,
    tickfontsize = 15, 
    xticks = collect(delta_min:5:delta_max),
    ms = 4,
    ylims = (10^-3,10^0),
    xlims = (0,20),
    framestyle = :box,
    lw = 2,
    label = "Ohm",
    c = :black
    )
    xlabel!(L"$\delta_{0} $")
    ylabel!(L"$T$")
        
    savefig("vec_T x delta0_1_N{$N}_Densidade={$ρ}_K={$k}.png")
end


function Transmissoes_por_b(b,delta_min, delta_max, Transmissao1, Transmissao2, Transmissao3, Transmissao4)
        
    gr()
    theme(:vibrant)
        
    plot(b, Transmissao1, 
    size = (tamanho+100, 3*tamanho/4),
    left_margin = 10Plots.mm,
    right_margin = 12Plots.mm,
    top_margin = 5Plots.mm,
    bottom_margin = 5Plots.mm, 
    gridalpha = 0,
    #title = L"\textrm{Transmissão x Detuning}",
    yscale = :log10,
    legendfontsize = 20,
    labelfontsize = 25,
    titlefontsize = 30,
    tickfontsize = 15, 
    xticks = collect(delta_min:5:delta_max),
    ms = 4,
    ylims = (10^-3,10^0),
    xlims = (0,20),
    framestyle = :box,
    lw = 3,
    label = "Coherent",
    c = :green
    )
    plot!(b, Transmissao2, 
    size = (tamanho+100, 3*tamanho/4),
    left_margin = 10Plots.mm,
    right_margin = 12Plots.mm,
    top_margin = 5Plots.mm,
    bottom_margin = 5Plots.mm, 
    gridalpha = 0,
    #title = L"\textrm{Transmissão x Detuning}",
    yscale = :log10,
    legendfontsize = 20,
    labelfontsize = 25,
    titlefontsize = 30,
    tickfontsize = 15, 
    xticks = collect(delta_min:5:delta_max),
    ms = 4,
    ylims = (10^-3,10^0),
    xlims = (0,20),
    framestyle = :box,
    lw = 3,
    label = "Diffuse",
    c = :red
    )
    plot!(b, Transmissao3, 
    size = (tamanho+100, 3*tamanho/4),
    left_margin = 10Plots.mm,
    right_margin = 12Plots.mm,
    top_margin = 5Plots.mm,
    bottom_margin = 5Plots.mm, 
    gridalpha = 0,
    #title = L"\textrm{Transmissão x Detuning}",
    yscale = :log10,
    legendfontsize = 20,
    labelfontsize = 25,
    titlefontsize = 30,
    tickfontsize = 15, 
    xticks = collect(delta_min:5:delta_max),
    ms = 4,
    ylims = (10^-3,10^0),
    xlims = (0,20),
    framestyle = :box,
    lw = 3,
    label = "B-L",
    c = :blue
    )
    plot!(b, Transmissao4, 
    size = (tamanho+100, 3*tamanho/4),
    left_margin = 10Plots.mm,
    right_margin = 12Plots.mm,
    top_margin = 5Plots.mm,
    bottom_margin = 5Plots.mm, 
    gridalpha = 0,
    title = L"\textrm{Transmissão x Detuning}",
    yscale = :log10,
    legendfontsize = 20,
    labelfontsize = 25,
    titlefontsize = 30,
    tickfontsize = 15, 
    xticks = collect(delta_min:5:delta_max),
    ms = 4,
    ylims = (10^-3,10^0),
    xlims = (0,20),
    framestyle = :box,
    lw = 3,
    label = "Ohm",
    c = :black
    )
    xlabel!(L"$b$")
    ylabel!(L"$T$")
    savefig("vec_T x delta0_2_N{$N}_Densidade={$ρ}_K={$k}.png")
end


function Transmissoes_por_b_log(b,delta_min, delta_max, Transmissao1, Transmissao2, Transmissao3, Transmissao4)
        
    gr()
    theme(:vibrant)
        
    plot(b, Transmissao1, 
    size = (tamanho+100, 3*tamanho/4),
    left_margin = 10Plots.mm,
    right_margin = 12Plots.mm,
    top_margin = 5Plots.mm,
    bottom_margin = 5Plots.mm, 
    gridalpha = 0,
    #title = L"\textrm{Transmissão x Detuning}",
    xscale = :log10,
    yscale = :log10,
    legendfontsize = 20,
    labelfontsize = 25,
    titlefontsize = 30,
    tickfontsize = 15, 
    xticks = [10^-2,10^-1,10^0,10^1,10^2],
    ms = 4,
    ylims = (10^-4,10^0),
    xlims = (10^-2,10^2),
    framestyle = :box,
    lw = 3,
    label = "Coherent",
    c = :green
    )
    plot!(b, Transmissao2, 
    size = (tamanho+100, 3*tamanho/4),
    left_margin = 10Plots.mm,
    right_margin = 12Plots.mm,
    top_margin = 5Plots.mm,
    bottom_margin = 5Plots.mm, 
    gridalpha = 0,
    #title = L"\textrm{Transmissão x Detuning}",
    xscale = :log10,
    yscale = :log10,
    legendfontsize = 20,
    labelfontsize = 25,
    titlefontsize = 30,
    tickfontsize = 15, 
    xticks = [10^-2,10^-1,10^0,10^1,10^2],
    ms = 4,
    ylims = (10^-4,10^0),
    xlims = (10^-2,10^2),
    framestyle = :box,
    lw = 3,
    label = "Diffuse",
    c = :red
    )
    plot!(b, Transmissao3, 
    size = (tamanho+100, 3*tamanho/4),
    left_margin = 10Plots.mm,
    right_margin = 12Plots.mm,
    top_margin = 5Plots.mm,
    bottom_margin = 5Plots.mm, 
    gridalpha = 0,
    #title = L"\textrm{Transmissão x Detuning}",
    xscale = :log10,
    yscale = :log10,
    legendfontsize = 20,
    labelfontsize = 25,
    titlefontsize = 30,
    tickfontsize = 15, 
    xticks = [10^-2,10^-1,10^0,10^1,10^2],
    ms = 4,
    ylims = (10^-4,10^0),
    xlims = (10^-2,10^2),
    framestyle = :box,
    lw = 3,
    label = "B-L",
    c = :blue
    )
    plot!(b, Transmissao4, 
    size = (tamanho+100, 3*tamanho/4),
    left_margin = 10Plots.mm,
    right_margin = 12Plots.mm,
    top_margin = 5Plots.mm,
    bottom_margin = 5Plots.mm, 
    gridalpha = 0,
    title = L"\textrm{Transmissão x Detuning}",
    xscale = :log10,
    yscale = :log10,
    legendfontsize = 20,
    labelfontsize = 25,
    titlefontsize = 30,
    tickfontsize = 15, 
    xticks = [10^-2,10^-1,10^0,10^1,10^2],
    ms = 4,
    ylims = (10^-4,10^0),
    xlims = (10^-2,10^2),
    framestyle = :box,
    lw = 3,
    label = "Ohm",
    c = :black
    )
    xlabel!(L"$b$")
    ylabel!(L"$T$")
    savefig("T x b2_N{$N}_Densidade={$ρ}_K={$k}.png")
end

function Transmissoes_por_b_lin(b,delta_min, delta_max, Transmissao1, Transmissao2, Transmissao3, Transmissao4)
        
    gr()
    theme(:vibrant)
        
    plot(b, Transmissao1, 
    size = (tamanho+100, 3*tamanho/4),
    left_margin = 10Plots.mm,
    right_margin = 12Plots.mm,
    top_margin = 5Plots.mm,
    bottom_margin = 5Plots.mm, 
    gridalpha = 0,
    #title = L"\textrm{Transmissão x Detuning}",
    legendfontsize = 20,
    labelfontsize = 25,
    titlefontsize = 30,
    tickfontsize = 15, 
    xticks = collect(delta_min:5:delta_max),
    xlims = (0,40),
    ylims = (0,1),
    ms = 4,
    framestyle = :box,
    lw = 3,
    label = "Coherent",
    c = :green
    )
    plot!(b, Transmissao2, 
    size = (tamanho+100, 3*tamanho/4),
    left_margin = 10Plots.mm,
    right_margin = 12Plots.mm,
    top_margin = 5Plots.mm,
    bottom_margin = 5Plots.mm, 
    gridalpha = 0,
    #title = L"\textrm{Transmissão x Detuning}",
    legendfontsize = 20,
    labelfontsize = 25,
    titlefontsize = 30,
    tickfontsize = 15, 
    xticks = collect(delta_min:5:delta_max),
    ylims = (0,1),
    xlims = (0,40),
    ms = 4,
    framestyle = :box,
    lw = 3,
    label = "Diffuse",
    c = :red
    )
    plot!(b, Transmissao3, 
    size = (tamanho+100, 3*tamanho/4),
    left_margin = 10Plots.mm,
    right_margin = 12Plots.mm,
    top_margin = 5Plots.mm,
    bottom_margin = 5Plots.mm, 
    gridalpha = 0,
    #title = L"\textrm{Transmissão x Detuning}",
    legendfontsize = 20,
    labelfontsize = 25,
    titlefontsize = 30,
    tickfontsize = 15, 
    xticks = collect(delta_min:5:delta_max),
    ylims = (0,1),
    xlims = (0,40),
    ms = 4,
    framestyle = :box,
    lw = 3,
    label = "B-L",
    c = :blue
    )
    plot!(b, Transmissao4, 
    size = (tamanho+100, 3*tamanho/4),
    left_margin = 10Plots.mm,
    right_margin = 12Plots.mm,
    top_margin = 5Plots.mm,
    bottom_margin = 5Plots.mm, 
    gridalpha = 0,
    title = L"\textrm{Transmissão x Detuning}",
    legendfontsize = 20,
    labelfontsize = 25,
    titlefontsize = 30,
    tickfontsize = 15, 
    xticks = collect(delta_min:5:delta_max),
    ylims = (0,1),
    xlims = (0,40),
    ms = 4,
    framestyle = :box,
    lw = 3,
    label = "Ohm",
    c = :black
    )
    
    xlabel!(L"$b$")
    ylabel!(L"$T$")
    savefig("T x b3_N{$N}_Densidade={$ρ}_K={$k}.png")
end


function Transmissoes_por_X(delta_range,delta_min, delta_max, Transmissao1, Transmissao2, Transmissao3)
        
    gr()
    theme(:vibrant)

    plot(delta_range, Transmissao1, 
    size = (tamanho+100, 3*tamanho/4),
    left_margin = 10Plots.mm,
    right_margin = 12Plots.mm,
    top_margin = 5Plots.mm,
    bottom_margin = 5Plots.mm, 
    gridalpha = 0,
    #title = L"\textrm{Transmissão x Detuning}",
    legendfontsize = 20,
    labelfontsize = 25,
    titlefontsize = 30,
    tickfontsize = 15, 
    xticks = collect(delta_min:5:delta_max),
    ms = 4,
    framestyle = :box,
    lw = 2,
    label = "Coherent",
    c = :green
    )
    plot!(delta_range, Transmissao2, 
    size = (tamanho+100, 3*tamanho/4),
    left_margin = 10Plots.mm,
    right_margin = 12Plots.mm,
    top_margin = 5Plots.mm,
    bottom_margin = 5Plots.mm, 
    gridalpha = 0,
    #title = L"\textrm{Transmissão x Detuning}",
    legendfontsize = 20,
    labelfontsize = 25,
    titlefontsize = 30,
    tickfontsize = 15, 
    xticks = collect(delta_min:5:delta_max),
    ms = 4,
    framestyle = :box,
    lw = 2,
    label = "Diffuse",
    c = :red
    )
    plot!(delta_range, Transmissao3, 
    size = (tamanho+100, 3*tamanho/4),
    left_margin = 10Plots.mm,
    right_margin = 12Plots.mm,
    top_margin = 5Plots.mm,
    bottom_margin = 5Plots.mm, 
    gridalpha = 0,
    #title = L"\textrm{Transmissão x Detuning}",
    legendfontsize = 20,
    labelfontsize = 25,
    titlefontsize = 30,
    tickfontsize = 15, 
    xticks = collect(delta_min:5:delta_max),
    ms = 4,
    framestyle = :box,
    lw = 2,
    label = "B-L",
    c = :blue
    )
    xlabel!(L"$L$")
    ylabel!(L"$T$")
        
    savefig("T x X, Δ={$Δ},Densidade={$ρ}_K={$k}.png")
end

function Transmissoes_por_Y(delta_range,delta_min, delta_max, Transmissao1, Transmissao2, Transmissao3)
        
    gr()
    theme(:vibrant)

    plot(delta_range, Transmissao1, 
    size = (tamanho+100, 3*tamanho/4),
    left_margin = 10Plots.mm,
    right_margin = 12Plots.mm,
    top_margin = 5Plots.mm,
    bottom_margin = 5Plots.mm, 
    gridalpha = 0,
    #title = L"\textrm{Transmissão x Detuning}",
    legendfontsize = 20,
    labelfontsize = 25,
    titlefontsize = 30,
    tickfontsize = 15, 
    xticks = collect(delta_min:5:delta_max),
    ms = 4,
    framestyle = :box,
    lw = 2,
    label = "Coherent",
    c = :green
    )
    plot!(delta_range, Transmissao2, 
    size = (tamanho+100, 3*tamanho/4),
    left_margin = 10Plots.mm,
    right_margin = 12Plots.mm,
    top_margin = 5Plots.mm,
    bottom_margin = 5Plots.mm, 
    gridalpha = 0,
    #title = L"\textrm{Transmissão x Detuning}",
    legendfontsize = 20,
    labelfontsize = 25,
    titlefontsize = 30,
    tickfontsize = 15, 
    xticks = collect(delta_min:5:delta_max),
    ms = 4,
    framestyle = :box,
    lw = 2,
    label = "Diffuse",
    c = :red
    )
    plot!(delta_range, Transmissao3, 
    size = (tamanho+100, 3*tamanho/4),
    left_margin = 10Plots.mm,
    right_margin = 12Plots.mm,
    top_margin = 5Plots.mm,
    bottom_margin = 5Plots.mm, 
    gridalpha = 0,
    #title = L"\textrm{Transmissão x Detuning}",
    legendfontsize = 20,
    labelfontsize = 25,
    titlefontsize = 30,
    tickfontsize = 15, 
    xticks = collect(delta_min:5:delta_max),
    ms = 4,
    framestyle = :box,
    lw = 2,
    label = "B-L",
    c = :blue
    )
    xlabel!(L"$l$")
    ylabel!(L"$T$")
        
    savefig("T x Y, Δ={$Δ}, N={$N}_Densidade={$ρ}_K={$k}.png")
end

function Autoval_real_por_imag(gamma, delta)
    
    gr()
    theme(:vibrant)
   
    tamanho = 1000;
    scatter(delta, gamma, 
    size = (tamanho+100, 3*tamanho/4),
    left_margin = 10Plots.mm,
    right_margin = 12Plots.mm,
    top_margin = 5Plots.mm,
    bottom_margin = 5Plots.mm, 
    gridalpha = 0,
    #title = L"\textrm{Transmissão x Detuning}",
    yscale = :log10,
    legendfontsize = 20,
    labelfontsize = 25,
    titlefontsize = 30,
    tickfontsize = 15, 
    ms = 4,
    framestyle = :box,
    lw = 2,
    label = "",
    c = :green
    )
    xlabel!(L"$\Delta $")
    ylabel!(L"$\gamma $")
end