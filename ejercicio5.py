import requests
from bs4 import BeautifulSoup
from selenium import webdriver

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
    def scrape(self, url):
        pass


class Context:
    def __init__(self, strategy):
        self._strategy = strategy

    def set_strategy(self, strategy):
        self._strategy = strategy

    def scrape(self, url):
        return self._strategy.scrape(url)


url = 'https://finance.yahoo.com/quote/TSLA'
context = Context(BeautifulSoupStrategy())
results = context.scrape(url)

for key,value in results.items():
    print(f'{key}: {value}')


from selenium import webdriver
from selenium.webdriver.common.by import By


driver = webdriver.Chrome()
driver.get('https://finance.yahoo.com/quote/TSLA')


boton_cookies_aceptar = driver.find_element(By.XPATH, "//button[@class='btn secondary accept-all ']") # /html/body/div/div/div/div/form/div[2]/div[2]/button[1]
boton_cookies_aceptar.click()
#tabla = driver.find_element(By.XPATH, "//div[@class='Bxz(bb) D(ib) Va(t) Mih(250px)!--lgv2 W(100%) Mt(-6px) Mt(0px)--mobp Mt(0px)--mobl W(50%)!--lgv2 Mend(20px)!--lgv2 Pend(10px)!--lgv2']")
driver.close()
# Resto del código sigue igual
"""
url = 'https://finance.yahoo.com/quote/TSLA'
context = Context(SeleniumStrategy())
results = context.scrape(url)

for key, value in results.items():
    print(f'{key}: {value}')
"""