######################################################################################################################
######################################################## Slab ########################################################
######################################################################################################################
#=
function get_slab(Variaveis_entrada::get_slab_ENTRADA)    #Modificar colocando rₘᵢₙ 
    x_atoms = -Variaveis_entrada.X*rand(Variaveis_entrada.N) .+ Variaveis_entrada.X/2; #Atoms positions (x-axis)
    y_atoms = -Variaveis_entrada.Y*rand(Variaveis_entrada.N) .+ Variaveis_entrada.Y/2; #Atoms positions (y-axis)
    r = zeros(Variaveis_entrada.N,2);
    r[:,1] = x_atoms;
    r[:,2] = y_atoms;
    return r
end
=#

function getAtoms_distribution(N,rₘᵢₙ,L,Lₐ)#X,Y = L,Lₐ

    # Chama a função responsavel por gerar duas matrizes "vazias"
    ## r_new_atom é uma matriz que gera pontos aleatorios em coordenadas polares 
    ## r_cartesian é a matriz que vai guardar os pontos validos, ou seja, aqueles no interior do disco
    r_new_atom, r_cartesian = get_empty_arrays(N)
    
    nValid = 0                                                                                                           # Variavel auxiliar para o loop
    
    while true 
        get_one_random_atom_inside_slab!(L,Lₐ,r_new_atom)

        if is_valid_position(r_new_atom, r_cartesian[1:nValid, : ], rₘᵢₙ)
            nValid += 1 
            r_cartesian[nValid, : ] = r_new_atom
        end

        if nValid == N                                                                                                   # Aqui existe a contagem de atomos validos, dentro do disco
            break
        end
    end

    # Aqui é rotornada uma matriz que contem as coordenadas cartesianas dos N pontos no interior do disco
    ## Primeira coluna coordenadas no eixo x
    ## Segunda coluna coordenadas no eixo y  
    return r_cartesian
end

function get_one_random_atom_inside_slab!(L,Lₐ, r_new_atom::Array)
    
    r_new_atom[1] = L*rand() - L/2 
    r_new_atom[2] = Lₐ*rand() - Lₐ/2
    nothing
    
end

function get_empty_arrays(N::Integer)
    
    r_new_atom = zeros(2)                                                                                                           # Matriz vazia para gerar pontos aleatorios
    r_cartesian = Array{Float64}(undef, N, 2)                                                                                       # Matriz vazia para guardar os pontos validos 
    
    return r_new_atom, r_cartesian
end

function is_valid_position(r_new_atom::Array, r_cartesian::Array, rₘᵢₙ::Number)
    
    nAtoms = size(r_cartesian, 1)                                                                                                       # Número de linhas de r que corresponde ao número de atomos do sistema


    # Retorna uma variavel booleana, a ideia é verificar se todos atomos tem distância permitida entre sí   
    return all(get_Distance_A_to_b(r_cartesian, r_new_atom) .≥ rₘᵢₙ)    
end

function get_Distance_A_to_b(A::Array, b::Array)


    n_rows = size(A, 1)                                                                                                                 # Aqui temos a contagem dos N atomos novamente
    distanceAb = zeros(n_rows)                                                                                                          # Define uma matriz que vai guardar a distancia entre os atomos
    @inbounds for i = 1:n_rows                                                                                                          # Fazer o calculo em loop para cada atomo

        # Aqui a matriz distaceAb vai guardar a distancia de todos os atomos com relação ao novo atomo
        ## Neste ponto é usado o pacote Distances 
        distanceAb[i] = Distances.evaluate(Euclidean(), A[i, :], b) 
    

    end
    return distanceAb
end



######################################################################################################################
####################################################### ESCALAR ######################################################
######################################################################################################################

function get_green_scalar(N::Integer, k::Number,rij::Array)
    G = Array{Complex{Float64}}(undef,N,N);
    @. G = SpecialFunctions.besselh(0,1,k*rij); # Scalar Green matrix
    G[LinearAlgebra.diagind(G)].= 1; #main diagonal 
    return G
end


function get_cloud_escalar(N,k, X, Y, rₘᵢₙ)
    r=getAtoms_distribution(N, rₘᵢₙ, X, Y)
    rij = Distances.pairwise(Euclidean(), r, r, dims = 1);
    G = get_green_scalar(N,k,rij)
    λ, ψ  = LinearAlgebra.eigen(G); #Eingenvalues and eigensvectors
    return r, rij, G, λ, ψ
end


function get_β_escalar(G,r, E₀, ω₀,k, Γ₀,Δ)
    EL = get_EL(r, E₀, ω₀,k)*1im/2
    A = Array{Complex{Float64}}(undef, N,N)
    @. A = 0 + 0im 
    A[LinearAlgebra.diagind(A)].= 1im*Δ
    Matriz_resultante = (-Γ₀/2)*G-A
    β = Matriz_resultante\EL
    return β
end





######################################################################################################################
###################################################### Vetorial ######################################################
######################################################################################################################
#=
function get_Slab(N,X,Y)
    x_atoms = -X*rand(N) .+ X/2; #Atoms positions (x-axis) 
    y_atoms = -Y*rand(N) .+ Y/2; #Atoms positions (y-axis)
    r = zeros(N,2);
    r[:,1] = x_atoms;
    r[:,2] = y_atoms;
    return r
end



function get_Φ(r,sensores)
    N = size(r,1)
    Nsensor = size(sensores,1)
    y_sensor = sensores[:,1]
    x_sensor = sensores[:,2]
    x = r[:,1]
    y = r[:,2]
    Φ = zeros(N)
    for i in Nsensor
        for j in N
            Φ = atan(y[j]-y_sensor[i],x[j]-x_sensor[i])        
        end
    end
    return Φ
end
=#
function get_ϕ(r)
    
    N = size(r,1)
    ϕ = zeros(N,N)


    contador_2 = 1
    contador_3 = 1
    contador_4 = 0

    while true
        
        ϕ[contador_2,contador_3] = atan((r[contador_2,2]-r[contador_3,2])/(r[contador_2,1]-r[contador_3,1]))
        contador_4 = contador_4 + 1
    
        if contador_3 == N
            contador_2 = contador_2 + 1
            contador_3 = 1
        else
            contador_3 = contador_3 + 1
        end 
        
        if contador_4 == N^2
            break
        end
    end

    ϕ[LinearAlgebra.diagind(ϕ)].= 0 
    return ϕ
end


function get_green_matrix(r,N,k,rij)
    ϕ = get_ϕ(r)
    H₀ = Array{Complex{Float64}}(undef,N,N);
    @. H₀ = SpecialFunctions.besselh(0,1,k*rij); # Scalar Green matrix
    H₀[LinearAlgebra.diagind(H₀)].= 1; #main diagonal 
    
    H₂⁺ = Array{Complex{Float64}}(undef,N,N);
    @. H₂⁺ = -exp(-2im*ϕ)*SpecialFunctions.besselh(2,1,k*rij);
    H₂⁺[LinearAlgebra.diagind(H₂⁺)].= 0 + 0im; #main diagonal 

    H₂⁻ = Array{Complex{Float64}}(undef,N,N);
    @. H₂⁻ = -exp(2im*ϕ)*SpecialFunctions.besselh(2,1,k*rij);
    H₂⁻[LinearAlgebra.diagind(H₂⁻)].= 0 + 0im; #main diagonal 

    G = [H₀ H₂⁺;H₂⁻ H₀]
    return G
end


function get_cloud_vetorial(N,k, X, Y, rₘᵢₙ)
    r = getAtoms_distribution(N, rₘᵢₙ, X, Y)
    rij = Distances.pairwise(Euclidean(), r, r, dims = 1);
    G = get_green_matrix(r, N,k,rij)
    λ, ψ  = LinearAlgebra.eigen(G); #Eingenvalues and eigensvectors
    return r, rij, G, λ, ψ 
end



function get_β_vetorial(G,r, E₀, ω₀,k, Γ₁,Δ)
    EL = get_EL(r, E₀, ω₀,k)
    Eₗ⁺ = -EL*(sqrt(2)/2im)
    Eₗ⁻ = -EL*(sqrt(2)/2im)
    EL_atoms = ([Eₗ⁺;Eₗ⁻])*(1im/2)
    A = Array{Complex{Float64}}(undef, 2*N,2*N)
    @. A = 0 + 0im 
    A[LinearAlgebra.diagind(A)].= 1im*Δ
    Matriz_resultante = (-Γ₁/2)*G-A
    β = Matriz_resultante\EL_atoms
    return β
end
