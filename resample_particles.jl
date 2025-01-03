function resample_particles(particles::Vector{Particle}, weights::Vector{Float64})
    """
    Resample particles based on their weights.

    Parameters:
    - particles: Array of particle states.
    - weights: Array of particle weights.

    Returns:
    - resampled_particles: Array of particles after resampling.
    """
    # Create a categorical distribution based on weights
    resampling_indices = rand(Categorical(weights), length(particles))
    resampled_particles = [particles[idx] for idx in resampling_indices]

    return resampled_particles
end
