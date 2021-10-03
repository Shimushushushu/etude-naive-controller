import JSON
import Plots

result = JSON.parsefile("build/frequency_response.json")

Plots.gr()

p = Plots.plot()

Plots.xlabel!(p, "t (s)")
Plots.ylabel!(p, "value")
Plots.plot!(p, [itr[1] for itr in result], [itr[2] for itr in result], lab="input,  ω = π rad/s")
Plots.plot!(p, [itr[1] for itr in result], [itr[3] for itr in result], lab="output, ω = π rad/s")
Plots.plot!(p, [itr[1] for itr in result], [itr[4] for itr in result], lab="input,  ω = 2π rad/s")
Plots.plot!(p, [itr[1] for itr in result], [itr[5] for itr in result], lab="output, ω = 2π rad/s")
Plots.savefig(p, "build/frequency_response.pdf")