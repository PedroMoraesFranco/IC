
#-Functions-#

function get_slab(Variaveis_entrada::get_slab_ENTRADA)
    x_atoms = -Variaveis_entrada.X*rand(Variaveis_entrada.N) .+ Variaveis_entrada.X/2; #Atoms positions (x-axis)
    y_atoms = -Variaveis_entrada.Y*rand(Variaveis_entrada.N) .+ Variaveis_entrada.Y/2; #Atoms positions (y-axis)
    r = zeros(Variaveis_entrada.N,2);
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
        Φ = atan((y[j])/(x[j]))        
    end
    return Φ
end

function get_matrix_H0()
    G = Array{Complex{Float64}}(undef,Variaveis_entrada.N,Variaveis_entrada.N);
    @. G = SpecialFunctions.besselh(0,1,Variaveis_entrada.k*Variaveis_entrada.rij); # Scalar Green matrix
    G[LinearAlgebra.diagind(G)].= 1; #main diagonal 
    return G
end

function get_matrix_H2_plus()
    G_plus = Array{Complex{Float64}}(undef,Variaveis_entrada.N,Variaveis_entrada.N);
    @. G_plus = exp(2im*Φ)*SpecialFunctions.besselh(2,1,Variaveis_entrada.k*Variaveis_entrada.rij);
    G_plus[LinearAlgebra.diagind(G_plus)].= 0; #main diagonal 
    return G_plus
end

function get_matrix_H2_minus()
    G_minus = Array{Complex{Float64}}(undef,Variaveis_entrada.N,Variaveis_entrada.N);
    @. G_minus = exp(-2im*Φ)*SpecialFunctions.besselh(2,1,Variaveis_entrada.k*Variaveis_entrada.rij);
    G_minus[LinearAlgebra.diagind(G_minus)].= 0; #main diagonal 
    return G_minus
end

function get_green_matrix()
    H0 = get_matrix_H0()
    H2plus = get_matrix_H2_plus()
    H2minus = get_matrix_H2_minus()
    G = [H0 H2plus; H2minus H0]
    

    Fator_iΔ = zeros(ComplexF64, N, N)
    Fator_iΔ[LinearAlgebra.diagind(Fator_iΔ)].= 1im*Δ;
    Matrix_G = G*(-Γ1/2)-Fator_iΔ
    return Matrix_G
end


function get_cloud()
    r = get_slab(Variaveis_entrada.N,Variaveis_entrada.X,Variaveis_entrada.Y)
    rij = Distances.pairwise(Euclidean(), r, r, dims = 1);
    Entrada_matrix_green = get_green_matrix_ENTRADA(Variaveis_entrada.N,Variaveis_entrada.k, rij,Variaveis_entrada.Δ,Variaveis_entrada.Γ₀)
    G = get_green_matrix()
    #λ, ψ  = LinearAlgebra.eigen(G); #Eingenvalues and eigensvectors
    return r, rij, G
end


function get_β(G::Array, EL_atoms::Array)
    β = G\((1im/2)*EL_atoms)
    return β
end
