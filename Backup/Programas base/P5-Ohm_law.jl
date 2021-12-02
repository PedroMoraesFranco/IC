function σ_scalar(Δ,Γ₀,k)
    δ₀ = Δ/Γ₀
    σ_scalar = (4/k)*(1/(4*δ₀^2+1))
    return σ_scalar   
end

function σ_vetorial(Δ,Γ₀,k)
    δ₀ = Δ/Γ₀
    σ_vetorial = (4/k)*(2/(16*δ₀^2+1))
    return σ_vetorial
end


function ohm_law(l, n, σ, R)
    lₛ = 1/(n*σ)
    T = (lₛ/l)*(1+(2/3)*(1+R/1-R))
    return T
end