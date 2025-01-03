function propagate_particles(particles::Vector{Particle}, time_step::Int,
    degradation_noise_prior::Distribution, output_noise_prior::Distribution)
    """
    Propagate particles to the next time step.

    Parameters:
    - particles: Array of particle states (Struct with degradation and noise).
    - time_step: Current time step (scalar).
    - degradation_noise_prior: Prior distribution for degradation rate noise.
    - output_noise_prior: Prior distribution for output prediction noise.

    Returns:
    - propagated_particles: Array of updated particle states.
    """
    propagated_particles = Particle[]  # Create an empty array for propagated particles

    for particle in particles
        # Add random noise from the specified priors
        new_degradation_rate = particle.degradation_rate + rand(degradation_noise_prior)
        predicted_output = exp(-new_degradation_rate * time_step) + rand(output_noise_prior)

        # Create a new particle with the updated parameters
        new_particle = Particle(new_degradation_rate, predicted_output)
        push!(propagated_particles, new_particle)
    end

    return propagated_particles
end
