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
include("Programas base\\P5-Intensidades-vetorial.jl");
include("Programas base\\P6-Beer_Lambert_law.jl");


#-Data-#


N = 200                                                # Number of particles
X = 10                                                  # Length of Slab
Y = 20                                                  # Slab width
k = 1                                                   # Wave number - vetor
ω₀ = 6*π/k #Y/8                                         # Cintura 
vetor_onda = (1,0)                                      # Vetor da onda
ρ = N/(X*Y)                                             # Density
ρ_normalizado = N/(X*Y*k^2)                             # Density
c = 1                                                   # Density of modes
Γ₀ = 1                                                  # Decay rate
Γ1 = Γ₀/2
E₀ = Γ₀/1                                               # Amplitude do Campo incidente 
Nsensor = 1000                                          # Number of sensors 
Angulo_inicial_sensor = -90
Angulo_final_sensor = 270
angulo_controle = 30
b₀ = 20#4*N/(Y*k) #(4*X*ρ)/k;
Δ = 5;                                                   # Detuning - indicador de pertubação 
#
r = get_Slab( N, X, Y );

Sensores = get_sensors(X,Y,ω₀,k,Angulo_inicial_sensor,Angulo_final_sensor,Nsensor)

sensores = zeros(Nsensor,2);
sensores[:,1] = Sensores[:,3];
sensores[:, 2] = Sensores[:,4];
theta = Sensores[:,2]
#Φ = get_Φ(r,sensores)
Φ = get_ϕ(r)
cloud = get_cloud_vetorial(N,k,Δ, Φ,Γ₀, r);
G = cloud[2]
#= 
entrada = get_cloud_ENTRADA(N,X,Y,k,Δ,Γ₀)
cloud = get_cloud_escalar(entrada)
G = cloud[3]
=#
A = LinearAlgebra.eigvals(G)
b = real(A)
gamma = abs.(b)
delta = imag(A)

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


#scatter(A)


EL = get_EL(r,E₀,ω₀,k)

EL_plus = EL*(1im/sqrt(2))
EL_minus = EL*(1im/sqrt(2))
EL_atoms = (1im/2)*([EL_plus;EL_minus])
β = get_β(G, EL_atoms)


I_Incidente = get_intensidade_laser(Sensores, k, E₀, ω₀)
I_espalhada =  get_intensidade_sensor(sensores, Γ₀, k,E₀, ω₀, β, r,Φ)
T_DIFUSO,T_COERENTE = get_transmition(I_espalhada, I_Incidente,Sensores, angulo_controle)

plot(theta,I_Incidente)
plot!(theta,I_espalhada)