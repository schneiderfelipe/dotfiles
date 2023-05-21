using Colors
using ImageInTerminal
using Statistics

# Original Monokai Pro colors
normal_black = colorant"#403E41"
normal_red = colorant"#FF6188"
normal_green = colorant"#A9DC76"
normal_yellow = colorant"#FFD866"
normal_blue = colorant"#FC9867"
normal_magenta = colorant"#AB9DF2"
normal_cyan = colorant"#78DCE8"
normal_white = colorant"#FCFCFA"

bright_black = colorant"#727072"  # The only one that's actually bright!
bright_red = colorant"#FF6188"
bright_green = colorant"#A9DC76"
bright_yellow = colorant"#FFD866"
bright_blue = colorant"#FC9867"
bright_magenta = colorant"#AB9DF2"
bright_cyan = colorant"#78DCE8"
bright_white = colorant"#FCFCFA"

# Correct blue (which is actually orange)
# This one comes from a triad including the original red and green.
# See
# <https://github.com/Monokai/monokai-pro-sublime-text/issues/45#issuecomment-341065531>.
normal_blue = colorant"#6088ff"
bright_blue = colorant"#6088ff"

# Other colors from the link above
normal_cyan = colorant"#78dce8"
# bright_black = colorant"#6c6c6c"  # Actually called gray there
normal_green = colorant"#a9dc76"
# normal_black = colorant"#000000"  # Controversial
normal_red = colorant"#fe6188"
normal_yellow = colorant"#ffd866"
bright_yellow = colorant"#ffd866"

# Use the original Monokai Pro colors from the web site
normal_red = RGB(255 / 255, 97 / 255, 136 / 255)
normal_yellow = RGB(252 / 255, 152 / 255, 103 / 255)  # Monokai Pro Orange
bright_yellow = RGB(255 / 255, 216 / 255, 102 / 255)  # Monokai Pro Yellow
normal_green = RGB(169 / 255, 220 / 255, 118 / 255)
normal_cyan = RGB(120 / 255, 220 / 255, 232 / 255)
normal_magenta = RGB(171 / 255, 157 / 255, 242 / 255)

# Convert colors to LCHuv
normal_black = convert(LCHuv, normal_black)
normal_red = convert(LCHuv, normal_red)
normal_green = convert(LCHuv, normal_green)
normal_yellow = convert(LCHuv, normal_yellow)
normal_blue = convert(LCHuv, normal_blue)
normal_magenta = convert(LCHuv, normal_magenta)
normal_cyan = convert(LCHuv, normal_cyan)
normal_white = convert(LCHuv, normal_white)

bright_black = convert(LCHuv, bright_black)
bright_red = convert(LCHuv, bright_red)
bright_green = convert(LCHuv, bright_green)
bright_yellow = convert(LCHuv, bright_yellow)
bright_blue = convert(LCHuv, bright_blue)
bright_magenta = convert(LCHuv, bright_magenta)
bright_cyan = convert(LCHuv, bright_cyan)
bright_white = convert(LCHuv, bright_white)

# What's the maximum span of luminance with respect to the bright colors?
luminance_span = maximum(filter(x -> x > 0, [
    abs(normal_black.l - bright_black.l),
    abs(normal_red.l - bright_red.l),
    abs(normal_green.l - bright_green.l),
    abs(normal_yellow.l - bright_yellow.l),
    abs(normal_blue.l - bright_blue.l),
    abs(normal_magenta.l - bright_magenta.l),
    abs(normal_cyan.l - bright_cyan.l),
    abs(normal_white.l - bright_white.l),
   ]))

println("Brightness luminance increase: ", luminance_span)

# min: 0.08 so that bright white would be FFFFFF
k = 4 * 0.08

# Adjust the luminance of the bright colors with respect to the luminance span
bright_red = LCHuv(bright_red.l + k * luminance_span, bright_red.c, bright_red.h)
bright_green = LCHuv(bright_green.l + k * luminance_span, bright_green.c, bright_green.h)
#  bright_yellow = LCHuv(bright_yellow.l + k * luminance_span, bright_yellow.c, bright_yellow.h)
bright_blue = LCHuv(bright_blue.l + k * luminance_span, bright_blue.c, bright_blue.h)
bright_magenta = LCHuv(bright_magenta.l + k * luminance_span, bright_magenta.c, bright_magenta.h)
bright_cyan = LCHuv(bright_cyan.l + k * luminance_span, bright_cyan.c, bright_cyan.h)

normal_white = LCHuv(normal_white.l - k * luminance_span, normal_white.c, normal_white.h)

println("Normal black: ", hex(normal_black))
println("Normal red: ", hex(normal_red))
println("Normal green: ", hex(normal_green))
println("Normal yellow: ", hex(normal_yellow))
println("Normal blue: ", hex(normal_blue))
println("Normal magenta: ", hex(normal_magenta))
println("Normal cyan: ", hex(normal_cyan))
println("Normal white: ", hex(normal_white))

println("Bright black: ", hex(bright_black))
println("Bright red: ", hex(bright_red))
println("Bright green: ", hex(bright_green))
println("Bright yellow: ", hex(bright_yellow))
println("Bright blue: ", hex(bright_blue))
println("Bright magenta: ", hex(bright_magenta))
println("Bright cyan: ", hex(bright_cyan))
println("Bright white: ", hex(bright_white))
