import pytest
from selenium import webdriver

@pytest.fixture
def setup_test():
    driver = webdriver.Firefox()
    driver.maximize_window()
    return driver

