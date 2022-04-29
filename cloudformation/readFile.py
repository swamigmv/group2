import sys


class FileUtils:

    fileName = sys.argv[1]
    searchText = sys.argv[2]
    def getData(self):
        f = open(self.fileName, "r")
        lines = f.readlines()
        for line in lines:
            print(f"Line {line.strip()}")
            if line.startswith(self.searchText):
                return line.replace(self.searchText, '')
        f.close();

fileUtils = FileUtils()
fileUtils.getData()
