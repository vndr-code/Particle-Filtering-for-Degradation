function update_weights(particles::Vector{Particle}, weights::Vector{Float64}, observed_value::Float64)
    """
    Update particle weights based on observed data.

    Parameters:
    - particles: Array of particle states (Struct with degradation and noise).
    - weights: Array of current particle weights.
    - observed_value: Observed data at the current time step.

    Returns:
    - updated_weights: Array of updated particle weights.
    """
    updated_weights = Float64[]  # Empty array for updated weights

    for (particle, weight) in zip(particles, weights)
        # Calculate likelihood of the observed value given the particle's prediction
        likelihood = pdf(Normal(particle.noise_level, 0.01), observed_value)
        push!(updated_weights, weight * likelihood)
    end

    # Normalize weights to sum to 1
    total_weight = sum(updated_weights)
    updated_weights ./= total_weight

    return updated_weights
end
