function lin_sys()
    Γ₀ = Γ₀
    Γ₁ = Γ₀/2
    k = k
    if vec == 1
        NN = 2*N
    else 
        NN = N
    end

    function Matrix(Γ₀,Γ₁,k,rij,N,ϕ)
        if vec == 1

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
            A = Array{Complex{Float64}}(undef, 2*N,2*N)
            @. A = 0 + 0im 
            A[LinearAlgebra.diagind(A)].= 1im*Δ
            Matriz_resultante = G*(-Γ₁/2)-A

        else

            G = Array{Complex{Float64}}(undef,N,N);
            @. G = SpecialFunctions.besselh(0,1,k*rij); # Scalar Green matrix
            G[LinearAlgebra.diagind(G)].= 1; #main diagonal 
            A = Array{Complex{Float64}}(undef, N,N)
            @. A = 0 + 0im 
            A[LinearAlgebra.diagind(A)].= 1im*Δ
            Matriz_resultante = G*(-Γ₀/2)-A 
    
        end
    return 
    end

    
    function data(N,X,Y,ρ,rₘᵢₙ)
        x_atoms = zeros(N,1)
        y_atoms = zeros(N,1)

        x_atoms[0] = X*rand()-X/2
        y_atoms[0] = Y*rand()-Y/2

        i = 1
        for rr in range(0,100*N)
            x1 = X*rand()-X/2
            y1 = Y*rand()-Y/2 
            
            rij = sqrt((x1-x_atoms)^2 + (y1-y_atoms)^2)      #Distance between the test poin and the other points
            test1 = rij < rₘᵢₙ                          #Testing if the distance bewteen the points are large enough
            test = any(test1)


            if test == False
                x_atoms[i] = x1
                y_atoms[i] = y1
                i=i+1
            
            if i == N
                break
            end
        end   

    
    end
end
