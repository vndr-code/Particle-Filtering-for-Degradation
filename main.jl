using Pkg

# Activate environment
Pkg.activate(".")
Pkg.instantiate()
Pkg.add("Distributions")

include("mock_data.jl")
include("particle_init.jl")
include("propagate_particles.jl")
include("update_weights.jl")
include("resample_particles.jl")
include("particle_filter.jl")

using Random
using Distributions

Random.seed!(42)


# check if you have multi threads, if not julia --threads=auto in terminal
if Threads.nthreads() == 1
    println("Warning: Only 1 thread available. Set JULIA_NUM_THREADS to enable multithreading.")
end


# Generate population data

time_steps = 10
initial_output = 1.0  # Starting efficiency or output
degradation_rate = 0.05  # 5% degradation rate
noise_level = 0.02  # Low noise for testing

# Generate mock data
pv_output, true_rates = generate_mock_data_basic(time_steps, initial_output, degradation_rate, noise_level)

println("Simulated PV Outputs: ", pv_output)
println("True Degradation Rates: ", true_rates)

# Define prior distributions for initialization
degradation_prior = Normal(0.05, 0.01)  # Mean 0.05, std 0.01 for degradation rate
noise_prior = Normal(0.01, 0.005)       # Mean 0.01, std 0.005 for noise level

# Define observed data (e.g., noisy observations of PV output)
observed_data = pv_output

# Run the particle filter encapsulation
num_particles = 10

final_particles, final_weights = particle_filter(
    num_time_steps=time_steps,
    observed_data=observed_data,
    num_particles=num_particles,
    degradation_prior=degradation_prior,
    noise_prior=noise_prior
)

# Display final results
println("\nFinal Particles and Weights:")
for i in 1:length(final_particles)
    println("Particle $i: Degradation Rate = ", final_particles[i].degradation_rate, 
            ", Noise Level = ", final_particles[i].noise_level, 
            ", Weight = ", final_weights[i])
end

# Calculate weighted average degradation rate from the final particles
weighted_average_degradation = sum(p.degradation_rate * w for (p, w) in zip(final_particles, final_weights))

# Print the comparison
println("True Degradation Rate (Mock Data): ", degradation_rate)
println("Estimated Degradation Rate (Weighted Average): ", weighted_average_degradation)

absolute_error = abs(weighted_average_degradation - degradation_rate)
println("Absolute Error: ", absolute_error)
println("Acceptable Range: ±", noise_level)

weighted_std_degradation = sqrt(sum(w * (p.degradation_rate - weighted_average_degradation)^2 for (p, w) in zip(final_particles, final_weights)))
println("Weighted Standard Deviation of Degradation Rate: ", weighted_std_degradation)

