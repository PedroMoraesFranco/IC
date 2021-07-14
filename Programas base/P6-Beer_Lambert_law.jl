function get_b_escalar(Δ,Γ₀)
    δ₀ = Δ/Γ₀
    b_scalar = 1/(4*(δ₀^2)+1)
    return b_scalar
end

function get_b_vectorial(Δ,Γ₀)
    δ₀ = Δ/Γ₀
    b_vectorial = 2/(16*(δ₀^2)+1)
    return b_vectorial
end

function get_BL_law(b,b₀)
    T = exp(-b₀*b)
    return T
end