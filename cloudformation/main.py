# This is a sample Python script.

# Press Shift+F10 to execute it or replace it with your code.
# Press Double Shift to search everywhere for classes, files, tool windows, actions, and settings.
import os
import json
import subprocess as sp

def print_hi(name):
    # Use a breakpoint in the code line below to debug your script.
    print(f'Hi, {name}')  # Press Ctrl+F8 to toggle the breakpoint.


# Press the green button in the gutter to run the script.
if __name__ == '__main__':
    print_hi('PyCharm')
    f = open('C:\\Users\\swv\\.aws\\credentials', 'w+')
    file_content = f.read()
    f.write('[default]\n')
    f.write('aws_access_key_id = AKIASL3XFI2NQEBSKKER\n')
    f.write('aws_secret_access_key = 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\n')
    f.write('aws_session_token =')
    f.close()

    output = sp.getoutput('aws sts get-session-token --duration-seconds 9000')
    # output = stream.read()
    print(output)
    output_json = json.loads(output)
    # print("output_json"+output_json)
    print("output_json" + output_json.get('Credentials').get('AccessKeyId'))

    f = open('C:\\Users\\swv\\.aws\\credentials', 'w+')
    file_content = f.read()
    f.write('[default]\n')
    f.write('aws_access_key_id = '+output_json.get('Credentials').get('AccessKeyId')+'\n')
    f.write('aws_secret_access_key = '+output_json.get('Credentials').get('SecretAccessKey')+'\n')
    f.write('aws_session_token = '+output_json.get('Credentials').get('SessionToken'))
    f.close()

#aws sts get-session-token --duration-seconds 9000
#>aws cloudformation create-stack --stack-name gl-task3-project --template-body file://cloud_project.json
# aws cloudformation create-stack --stack-name gl-group2-project --template-body file://cloud_formation_capstone.json --region us-east-1

