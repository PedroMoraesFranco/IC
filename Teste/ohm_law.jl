using Plots
N = 250
x = 200
y = 100
l = x
R = 0
k = 1
Γ₀ = 1
n = N/(x*y)
N_div = 100; 
delta_min = -10;                                                    
delta_max = 10;                                                     
delta_range = collect(range(delta_min, delta_max, length = N_div)); 
T = zeros(N_div)
for i in 1:N_div
    Δ = delta_range[i]
    δ₀ = Δ/Γ₀
    σ = (4/k)*(1/(4*δ₀+1))
    lₛ = 1/(n*σ)
    T[i] = (lₛ/l)*(1+(2/3)*(1+R/1-R)) 
end
plot(delta_range, T)