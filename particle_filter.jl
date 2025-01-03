function particle_filter(; num_time_steps, observed_data, num_particles, degradation_prior, noise_prior)
    # Initialize particles and weights
    particles, weights = initialize_particles(num_particles, degradation_prior, noise_prior)

    # Iterate through all time steps
    for t in 1:num_time_steps
        println("Time Step $t")
        
        # Propagate particles
        propagated_particles = propagate_particles(particles, t, Normal(0.0, 0.005), Normal(0.0, 0.01))

        # Update weights based on observed data
        weights = update_weights(propagated_particles, weights, observed_data[t])

        # Resample particles if necessary (optional)
        particles = resample_particles(propagated_particles, weights)
        
        # Output some diagnostics (optional)
        println("Updated Weights: ", weights)
    end

    return particles, weights
end
