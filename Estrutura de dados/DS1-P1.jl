mutable struct get_slab_ENTRADA
    N::Integer
    X::Number
    Y::Number
end

mutable struct get_slab_SAIDA
    r::Array
end



mutable struct get_green_matrix_ENTRADA
    N::Integer
    k::Number
    rij::Array
    Δ::Number
    Γ₀::Number
end 


mutable struct get_green_matrix_SAIDA
    Matrix_G::Array
end 



mutable struct get_cloud_ENTRADA
    N::Integer
    X::Number
    Y::Number
    k::Number
    Δ::Number
    Γ₀::Number
end 

mutable struct get_cloud_SAIDA
    r::Array 
    rij::Array 
    G::Array
end 



mutable struct get_β_ENTRADA
    G::Array 
    EL_atoms::Array
end

mutable struct get_β_SAIDA
    β::Array
end