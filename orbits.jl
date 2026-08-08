#ENV["GKSwstype"] = "100" # uncomment to disable the pop-up (remember to restart your REPL)
using Plots
theme(:dark)

### celestial body
star = [0.0, 0.0] #position vector in meters
star_mass = 1.989e30 #kilograms

### moving body
p = [149.6*10^9, 20000.0] #position in meters
v = [-20000.0, 20000.0] #velocity in meters/seconds
# v = [0.0, 0.0]
a = [0.0, 0.0] #acceleration in meters/seconds^2
# note the mass is irrelevant as it cancels out

### universal const
G = 6.67428*10^(-11) #gravitational constant in m^3/(kg*s^2)
dt = 1.0*10^5

GM = G * star_mass

### loop creating the animation
anim = @animate for step in 1:2000
	global p, v, a
	# computation algorithm here
  diff = star .- p
  r = sqrt(diff[1]^2 + diff[2]^2)
	a = GM .* diff ./ r^3

	v .= v .+ a .* dt

	p .= p .+ v .* dt

	scatter([star[1]], [star[2]], xlims=(-2.5e11, 2.5e11), ylims=(-2.5e11, 2.5e11), label="Star")
	scatter!([p[1]], [p[2]], label="Planet")
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
