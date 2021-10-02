
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
include("Programas base\\P5-ohm_law.jl");
include("Plots\\Plotter.jl");
include("Extração\\E1-transmissão.jl");

#-Data-#

vec = 0                                                             # vec = 1 -> vectorial case ### vec = 0 -> scalar case

ρ = 0.01                                                            # density
X = 100                                                             # slab length
Y = 200                                                             # slab width 
N = ρ*X*Y                                                           # Number of atoms
rₘᵢₙ = 1/10*sqrt(ρ);                                                 # minimum distance between   
k = 1                                                               # Wave number - vetor
ω₀ =  6*π/k#Y/10                                                    # Cintura 
vetor_onda = (1,0)                                                  # Vetor da onda
c = 1                                                               # Density of modes
Γ₀ = 1                                                              # Decay rate
E₀ = Γ₀/1#000                                                       # Amplitude do Campo incidente 
Nsensor = 1000                                                      # Number of sensors 
Angulo_inicial_sensor = -90                                         # initial angle of sensor
Angulo_final_sensor = 270                                           # final angle of sensor
angulo_controle = 30                                                # coehrent angle 
b₀ = 4*N/(Y*k)#(4*X*ρ)/k;                                           # optical depth
Δ = 0;                                                              # Detuning - indicador de pertubação 
Y_min = 100;                                                      # minimum Detuning
Y_max = 200;                                                     # maximum Detuning
N_div = 100;                                                        # number of divisions 
Y_range = collect(range(Y_min, Y_max, length = N_div)); # Detuning range
Reflection = 0                                                      # efficient reflection coefficient of the material
Realizações = 1                                                    # number of realizations 

#-Plot parameters-#

tamanho = 1000;                                                     # plot size

Transmissoes = zeros(N_div);
Transmissoes2 = zeros(N_div);
Transmissoes3 = zeros(N_div);
Transmissoes4 = zeros(N_div);
T_DIFUSO_medio = zeros(Realizações);
T_COERENTE_medio = zeros(Realizações);
BL_law_medio = zeros(Realizações);
ohm_law_medio = zeros(Realizações);
b = zeros(N_div);
for i in 1:N_div
    Y = Y_range[i]
    for j in 1:Realizações
        n = ρ*X*Y
        N = round(Int, n)
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
            δ₀ = Δ/Γ₀
            b[i] = 2*b₀/(16*(δ₀^2)+1)
        else 
            resultados = E1_transmissão_escalar(Entrada_E1)
            δ₀ = Δ/Γ₀
            b[i] = b₀/(4*(δ₀^2)+1)
        end
        T_DIFUSO_medio[j] = mean(abs(resultados[1])^2)
        T_COERENTE_medio[j] = abs(mean(resultados[2]))^2
        BL_law_medio[j] = mean(resultados[3])
        ohm_law_medio[j] = mean(resultados[4])
    end
    Transmissoes[i] = T_COERENTE_medio[1]
    Transmissoes2[i] = T_DIFUSO_medio[1]
    Transmissoes3[i] = BL_law_medio[1]
    Transmissoes4[i] = ohm_law_medio[1]
end