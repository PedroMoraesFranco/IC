function E2_autoval_escalar(variaveis_entrada::E2_autoval_ENTRADA)

    cloud = get_cloud_escalar(
        variaveis_entrada.N,
        variaveis_entrada.k, 
        variaveis_entrada.X, 
        variaveis_entrada.Y, 
        variaveis_entrada.rₘᵢₙ
    );

         
    b = real(cloud[4])
    gamma = abs.(b)
    delta = imag(cloud[4])

    return gamma, delta
end

function E2_autoval_vetorial(variaveis_entrada::E2_autoval_ENTRADA)
    cloud = get_cloud_vetorial( 
        variaveis_entrada.N,
        variaveis_entrada.k, 
        variaveis_entrada.X, 
        variaveis_entrada.Y, 
        variaveis_entrada.rₘᵢₙ
    );
      
    b = real(cloud[4])
    gamma = abs.(b)
    delta = imag(cloud[4])

    return gamma, delta
end