import sys
import xml.dom.minidom as d
import os

res = d.parse(sys.argv[1])

print("OK")
print()

pretty_xml = res.toprettyxml()
pretty_xml = os.linesep.join([s for s in pretty_xml.splitlines() if s.strip()])

print(pretty_xml)




