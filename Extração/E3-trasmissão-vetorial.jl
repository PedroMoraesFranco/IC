
function E3_transmissão(variaveis_entrada::E1_transmissão_ENTRADA)
    cloud = get_cloud_vetorial( 
        variaveis_entrada.N,
        variaveis_entrada.k, 
        variaveis_entrada.X, 
        variaveis_entrada.Y, 
        variaveis_entrada.rₘᵢₙ
    );

    β = get_β_vetorial(
        cloud[3],
        cloud[1], 
        variaveis_entrada.E₀, 
        variaveis_entrada.ω₀,
        variaveis_entrada.k, 
        variaveis_entrada.Γ₀/2,
        variaveis_entrada.Δ
    )

    Sensores = get_sensors(
        variaveis_entrada.X,
        variaveis_entrada.Y,
        variaveis_entrada.ω₀,
        variaveis_entrada.k,
        variaveis_entrada.Angulo_inicial_sensor,
        variaveis_entrada.Angulo_final_sensor,
        variaveis_entrada.Nsensor
    )

    Posição_sensores = zeros(variaveis_entrada.Nsensor,2);
    Posição_sensores[:,1] = Sensores[:,3];
    Posição_sensores[:, 2] = Sensores[:,4];

    I_espalhada =  get_intensidade_espalhada_vetorial(
        Posição_sensores, 
        variaveis_entrada.k, 
        variaveis_entrada.E₀, 
        variaveis_entrada.ω₀, 
        variaveis_entrada.Γ₀, 
        β, 
        cloud[1]
    )

    I_Incidente = get_intensidade_laser_vetorial(
        Sensores, 
        variaveis_entrada.k, 
        variaveis_entrada.E₀, 
        variaveis_entrada.ω₀
    )

    T_DIFUSO,T_COERENTE = get_transmition(
        I_espalhada, 
        I_Incidente,
        Sensores, 
        variaveis_entrada.angulo_controle
    )

    b = get_b_vectorial(
        variaveis_entrada.Δ,
        variaveis_entrada.Γ₀
    )
    b₀ = 4*variaveis_entrada.N/(variaveis_entrada.Y*variaveis_entrada.k)
    BL = get_BL_law(b,b₀)
    return T_DIFUSO, T_COERENTE, BL, b
end