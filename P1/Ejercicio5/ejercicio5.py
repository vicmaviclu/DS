import requests
import json
from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.webdriver.common.by import By

class ScrapeStrategy():
    def scrape(self, url):
        pass


class BeautifulSoupStrategy(ScrapeStrategy):
    def scrape(self, url):
        response = requests.get(url)
        if response.status_code == 200:
            soup = BeautifulSoup(response.content, 'html.parser')
            open_value_td = soup.find('td', {'data-test': 'OPEN-value'})
            previous_close = soup.find("td", {"data-test": "PREV_CLOSE-value"})
            volume = soup.find("td", {"data-test": "TD_VOLUME-value"})
            market_cap = soup.find("td", {"data-test": "MARKET_CAP-value"})
            if (open_value_td, previous_close, volume, market_cap):
                return {
                    'OPEN-value': open_value_td.text.strip(),
                    'PREV_CLOSE-value': previous_close.text.strip(),
                    'Volume': volume.text.strip(),
                    'Market_cap': market_cap.text.strip()
                }
            else:
                return 'Values not found'
        else:
            return f'Failed to retrieve the webpage, status code: {response.status_code}'


class SeleniumStrategy(ScrapeStrategy):
    # Variables de clase
    XPATH_BOTON_COOKIES_ACEPTAR = "/html/body/div/div/div/div/form/div[2]/div[2]/button[1]"
    XPATH_OPEN_VALUE = ".//td[@data-test='OPEN-value']"
    XPATH_VOLUME = ".//td[@data-test='TD_VOLUME-value']"
    XPATH_MARKET_CAP = ".//td[@data-test='MARKET_CAP-value']"
    XPATH_PREV_CLOSE = ".//td[@data-test='PREV_CLOSE-value']"

    def __init__(self):
        self.driver = webdriver.Chrome()
        self.driver.implicitly_wait(30)

    def scrape(self, url):
        self.driver.get(url)
        self.accept_cookies()
        return self.get_values()

    # Acepta las cookies
    def accept_cookies(self):
        boton_cookies_aceptar = self.driver.find_element(By.XPATH, self.XPATH_BOTON_COOKIES_ACEPTAR)
        boton_cookies_aceptar.click()

    # Encuentra los valores de la página
    def get_values(self):
        open_value_td = self.driver.find_element(By.XPATH, self.XPATH_OPEN_VALUE)
        volume = self.driver.find_element(By.XPATH, self.XPATH_VOLUME)
        market_cap = self.driver.find_element(By.XPATH, self.XPATH_MARKET_CAP)
        previous_close = self.driver.find_element(By.XPATH, self.XPATH_PREV_CLOSE)
        if (open_value_td, previous_close, volume, market_cap):
            return {
                'OPEN-value': open_value_td.text.strip(),
                'PREV_CLOSE-value': previous_close.text.strip(),
                'Volume': volume.text.strip(),
                'Market_cap': market_cap.text.strip()
            }
        else:
            return 'Values not found'

class Context:
    def __init__(self, strategy):
        self._strategy = strategy

    def set_strategy(self, strategy):
        self._strategy = strategy

    def scrape(self, url):
        return self._strategy.scrape(url)


# Estrategia scraping con BeautifulSoup
    
strategy = input("Por favor, elige una estrategia de scraping (ingresa 'B' para BeautifulSoup o 'S' para Selenium): ")

if strategy.lower() == 'b':
    context = Context(BeautifulSoupStrategy())
elif strategy.lower() == 's':
    context = Context(SeleniumStrategy())
else:
    print("Estrategia no reconocida. Por favor, elige 'BeautifulSoup' o 'Selenium'.")
    exit(1)

url = 'https://finance.yahoo.com/quote/TSLA'
results = context.scrape(url)

with open('Ejercicio5/results.json', 'w') as f:
    json.dump(results, f)

print("Los resultados se han guardado en un archivo llamado 'results.json'")

# print("Resultados con Selenium: ")
# for key, value in results.items():
#   print(f'{key}: {value}')
