#!/opt/homebrew/bin/bash

# window size
W=($(tput cols) $(tput lines))

# line position (\e[y;xH is 1-based)
P=(1 1)

# sweeping direction / increment (inc-x, inc-y)
D=(1 1)
# line symbols
# dir symbol inc-x   -y       idx = (ix * iy + 1) / 2
#  NE      \     1 * -1 = -1    0
#  SW      \    -1 *  1 = -1    0
#  NW      /    -1 * -1 =  1    1
#  SE      /     1 *  1 =  1    1
L='\/'


clear
while sleep 0.05; do
    ((i = (D[0] * D[1] + 1) / 2))
    echo -ne "\e[${P[1]};${P[0]}H${L:i:1}"
    for i in 0 1; do
        # sweeping by one step
        ((P[i] += D[i]))
        # if out of bound, flip the direction (by * -1), and use the new
        # direction value to compensate to get back into the boundary
        ((P[i] < 1 || P[i] > W[i])) && ((D[i] *= -1, P[i] += D[i]))
    done
done
