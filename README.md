# Particle Filtering for PV Degradation
A **Bayesian particle filtering approach** implemented in **Julia** to estimate the degradation rate. This project demonstrates how **Bayesian state estimation** can track system degradation over time using simulated data.

## 🚀 Project Overview
Photovoltaic systems degrade over time, and accurately estimating their degradation rates is essential for maintenance and forecasting. This project:
- **Simulates PV degradation** with added noise.
- **Implements a particle filter** to estimate degradation over time.
- **Uses Bayesian inference** to update beliefs about the system state.
- **Tracks uncertainty** through weighted probability distributions.

## 📂 Repository Structure
- 📄 main.jl # Main script to run the particle filter 
- 📄 mock_data.jl # Generates synthetic PV degradation data 
- 📄 particle_init.jl # Initializes particles with prior distributions 
- 📄 propagate_particles.jl # Simulates the evolution of particles 
- 📄 update_weights.jl # Updates particle weights based on observations 
- 📄 resample_particles.jl # Resamples particles for the next step 
- 📄 particle_filter.jl # Encapsulates the full particle filtering process 


## ⚡ How It Works
1. **Simulated Data**: The model generates synthetic PV degradation data, assuming a **constant degradation rate**.
2. **Particle Initialization**: A set of particles is initialized with **prior beliefs** about the degradation rate.
3. **Particle Propagation**: At each time step, particles evolve according to a **stochastic model**.
4. **Weight Updates**: The model assigns **higher weights** to particles that match observed data.
5. **Resampling**: Particles with low weights are discarded, while high-weight particles are replicated.
6. **Final Estimation**: The degradation rate is estimated as the **weighted average of the particles**.

## 📊 Results Interpretation
- The **true degradation rate** is compared against the **estimated rate**.
- The **absolute error** and **weighted standard deviation** provide insights into accuracy.

## 🛠 Installation & Running the Code
### Prerequisites
- **Julia** (tested with Julia 1.17.9)
- Required packages: `Distributions`
