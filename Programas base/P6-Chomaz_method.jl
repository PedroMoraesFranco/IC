function chomaz(r,sensores,k)
    
    x_atom = r[:,1]
    y_atom = r[:,2]
    x_sensor = sensores[:,1]
    y_sensor = sensores[:,2]
    E_rel = exp(1im*k*(sqrt(x_sensor^2+y_sensor^2)-(x_atom*x_sensor+y_atom*y_sensor)/sqrt(x_sensor^2+y_sensor^2)))/(sqrt(π*k*sqrt(x_sensor^2+y_sensor^2)))
    
    return E_rel
end