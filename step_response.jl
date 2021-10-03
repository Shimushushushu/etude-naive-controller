import JSON
import Plots

result = JSON.parsefile("build/step_response.json")

Plots.gr()

p = Plots.plot()

Plots.xlabel!(p, "t (s)")
Plots.ylabel!(p, "value")
Plots.plot!(p, [itr[1] for itr in result], [itr[2] for itr in result], lab="input")
Plots.plot!(p, [itr[1] for itr in result], [itr[3] for itr in result], lab="output")
Plots.savefig(p, "build/step_response.pdf")