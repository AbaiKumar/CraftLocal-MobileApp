from selenium import webdriver
from selenium.webdriver.common.keys import Keys
import requests

# Start a Selenium WebDriver session
driver = webdriver.Chrome()

# Open the web page where your Flask application is running
driver.get("http://127.0.0.1:8000")

# Test Case 1: Deleting a user that exists
phone_number_existing = "7418768673"
response = requests.post("http://127.0.0.1:8000/delete", data={"phone": phone_number_existing})
if response.status_code == 200:
    result = response.json()["result"]
    if result:
        print(f"User with phone number {phone_number_existing} deleted successfully!")
    else:
        print(f"Failed to delete user with phone number {phone_number_existing}.")
else:
    print("Failed to connect to the server.")

# Test Case 2: Deleting a user that does not exist
phone_number_non_existing = "9999999999"
response = requests.post("http://127.0.0.1:8000/delete", data={"phone": phone_number_non_existing})
if response.status_code == 200:
    result = response.json()["result"]
    if not result:
        print(f"No user found with phone number {phone_number_non_existing}.")
    else:
        print(f"Unexpected result: User with phone number {phone_number_non_existing} deleted.")
else:
    print("Failed to connect to the server.")


phone_number_non_existing = "1234"
response = requests.post("http://127.0.0.1:8000/delete", data={"phone": phone_number_non_existing})
if response.status_code == 200:
    result = response.json()["result"]
    if not result:
        print(f"No user found with phone number {phone_number_non_existing}.")
    else:
        print(f"Unexpected result: User with phone number {phone_number_non_existing} deleted.")
else:
    print("Failed to connect to the server.")

# Close the Selenium WebDriver session
driver.quit()
