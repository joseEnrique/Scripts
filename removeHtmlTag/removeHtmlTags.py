#This script is written by Jose Enrique Ruiz Navarro for import Wordpress posts to Ghost and it is Free

import re

#Add source file path

fileHtmlSource = "/home/quique/Escritorio/sinhtml.json"
# Add destination file path

fileHtmlDestination = "/home/quique/Escritorio/sinhtml1.json"

#Return string without html tags

def cleanHtml(textwithHtml):
	cleanr = re.compile('http:\/\/enreda.coop\/wp-content\/')
	cleantext = re.sub(cleanr,'http:\/\/blog.enreda.coop\/content\/', textwithHtml)
	return cleantext

#Return string with file convert to a unique string

def fileToString():
	with  open(fileHtmlSource,"r") as file:
   		 datos=file.read()
	return datos

#Void writting data in file
def writeNewFile(stringFile):
	f = open(fileHtmlDestination,'w')
	f.write(stringFile) # python will convert \n to os.linesep
	f.close()



def main():
	writeNewFile(cleanHtml(fileToString()))
	
if __name__ == "__main__":
    main()
