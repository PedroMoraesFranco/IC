using Base: Float64, Number
######################################################################################################################
###################################################### P1-NUVEM ######################################################
######################################################################################################################

mutable struct get_slab_ENTRADA
    N::Integer
    X::Number
    Y::Number
end


mutable struct get_green_scalar_ENTRADA
    N::Integer
    k::Number
    rij::Array
    Δ::Number
    Γ₀::Number
end 


mutable struct get_cloud_ENTRADA
    N::Integer
    X::Number
    Y::Number
    k::Number
    Δ::Number
    Γ₀::Number
end 


mutable struct get_β_ENTRADA
    G::Array
    EL_atoms::Array
end


mutable struct get_H0_ENTRADA
    N::Integer
    k::Number
    rij::Array
end


mutable struct get_H2_ENTRADA
    N::Integer
    k::Number
    rij::Array
    Φ::Array
end

mutable struct get_green_vectorial_ENTRADA
    N::Integer
    k::Number
    rij::Array
    Δ::Number
    Γ1::Number
    Φ::Array
end


mutable struct get_cloud_vetorial_ENTRADA
    N::Integer
    X::Number
    Y::Number
    k::Number
    Δ::Number
    Γ₀::Number
    Γ1::Number
end 




######################################################################################################################
###################################################### P2-SENSOR #####################################################
######################################################################################################################





######################################################################################################################
###################################################### P3-EL #########################################################
######################################################################################################################





######################################################################################################################
################################################# P4-INTENSIDADE ESCALAR #############################################
######################################################################################################################





######################################################################################################################
################################################ P5-INTENSIDADE VETORIAL #############################################
######################################################################################################################





######################################################################################################################
##################################################### E1-ESCALAR #####################################################
######################################################################################################################

mutable struct E1_transmissão_ENTRADA
    N::Integer
    X::Number 
    Y::Number 
    ω₀::Number
    k::Number
    Γ₀::Number 
    E₀::Number
    Nsensor::Integer 
    Angulo_inicial_sensor::Number 
    Angulo_final_sensor::Number
    Δ::Number
    angulo_controle::Number 
    ρ::Number
    rₘᵢₙ::Number
    vec::Number
end

mutable struct E1_transmissão_SAÍDA
    cloud::Any 
    Sensores::Array 
    EL_atoms::Array 
    β::Array 
    I_espalhada::Array  
    I_EL::Array  
    T_DIFUSO::Number
    T_COERENTE::Number
    BL_law::Number
    b::Array
end




######################################################################################################################
##################################################### E2-VETORIAL ####################################################
######################################################################################################################
