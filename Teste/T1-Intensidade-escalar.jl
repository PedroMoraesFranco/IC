
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

function get_eletric_field_LG(PX,PY, E₀, ω₀, k)

    α = ((2*PX)/(k*(ω₀^2))) 
    Campo = (E₀*(exp(1im*k*PX - ((PY^2)/((ω₀^2)*(1 + 1im*α))))))/(sqrt(1 + 1im*α))

    return Campo
end

function get_distance_A_to_B(A,b)
    n_rows = size(A,1)
    distanceAb = zeros(n_rows)
    @inbounds for i = 1:n_rows

        distanceAb[i] = Distances.evaluate(Euclidean(), A[i,:], b)
    end
    return distanceAb
end

function get_intensidade_sensor(sensores, k, E₀, ω₀, Γ₀, β, r)

    N = size(r,1)
    Nsensor = size(sensores,1)
    I_sensor = zeros(Nsensor)
    for j in 1:Nsensor
        r_sensor_atomo = get_distance_A_to_B(r,sensores[j,:])
        fator_soma = 0
        for i in 1:N
            fator_soma += (((1-1im)*exp(1im*k*r_sensor_atomo[i]))/sqrt(π*k*r_sensor_atomo[i]))*β[i]
            #(SpecialFunctions.besselh(0,1,k*r_sensor_atomo[i]))*β[i]
            #(cis(k*r_sensor_atomo[i])/sqrt(k*r_sensor_atomo[i]) + (1/(π*k*r_sensor_atomo[i])))*β[i]

        end
        EL_sensor = get_eletric_field_LG(sensores[j,1], sensores[j,2], E₀, ω₀, k)

        Campo_espalhado = EL_sensor - 1im*Γ₀*fator_soma

        I_sensor[j] = (abs(Campo_espalhado))^2
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