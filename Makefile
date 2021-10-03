.PHONY: all, step, freq

all: step, freq

step:
	g++ -Iinclude step_response.cc -o build/step && \
	build/step && \
	julia step_response.jl

freq:
	g++ -Iinclude frequency_response.cc -o build/freq && \
	build/freq && \
	julia frequency_response.jl