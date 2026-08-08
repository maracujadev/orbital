#ENV["GKSwstype"] = "100"
using Plots
theme(:dark)

#= notes on the units used in these calculations
G is in m³/(kg*s²)
positions are always in m
masses are always in kg
=#

### celestial body
star = [0.0, 0.0]
star_mass = 1.989e30 #kilograms

### moving body
p = [149.6*10^9, 20000.0]
v = [-20000.0, 20000.0]
# v = [0.0, 0.0]
a = [0.0, 0.0]
# note the mass is irrelevant as it cancels out

### universal const
G = 6.67428*10^(-11)
dt = 1.0*10^5


### loop creating the animation
anim = @animate for step in 1:2000
	global p, v
	# computation algorithm here
	r = sqrt((star[1]-p[1])^2+(star[2]-p[2])^2)
	a[1] = G*star_mass*(star[1]-p[1])/(r^3)
	a[2] = G*star_mass*(star[2]-p[2])/(r^3)

	v[1] = v[1] + a[1] * dt
	v[2] = v[2] + a[2] * dt

	p[1] = p[1] + v[1] * dt
	p[2] = p[2] + v[2] * dt

	scatter([star[1]], [star[2]], xlims=(-2.5e11, 2.5e11), ylims=(-2.5e11, 2.5e11))
	scatter!([p[1]], [p[2]])
	#= 
	if step % 100 == 0
    	println(step, ": ", p, " r=", r)
	end
	=#
end

gif(anim, "orbit.gif", fps=30)

### Debugging tools

#println(p)
#= 
for step in 1:5
    global p, v
    r = sqrt((star[1]-p[1])^2+(star[2]-p[2])^2)
    a[1] = G*star_mass*(star[1]-p[1])/(r^3)
    a[2] = G*star_mass*(star[2]-p[2])/(r^3)
    v[1] = v[1] + a[1] * dt
    v[2] = v[2] + a[2] * dt
    p[1] = p[1] + v[1] * dt
    p[2] = p[2] + v[2] * dt
    println("step $step: a=$a v=$v p=$p r=$r")
end
=#