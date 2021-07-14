#Install Packages:

# using Pkg
# Pkg.add("Plots")
# Pkg.add("SpecialFunctions")
# Pkg.add("LinearAlgebra")
# Pkg.add("Distances")
# Pkg.add("Statistics")
# Pkg.add("ColorSchemes")
# Pkg.add("Trapz")
# Pkg.add("PyCall")
# Pkg.add("QuadGK")
# Pkg.add("LaTeXStrings")


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
include("Teste\\T1-Intensidade-escalar.jl");
include("Teste\\ET1-transmissão-escalar.jl")

#-Data-#

N = 250                                                # Number of particles
X = 10                                                 # Length of Slab
Y = 200                                                 # Slab width
ω₀ = Y/8                                                # Cintura 
k = 1                                                   # Wave number - vetor
vetor_onda = (1,0)                                      # Vetor da onda
ρ = N/(X*Y)                                             # Density
ρ_normalizado = N/(X*Y*k^2)                             # Density
c = 1                                                   # Density of modes
Γ₀ = 1                                                  # Decay rate
E₀ = Γ₀/100                                             # Amplitude do Campo incidente 
Nsensor = 1000                                          # Number of sensors 
Angulo_inicial_sensor = -90
Angulo_final_sensor = 270
Δ = 0                                                  # Detuning - indicador de pertubação 
angulo_controle = 30


Entrada_ET1 = E1_transmissão_ENTRADA(
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
    angulo_controle
)

resultados = ET1_transmissão(Entrada_ET1);

cloud = resultados.cloud;
r = cloud[1];
rij = cloud[2];
G = cloud[3];

sensores = resultados.Sensores

EL_atoms = resultados.EL_atoms;

β = resultados.β;

I_espalhada = resultados.I_espalhada;

I_EL = resultados.I_EL;

T_DIFUSO = resultados.T_DIFUSO
T_COERENTE = resultados.T_COERENTE


#scatter(sensores[:,3],sensores[:,4],aspect_ratio=:equal)

#index_sensor_coerente = findall(  (sensores[:,2] .≥ -angulo_controle).*(sensores[:,2] .≤ angulo_controle))
#scatter(sensores[index_sensor_coerente,3],sensores[index_sensor_coerente,4],aspect_ratio=:equal)


#index_sensor_difuso = findall(  (sensores[:,2] .≥ -90).*(sensores[:,2] .≤ 90))
#scatter(sensores[index_sensor_difuso,3],sensores[index_sensor_difuso,4],aspect_ratio=:equal)


#index_sensor_incidente = findall(  (sensores[:,2] .≥ 90).*(sensores[:,2] .≤ 270))
#scatter(sensores[index_sensor_incidente,3],sensores[index_sensor_incidente,4],aspect_ratio=:equal)























#Teste 
N_div = 100
tamanho = 1000
delta_min = 0
delta_max = 20
delta_range = collect(range(delta_min, delta_max, length = N_div))
Transmissoes = zeros(N_div)

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
        angulo_controle
    )

    resultados = ET1_transmissão(Entrada_E1)
    Transmissoes[i] = resultados.T_DIFUSO
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
xlabel!(L"$\Delta/\Gamma_0 $")
ylabel!(L"$T_{difuso}$")

savefig("T-escalar7_N{$N}_Densidade={$ρ}_K={$k}.png")