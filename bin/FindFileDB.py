#!/usr/bin/env python3

import os
import optparse
import sys
import glob
import re

DataBaseFileName = '.file.db'

def GenerateDB(display, path):
    for File in glob.glob(path + '/*'):
        if(os.path.isdir(File)):
            path = os.path.realpath(File)
            GenerateDB(display, path)
        else:
            FilePath = os.path.realpath(File)
            FileName = os.path.split(File[1])
            if (os.path.isfile(FilePath)):
                with open(DataBaseFileName, mode='a', encoding='utf-8') as DBFile:
                    content = FileName  + ' : ' + FilePath
                    if(display):
                        print(content)
                    DBFile.write(content + '\n')
            
def FindFile(File):
    with open(DataBaseFileName, encoding='utf-8') as DBFile:
        LineNumber = 0
        for line in DBFile:
            line_list = line.split(' : ')
            if(File == line_list[0]):
                LineNumber += 1
                print(str(LineNumber) + " " + line_list[1])

def main():
    usage = "usage: %prog filename\n" +\
        "       %prog -g [-d]"
    parser = optparse.OptionParser(usage)
    parser.add_option('-g', '--generate-database', 
                      action='store_true', dest='generate', default=False,
                      help='Scan the Directory, and generate the database')
    parser.add_option('-d', '--display', 
                      action='store_true', dest='display', default=False,
                      help='Print the the file had scaned')
    (options, args) = parser.parse_args()
    
    if (options.generate):
        with open(DataBaseFileName, mode='a', encoding='utf-8') as DBFile:
            DBFile.write('')
        GenerateDB(options.display, '.')
    else:
        if (len(args) != 0):
            FindFile(args[0])
        else:
            print(usage)

if __name__ == '__main__':
    main()
