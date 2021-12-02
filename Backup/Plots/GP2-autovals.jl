
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
include("Plots\\Plotter.jl");
include("Extração/E2-autoval.jl");

#-Data-#

vec = 1                                                             # vec = 1 -> vectorial case ### vec = 0 -> scalar case

N = 500                                                             # Number of atoms
X = 100                                                             # slab length
Y = 200                                                             # slab width 
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
b₀ = 4*N/(Y*k)#(4*X*ρ)/k;                                           # optical depth
Δ = 0;                                                              # Detuning - indicador de pertubação 

#-Plot parameters-#
Entrada_E2 =  E2_autoval_ENTRADA(
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
if vec == 1
    Matriz = E2_autoval_vetorial(Entrada_E2)
else 
    Matriz = E2_autoval_escalar(Entrada_E2)
end

Autoval_real_por_imag(Matriz[1],Matriz[2])