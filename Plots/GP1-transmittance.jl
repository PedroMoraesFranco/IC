using QuadGK: include

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
include("Programas base\\P5-ohm_law.jl")
include("Extração\\E1-transmissão.jl");
include("Plots\\Plotter.jl");

#-Data-#


vec = 0                                                             # vec = 1 -> vectorial case ### vec = 0 -> scalar case

N = 1000                                                            # Number of atoms
X = 100                                                             # slab length
Y = 100                                                             # slab width 
ρ = N/(X*Y)                                                         # density
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
b₀ = (4*N)/(Y*k)#(4*X*ρ)/k;                                         # optical depth
Δ = 0;                                                              # Detuning - indicador de pertubação 
delta_min = 0;                                                      # minimum Detuning
delta_max = 10;                                                     # maximum Detuning
N_div = 100;                                                        # number of divisions 
delta_range = collect(range(delta_min, delta_max, length = N_div)); # Detuning range
Reflection = 0                                                      # efficient reflection coefficient of the material
Realizações = 10                                                   # number of realizations 

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
    Δ = delta_range[i]
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
            δ₀ = Δ/Γ₀
            b[i] = 2*b₀/(16*(δ₀^2)+1)
        else 
            resultados = E1_transmissão_escalar(Entrada_E1)
            δ₀ = Δ/Γ₀
            b[i] = b₀/(4*(δ₀^2)+1)
        end
        T_DIFUSO_medio[j] = mean(resultados[1])
        T_COERENTE_medio[j] = mean(resultados[2])
        BL_law_medio[j] = mean(resultados[3])
        ohm_law_medio[j] = mean(resultados[4])
    end
    Transmissoes[i] = T_COERENTE_medio[1]
    Transmissoes2[i] = T_DIFUSO_medio[1]
    Transmissoes3[i] = BL_law_medio[1]
    Transmissoes4[i] = ohm_law_medio[1]
end
Transmissoes_por_δ₀(delta_range,delta_min, delta_max, Transmissoes, Transmissoes2, Transmissoes3, Transmissoes4)
Transmissoes_por_b(b,delta_min, delta_max, Transmissoes, Transmissoes2, Transmissoes3, Transmissoes4)