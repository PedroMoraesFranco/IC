
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
include("Estrutura de dados/EsDados.jl");

#-Data-#

N = 250                                                # Number of particles
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
b₀ = 20#4*N/(Y*k) #(4*X*ρ)/k;
Δ = 0;                                                   # Detuning - indicador de pertubação 


function get_slab(N,X,Y)
    x_atoms = -X*rand(N) .+ X/2; #Atoms positions (x-axis)
    y_atoms = -Y*rand(N) .+ Y/2; #Atoms positions (y-axis)
    r = zeros(N,2);
    r[:,1] = x_atoms;
    r[:,2] = y_atoms;
    return r
end

function get_Φ(r)
    N = size(r,1)
    x = r[:,1]
    y = r[:,2]
    Φ = zeros(N)
    for j in N
        Φ = atan(y[j]/x[j])        
    end
    return Φ
end


function get_matrix_H0(N,k,rij)
    G = Array{Complex{Float64}}(undef,N,N);
    @. G = SpecialFunctions.besselh(0,1,k*rij); # Scalar Green matrix
    G[LinearAlgebra.diagind(G)].= 1; #main diagonal 
    return G
end


function get_matrix_H2_plus(N,k,rij,Φ)
    G_plus = Array{Complex{Float64}}(undef,N,N);
    @. G_plus = exp(2im*Φ)*SpecialFunctions.besselh(2,1,k*rij);
    G_plus[LinearAlgebra.diagind(G_plus)].= 0; #main diagonal 
    return G_plus
end


function get_matrix_H2_minus(N,k,rij,Φ)
    G_minus = Array{Complex{Float64}}(undef,N,N);
    @. G_minus = exp(-2im*Φ)*SpecialFunctions.besselh(2,1,k*rij);
    G_minus[LinearAlgebra.diagind(G_minus)].= 0; #main diagonal 
    return G_minus
end

function get_green_matrix(N,k,rij,Δ,Γ1,Φ)
    H0 = get_matrix_H0(N,k,rij)
    H2plus = get_matrix_H2_plus(N,k,rij,Φ)
    H2minus = get_matrix_H2_minus(N,k,rij,Φ)
    G = [H0 H2plus; H2minus H0]
    

    Fator_iΔ = zeros(ComplexF64, 2N, 2N)
    Fator_iΔ[LinearAlgebra.diagind(Fator_iΔ)].= 1im*Δ;
    Matrix_G = G*(-Γ1/2)-Fator_iΔ
    return Matrix_G
end

function get_cloud_vetorial(N, X, Y, k,Δ, Γ₀,Γ1)
    r = get_slab(N,X,Y)
    Φ = get_Φ(r)
    rij = Distances.pairwise(Euclidean(), r, r, dims = 1);
    G = get_green_matrix(N,k,rij,Δ,Γ1,Φ)
    #λ, ψ  = LinearAlgebra.eigen(G); #Eingenvalues and eigensvectors
    return r, rij, G
end

function get_β(G,EL_atoms)
    β = G\((1im/2)*EL_atoms)
    return β
end

function get_sensors(X::Number, Y::Number, ω₀::Number, k::Number, Angulo_inicial_sensor::Number, Angulo_final_sensor::Number, Nsensor::Number)
    meia_diagonal = sqrt((X/2)^2 +(Y/2)^2);
    raio = (X/2 + meia_diagonal)/2;

    comprimento_de_ray = (k*ω₀^2)/2;
    D_sensor = 10*raio + comprimento_de_ray;

    θ = collect(range(Angulo_inicial_sensor, Angulo_final_sensor, length = Nsensor))
    x_sensor = D_sensor*cosd.(θ)
    y_sensor = D_sensor*sind.(θ)


    Sensores = zeros(Nsensor,4);
    Sensores[:,1] .= D_sensor;
    Sensores[:,2] = θ;
    Sensores[:,3] = x_sensor;
    Sensores[:,4] = y_sensor;
    return Sensores
end

function get_EL(position::Array, E₀::Number , ω₀::Number, k::Number) #beam equation for atoms
    N = size(position,1);
    x = position[:,1];
    y = position[:,2];
    Campo = Array{Complex{Float64}}(undef,N);
    for i in 1:N
        α = ((2*x[i])/(k*(ω₀^2)))
        termo_1 = E₀/sqrt(1 + 1im*α)
        termo_exp = 1im*k*x[i] - (y[i]^2)/((ω₀^2)*(1 + 1im*α))
        Campo[i] = termo_1*exp(termo_exp)
    end
    return Campo
end

cloud = get_cloud_vetorial(N,X,Y,k,Δ,Γ₀,Γ1);
Sensores = get_sensors(X,Y,ω₀,k,Angulo_inicial_sensor,Angulo_final_sensor,Nsensor)
r = cloud[1]
EL =  get_EL(r,E₀,ω₀,k)
EL_plus = EL*1im/sqrt(2)
EL_minus = -EL*1im/sqrt(2)
EL_atoms = [EL_plus;EL_minus]
G = cloud[3]
β = get_β(G,EL_atoms)
β_plus = β[1:N,1]
β_minus = β[N+1:2N,1]