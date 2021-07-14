
#Using Packages
using Plots
using SpecialFunctions
using LinearAlgebra
using Distances
using Statistics
using ColorSchemes
using Trapz
using QuadGK
using LaTeXStrings

#-Modulos-#

include("Estrutura de dados/EsDados.jl");

include("Programas base\\P1-Criando nuvem.jl");
include("Programas base\\P2-sensores.jl");
include("Programas base\\P3-Intensidade.jl");
include("Programas base\\P6-Beer_Lambert_law.jl");
include("Extração/E1-transmissão.jl");

vec = 1
N = 500
ρ = 0.03
Y = 280
X = N/(ρ*Y)
rₘᵢₙ = 1/10*sqrt(ρ)                                       
k = 1                                                   # Wave number - vetor
ω₀ = Y/10                                               # Cintura 
vetor_onda = (1,0)                                      # Vetor da onda
c = 1                                                   # Density of modes
Γ₀ = 1                                                  # Decay rate
E₀ = Γ₀/1000                                            # Amplitude do Campo incidente 
Nsensor = 1000                                          # Number of sensors 
Angulo_inicial_sensor = 0
Angulo_final_sensor = 360
angulo_controle = 30
b₀ = 4*N/(Y*k)#(4*X*ρ)/k;
#Δ ;                                                   # Detuning - indicador de pertubação 


#-Plot parameters-#

N_div = 100;
tamanho = 1000;
delta_min = -20;
delta_max = 20;
delta_range = collect(range(delta_min, delta_max, length = N_div));
Transmissoes = zeros(N_div);
Transmissoes2 = zeros(N_div);
Transmissoes3 = zeros(N_div);
b = zeros(N_div);
for i in 1:N_div
    Δ = delta_range[i]

    Entrada_E1 = E1_transmissão_ENTRADA(
        N,
        X,
        Y, 
        ω₀,
        k,
        Γ₀, 
        E₀,
        Nsensor, 
        Angulo_inicial_sensor, 
        Angulo_final_sensor,
        Δ,
        angulo_controle,
        ρ,
        rₘᵢₙ,
        vec
    )

    resultados = E1_transmissão(Entrada_E1)
    Transmissoes[i] = resultados[1]
    Transmissoes2[i] = resultados[2]
    Transmissoes3[i] = resultados[3]
    b[i] = resultados[4]

end

#=
gr()
theme(:vibrant)

plot(delta_range, Transmissoes, 
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
ylabel!(L"$T_{coerente}$")



plot(delta_range, Transmissoes2, 
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
ylabel!(L"$T_{difusa}$")



plot(delta_range, Transmissoes3, 
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
ylabel!(L"$T_{BL}$")

=#
gr()
theme(:vibrant)

plot(delta_range, Transmissoes, 
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
framestyle = :box,
lw = 1,
label = "Coherent",
c = :green
)
plot!(delta_range, Transmissoes2, 
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
framestyle = :box,
lw = 1,
label = "Diffuse",
c = :red
)
plot!(delta_range, Transmissoes3, 
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
framestyle = :box,
lw = 1,
label = "B-L",
c = :blue
)
xlabel!(L"$\delta_{0} $")
ylabel!(L"$T$")
#
#savefig("T x delta0_6_N{$N}_Densidade={$ρ}_K={$k}.png")