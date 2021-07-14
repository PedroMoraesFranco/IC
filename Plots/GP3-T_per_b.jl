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


N = 250                                                # Number of particles
X = 10                                                 # Length of Slab
Y = 200                                                 # Slab width
k = 1                                                   # Wave number - vetor
ω₀ = 6*π/k #Y/8                                         # Cintura 
vetor_onda = (1,0)                                      # Vetor da onda
ρ = N/(X*Y)                                             # Density
ρ_normalizado = N/(X*Y*k^2)                             # Density
c = 1                                                   # Density of modes
Γ₀ = 1                                                  # Decay rate
E₀ = Γ₀/1                                             # Amplitude do Campo incidente 
Nsensor = 1000                                          # Number of sensors 
Angulo_inicial_sensor = -90
Angulo_final_sensor = 270
angulo_controle = 30
b₀ = 4*N/(Y*k) #(4*X*ρ)/k;
Δ = 0;                   


#-Plot parameters-#

N_div = 100;
tamanho = 1000;
b_min = 0;
b_max = 20;
b_range = collect(range(b_min, b_max, length = N_div));
Transmissoes = zeros(N_div);
Transmissoes2 = zeros(N_div);
Transmissoes3 = zeros(N_div);
for i in 1:N_div
    b = b_range[i]

    Entrada_E3 = E1_transmissão_ENTRADA(
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

    resultados = E21_transmissão(Entrada_E3)
    Transmissoes[i] = resultados.T_COERENTE
    Transmissoes2[i] = resultados.T_DIFUSO
    Transmissoes3[i] = resultados.BL_law

end


gr()
theme(:vibrant)

plot(b_range, Transmissoes, 
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
xticks = collect(b_min:5:b_max),
ms = 4,
framestyle = :box,
lw = 5,
label = "Coherent",
c = :green
)
plot!(b_range, Transmissoes2, 
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
xticks = collect(b_min:5:b_max),
ms = 4,
framestyle = :box,
lw = 5,
label = "Diffuse",
c = :red
)
plot!(b_range, Transmissoes3, 
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
xticks = collect(b_min:5:b_max),
ms = 4,
framestyle = :box,
lw = 5,
label = "B-L",
c = :blue
)
xlabel!(L"$b$")
ylabel!(L"$T$")