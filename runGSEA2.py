#Run GSEA uses command line to run GSEA
#Takes dirlab (directory containing permulated labels),compare(tags for phenotypes, ex PRE_UNST_versus_CTRL_UNST ), analysis_name (what to name analysis),iteration(what iteration of loop 1:1000),resultsFolder (what Folder to store results in)
import os
import pandas as pd
import bs4
from bs4 import BeautifulSoup

def runGSEA(a,b,analysisName,iteration,resultsFolder,classstem):
		
	iteration=str(iteration)
	c1=r'java -cp gsea2-2.2.3.jar -Xmx512m xtools.gsea.Gsea -res '
	c=r"C:\Users\Allison\Documents\GSEAforjavaapp\all processed for gsea.gct -cls "
	
	c2=r" -gmx C:\Users\Allison\Documents\GSEAforjavaapp\gsea classes all.gmx -collapse false -mode Max_probe -norm meandiv -nperm 1000 -permute phenotype -rnd_type no_balance -scoring_scheme weighted -rpt_label "
	
	c3=r" -metric Signal2Noise -sort real -order descending -include_only_symbols true -make_sets false -median false -	num 100 -plot_top_x 20 -rnd_seed timestamp -save_rnd_lists false -set_max 500 -set_min 2 -zip_report false -out "
	command=c1+c+a+"\\"+classstem+iteration+".cls#"+b+c2+analysisName+c3+resultsFolder
	os.chdir(r"C:\Users\Allison\Documents\GSEAforjavaapp")
	os.system(command)

	return
#let1 and let 2 Capital letter P,R,C (for pre,rem,ctrl)
def getFiles(resultsFolder,let1,let2):
	os.chdir(resultsFolder)
	sub=os.listdir(resultsFolder)[0]
	new=resultsFolder+"\\"+sub

	#Navigating to results folder
	os.chdir(new)
	#Finding .html output files
	allfile=os.listdir()
	gseafile=[k for k in allfile if 'gsea_report_for' in k]
	gseafile=[k for k in gseafile if 'html'in k]
	gseafile1=[k for k in gseafile if let1 in k]
	gseafile1=gseafile1[0]
	gseafile2=[k for k in gseafile if let2 in k]
	gseafile2=gseafile2[0]
	return gseafile1,gseafile2,new

def parseFiles(filename,iteration):
	soup=BeautifulSoup(open(filename))
	table=soup.find_all('table')[0]
	rows=table.find_all('tr')[2:]

	data={
		'GS':[],
		'FDR':[]
	}

	for row in rows:
		cols=row.find_all('td')
		data['GS'].append(cols[1].get_text())
		data['FDR'].append(cols[7].get_text())

	#Converting to pandas dataframe
	pdata=pd.DataFrame(data)

	#Converting FDR column of dataframe from string to float
	floater=lambda x:float(x)
	pdata['FDR']=pdata['FDR'].apply(floater)
	#Finding features only with FDR below 5%
	sig=pdata[pdata['FDR']<0.05]
	return sig

def deleteFiles(new):
	os.chdir(r"C:\Users\Allison\Documents\GSEAforjavaapp\pre ctrl unstim")
	os.system('rmdir /q /s '+new)

def checkFDR():
	dfcollection1={}
	dfcollection2={}
	dirlab=r"C:\Users\Allison\Documents\GSEAforjavaapp\pre ctrl unstim"
	i=list(range(0,1000))
	a=r"C:\Users\Allison\Documents\GSEAforjavaapp\pre ctrl unstim"
	b="PRE_UNST_versus_CTRL_UNST"
	c="pre_ctrl_unst"
	e=r"C:\Users\Allison\gsea_home\output\dec01"
	f="prectrlunstim"
	pre=[None]*1000
	ctrl=[None]*1000
	new=[None]*1000
	for j in i:
		k=j+1
		runGSEA(a,b,c,k,e,f)
		pre[j],ctrl[j],new[j]=getFiles(e,"P","C")
		dfcollection1[j]=parseFiles(pre[j],k)
		dfcollection2[j]=parseFiles(ctrl[j],k)
		deleteFiles(new[j])
	return dfcollection1,dfcollection2



	
	