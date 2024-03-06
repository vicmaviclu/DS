import requests
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

from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
class SeleniumStrategy(ScrapeStrategy):
    def scrape(self, url):
        driver = webdriver.Chrome()
        driver.get(url)
        driver.implicitly_wait(30)

        boton_cookies_aceptar = driver.find_element(By.XPATH, "/html/body/div/div/div/div/form/div[2]/div[2]/button[1]") # /html/body/div/div/div/div/form/div[2]/div[2]/button[1]
        boton_cookies_aceptar.click()     
   
        # div = driver.find_element(By.XPATH, "//div[@id='quote-summary']")        

        open_value_td = driver.find_element(By.XPATH, ".//td[@data-test='OPEN-value']")
        volume = driver.find_element(By.XPATH, ".//td[@data-test='TD_VOLUME-value']")
        market_cap = driver.find_element(By.XPATH, ".//td[@data-test='MARKET_CAP-value']")
        previous_close = driver.find_element(By.XPATH, ".//td[@data-test='PREV_CLOSE-value']")
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
    
url = 'https://finance.yahoo.com/quote/TSLA'
context = Context(BeautifulSoupStrategy())
results = context.scrape(url)

print("Resultados con BeautifulSoup: ")
for key,value in results.items():
    print(f'{key}: {value}')


# Estrategia scraping con Selenium

context = Context(SeleniumStrategy())
results = context.scrape(url)

print("Resultados con Selenium: ")
for key, value in results.items():
    print(f'{key}: {value}')
