from bs4 import BeautifulSoup
import sys

with open(sys.argv[1], "r") as f:
    contents = f.read()
    soup = BeautifulSoup(contents, "xml")

