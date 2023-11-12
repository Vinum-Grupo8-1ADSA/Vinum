#include "DHT.h"
#define dht_type DHT11 

int dht_pin = A0;
DHT dht_1 = DHT(dht_pin, dht_type);
float temperature;

void setup()
{
Serial.begin(9600);
dht_1.begin();
}
void loop() {
  float umidade = 0.3464 * dht_1.readHumidity() + 34.04;
  float temperatura = 0.0934 * dht_1.readTemperature() + 6.707;
  if (isnan(temperatura) or isnan(umidade)) 
  {
    Serial.println("Erro: Incapaz de ler as informações");
  } 
  else
  {
    
    Serial.print(umidade);
    Serial.print(";");
    Serial.println(temperatura);
    
   }
   delay(3000);
   }