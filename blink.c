#include "pico/stdlib.h"

const uint LED_PIN = 25;

int main(void)
{
    stdio_init_all();
    gpio_init(LED_PIN);
    gpio_set_dir(LED_PIN, GPIO_OUT);

    while (true) {
        gpio_put(LED_PIN, 1);
        printf("LED ON\n");
        sleep_ms(500);
        gpio_put(LED_PIN, 0);
        printf("LED OFF\n");
        sleep_ms(500);
    }
}
