from readFile import FileUtils

class UpdateDataToApi:

    def send_data(self):
        fileUtils = FileUtils()
        custAcct1 = fileUtils.getData("/var/log/cloud-init-output.log", "Public address of the key:   ", 0)
        custAcct2 = fileUtils.getData("/var/log/cloud-init-output.log", "Public address of the key:   ", 1)
        minerAcct = fileUtils.getData("/var/log/cloud-init-output.log", "Public address of the key:   ", 2)

updateData = UpdateDataToApi()
updateData.send_data()
#sudo python3 group2/cloudformation/UpdateDataToApi.py /var/log/cloud-init-output.log "Public address of the key:   "