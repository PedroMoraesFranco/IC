
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
include("Programas base\\P3-ELs.jl");
include("Programas base\\P4-Intensidade-escalar.jl");
include("Programas base\\P6-Beer_Lambert_law.jl");
include("Extração/E2-transmissão-escalar.jl")

#-Data-#


N = 250                                               # Number of particles
X = 100                                                 # Length of Slab
Y = 200                                                 # Slab width
k = 1                                                   # Wave number - vetor
ω₀ = 6*π/k #Y/8                                         # Cintura 
vetor_onda = (1,0)                                      # Vetor da onda
ρ = N/(X*Y)                                             # Density
ρ_normalizado = N/(X*Y*k^2)                             # Density
c = 1                                                   # Density of modes
Γ₀ = 1                                                  # Decay rate
Γ1 = Γ₀/2
E₀ = Γ₀/1                                             # Amplitude do Campo incidente 
Nsensor = 1000                                          # Number of sensors 
Angulo_inicial_sensor = -90
Angulo_final_sensor = 270
angulo_controle = 30
b₀ = 4*N/(Y*k) #(4*X*ρ)/k;
Δ = 0;                                                   # Detuning - indicador de pertubação 

#-Plot parameters-#

N_div = 10000;
tamanho = 1000;
delta_min = 0;
delta_max = 100;
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
        b₀
    )

    resultados = E2_transmissão(Entrada_E1)
    Transmissoes[i] = resultados.T_COERENTE
    Transmissoes2[i] = resultados.T_DIFUSO
    Transmissoes3[i] = resultados.BL_law
    b[i] = b₀/(4*(Δ^2)+1)

end

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
lw = 2,
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
lw = 2,
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
lw = 2,
label = "B-L",
c = :blue
)
xlabel!(L"$\delta_{0} $")
ylabel!(L"$T$")

savefig("T x delta0_1_N{$N}_Densidade={$ρ}_K={$k}.png")

plot(b, Transmissoes, 
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
lw = 3,
label = "Coherent",
c = :green
)
plot!(b, Transmissoes2, 
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
lw = 3,
label = "Diffuse",
c = :red
)
plot!(b, Transmissoes3, 
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
lw = 3,
label = "B-L",
c = :blue
)
xlabel!(L"$b$")
ylabel!(L"$T$")
#
savefig("T x delta0_2_N{$N}_Densidade={$ρ}_K={$k}.png")