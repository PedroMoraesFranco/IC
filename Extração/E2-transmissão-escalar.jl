
function E2_transmissão(variaveis_entrada::E1_transmissão_ENTRADA)
    entrada_cloud = get_cloud_ENTRADA(
        variaveis_entrada.N, 
        variaveis_entrada.X, 
        variaveis_entrada.Y, 
        variaveis_entrada.k,
        variaveis_entrada.Δ, 
        variaveis_entrada.Γ₀
    )
    cloud = get_cloud(entrada_cloud);

    r = cloud[1];
    rij = cloud[2];
    G = cloud[3];

    Sensores = get_sensors(
        variaveis_entrada.X,
        variaveis_entrada.Y,
        variaveis_entrada.ω₀,
        variaveis_entrada.k,
        variaveis_entrada.Angulo_inicial_sensor,
        variaveis_entrada.Angulo_final_sensor,
        variaveis_entrada.Nsensor
    )
    r;

    sensores = zeros(Nsensor,2);
    sensores[:,1] = Sensores[:,3];
    sensores[:, 2] = Sensores[:,4];

    EL_atoms = get_EL(
        r, 
        variaveis_entrada.E₀, 
        variaveis_entrada.ω₀,
        variaveis_entrada.k
    )

    β = get_β(G, EL_atoms);

    I_espalhada =  get_intensidade_sensor(
        sensores, 
        variaveis_entrada.k, 
        variaveis_entrada.E₀, 
        variaveis_entrada.ω₀, 
        variaveis_entrada.Γ₀, 
        β, 
        r
    )

    I_Incidente = get_intensidade_laser(
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

    b = get_b_scalar(
        variaveis_entrada.Δ, 
        variaveis_entrada.Γ₀
    )

    BL_law = get_BL_law(
        b,
        variaveis_entrada.b₀
    )

    return E1_transmissão_SAÍDA(cloud, Sensores, EL_atoms, β, I_espalhada, I_Incidente, T_DIFUSO,T_COERENTE, BL_law, b)
end











function E21_transmissão(variaveis_entrada::E1_transmissão_ENTRADA)
    
    Δ = sqrt((variaveis_entrada.b₀/4)-1)

    entrada_cloud = get_cloud_ENTRADA(
        variaveis_entrada.N, 
        variaveis_entrada.X, 
        variaveis_entrada.Y, 
        variaveis_entrada.k,
        Δ, 
        variaveis_entrada.Γ₀
    )
    cloud = get_cloud(entrada_cloud);

    r = cloud[1];
    rij = cloud[2];
    G = cloud[3];

    Sensores = get_sensors(
        variaveis_entrada.X,
        variaveis_entrada.Y,
        variaveis_entrada.ω₀,
        variaveis_entrada.k,
        variaveis_entrada.Angulo_inicial_sensor,
        variaveis_entrada.Angulo_final_sensor,
        variaveis_entrada.Nsensor
    )
    r;

    sensores = zeros(Nsensor,2);
    sensores[:,1] = Sensores[:,3];
    sensores[:, 2] = Sensores[:,4];

    EL_atoms = get_EL(
        r, 
        variaveis_entrada.E₀, 
        variaveis_entrada.ω₀,
        variaveis_entrada.k
    )

    β = get_β(G, EL_atoms);

    I_espalhada =  get_intensidade_sensor(
        sensores, 
        variaveis_entrada.k, 
        variaveis_entrada.E₀, 
        variaveis_entrada.ω₀, 
        variaveis_entrada.Γ₀, 
        β, 
        r
    )

    I_Incidente = get_intensidade_laser(
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

    b = get_b_scalar(
        Δ, 
        variaveis_entrada.Γ₀
    )

    BL_law = get_BL_law(
        b,
        variaveis_entrada.b₀
    )

    return E1_transmissão_SAÍDA(cloud, Sensores, EL_atoms, β, I_espalhada, I_Incidente, T_DIFUSO,T_COERENTE, BL_law, b)
end
