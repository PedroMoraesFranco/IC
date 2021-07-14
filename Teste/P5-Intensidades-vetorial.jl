#=
function get_intensidade_laser_one_point(Position_Sensor::Array, E₀::Number, ω₀::Number, k::Number)
    EL_sensor = get_EL_sensor_one_point(Position_Sensor, E₀, ω₀, k)
    I_laser = (abs(EL_sensor))^2
    return I_laser
end


function get_intensidade_laser(Sensores::Array, k::Number, E₀::Number, ω₀::Number)
    Nsensor = size(Sensores,1);
    I_laser = zeros(Nsensor)
    for i in 1:Nsensor
       I_laser[i] = get_intensidade_laser_one_point( Sensores[i,3:4], E₀, ω₀, k)
    end
    return I_laser
end
=#
######################################################################################################################
######################################################## Geral ######################################################
######################################################################################################################

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


function get_EL_sensor_one_point(Position_Sensor, E₀ , ω₀, k) 
    PX = Position_Sensor[1]; 
    PY = Position_Sensor[2];
    
    α = ((2*PX)/(k*(ω₀^2))) 
    Campo = (E₀*(exp(1im*k*PX - ((PY^2)/((ω₀^2)*(1 + 1im*α))))))/(sqrt(1 + 1im*α))
    
    return Campo
end

function get_eletric_field_LG(PX,PY, E₀, ω₀, k)

    α = ((2*PX)/(k*(ω₀^2))) 
    Campo = (E₀*(exp(1im*k*PX - ((PY^2)/((ω₀^2)*(1 + 1im*α))))))/(sqrt(1 + 1im*α))

    return Campo
end

function get_intensidade_laser_one_point_vetorial(Position_Sensor, E₀, ω₀, k)
    EL_sensor = get_EL_sensor_one_point_vetorial(Position_Sensor, E₀, ω₀, k)
    EL_sensor⁺ = -EL_sensor*(sqrt(2)/2im)
    EL_sensor⁻ = -EL_sensor*(sqrt(2)/2im)
    I_laser = (abs(EL_sensor⁺))^2 + (abs(EL_sensor⁻))^2
    return I_laser
end


function get_intensidade_laser(Sensores, k, E₀, ω₀)
    Nsensor = size(Sensores,1);
    I_laser = zeros(Nsensor)
    for i in 1:Nsensor
       I_laser[i] = get_intensidade_laser_one_point_vetorial( Sensores[i,3:4], E₀, ω₀, k)
    end
    return I_laser
end

function get_degree_azimut(Posição_Sensor)
    x = Posição_Sensor[1]
    y = Posição_Sensor[2]

    if x >= 0 && y >= 0
        θ = 90 - atand(x/y)
    elseif x <= 0  && y >= 0
        θ = 90 - atand(x/y)
    elseif x <= 0 && y <= 0
        θ = 270 - atand(x/y)
    elseif x >= 0 && y <= 0
        θ = 270 - atand(x/y)
    end

    return θ
end 
function get_ϕj(r::Array,Position_Sensor::Array)

    N = size(r,1)
    ϕₛ = zeros(N)

    for i in 1:N
        ϕₛ[i] = atan((r[i,2]-Position_Sensor[2])/(r[i,1]-Position_Sensor[1]))
    end
    return ϕₛ
end

function get_distance_A_to_B(A,b)
    n_rows = size(A,1)
    distanceAb = zeros(n_rows)
    @inbounds for i = 1:n_rows

        distanceAb[i] = Distances.evaluate(Euclidean(), A[i,:], b)
    end
    return distanceAb
end

function get_intensidade_espalhada(sensores, k, E₀, ω₀, Γ₀, β, r)
    
    N = size(r,1)
    Γ₁=Γ₀/2
    β⁺ = β[1:N,1]
    β⁻ = β[N+1:2*N,1]
    Nsensor = size(sensores,1)
    I_sensor = zeros(Nsensor)
    
    for j in 1:Nsensor
        Position_Sensor = sensores[j,:]
        ϕ = get_ϕj(r,Position_Sensor)
        R_Sensor = norm(Position_Sensor)
        θ_Sensor = get_degree_azimut(Position_Sensor)
        versor_Sensor = (cosd(θ_Sensor),sind(θ_Sensor))
        E⁺ = 0
        E⁻ = 0
        
        for i in 1:N
            E⁺ += (cis(-k*dot(r[i, : ],versor_Sensor)))*(β⁺[i] + (cis(-2*ϕ[i])*β⁻[i]))
            # E_plus += (SpecialFunctions.besselh(0,1,k*r_sensor_atomo[i]))*β_plus[i] -1*exp(-2im*Φ[i])*(SpecialFunctions.besselh(2,1,k*r_sensor_atomo[i]))*β_minus[i]
            
            E⁻ += (cis(-k*dot(r[i, : ],versor_Sensor)))*(β⁻[i] + (cis(2*ϕ[i])*β⁺[i]))
            # E_minus += (SpecialFunctions.besselh(0,1,k*r_sensor_atomo[i]))*β_minus[i] -1*exp(2im*Φ[i])*(SpecialFunctions.besselh(2,1,k*r_sensor_atomo[i]))*β_plus[i]
        end

        EL_sensor = get_eletric_field_LG(sensores[j,1], sensores[j,2], E₀, ω₀, k)
        Eₗ⁺ = -EL_sensor*(sqrt(2)/2im)
        Eₗ⁻ = -EL_sensor*(sqrt(2)/2im)

        Campo_espalhado⁺ = Eₗ⁺ -(1im*(1-1im)*(sqrt(1/π))*Γ₁*((cis(k*R_Sensor))/sqrt(k*R_Sensor)))*E⁺
        Campo_espalhado⁻ = Eₗ⁻ -(1im*(1-1im)*(sqrt(1/π))*Γ₁*((cis(k*R_Sensor))/sqrt(k*R_Sensor)))*E⁻
        I_sensor[j] = (abs(Campo_espalhado⁺))^2 + (abs(Campo_espalhado⁻))^2
    end
    
    return I_sensor
end


function get_transmition(I::Array,IEL::Array, Sensores::Array, angulo_controle::Number)
    index_sensor_coerente = findall(  (Sensores[:,2] .≥ -angulo_controle).*(Sensores[:,2] .≤ angulo_controle))
    I_coerente = sum(I[index_sensor_coerente])
    

    index_sensor_difuso = findall(  (Sensores[:,2] .≥ -90).*(Sensores[:,2] .≤ 90))
    I_espalhada = sum(I[index_sensor_difuso])


    index_sensor_incidente = findall(  (Sensores[:,2] .≥ 90).*(Sensores[:,2] .≤ 270))
    I_incidente = sum(IEL[index_sensor_incidente])


    T_DIFUSO = I_espalhada/I_incidente
    T_COERENTE = I_coerente/I_incidente


    return T_DIFUSO,T_COERENTE
end