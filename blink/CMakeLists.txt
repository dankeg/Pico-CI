add_executable(blink
    blink.c
)

# Pull in all STDIO + GPIO helpers
target_link_libraries(blink pico_stdlib)

# Create UF2 and ELF
pico_add_extra_outputs(blink)
