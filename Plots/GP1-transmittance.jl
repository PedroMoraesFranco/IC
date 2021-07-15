
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


vec = 0

N = 200
X = 10
Y = 20
ρ = N/(X*Y)
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
b₀ = (4*X*ρ)/k;
#Δ ;                                                   # Detuning - indicador de pertubação 

#-Plot parameters-#

N_div = 100;
tamanho = 1000;
delta_min = 0;
delta_max = 10;
delta_range = collect(range(delta_min, delta_max, length = N_div)); #Colocar: delta em log 
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
        rₘᵢₙ
    )
    if vec == 1
        resultados = E1_transmissão_vetorial(Entrada_E1)
    else 
        resultados = E1_transmissão_escalar(Entrada_E1)
    end
    Transmissoes[i] = resultados[2]
    Transmissoes2[i] = resultados[1]
    Transmissoes3[i] = resultados[3]
    b[i] = 2/(16*(Δ^2)+1)
end
Transmissoes_por_δ₀(delta_range,delta_min, delta_max, Transmissoes, Transmissoes2, Transmissoes3)