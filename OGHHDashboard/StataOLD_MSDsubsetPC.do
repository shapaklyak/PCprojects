*********************************************
Purpose: To subset PSNU X IM MSD for OGHH dash
Date updated: 6/06/2018
Analyst: Katya 
*********************************************
*import dataset, edit file location as needed
import delimited C:\Users\knoykhovich\Desktop\datasets\ICPI_MER_Structured_Dataset_PSNU_IM_FY17-18_20180515_v1_1.txt

*keeps relevant countries
keep if operatingunit == "Botswana" | operatingunit == "Cameroon" | operatingunit == "Ethiopia" | operatingunit == "Ghana" | operatingunit == "Guyana" | operatingunit == "Kenya"| operatingunit == "Lesotho"| operatingunit == "Malawi"| operatingunit == "Mozambique"| operatingunit == "Namibia"| operatingunit == "Rwanda"| operatingunit == "South Africa"| operatingunit == "Swaziland"| operatingunit == "Tanzania"| operatingunit == "Uganda" | operatingunit == "Ukraine"| operatingunit == "Zambia"

*keeps PC
keep if fundingagency == "PC"

*change values to numeric instead of strings
destring fy2017_targets fy2017q1 fy2017q2 fy2017q3 fy2017q4 fy2017apr fy2018_targets fy2018q1 fy2018q2, replace ignore(NULL)

*drop any unnecessary columns for OVC dashboard
drop ïregion regionuid operatingunituid snu1uid psnuuid mechanismuid dataelementuid categoryoptioncombouid modality ismcad 

*move exited without graduation under TransferExit 
replace standardizeddisaggregate = "TransferExit" if otherdisaggregate == "Exited without Graduation"
replace standardizeddisaggregate = "TransferExit" if otherdisaggregate == "Transferred"
replace otherdisaggregate = "Transferred out - non PEPFAR Support Partner" if otherdisaggregate == "Transferred"

*export to excel
export excel using "C:\Users\knoykhovich\Desktop\datasets\PC FY18Q2 PSNUxIM 2018 06 06 subset.xlsx", firstrow(variables)
