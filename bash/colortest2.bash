# Standard colors (0-15)
echo "Standard colors (0-15):"
for i in {0..15}; do
  printf "\x1b[48;5;${i}m %3s \x1b[0m" "$i"
done
echo -e "\n"

# RGB cube (16-231) - 6x6x6 = 216 colors
echo "RGB cube (16-231):"
for i in {16..231}; do
  printf "\x1b[48;5;${i}m %3s \x1b[0m" "$i"
  (( (i - 16 + 1) % 36 == 0 )) && echo
done
echo

# Grayscale ramp (232-255)
echo "Grayscale ramp (232-255):"
for i in {232..255}; do
  printf "\x1b[48;5;${i}m %3s \x1b[0m" "$i"
done
echo -e "\n"
