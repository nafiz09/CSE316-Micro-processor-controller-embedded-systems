#define F_CPU 1000000
#include <avr/io.h>
#include <util/delay.h>
#include <avr/interrupt.h>

char i = 0;
char a[] = {0b10000001,0b11000000,0b01100000,0b00110000,0b00011000,0b00001100,0b00000110,0b00000011};
char b[] = {0b11111011,0b11111101,0b11111110,0b01111111,0b10111111,0b11011111,0b11101111,0b11110111};
char c[] = {0b11110111,0b11111011,0b11111101,0b11111110,0b01111111,0b10111111,0b11011111,0b11101111};

char flag = 0;
ISR(INT0_vect)
{	
		flag = ~flag;
}

char inc()
{
	i++;
	if(i==8)
	i = 0;
	return i;
}


void staticdis(char i)
{
	while(1)
	{
		PORTC = 0b01000010;
		PORTB = a[i];
		_delay_ms(25);
		PORTC = 0b00100100;
		PORTB = b[i];
		_delay_ms(25);
		PORTC = 0b00011000;
		PORTB = c[i];
		_delay_ms(25);
		return;
	}
}

void rotatedis(char i)
{
	while(1)
	{
		PORTC = 0b01000010;
		PORTB = a[i];
		_delay_ms(25);
		PORTC = 0b00100100;
		PORTB = b[i];
		_delay_ms(25);
		PORTC = 0b00011000;
		PORTB = c[i];
		_delay_ms(25);
		i = inc();
		return;
	}
}

int main(void)
{
	DDRB = 0b11111111;
	DDRC = 0b11111111;
	while(1){
		GICR = 1<<INT0;
		MCUCR = 1<<ISC01 | 0<<ISC00;
		sei();
		if(flag == 0)
			staticdis(i);
		else
			rotatedis(i);
	}
}