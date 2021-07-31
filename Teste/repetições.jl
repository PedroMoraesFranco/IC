
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
include("Programas base\\P4-Beer_Lambert_law.jl");
include("Extração\\E1-transmissão.jl");
include("Plots\\Plotter.jl");

#-Data-#


vec = 1

N = 500
X = 100
Y = 200
ρ = N/(X*Y)
rₘᵢₙ = 1/10*sqrt(ρ)                                       
k = 1                                                   # Wave number - vetor
ω₀ =  6*π/k#Y/10                                               # Cintura 
vetor_onda = (1,0)                                      # Vetor da onda
c = 1                                                   # Density of modes
Γ₀ = 1                                                  # Decay rate
E₀ = Γ₀/1#000                                            # Amplitude do Campo incidente 
Nsensor = 1000                                          # Number of sensors 
Angulo_inicial_sensor = -90
Angulo_final_sensor = 270
angulo_controle = 30
b₀ = 4*N/(Y*k)#(4*X*ρ)/k;
Δ = 0;                                                   # Detuning - indicador de pertubação 
Realizações = 10;
Reflection = 0; 

#-Plot parameters-#

N_div = 1000;
tamanho = 1000;
delta_min = -10;
delta_max = 10;
delta_range = collect(range(delta_min, delta_max, length = N_div)); #Colocar: delta em log 
T_DIFUSO = zeros(Realizações);
T_COERENTE = zeros(Realizações);
BL_law = zeros(Realizações);
Transmissoes = zeros(N_div);
Transmissoes2 = zeros(N_div);
Transmissoes3 = zeros(N_div);
b = zeros(N_div);
for j in 1:Realizações
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
        Reflection
    )
    if vec == 1
        resultados = E1_transmissão_vetorial(Entrada_E1)
    else 
        resultados = E1_transmissão_escalar(Entrada_E1)
    end
    T_DIFUSO[j] = resultados[1]
    T_COERENTE[j] = resultados[2]
    BL_law[j] = resultados[3]
    T_DIFUSO_medio = mean(T_DIFUSO)
    T_COERENTE_medio = mean(T_COERENTE)
    BL_law_medio = mean(BL_law)
    return T_COERENTE_medio, T_COERENTE_medio, BL_law_medio
end

plot(T_DIFUSO_medio)
plot!(T_COERENTE_medio)
plot!(BL_law_medio)