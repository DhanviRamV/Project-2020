import pandas as pd
import re
fname = input("Enter the filename:")
df = pd.read_excel(fname+".xlsx", header = None, usecols = [0, 6])
list = []
for i in range(len(df)):
    resname = df[0][i]
    loc = resname.find("A:")
    #finding if the residue exists
    if loc == -1:
        continue
    resname = re.findall("A:[A-Z0-9]+", resname)
    inttype = df[6][i]
    symloc = inttype.find(";")
    if symloc != -1:
        inttype = inttype[:symloc]
    templist = [inttype+resname[0], 1]
    list.append(templist)
mapdf = pd.DataFrame(list)
transmap = mapdf.T
print(transmap)
# transmap.to_excel(fname+"output.xlsx", index = False, header = False)
# print("The mappings have been written as", fname + "output.xlsx file in the directory")
