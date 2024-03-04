import requests
from bs4 import BeautifulSoup
from selenium import webdriver
import json

class ScraperStrategy:
    def scrape(self, symbol):
        pass

class BeautifulSoupScraper(ScraperStrategy):
    def scrape(self, symbol):
        url = f"https://finance.yahoo.com/quote/{symbol}"
        response = requests.get(url)
        soup = BeautifulSoup(response.text, 'html.parser')
        
        previous_close = soup.find("td", {"data-test": "PREV_CLOSE-value"}).text
        open_price = soup.find("td", {"data-test": "OPEN-value"}).text
        volume = soup.find("td", {"data-test": "TD_VOLUME-value"}).text
        market_cap = soup.find("td", {"data-test": "MARKET_CAP-value"}).text
        
        return {
            "Previous Close": previous_close,
            "Open": open_price,
            "Volume": volume,
            "Market Cap": market_cap
        }

class SeleniumScraper(ScraperStrategy):
    def scrape(self, symbol):
        url = f"https://finance.yahoo.com/quote/{symbol}"
        driver = webdriver.Chrome()  # You might need to adjust this path according to your system
        driver.get(url)
        
        previous_close = driver.find_element_by_xpath("//td[@data-test='PREV_CLOSE-value']").text
        open_price = driver.find_element_by_xpath("//td[@data-test='OPEN-value']").text
        volume = driver.find_element_by_xpath("//td[@data-test='TD_VOLUME-value']").text
        market_cap = driver.find_element_by_xpath("//td[@data-test='MARKET_CAP-value']").text
        
        driver.quit()
        
        return {
            "Previous Close": previous_close,
            "Open": open_price,
            "Volume": volume,
            "Market Cap": market_cap
        }

class Scraper:
    def __init__(self, strategy):
        self.strategy = strategy
    
    def scrape(self, symbol):
        return self.strategy.scrape(symbol)

def main():
    symbol = "TSLA"  # Example symbol, you can change it to any other symbol
    
    # Choose the scraper strategy (BeautifulSoup or Selenium)
    scraper = Scraper(BeautifulSoupScraper())
    # scraper = Scraper(SeleniumScraper())
    
    data = scraper.scrape(symbol)
    
    # Write data to JSON file
    with open("stock_data.json", "w") as file:
        json.dump(data, file, indent=4)
    
    print("Data scraped and saved successfully.")

if __name__ == "__main__":
    main()



def display_data():
# Read data from JSON file
    with open("stock_data.json", "r") as file:
        data = json.load(file)
    
    # Display the data
    print("Stock Data:")
    for key, value in data.items():
        print(f"{key}: {value}")

# Luego de guardar los datos en el archivo JSON, llama a esta función para mostrarlos
display_data()