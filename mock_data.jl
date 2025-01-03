# Function to generate basic mock data
function generate_mock_data_basic(time_steps::Int, initial_output::Float64, degradation_rate::Float64, noise_level::Float64)
    """
    Generate basic synthetic PV data with a constant degradation rate.

    Parameters:
    - time_steps: Number of time steps to simulate.
    - initial_output: Initial PV output at time step 0.
    - degradation_rate: Constant degradation rate per time step.
    - noise_level: Standard deviation of Gaussian noise.

    Returns:
    - pv_output: Simulated noisy PV output over time (Array).
    - true_rates: True degradation rates used (Array, constant in this case).
    """
    # Create a timeline
    t = 1:time_steps

    # Generate true PV outputs (without noise)
    true_output = [initial_output * exp(-degradation_rate * t[i]) for i in t]

    # Add Gaussian noise
    pv_output = [true_output[i] + randn() * noise_level for i in t]

    # Return outputs and constant degradation rate
    return pv_output, fill(degradation_rate, time_steps)
end
