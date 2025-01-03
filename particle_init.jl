
using Distributions

# Define a particle struct for clarity
struct Particle
    degradation_rate::Float64
    noise_level::Float64
end

# Function to initialize particles
function initialize_particles(num_particles::Int, degradation_prior::Distribution, noise_prior::Distribution)
    """
    Initialize particles for the particle filter.

    Parameters:
    - num_particles: Number of particles.
    - degradation_prior: Prior distribution for degradation rate.
    - noise_prior: Prior distribution for noise level.

    Returns:
    - particles: Array of particle states (Struct with degradation and noise).
    - weights: Array of initial weights (equal for all particles).
    """
    # Sample particles from the priors
    particles = [
        Particle(rand(degradation_prior), rand(noise_prior)) for _ in 1:num_particles
    ]

    # Initialize weights to uniform distribution
    weights = fill(1.0 / num_particles, num_particles)

    return particles, weights
end

