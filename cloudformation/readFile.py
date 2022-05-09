import sys


class FileUtils:

    # fileName = sys.argv[1]
    # searchText = sys.argv[2]
    # arg = sys.argv[3]
    def getData(self, fileName, searchText, arg):
        f = open(fileName, "r")
        lines = f.readlines()
        counter = 0
        for line in lines:
            # print(f"Line {line.strip()}")
            if line.startswith(searchText):
                if counter == arg:
                    print(line.replace(searchText, ''))
                    return line.replace(searchText, '')

        f.close();



#sudo python3 group2/cloudformation/readFile.py /var/log/cloud-init-output.log "Public address of the key:   "
