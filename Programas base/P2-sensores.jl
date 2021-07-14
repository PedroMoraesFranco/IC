#-Functions-#
function get_sensors(X::Number, Y::Number, ω₀::Number, k::Number, Angulo_inicial_sensor::Number, Angulo_final_sensor::Number, Nsensor::Number)
    meia_diagonal = sqrt((X/2)^2 +(Y/2)^2);
    raio = (X/2 + meia_diagonal)/2;

    comprimento_de_ray = (k*ω₀^2)/2;
    D_sensor = 10*raio + comprimento_de_ray;

    θ = collect(range(Angulo_inicial_sensor, Angulo_final_sensor, length = Nsensor))
    x_sensor = D_sensor*cosd.(θ)
    y_sensor = D_sensor*sind.(θ)


    Sensores = zeros(Nsensor,4);
    Sensores[:,1] .= D_sensor;
    Sensores[:,2] = θ;
    Sensores[:,3] = x_sensor;
    Sensores[:,4] = y_sensor;
    return Sensores
end
