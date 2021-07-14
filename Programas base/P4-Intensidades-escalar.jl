#-Functions-#

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


function get_intensidade_espalhada_one_point(θ::Number, Position_Sensor::Array, R_sensor::Number,r::Array, k::Number, E₀::Number, ω₀::Number, Γ₀::Number, β::Array)
    N = size(r,1)
    fator_soma = 0
    vetor = (r[1]*cosd(θ),r[2]*sind(θ))
    for i in 1:N
        termo_cis = (1im*k*(vetor[i]))
        fator_soma += exp(termo_cis)*β[i]
    end
    EL_sensor = get_EL_sensor_one_point(Position_Sensor, E₀, ω₀, k)
    termo_a = (1im*Γ₀)
    termo_b = (1-1im)
    termo_c = (exp(1im*R_sensor*k)/sqrt(π*k*R_sensor))
    Campo_espalhado = EL_sensor - termo_a*termo_b*termo_c*fator_soma
    I_Espalhado_sensor = (abs(Campo_espalhado))^2
    
    return I_Espalhado_sensor
end


function get_intensidade_espalhada(Sensores::Array, k::Number, E₀::Number, ω₀::Number, Γ₀::Number, β::Array, r::Array)
    Nsensor = size(Sensores,1);
    I_espalhada = zeros(Nsensor)
    for i in 1:Nsensor
       I_espalhada[i] = get_intensidade_espalhada_one_point(Sensores[i,2], Sensores[i,3:4], Sensores[i,1], r, k, E₀, ω₀, Γ₀, β)
    end
    return I_espalhada
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