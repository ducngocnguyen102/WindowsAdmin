<#
.SYNOPSIS
    Adjust device timezone using IP geo location.
.DESCRIPTION
.AUTHOR
    Ngoc Nguyen

.NOTES
    
#>

#Use TLS 1.2
[System.Net.ServicePointManager]::SecurityProtocol = 'TLS12'

<#

#Generate TimeZone List using BingMaps rest API https://learn.microsoft.com/en-us/bingmaps/rest-services/timezone/find-time-zone
$BingMapsKey = 'Al1zJ2CsCQcUk4MLKIzFCSdb1TDLiRbXalsvlgEX_e1NdMyBB5kypfI1_ZQ9vm9-'  
$BingMaps_Response = Invoke-RestMethod "https://dev.virtualearth.net/REST/v1/TimeZone/List/?timezonestandard=IANA&key=$BingMapsKey"
$TimeZoneJSON = $BingMaps_Response.resourceSets.resources.timezone | ConvertTo-Json
Set-Clipboard -Value $TimeZoneJSON
#>
$Date = Get-Date -Format yyyy-MM-dd-hh-mm-ss 
$TimeZone = (Get-TimeZone).id -replace " "
$TimeStamp = $Date + "_" + $TimeZone + "_"
$Directory = "C:\ProgramData\Microsoft\IntuneManagementExtension\Logs\"
$FolderName = "AdjustTimeZone" + "\"
$FileName = $TimeStamp  + "AdjustTimeZone.log"
$OutputFolder = $Directory + $FolderName
$OutputFile = $Directory + $FolderName + $FileName

Start-Transcript $OutputFile

if (!(Test-Path $OutputFolder)){
    mkdir $OutputFolder
}


$TimeZoneJSONValue = '[
    {
        "genericName":  "UTC-11",
        "abbreviation":  "NUT",
        "ianaTimeZoneId":  "Pacific/Niue",
        "windowsTimeZoneId":  "UTC-11",
        "utcOffset":  "-11:00"
    },
    {
        "genericName":  "UTC-11",
        "ianaTimeZoneId":  "Pacific/Pago_Pago",
        "windowsTimeZoneId":  "UTC-11",
        "utcOffset":  "-11:00"
    },
    {
        "genericName":  "UTC-11",
        "ianaTimeZoneId":  "Pacific/Midway",
        "windowsTimeZoneId":  "UTC-11",
        "utcOffset":  "-11:00"
    },
    {
        "genericName":  "Hawaiian Standard Time",
        "abbreviation":  "TAHT",
        "ianaTimeZoneId":  "Pacific/Tahiti",
        "windowsTimeZoneId":  "Hawaiian Standard Time",
        "utcOffset":  "-10:00"
    },
    {
        "genericName":  "Hawaiian Standard Time",
        "abbreviation":  "CKT",
        "ianaTimeZoneId":  "Pacific/Rarotonga",
        "windowsTimeZoneId":  "Hawaiian Standard Time",
        "utcOffset":  "-10:00"
    },
    {
        "genericName":  "Hawaiian Standard Time",
        "ianaTimeZoneId":  "Pacific/Johnston",
        "windowsTimeZoneId":  "Hawaiian Standard Time",
        "utcOffset":  "-10:00"
    },
    {
        "genericName":  "Hawaiian Standard Time",
        "abbreviation":  "HST",
        "ianaTimeZoneId":  "Pacific/Honolulu",
        "windowsTimeZoneId":  "Hawaiian Standard Time",
        "utcOffset":  "-10:00"
    },
    {
        "genericName":  "Aleutian Standard Time",
        "abbreviation":  "HST",
        "ianaTimeZoneId":  "America/Adak",
        "windowsTimeZoneId":  "Aleutian Standard Time",
        "utcOffset":  "-10:00"
    },
    {
        "genericName":  "Marquesas Standard Time",
        "abbreviation":  "MART",
        "ianaTimeZoneId":  "Pacific/Marquesas",
        "windowsTimeZoneId":  "Marquesas Standard Time",
        "utcOffset":  "-9:30"
    },
    {
        "genericName":  "UTC-09",
        "abbreviation":  "GIT",
        "ianaTimeZoneId":  "Pacific/Gambier",
        "windowsTimeZoneId":  "UTC-09",
        "utcOffset":  "-9:00"
    },
    {
        "genericName":  "Alaskan Standard Time",
        "abbreviation":  "AKST",
        "ianaTimeZoneId":  "America/Nome",
        "windowsTimeZoneId":  "Alaskan Standard Time",
        "utcOffset":  "-9:00"
    },
    {
        "genericName":  "Alaskan Standard Time",
        "abbreviation":  "AKST",
        "ianaTimeZoneId":  "America/Sitka",
        "windowsTimeZoneId":  "Alaskan Standard Time",
        "utcOffset":  "-9:00"
    },
    {
        "genericName":  "Alaskan Standard Time",
        "abbreviation":  "AKST",
        "ianaTimeZoneId":  "America/Anchorage",
        "windowsTimeZoneId":  "Alaskan Standard Time",
        "utcOffset":  "-9:00"
    },
    {
        "genericName":  "Alaskan Standard Time",
        "abbreviation":  "AKST",
        "ianaTimeZoneId":  "America/Metlakatla",
        "windowsTimeZoneId":  "Alaskan Standard Time",
        "utcOffset":  "-9:00"
    },
    {
        "genericName":  "Alaskan Standard Time",
        "abbreviation":  "AKST",
        "ianaTimeZoneId":  "America/Juneau",
        "windowsTimeZoneId":  "Alaskan Standard Time",
        "utcOffset":  "-9:00"
    },
    {
        "genericName":  "Alaskan Standard Time",
        "abbreviation":  "AKST",
        "ianaTimeZoneId":  "America/Yakutat",
        "windowsTimeZoneId":  "Alaskan Standard Time",
        "utcOffset":  "-9:00"
    },
    {
        "genericName":  "UTC-08",
        "ianaTimeZoneId":  "Pacific/Pitcairn",
        "windowsTimeZoneId":  "UTC-08",
        "utcOffset":  "-8:00"
    },
    {
        "genericName":  "Pacific Standard Time (Mexico)",
        "abbreviation":  "PST",
        "ianaTimeZoneId":  "America/Tijuana",
        "windowsTimeZoneId":  "Pacific Standard Time (Mexico)",
        "utcOffset":  "-8:00"
    },
    {
        "genericName":  "Pacific Standard Time",
        "abbreviation":  "PST",
        "ianaTimeZoneId":  "America/Los_Angeles",
        "windowsTimeZoneId":  "Pacific Standard Time",
        "utcOffset":  "-8:00"
    },
    {
        "genericName":  "Pacific Standard Time",
        "abbreviation":  "PST",
        "ianaTimeZoneId":  "America/Vancouver",
        "windowsTimeZoneId":  "Pacific Standard Time",
        "utcOffset":  "-8:00"
    },
    {
        "genericName":  "Pacific Standard Time",
        "abbreviation":  "PST",
        "ianaTimeZoneId":  "America/Whitehorse",
        "windowsTimeZoneId":  "Pacific Standard Time",
        "utcOffset":  "-8:00"
    },
    {
        "genericName":  "Pacific Standard Time",
        "abbreviation":  "PST",
        "ianaTimeZoneId":  "America/Dawson",
        "windowsTimeZoneId":  "Pacific Standard Time",
        "utcOffset":  "-8:00"
    },
    {
        "genericName":  "Mountain Standard Time (Mexico)",
        "abbreviation":  "MST",
        "ianaTimeZoneId":  "America/Mazatlan",
        "windowsTimeZoneId":  "Mountain Standard Time (Mexico)",
        "utcOffset":  "-7:00"
    },
    {
        "genericName":  "Mountain Standard Time (Mexico)",
        "abbreviation":  "MST",
        "ianaTimeZoneId":  "America/Chihuahua",
        "windowsTimeZoneId":  "Mountain Standard Time (Mexico)",
        "utcOffset":  "-7:00"
    },
    {
        "genericName":  "US Mountain Standard Time",
        "abbreviation":  "MST",
        "ianaTimeZoneId":  "America/Hermosillo",
        "windowsTimeZoneId":  "US Mountain Standard Time",
        "utcOffset":  "-7:00"
    },
    {
        "genericName":  "Mountain Standard Time",
        "abbreviation":  "MST",
        "ianaTimeZoneId":  "America/Ojinaga",
        "windowsTimeZoneId":  "Mountain Standard Time",
        "utcOffset":  "-7:00"
    },
    {
        "genericName":  "US Mountain Standard Time",
        "abbreviation":  "MST",
        "ianaTimeZoneId":  "America/Phoenix",
        "windowsTimeZoneId":  "US Mountain Standard Time",
        "utcOffset":  "-7:00"
    },
    {
        "genericName":  "Mountain Standard Time",
        "abbreviation":  "MST",
        "ianaTimeZoneId":  "America/Denver",
        "windowsTimeZoneId":  "Mountain Standard Time",
        "utcOffset":  "-7:00"
    },
    {
        "genericName":  "Mountain Standard Time",
        "abbreviation":  "MST",
        "ianaTimeZoneId":  "America/Boise",
        "windowsTimeZoneId":  "Mountain Standard Time",
        "utcOffset":  "-7:00"
    },
    {
        "genericName":  "US Mountain Standard Time",
        "abbreviation":  "MST",
        "ianaTimeZoneId":  "America/Creston",
        "windowsTimeZoneId":  "US Mountain Standard Time",
        "utcOffset":  "-7:00"
    },
    {
        "genericName":  "Mountain Standard Time",
        "abbreviation":  "MST",
        "ianaTimeZoneId":  "America/Edmonton",
        "windowsTimeZoneId":  "Mountain Standard Time",
        "utcOffset":  "-7:00"
    },
    {
        "genericName":  "US Mountain Standard Time",
        "abbreviation":  "MST",
        "ianaTimeZoneId":  "America/Dawson_Creek",
        "windowsTimeZoneId":  "US Mountain Standard Time",
        "utcOffset":  "-7:00"
    },
    {
        "genericName":  "US Mountain Standard Time",
        "abbreviation":  "MST",
        "ianaTimeZoneId":  "America/Fort_Nelson",
        "windowsTimeZoneId":  "US Mountain Standard Time",
        "utcOffset":  "-7:00"
    },
    {
        "genericName":  "Mountain Standard Time",
        "abbreviation":  "MST",
        "ianaTimeZoneId":  "America/Yellowknife",
        "windowsTimeZoneId":  "Mountain Standard Time",
        "utcOffset":  "-7:00"
    },
    {
        "genericName":  "Mountain Standard Time",
        "abbreviation":  "MST",
        "ianaTimeZoneId":  "America/Cambridge_Bay",
        "windowsTimeZoneId":  "Mountain Standard Time",
        "utcOffset":  "-7:00"
    },
    {
        "genericName":  "Mountain Standard Time",
        "abbreviation":  "MST",
        "ianaTimeZoneId":  "America/Inuvik",
        "windowsTimeZoneId":  "Mountain Standard Time",
        "utcOffset":  "-7:00"
    },
    {
        "genericName":  "Easter Island Standard Time",
        "abbreviation":  "EAST",
        "ianaTimeZoneId":  "Pacific/Easter",
        "windowsTimeZoneId":  "Easter Island Standard Time",
        "utcOffset":  "-6:00"
    },
    {
        "genericName":  "Central America Standard Time",
        "abbreviation":  "GALT",
        "ianaTimeZoneId":  "Pacific/Galapagos",
        "windowsTimeZoneId":  "Central America Standard Time",
        "utcOffset":  "-6:00"
    },
    {
        "genericName":  "Central America Standard Time",
        "abbreviation":  "CST",
        "ianaTimeZoneId":  "America/Costa_Rica",
        "windowsTimeZoneId":  "Central America Standard Time",
        "utcOffset":  "-6:00"
    },
    {
        "genericName":  "Central America Standard Time",
        "abbreviation":  "CST",
        "ianaTimeZoneId":  "America/Managua",
        "windowsTimeZoneId":  "Central America Standard Time",
        "utcOffset":  "-6:00"
    },
    {
        "genericName":  "Central America Standard Time",
        "abbreviation":  "CST",
        "ianaTimeZoneId":  "America/El_Salvador",
        "windowsTimeZoneId":  "Central America Standard Time",
        "utcOffset":  "-6:00"
    },
    {
        "genericName":  "Central America Standard Time",
        "abbreviation":  "CST",
        "ianaTimeZoneId":  "America/Tegucigalpa",
        "windowsTimeZoneId":  "Central America Standard Time",
        "utcOffset":  "-6:00"
    },
    {
        "genericName":  "Central America Standard Time",
        "abbreviation":  "CST",
        "ianaTimeZoneId":  "America/Guatemala",
        "windowsTimeZoneId":  "Central America Standard Time",
        "utcOffset":  "-6:00"
    },
    {
        "genericName":  "Central Standard Time (Mexico)",
        "abbreviation":  "CST",
        "ianaTimeZoneId":  "America/Mexico_City",
        "windowsTimeZoneId":  "Central Standard Time (Mexico)",
        "utcOffset":  "-6:00"
    },
    {
        "genericName":  "Central America Standard Time",
        "abbreviation":  "CST",
        "ianaTimeZoneId":  "America/Belize",
        "windowsTimeZoneId":  "Central America Standard Time",
        "utcOffset":  "-6:00"
    },
    {
        "genericName":  "Central Standard Time (Mexico)",
        "abbreviation":  "CST",
        "ianaTimeZoneId":  "America/Merida",
        "windowsTimeZoneId":  "Central Standard Time (Mexico)",
        "utcOffset":  "-6:00"
    },
    {
        "genericName":  "Central Standard Time (Mexico)",
        "abbreviation":  "CST",
        "ianaTimeZoneId":  "America/Bahia_Banderas",
        "windowsTimeZoneId":  "Central Standard Time (Mexico)",
        "utcOffset":  "-6:00"
    },
    {
        "genericName":  "Central Standard Time (Mexico)",
        "abbreviation":  "CST",
        "ianaTimeZoneId":  "America/Monterrey",
        "windowsTimeZoneId":  "Central Standard Time (Mexico)",
        "utcOffset":  "-6:00"
    },
    {
        "genericName":  "Central Standard Time",
        "abbreviation":  "CST",
        "ianaTimeZoneId":  "America/Matamoros",
        "windowsTimeZoneId":  "Central Standard Time",
        "utcOffset":  "-6:00"
    },
    {
        "genericName":  "Central Standard Time",
        "abbreviation":  "CST",
        "ianaTimeZoneId":  "America/Chicago",
        "windowsTimeZoneId":  "Central Standard Time",
        "utcOffset":  "-6:00"
    },
    {
        "genericName":  "Central Standard Time",
        "abbreviation":  "CST",
        "ianaTimeZoneId":  "America/Indiana/Tell_City",
        "windowsTimeZoneId":  "Central Standard Time",
        "utcOffset":  "-6:00"
    },
    {
        "genericName":  "Central Standard Time",
        "abbreviation":  "CST",
        "ianaTimeZoneId":  "America/Indiana/Knox",
        "windowsTimeZoneId":  "Central Standard Time",
        "utcOffset":  "-6:00"
    },
    {
        "genericName":  "Central Standard Time",
        "abbreviation":  "CST",
        "ianaTimeZoneId":  "America/Menominee",
        "windowsTimeZoneId":  "Central Standard Time",
        "utcOffset":  "-6:00"
    },
    {
        "genericName":  "Central Standard Time",
        "abbreviation":  "CST",
        "ianaTimeZoneId":  "America/North_Dakota/New_Salem",
        "windowsTimeZoneId":  "Central Standard Time",
        "utcOffset":  "-6:00"
    },
    {
        "genericName":  "Central Standard Time",
        "abbreviation":  "CST",
        "ianaTimeZoneId":  "America/North_Dakota/Center",
        "windowsTimeZoneId":  "Central Standard Time",
        "utcOffset":  "-6:00"
    },
    {
        "genericName":  "Central Standard Time",
        "abbreviation":  "CST",
        "ianaTimeZoneId":  "America/North_Dakota/Beulah",
        "windowsTimeZoneId":  "Central Standard Time",
        "utcOffset":  "-6:00"
    },
    {
        "genericName":  "Central Standard Time",
        "abbreviation":  "CST",
        "ianaTimeZoneId":  "America/Rainy_River",
        "windowsTimeZoneId":  "Central Standard Time",
        "utcOffset":  "-6:00"
    },
    {
        "genericName":  "Canada Central Standard Time",
        "abbreviation":  "CST",
        "ianaTimeZoneId":  "America/Swift_Current",
        "windowsTimeZoneId":  "Canada Central Standard Time",
        "utcOffset":  "-6:00"
    },
    {
        "genericName":  "Central Standard Time",
        "abbreviation":  "CST",
        "ianaTimeZoneId":  "America/Winnipeg",
        "windowsTimeZoneId":  "Central Standard Time",
        "utcOffset":  "-6:00"
    },
    {
        "genericName":  "Canada Central Standard Time",
        "abbreviation":  "CST",
        "ianaTimeZoneId":  "America/Regina",
        "windowsTimeZoneId":  "Canada Central Standard Time",
        "utcOffset":  "-6:00"
    },
    {
        "genericName":  "Central Standard Time",
        "abbreviation":  "CST",
        "ianaTimeZoneId":  "America/Rankin_Inlet",
        "windowsTimeZoneId":  "Central Standard Time",
        "utcOffset":  "-6:00"
    },
    {
        "genericName":  "Central Standard Time",
        "abbreviation":  "CST",
        "ianaTimeZoneId":  "America/Resolute",
        "windowsTimeZoneId":  "Central Standard Time",
        "utcOffset":  "-6:00"
    },
    {
        "genericName":  "SA Pacific Standard Time",
        "abbreviation":  "PET",
        "ianaTimeZoneId":  "America/Lima",
        "windowsTimeZoneId":  "SA Pacific Standard Time",
        "utcOffset":  "-5:00"
    },
    {
        "genericName":  "SA Pacific Standard Time",
        "abbreviation":  "ACT",
        "ianaTimeZoneId":  "America/Rio_Branco",
        "windowsTimeZoneId":  "SA Pacific Standard Time",
        "utcOffset":  "-5:00"
    },
    {
        "genericName":  "SA Pacific Standard Time",
        "abbreviation":  "ACT",
        "ianaTimeZoneId":  "America/Eirunepe",
        "windowsTimeZoneId":  "SA Pacific Standard Time",
        "utcOffset":  "-5:00"
    },
    {
        "genericName":  "SA Pacific Standard Time",
        "abbreviation":  "ECT",
        "ianaTimeZoneId":  "America/Guayaquil",
        "windowsTimeZoneId":  "SA Pacific Standard Time",
        "utcOffset":  "-5:00"
    },
    {
        "genericName":  "SA Pacific Standard Time",
        "abbreviation":  "COT",
        "ianaTimeZoneId":  "America/Bogota",
        "windowsTimeZoneId":  "SA Pacific Standard Time",
        "utcOffset":  "-5:00"
    },
    {
        "genericName":  "SA Pacific Standard Time",
        "abbreviation":  "EST",
        "ianaTimeZoneId":  "America/Panama",
        "windowsTimeZoneId":  "SA Pacific Standard Time",
        "utcOffset":  "-5:00"
    },
    {
        "genericName":  "SA Pacific Standard Time",
        "abbreviation":  "EST",
        "ianaTimeZoneId":  "America/Jamaica",
        "windowsTimeZoneId":  "SA Pacific Standard Time",
        "utcOffset":  "-5:00"
    },
    {
        "genericName":  "Haiti Standard Time",
        "abbreviation":  "EST",
        "ianaTimeZoneId":  "America/Port-au-Prince",
        "windowsTimeZoneId":  "Haiti Standard Time",
        "utcOffset":  "-5:00"
    },
    {
        "genericName":  "Eastern Standard Time (Mexico)",
        "abbreviation":  "EST",
        "ianaTimeZoneId":  "America/Cancun",
        "windowsTimeZoneId":  "Eastern Standard Time (Mexico)",
        "utcOffset":  "-5:00"
    },
    {
        "genericName":  "SA Pacific Standard Time",
        "abbreviation":  "EST",
        "ianaTimeZoneId":  "America/Cayman",
        "windowsTimeZoneId":  "SA Pacific Standard Time",
        "utcOffset":  "-5:00"
    },
    {
        "genericName":  "Cuba Standard Time",
        "abbreviation":  "CST",
        "ianaTimeZoneId":  "America/Havana",
        "windowsTimeZoneId":  "Cuba Standard Time",
        "utcOffset":  "-5:00"
    },
    {
        "genericName":  "Eastern Standard Time",
        "abbreviation":  "EST",
        "ianaTimeZoneId":  "America/New_York",
        "windowsTimeZoneId":  "Eastern Standard Time",
        "utcOffset":  "-5:00"
    },
    {
        "genericName":  "Eastern Standard Time",
        "abbreviation":  "EST",
        "ianaTimeZoneId":  "America/Nassau",
        "windowsTimeZoneId":  "Eastern Standard Time",
        "utcOffset":  "-5:00"
    },
    {
        "genericName":  "Turks and Caicos Standard Time",
        "abbreviation":  "EST",
        "ianaTimeZoneId":  "America/Grand_Turk",
        "windowsTimeZoneId":  "Turks And Caicos Standard Time",
        "utcOffset":  "-5:00"
    },
    {
        "genericName":  "Eastern Standard Time",
        "abbreviation":  "EST",
        "ianaTimeZoneId":  "America/Kentucky/Monticello",
        "windowsTimeZoneId":  "Eastern Standard Time",
        "utcOffset":  "-5:00"
    },
    {
        "genericName":  "US Eastern Standard Time",
        "abbreviation":  "EST",
        "ianaTimeZoneId":  "America/Indiana/Marengo",
        "windowsTimeZoneId":  "US Eastern Standard Time",
        "utcOffset":  "-5:00"
    },
    {
        "genericName":  "Eastern Standard Time",
        "ianaTimeZoneId":  "America/Kentucky/Louisville",
        "windowsTimeZoneId":  "Eastern Standard Time",
        "utcOffset":  "-5:00"
    },
    {
        "genericName":  "Eastern Standard Time",
        "abbreviation":  "EST",
        "ianaTimeZoneId":  "America/Indiana/Petersburg",
        "windowsTimeZoneId":  "Eastern Standard Time",
        "utcOffset":  "-5:00"
    },
    {
        "genericName":  "Eastern Standard Time",
        "abbreviation":  "EST",
        "ianaTimeZoneId":  "America/Indiana/Vincennes",
        "windowsTimeZoneId":  "Eastern Standard Time",
        "utcOffset":  "-5:00"
    },
    {
        "genericName":  "US Eastern Standard Time",
        "abbreviation":  "EST",
        "ianaTimeZoneId":  "America/Indiana/Vevay",
        "windowsTimeZoneId":  "US Eastern Standard Time",
        "utcOffset":  "-5:00"
    },
    {
        "genericName":  "US Eastern Standard Time",
        "abbreviation":  "EST",
        "ianaTimeZoneId":  "America/Indiana/Indianapolis",
        "windowsTimeZoneId":  "US Eastern Standard Time",
        "utcOffset":  "-5:00"
    },
    {
        "genericName":  "Eastern Standard Time",
        "abbreviation":  "EST",
        "ianaTimeZoneId":  "America/Indiana/Winamac",
        "windowsTimeZoneId":  "Eastern Standard Time",
        "utcOffset":  "-5:00"
    },
    {
        "genericName":  "Eastern Standard Time",
        "abbreviation":  "EST",
        "ianaTimeZoneId":  "America/Toronto",
        "windowsTimeZoneId":  "Eastern Standard Time",
        "utcOffset":  "-5:00"
    },
    {
        "genericName":  "Eastern Standard Time",
        "abbreviation":  "EST",
        "ianaTimeZoneId":  "America/Detroit",
        "windowsTimeZoneId":  "Eastern Standard Time",
        "utcOffset":  "-5:00"
    },
    {
        "genericName":  "Eastern Standard Time",
        "ianaTimeZoneId":  "America/Montreal",
        "windowsTimeZoneId":  "Eastern Standard Time",
        "utcOffset":  "-5:00"
    },
    {
        "genericName":  "Eastern Standard Time",
        "abbreviation":  "EST",
        "ianaTimeZoneId":  "America/Thunder_Bay",
        "windowsTimeZoneId":  "Eastern Standard Time",
        "utcOffset":  "-5:00"
    },
    {
        "genericName":  "SA Pacific Standard Time",
        "ianaTimeZoneId":  "America/Atikokan",
        "windowsTimeZoneId":  "SA Pacific Standard Time",
        "utcOffset":  "-5:00"
    },
    {
        "genericName":  "Eastern Standard Time",
        "abbreviation":  "EST",
        "ianaTimeZoneId":  "America/Nipigon",
        "windowsTimeZoneId":  "Eastern Standard Time",
        "utcOffset":  "-5:00"
    },
    {
        "genericName":  "Eastern Standard Time",
        "abbreviation":  "EST",
        "ianaTimeZoneId":  "America/Iqaluit",
        "windowsTimeZoneId":  "Eastern Standard Time",
        "utcOffset":  "-5:00"
    },
    {
        "genericName":  "Eastern Standard Time",
        "abbreviation":  "EST",
        "ianaTimeZoneId":  "America/Pangnirtung",
        "windowsTimeZoneId":  "Eastern Standard Time",
        "utcOffset":  "-5:00"
    },
    {
        "genericName":  "SA Pacific Standard Time",
        "ianaTimeZoneId":  "America/Coral_Harbour",
        "windowsTimeZoneId":  "SA Pacific Standard Time",
        "utcOffset":  "-5:00"
    },
    {
        "genericName":  "Pacific SA Standard Time",
        "abbreviation":  "CLT",
        "ianaTimeZoneId":  "America/Santiago",
        "windowsTimeZoneId":  "Pacific SA Standard Time",
        "utcOffset":  "-4:00"
    },
    {
        "genericName":  "Paraguay Standard Time",
        "abbreviation":  "PYT",
        "ianaTimeZoneId":  "America/Asuncion",
        "windowsTimeZoneId":  "Paraguay Standard Time",
        "utcOffset":  "-4:00"
    },
    {
        "genericName":  "SA Western Standard Time",
        "abbreviation":  "BOT",
        "ianaTimeZoneId":  "America/La_Paz",
        "windowsTimeZoneId":  "SA Western Standard Time",
        "utcOffset":  "-4:00"
    },
    {
        "genericName":  "Central Brazilian Standard Time",
        "abbreviation":  "AMT",
        "ianaTimeZoneId":  "America/Campo_Grande",
        "windowsTimeZoneId":  "Central Brazilian Standard Time",
        "utcOffset":  "-4:00"
    },
    {
        "genericName":  "Central Brazilian Standard Time",
        "abbreviation":  "AMT",
        "ianaTimeZoneId":  "America/Cuiaba",
        "windowsTimeZoneId":  "Central Brazilian Standard Time",
        "utcOffset":  "-4:00"
    },
    {
        "genericName":  "SA Western Standard Time",
        "abbreviation":  "AMT",
        "ianaTimeZoneId":  "America/Porto_Velho",
        "windowsTimeZoneId":  "SA Western Standard Time",
        "utcOffset":  "-4:00"
    },
    {
        "genericName":  "SA Western Standard Time",
        "abbreviation":  "AMT",
        "ianaTimeZoneId":  "America/Manaus",
        "windowsTimeZoneId":  "SA Western Standard Time",
        "utcOffset":  "-4:00"
    },
    {
        "genericName":  "SA Western Standard Time",
        "abbreviation":  "AMT",
        "ianaTimeZoneId":  "America/Boa_Vista",
        "windowsTimeZoneId":  "SA Western Standard Time",
        "utcOffset":  "-4:00"
    },
    {
        "genericName":  "SA Western Standard Time",
        "abbreviation":  "GYT",
        "ianaTimeZoneId":  "America/Guyana",
        "windowsTimeZoneId":  "SA Western Standard Time",
        "utcOffset":  "-4:00"
    },
    {
        "genericName":  "Venezuela Standard Time",
        "abbreviation":  "VET",
        "ianaTimeZoneId":  "America/Caracas",
        "windowsTimeZoneId":  "Venezuela Standard Time",
        "utcOffset":  "-4:00"
    },
    {
        "genericName":  "SA Western Standard Time",
        "abbreviation":  "AST",
        "ianaTimeZoneId":  "America/Port_of_Spain",
        "windowsTimeZoneId":  "SA Western Standard Time",
        "utcOffset":  "-4:00"
    },
    {
        "genericName":  "SA Western Standard Time",
        "abbreviation":  "AST",
        "ianaTimeZoneId":  "America/Curacao",
        "windowsTimeZoneId":  "SA Western Standard Time",
        "utcOffset":  "-4:00"
    },
    {
        "genericName":  "SA Western Standard Time",
        "abbreviation":  "AST",
        "ianaTimeZoneId":  "America/Grenada",
        "windowsTimeZoneId":  "SA Western Standard Time",
        "utcOffset":  "-4:00"
    },
    {
        "genericName":  "SA Western Standard Time",
        "abbreviation":  "AST",
        "ianaTimeZoneId":  "America/Kralendijk",
        "windowsTimeZoneId":  "SA Western Standard Time",
        "utcOffset":  "-4:00"
    },
    {
        "genericName":  "SA Western Standard Time",
        "abbreviation":  "AST",
        "ianaTimeZoneId":  "America/Aruba",
        "windowsTimeZoneId":  "SA Western Standard Time",
        "utcOffset":  "-4:00"
    },
    {
        "genericName":  "SA Western Standard Time",
        "abbreviation":  "AST",
        "ianaTimeZoneId":  "America/St_Vincent",
        "windowsTimeZoneId":  "SA Western Standard Time",
        "utcOffset":  "-4:00"
    },
    {
        "genericName":  "SA Western Standard Time",
        "abbreviation":  "AST",
        "ianaTimeZoneId":  "America/Barbados",
        "windowsTimeZoneId":  "SA Western Standard Time",
        "utcOffset":  "-4:00"
    },
    {
        "genericName":  "SA Western Standard Time",
        "abbreviation":  "AST",
        "ianaTimeZoneId":  "America/St_Lucia",
        "windowsTimeZoneId":  "SA Western Standard Time",
        "utcOffset":  "-4:00"
    },
    {
        "genericName":  "SA Western Standard Time",
        "abbreviation":  "AST",
        "ianaTimeZoneId":  "America/Martinique",
        "windowsTimeZoneId":  "SA Western Standard Time",
        "utcOffset":  "-4:00"
    },
    {
        "genericName":  "SA Western Standard Time",
        "abbreviation":  "AST",
        "ianaTimeZoneId":  "America/Dominica",
        "windowsTimeZoneId":  "SA Western Standard Time",
        "utcOffset":  "-4:00"
    },
    {
        "genericName":  "SA Western Standard Time",
        "abbreviation":  "AST",
        "ianaTimeZoneId":  "America/Guadeloupe",
        "windowsTimeZoneId":  "SA Western Standard Time",
        "utcOffset":  "-4:00"
    },
    {
        "genericName":  "SA Western Standard Time",
        "abbreviation":  "AST",
        "ianaTimeZoneId":  "America/Montserrat",
        "windowsTimeZoneId":  "SA Western Standard Time",
        "utcOffset":  "-4:00"
    },
    {
        "genericName":  "SA Western Standard Time",
        "abbreviation":  "AST",
        "ianaTimeZoneId":  "America/Antigua",
        "windowsTimeZoneId":  "SA Western Standard Time",
        "utcOffset":  "-4:00"
    },
    {
        "genericName":  "SA Western Standard Time",
        "abbreviation":  "AST",
        "ianaTimeZoneId":  "America/St_Kitts",
        "windowsTimeZoneId":  "SA Western Standard Time",
        "utcOffset":  "-4:00"
    },
    {
        "genericName":  "SA Western Standard Time",
        "abbreviation":  "AST",
        "ianaTimeZoneId":  "America/Santo_Domingo",
        "windowsTimeZoneId":  "SA Western Standard Time",
        "utcOffset":  "-4:00"
    },
    {
        "genericName":  "SA Western Standard Time",
        "abbreviation":  "AST",
        "ianaTimeZoneId":  "America/St_Thomas",
        "windowsTimeZoneId":  "SA Western Standard Time",
        "utcOffset":  "-4:00"
    },
    {
        "genericName":  "SA Western Standard Time",
        "abbreviation":  "AST",
        "ianaTimeZoneId":  "America/Puerto_Rico",
        "windowsTimeZoneId":  "SA Western Standard Time",
        "utcOffset":  "-4:00"
    },
    {
        "genericName":  "SA Western Standard Time",
        "abbreviation":  "AST",
        "ianaTimeZoneId":  "America/St_Barthelemy",
        "windowsTimeZoneId":  "SA Western Standard Time",
        "utcOffset":  "-4:00"
    },
    {
        "genericName":  "SA Western Standard Time",
        "abbreviation":  "AST",
        "ianaTimeZoneId":  "America/Lower_Princes",
        "windowsTimeZoneId":  "SA Western Standard Time",
        "utcOffset":  "-4:00"
    },
    {
        "genericName":  "SA Western Standard Time",
        "abbreviation":  "AST",
        "ianaTimeZoneId":  "America/Marigot",
        "windowsTimeZoneId":  "SA Western Standard Time",
        "utcOffset":  "-4:00"
    },
    {
        "genericName":  "SA Western Standard Time",
        "abbreviation":  "AST",
        "ianaTimeZoneId":  "America/Anguilla",
        "windowsTimeZoneId":  "SA Western Standard Time",
        "utcOffset":  "-4:00"
    },
    {
        "genericName":  "SA Western Standard Time",
        "abbreviation":  "AST",
        "ianaTimeZoneId":  "America/Tortola",
        "windowsTimeZoneId":  "SA Western Standard Time",
        "utcOffset":  "-4:00"
    },
    {
        "genericName":  "Atlantic Standard Time",
        "abbreviation":  "AST",
        "ianaTimeZoneId":  "Atlantic/Bermuda",
        "windowsTimeZoneId":  "Atlantic Standard Time",
        "utcOffset":  "-4:00"
    },
    {
        "genericName":  "Atlantic Standard Time",
        "abbreviation":  "AST",
        "ianaTimeZoneId":  "America/Halifax",
        "windowsTimeZoneId":  "Atlantic Standard Time",
        "utcOffset":  "-4:00"
    },
    {
        "genericName":  "Atlantic Standard Time",
        "abbreviation":  "AST",
        "ianaTimeZoneId":  "America/Moncton",
        "windowsTimeZoneId":  "Atlantic Standard Time",
        "utcOffset":  "-4:00"
    },
    {
        "genericName":  "Atlantic Standard Time",
        "abbreviation":  "AST",
        "ianaTimeZoneId":  "America/Glace_Bay",
        "windowsTimeZoneId":  "Atlantic Standard Time",
        "utcOffset":  "-4:00"
    },
    {
        "genericName":  "SA Western Standard Time",
        "abbreviation":  "AST",
        "ianaTimeZoneId":  "America/Blanc-Sablon",
        "windowsTimeZoneId":  "SA Western Standard Time",
        "utcOffset":  "-4:00"
    },
    {
        "genericName":  "Atlantic Standard Time",
        "abbreviation":  "AST",
        "ianaTimeZoneId":  "America/Goose_Bay",
        "windowsTimeZoneId":  "Atlantic Standard Time",
        "utcOffset":  "-4:00"
    },
    {
        "genericName":  "Atlantic Standard Time",
        "abbreviation":  "AST",
        "ianaTimeZoneId":  "America/Thule",
        "windowsTimeZoneId":  "Atlantic Standard Time",
        "utcOffset":  "-4:00"
    },
    {
        "genericName":  "Newfoundland Standard Time",
        "abbreviation":  "NST",
        "ianaTimeZoneId":  "America/St_Johns",
        "windowsTimeZoneId":  "Newfoundland Standard Time",
        "utcOffset":  "-3:30"
    },
    {
        "genericName":  "Argentina Standard Time",
        "abbreviation":  "ART",
        "ianaTimeZoneId":  "America/Argentina/Ushuaia",
        "windowsTimeZoneId":  "Argentina Standard Time",
        "utcOffset":  "-3:00"
    },
    {
        "genericName":  "SA Eastern Standard Time",
        "abbreviation":  "FKST",
        "ianaTimeZoneId":  "Atlantic/Stanley",
        "windowsTimeZoneId":  "SA Eastern Standard Time",
        "utcOffset":  "-3:00"
    },
    {
        "genericName":  "Argentina Standard Time",
        "abbreviation":  "ART",
        "ianaTimeZoneId":  "America/Argentina/Rio_Gallegos",
        "windowsTimeZoneId":  "Argentina Standard Time",
        "utcOffset":  "-3:00"
    },
    {
        "genericName":  "Argentina Standard Time",
        "ianaTimeZoneId":  "America/Argentina/Catamarca",
        "windowsTimeZoneId":  "Argentina Standard Time",
        "utcOffset":  "-3:00"
    },
    {
        "genericName":  "Argentina Standard Time",
        "abbreviation":  "ART",
        "ianaTimeZoneId":  "America/Argentina/Salta",
        "windowsTimeZoneId":  "Argentina Standard Time",
        "utcOffset":  "-3:00"
    },
    {
        "genericName":  "Argentina Standard Time",
        "ianaTimeZoneId":  "America/Argentina/Buenos_Aires",
        "windowsTimeZoneId":  "Argentina Standard Time",
        "utcOffset":  "-3:00"
    },
    {
        "genericName":  "Argentina Standard Time",
        "ianaTimeZoneId":  "America/Argentina/Mendoza",
        "windowsTimeZoneId":  "Argentina Standard Time",
        "utcOffset":  "-3:00"
    },
    {
        "genericName":  "Montevideo Standard Time",
        "abbreviation":  "UYT",
        "ianaTimeZoneId":  "America/Montevideo",
        "windowsTimeZoneId":  "Montevideo Standard Time",
        "utcOffset":  "-3:00"
    },
    {
        "genericName":  "Argentina Standard Time",
        "abbreviation":  "ART",
        "ianaTimeZoneId":  "America/Argentina/San_Luis",
        "windowsTimeZoneId":  "Argentina Standard Time",
        "utcOffset":  "-3:00"
    },
    {
        "genericName":  "Argentina Standard Time",
        "ianaTimeZoneId":  "America/Argentina/Cordoba",
        "windowsTimeZoneId":  "Argentina Standard Time",
        "utcOffset":  "-3:00"
    },
    {
        "genericName":  "E. South America Standard Time",
        "ianaTimeZoneId":  "America/Sao_Paulo",
        "windowsTimeZoneId":  "E. South America Standard Time",
        "utcOffset":  "-3:00"
    },
    {
        "genericName":  "Argentina Standard Time",
        "abbreviation":  "ART",
        "ianaTimeZoneId":  "America/Argentina/San_Juan",
        "windowsTimeZoneId":  "Argentina Standard Time",
        "utcOffset":  "-3:00"
    },
    {
        "genericName":  "Argentina Standard Time",
        "abbreviation":  "ART",
        "ianaTimeZoneId":  "America/Argentina/La_Rioja",
        "windowsTimeZoneId":  "Argentina Standard Time",
        "utcOffset":  "-3:00"
    },
    {
        "genericName":  "Argentina Standard Time",
        "abbreviation":  "ART",
        "ianaTimeZoneId":  "America/Argentina/Tucuman",
        "windowsTimeZoneId":  "Argentina Standard Time",
        "utcOffset":  "-3:00"
    },
    {
        "genericName":  "Argentina Standard Time",
        "ianaTimeZoneId":  "America/Argentina/Jujuy",
        "windowsTimeZoneId":  "Argentina Standard Time",
        "utcOffset":  "-3:00"
    },
    {
        "genericName":  "Bahia Standard Time",
        "abbreviation":  "BRT",
        "ianaTimeZoneId":  "America/Bahia",
        "windowsTimeZoneId":  "Bahia Standard Time",
        "utcOffset":  "-3:00"
    },
    {
        "genericName":  "Tocantins Standard Time",
        "abbreviation":  "BRT",
        "ianaTimeZoneId":  "America/Araguaina",
        "windowsTimeZoneId":  "Tocantins Standard Time",
        "utcOffset":  "-3:00"
    },
    {
        "genericName":  "SA Eastern Standard Time",
        "abbreviation":  "BRT",
        "ianaTimeZoneId":  "America/Maceio",
        "windowsTimeZoneId":  "SA Eastern Standard Time",
        "utcOffset":  "-3:00"
    },
    {
        "genericName":  "SA Eastern Standard Time",
        "abbreviation":  "BRT",
        "ianaTimeZoneId":  "America/Fortaleza",
        "windowsTimeZoneId":  "SA Eastern Standard Time",
        "utcOffset":  "-3:00"
    },
    {
        "genericName":  "SA Eastern Standard Time",
        "abbreviation":  "BRT",
        "ianaTimeZoneId":  "America/Recife",
        "windowsTimeZoneId":  "SA Eastern Standard Time",
        "utcOffset":  "-3:00"
    },
    {
        "genericName":  "SA Eastern Standard Time",
        "abbreviation":  "BRT",
        "ianaTimeZoneId":  "America/Belem",
        "windowsTimeZoneId":  "SA Eastern Standard Time",
        "utcOffset":  "-3:00"
    },
    {
        "genericName":  "SA Eastern Standard Time",
        "abbreviation":  "BRT",
        "ianaTimeZoneId":  "America/Santarem",
        "windowsTimeZoneId":  "SA Eastern Standard Time",
        "utcOffset":  "-3:00"
    },
    {
        "genericName":  "SA Eastern Standard Time",
        "abbreviation":  "GFT",
        "ianaTimeZoneId":  "America/Cayenne",
        "windowsTimeZoneId":  "SA Eastern Standard Time",
        "utcOffset":  "-3:00"
    },
    {
        "genericName":  "SA Eastern Standard Time",
        "abbreviation":  "SRT",
        "ianaTimeZoneId":  "America/Paramaribo",
        "windowsTimeZoneId":  "SA Eastern Standard Time",
        "utcOffset":  "-3:00"
    },
    {
        "genericName":  "Saint Pierre Standard Time",
        "abbreviation":  "PMST",
        "ianaTimeZoneId":  "America/Miquelon",
        "windowsTimeZoneId":  "Saint Pierre Standard Time",
        "utcOffset":  "-3:00"
    },
    {
        "genericName":  "Greenland Standard Time",
        "abbreviation":  "WGT",
        "ianaTimeZoneId":  "America/Godthab",
        "windowsTimeZoneId":  "Greenland Standard Time",
        "utcOffset":  "-3:00"
    },
    {
        "genericName":  "UTC-02",
        "abbreviation":  "GST",
        "ianaTimeZoneId":  "Atlantic/South_Georgia",
        "windowsTimeZoneId":  "UTC-02",
        "utcOffset":  "-2:00"
    },
    {
        "genericName":  "UTC-02",
        "abbreviation":  "FNT",
        "ianaTimeZoneId":  "America/Noronha",
        "windowsTimeZoneId":  "UTC-02",
        "utcOffset":  "-2:00"
    },
    {
        "genericName":  "Cabo Verde Standard Time",
        "abbreviation":  "CVT",
        "ianaTimeZoneId":  "Atlantic/Cape_Verde",
        "windowsTimeZoneId":  "Cape Verde Standard Time",
        "utcOffset":  "-1:00"
    },
    {
        "genericName":  "Azores Standard Time",
        "abbreviation":  "AZOT",
        "ianaTimeZoneId":  "Atlantic/Azores",
        "windowsTimeZoneId":  "Azores Standard Time",
        "utcOffset":  "-1:00"
    },
    {
        "genericName":  "Azores Standard Time",
        "abbreviation":  "AZOT",
        "ianaTimeZoneId":  "America/Scoresbysund",
        "windowsTimeZoneId":  "Azores Standard Time",
        "utcOffset":  "-1:00"
    },
    {
        "genericName":  "Greenwich Standard Time",
        "abbreviation":  "GMT",
        "ianaTimeZoneId":  "Atlantic/St_Helena",
        "windowsTimeZoneId":  "Greenwich Standard Time",
        "utcOffset":  "-0:00"
    },
    {
        "genericName":  "Sao Tome Standard Time",
        "abbreviation":  "GMT",
        "ianaTimeZoneId":  "Africa/Sao_Tome",
        "windowsTimeZoneId":  "Sao Tome Standard Time",
        "utcOffset":  "-0:00"
    },
    {
        "genericName":  "Greenwich Standard Time",
        "abbreviation":  "GMT",
        "ianaTimeZoneId":  "Africa/Monrovia",
        "windowsTimeZoneId":  "Greenwich Standard Time",
        "utcOffset":  "-0:00"
    },
    {
        "genericName":  "Greenwich Standard Time",
        "abbreviation":  "GMT",
        "ianaTimeZoneId":  "Africa/Abidjan",
        "windowsTimeZoneId":  "Greenwich Standard Time",
        "utcOffset":  "-0:00"
    },
    {
        "genericName":  "Greenwich Standard Time",
        "abbreviation":  "GMT",
        "ianaTimeZoneId":  "Africa/Accra",
        "windowsTimeZoneId":  "Greenwich Standard Time",
        "utcOffset":  "-0:00"
    },
    {
        "genericName":  "Greenwich Standard Time",
        "abbreviation":  "GMT",
        "ianaTimeZoneId":  "Africa/Lome",
        "windowsTimeZoneId":  "Greenwich Standard Time",
        "utcOffset":  "-0:00"
    },
    {
        "genericName":  "Greenwich Standard Time",
        "abbreviation":  "GMT",
        "ianaTimeZoneId":  "Africa/Freetown",
        "windowsTimeZoneId":  "Greenwich Standard Time",
        "utcOffset":  "-0:00"
    },
    {
        "genericName":  "Greenwich Standard Time",
        "abbreviation":  "GMT",
        "ianaTimeZoneId":  "Africa/Conakry",
        "windowsTimeZoneId":  "Greenwich Standard Time",
        "utcOffset":  "-0:00"
    },
    {
        "genericName":  "Greenwich Standard Time",
        "abbreviation":  "GMT",
        "ianaTimeZoneId":  "Africa/Bamako",
        "windowsTimeZoneId":  "Greenwich Standard Time",
        "utcOffset":  "-0:00"
    },
    {
        "genericName":  "Greenwich Standard Time",
        "abbreviation":  "GMT",
        "ianaTimeZoneId":  "Africa/Ouagadougou",
        "windowsTimeZoneId":  "Greenwich Standard Time",
        "utcOffset":  "-0:00"
    },
    {
        "genericName":  "Greenwich Standard Time",
        "abbreviation":  "GMT",
        "ianaTimeZoneId":  "Africa/Bissau",
        "windowsTimeZoneId":  "Greenwich Standard Time",
        "utcOffset":  "-0:00"
    },
    {
        "genericName":  "Greenwich Standard Time",
        "abbreviation":  "GMT",
        "ianaTimeZoneId":  "Africa/Dakar",
        "windowsTimeZoneId":  "Greenwich Standard Time",
        "utcOffset":  "-0:00"
    },
    {
        "genericName":  "Greenwich Standard Time",
        "abbreviation":  "GMT",
        "ianaTimeZoneId":  "Africa/Banjul",
        "windowsTimeZoneId":  "Greenwich Standard Time",
        "utcOffset":  "-0:00"
    },
    {
        "genericName":  "Greenwich Standard Time",
        "abbreviation":  "GMT",
        "ianaTimeZoneId":  "Africa/Nouakchott",
        "windowsTimeZoneId":  "Greenwich Standard Time",
        "utcOffset":  "-0:00"
    },
    {
        "genericName":  "Morocco Standard Time",
        "ianaTimeZoneId":  "Africa/El_Aaiun",
        "windowsTimeZoneId":  "Morocco Standard Time",
        "utcOffset":  "-0:00"
    },
    {
        "genericName":  "GMT Standard Time",
        "abbreviation":  "WET",
        "ianaTimeZoneId":  "Atlantic/Canary",
        "windowsTimeZoneId":  "GMT Standard Time",
        "utcOffset":  "-0:00"
    },
    {
        "genericName":  "GMT Standard Time",
        "abbreviation":  "WET",
        "ianaTimeZoneId":  "Atlantic/Madeira",
        "windowsTimeZoneId":  "GMT Standard Time",
        "utcOffset":  "-0:00"
    },
    {
        "genericName":  "Morocco Standard Time",
        "ianaTimeZoneId":  "Africa/Casablanca",
        "windowsTimeZoneId":  "Morocco Standard Time",
        "utcOffset":  "-0:00"
    },
    {
        "genericName":  "GMT Standard Time",
        "abbreviation":  "WET",
        "ianaTimeZoneId":  "Europe/Lisbon",
        "windowsTimeZoneId":  "GMT Standard Time",
        "utcOffset":  "-0:00"
    },
    {
        "genericName":  "GMT Standard Time",
        "abbreviation":  "GMT",
        "ianaTimeZoneId":  "Europe/Jersey",
        "windowsTimeZoneId":  "GMT Standard Time",
        "utcOffset":  "-0:00"
    },
    {
        "genericName":  "GMT Standard Time",
        "abbreviation":  "GMT",
        "ianaTimeZoneId":  "Europe/Guernsey",
        "windowsTimeZoneId":  "GMT Standard Time",
        "utcOffset":  "-0:00"
    },
    {
        "genericName":  "GMT Standard Time",
        "abbreviation":  "GMT",
        "ianaTimeZoneId":  "Europe/London",
        "windowsTimeZoneId":  "GMT Standard Time",
        "utcOffset":  "-0:00"
    },
    {
        "genericName":  "GMT Standard Time",
        "abbreviation":  "IST",
        "ianaTimeZoneId":  "Europe/Dublin",
        "windowsTimeZoneId":  "GMT Standard Time",
        "utcOffset":  "-0:00"
    },
    {
        "genericName":  "GMT Standard Time",
        "abbreviation":  "GMT",
        "ianaTimeZoneId":  "Europe/Isle_of_Man",
        "windowsTimeZoneId":  "GMT Standard Time",
        "utcOffset":  "-0:00"
    },
    {
        "genericName":  "GMT Standard Time",
        "ianaTimeZoneId":  "Atlantic/Faroe",
        "windowsTimeZoneId":  "GMT Standard Time",
        "utcOffset":  "-0:00"
    },
    {
        "genericName":  "Greenwich Standard Time",
        "abbreviation":  "GMT",
        "ianaTimeZoneId":  "Atlantic/Reykjavik",
        "windowsTimeZoneId":  "Greenwich Standard Time",
        "utcOffset":  "-0:00"
    },
    {
        "genericName":  "UTC",
        "abbreviation":  "GMT",
        "ianaTimeZoneId":  "America/Danmarkshavn",
        "windowsTimeZoneId":  "UTC",
        "utcOffset":  "-0:00"
    },
    {
        "genericName":  "W. Central Africa Standard Time",
        "abbreviation":  "WAT",
        "ianaTimeZoneId":  "Africa/Luanda",
        "windowsTimeZoneId":  "W. Central Africa Standard Time",
        "utcOffset":  "1:00"
    },
    {
        "genericName":  "W. Central Africa Standard Time",
        "abbreviation":  "WAT",
        "ianaTimeZoneId":  "Africa/Kinshasa",
        "windowsTimeZoneId":  "W. Central Africa Standard Time",
        "utcOffset":  "1:00"
    },
    {
        "genericName":  "W. Central Africa Standard Time",
        "abbreviation":  "WAT",
        "ianaTimeZoneId":  "Africa/Brazzaville",
        "windowsTimeZoneId":  "W. Central Africa Standard Time",
        "utcOffset":  "1:00"
    },
    {
        "genericName":  "W. Central Africa Standard Time",
        "abbreviation":  "WAT",
        "ianaTimeZoneId":  "Africa/Libreville",
        "windowsTimeZoneId":  "W. Central Africa Standard Time",
        "utcOffset":  "1:00"
    },
    {
        "genericName":  "W. Central Africa Standard Time",
        "abbreviation":  "WAT",
        "ianaTimeZoneId":  "Africa/Malabo",
        "windowsTimeZoneId":  "W. Central Africa Standard Time",
        "utcOffset":  "1:00"
    },
    {
        "genericName":  "W. Central Africa Standard Time",
        "abbreviation":  "WAT",
        "ianaTimeZoneId":  "Africa/Douala",
        "windowsTimeZoneId":  "W. Central Africa Standard Time",
        "utcOffset":  "1:00"
    },
    {
        "genericName":  "W. Central Africa Standard Time",
        "abbreviation":  "WAT",
        "ianaTimeZoneId":  "Africa/Bangui",
        "windowsTimeZoneId":  "W. Central Africa Standard Time",
        "utcOffset":  "1:00"
    },
    {
        "genericName":  "W. Central Africa Standard Time",
        "abbreviation":  "WAT",
        "ianaTimeZoneId":  "Africa/Lagos",
        "windowsTimeZoneId":  "W. Central Africa Standard Time",
        "utcOffset":  "1:00"
    },
    {
        "genericName":  "W. Central Africa Standard Time",
        "abbreviation":  "WAT",
        "ianaTimeZoneId":  "Africa/Porto-Novo",
        "windowsTimeZoneId":  "W. Central Africa Standard Time",
        "utcOffset":  "1:00"
    },
    {
        "genericName":  "W. Central Africa Standard Time",
        "abbreviation":  "WAT",
        "ianaTimeZoneId":  "Africa/Ndjamena",
        "windowsTimeZoneId":  "W. Central Africa Standard Time",
        "utcOffset":  "1:00"
    },
    {
        "genericName":  "W. Central Africa Standard Time",
        "abbreviation":  "WAT",
        "ianaTimeZoneId":  "Africa/Niamey",
        "windowsTimeZoneId":  "W. Central Africa Standard Time",
        "utcOffset":  "1:00"
    },
    {
        "genericName":  "W. Central Africa Standard Time",
        "abbreviation":  "CET",
        "ianaTimeZoneId":  "Africa/Algiers",
        "windowsTimeZoneId":  "W. Central Africa Standard Time",
        "utcOffset":  "1:00"
    },
    {
        "genericName":  "W. Central Africa Standard Time",
        "abbreviation":  "CET",
        "ianaTimeZoneId":  "Africa/Tunis",
        "windowsTimeZoneId":  "W. Central Africa Standard Time",
        "utcOffset":  "1:00"
    },
    {
        "genericName":  "Romance Standard Time",
        "abbreviation":  "CET",
        "ianaTimeZoneId":  "Africa/Ceuta",
        "windowsTimeZoneId":  "Romance Standard Time",
        "utcOffset":  "1:00"
    },
    {
        "genericName":  "W. Europe Standard Time",
        "abbreviation":  "CET",
        "ianaTimeZoneId":  "Europe/Rome",
        "windowsTimeZoneId":  "W. Europe Standard Time",
        "utcOffset":  "1:00"
    },
    {
        "genericName":  "W. Europe Standard Time",
        "abbreviation":  "CET",
        "ianaTimeZoneId":  "Europe/Malta",
        "windowsTimeZoneId":  "W. Europe Standard Time",
        "utcOffset":  "1:00"
    },
    {
        "genericName":  "Romance Standard Time",
        "abbreviation":  "CET",
        "ianaTimeZoneId":  "Europe/Madrid",
        "windowsTimeZoneId":  "Romance Standard Time",
        "utcOffset":  "1:00"
    },
    {
        "genericName":  "W. Europe Standard Time",
        "abbreviation":  "CET",
        "ianaTimeZoneId":  "Europe/Gibraltar",
        "windowsTimeZoneId":  "W. Europe Standard Time",
        "utcOffset":  "1:00"
    },
    {
        "genericName":  "Central Europe Standard Time",
        "abbreviation":  "CET",
        "ianaTimeZoneId":  "Europe/Tirane",
        "windowsTimeZoneId":  "Central Europe Standard Time",
        "utcOffset":  "1:00"
    },
    {
        "genericName":  "Central European Standard Time",
        "abbreviation":  "CET",
        "ianaTimeZoneId":  "Europe/Skopje",
        "windowsTimeZoneId":  "Central European Standard Time",
        "utcOffset":  "1:00"
    },
    {
        "genericName":  "Romance Standard Time",
        "abbreviation":  "CET",
        "ianaTimeZoneId":  "Europe/Paris",
        "windowsTimeZoneId":  "Romance Standard Time",
        "utcOffset":  "1:00"
    },
    {
        "genericName":  "Central Europe Standard Time",
        "abbreviation":  "CET",
        "ianaTimeZoneId":  "Europe/Belgrade",
        "windowsTimeZoneId":  "Central Europe Standard Time",
        "utcOffset":  "1:00"
    },
    {
        "genericName":  "W. Europe Standard Time",
        "abbreviation":  "CET",
        "ianaTimeZoneId":  "Europe/Vatican",
        "windowsTimeZoneId":  "W. Europe Standard Time",
        "utcOffset":  "1:00"
    },
    {
        "genericName":  "Central European Standard Time",
        "abbreviation":  "CET",
        "ianaTimeZoneId":  "Europe/Zagreb",
        "windowsTimeZoneId":  "Central European Standard Time",
        "utcOffset":  "1:00"
    },
    {
        "genericName":  "Central Europe Standard Time",
        "abbreviation":  "CET",
        "ianaTimeZoneId":  "Europe/Podgorica",
        "windowsTimeZoneId":  "Central Europe Standard Time",
        "utcOffset":  "1:00"
    },
    {
        "genericName":  "W. Europe Standard Time",
        "abbreviation":  "CET",
        "ianaTimeZoneId":  "Europe/Andorra",
        "windowsTimeZoneId":  "W. Europe Standard Time",
        "utcOffset":  "1:00"
    },
    {
        "genericName":  "Central European Standard Time",
        "abbreviation":  "CET",
        "ianaTimeZoneId":  "Europe/Sarajevo",
        "windowsTimeZoneId":  "Central European Standard Time",
        "utcOffset":  "1:00"
    },
    {
        "genericName":  "W. Europe Standard Time",
        "abbreviation":  "CET",
        "ianaTimeZoneId":  "Europe/Monaco",
        "windowsTimeZoneId":  "W. Europe Standard Time",
        "utcOffset":  "1:00"
    },
    {
        "genericName":  "W. Europe Standard Time",
        "abbreviation":  "CET",
        "ianaTimeZoneId":  "Europe/San_Marino",
        "windowsTimeZoneId":  "W. Europe Standard Time",
        "utcOffset":  "1:00"
    },
    {
        "genericName":  "Central Europe Standard Time",
        "abbreviation":  "CET",
        "ianaTimeZoneId":  "Europe/Budapest",
        "windowsTimeZoneId":  "Central Europe Standard Time",
        "utcOffset":  "1:00"
    },
    {
        "genericName":  "Central Europe Standard Time",
        "abbreviation":  "CET",
        "ianaTimeZoneId":  "Europe/Ljubljana",
        "windowsTimeZoneId":  "Central Europe Standard Time",
        "utcOffset":  "1:00"
    },
    {
        "genericName":  "W. Europe Standard Time",
        "abbreviation":  "CET",
        "ianaTimeZoneId":  "Europe/Zurich",
        "windowsTimeZoneId":  "W. Europe Standard Time",
        "utcOffset":  "1:00"
    },
    {
        "genericName":  "W. Europe Standard Time",
        "abbreviation":  "CET",
        "ianaTimeZoneId":  "Europe/Vaduz",
        "windowsTimeZoneId":  "W. Europe Standard Time",
        "utcOffset":  "1:00"
    },
    {
        "genericName":  "W. Europe Standard Time",
        "abbreviation":  "CET",
        "ianaTimeZoneId":  "Europe/Vienna",
        "windowsTimeZoneId":  "W. Europe Standard Time",
        "utcOffset":  "1:00"
    },
    {
        "genericName":  "W. Europe Standard Time",
        "abbreviation":  "CET",
        "ianaTimeZoneId":  "Europe/Berlin",
        "windowsTimeZoneId":  "W. Europe Standard Time",
        "utcOffset":  "1:00"
    },
    {
        "genericName":  "W. Europe Standard Time",
        "abbreviation":  "CET",
        "ianaTimeZoneId":  "Europe/Busingen",
        "windowsTimeZoneId":  "W. Europe Standard Time",
        "utcOffset":  "1:00"
    },
    {
        "genericName":  "Central Europe Standard Time",
        "abbreviation":  "CET",
        "ianaTimeZoneId":  "Europe/Bratislava",
        "windowsTimeZoneId":  "Central Europe Standard Time",
        "utcOffset":  "1:00"
    },
    {
        "genericName":  "Central Europe Standard Time",
        "abbreviation":  "CET",
        "ianaTimeZoneId":  "Europe/Prague",
        "windowsTimeZoneId":  "Central Europe Standard Time",
        "utcOffset":  "1:00"
    },
    {
        "genericName":  "W. Europe Standard Time",
        "abbreviation":  "CET",
        "ianaTimeZoneId":  "Europe/Luxembourg",
        "windowsTimeZoneId":  "W. Europe Standard Time",
        "utcOffset":  "1:00"
    },
    {
        "genericName":  "Central European Standard Time",
        "abbreviation":  "CET",
        "ianaTimeZoneId":  "Europe/Warsaw",
        "windowsTimeZoneId":  "Central European Standard Time",
        "utcOffset":  "1:00"
    },
    {
        "genericName":  "Romance Standard Time",
        "abbreviation":  "CET",
        "ianaTimeZoneId":  "Europe/Brussels",
        "windowsTimeZoneId":  "Romance Standard Time",
        "utcOffset":  "1:00"
    },
    {
        "genericName":  "W. Europe Standard Time",
        "abbreviation":  "CET",
        "ianaTimeZoneId":  "Europe/Amsterdam",
        "windowsTimeZoneId":  "W. Europe Standard Time",
        "utcOffset":  "1:00"
    },
    {
        "genericName":  "Romance Standard Time",
        "abbreviation":  "CET",
        "ianaTimeZoneId":  "Europe/Copenhagen",
        "windowsTimeZoneId":  "Romance Standard Time",
        "utcOffset":  "1:00"
    },
    {
        "genericName":  "W. Europe Standard Time",
        "abbreviation":  "CET",
        "ianaTimeZoneId":  "Europe/Stockholm",
        "windowsTimeZoneId":  "W. Europe Standard Time",
        "utcOffset":  "1:00"
    },
    {
        "genericName":  "W. Europe Standard Time",
        "abbreviation":  "CET",
        "ianaTimeZoneId":  "Europe/Oslo",
        "windowsTimeZoneId":  "W. Europe Standard Time",
        "utcOffset":  "1:00"
    },
    {
        "genericName":  "W. Europe Standard Time",
        "abbreviation":  "CET",
        "ianaTimeZoneId":  "Arctic/Longyearbyen",
        "windowsTimeZoneId":  "W. Europe Standard Time",
        "utcOffset":  "1:00"
    },
    {
        "genericName":  "South Africa Standard Time",
        "abbreviation":  "SAST",
        "ianaTimeZoneId":  "Africa/Johannesburg",
        "windowsTimeZoneId":  "South Africa Standard Time",
        "utcOffset":  "2:00"
    },
    {
        "genericName":  "South Africa Standard Time",
        "abbreviation":  "SAST",
        "ianaTimeZoneId":  "Africa/Maseru",
        "windowsTimeZoneId":  "South Africa Standard Time",
        "utcOffset":  "2:00"
    },
    {
        "genericName":  "Namibia Standard Time",
        "abbreviation":  "WAST",
        "ianaTimeZoneId":  "Africa/Windhoek",
        "windowsTimeZoneId":  "Namibia Standard Time",
        "utcOffset":  "2:00"
    },
    {
        "genericName":  "South Africa Standard Time",
        "abbreviation":  "SAST",
        "ianaTimeZoneId":  "Africa/Mbabane",
        "windowsTimeZoneId":  "South Africa Standard Time",
        "utcOffset":  "2:00"
    },
    {
        "genericName":  "South Africa Standard Time",
        "abbreviation":  "CAT",
        "ianaTimeZoneId":  "Africa/Maputo",
        "windowsTimeZoneId":  "South Africa Standard Time",
        "utcOffset":  "2:00"
    },
    {
        "genericName":  "South Africa Standard Time",
        "abbreviation":  "CAT",
        "ianaTimeZoneId":  "Africa/Gaborone",
        "windowsTimeZoneId":  "South Africa Standard Time",
        "utcOffset":  "2:00"
    },
    {
        "genericName":  "South Africa Standard Time",
        "abbreviation":  "CAT",
        "ianaTimeZoneId":  "Africa/Harare",
        "windowsTimeZoneId":  "South Africa Standard Time",
        "utcOffset":  "2:00"
    },
    {
        "genericName":  "South Africa Standard Time",
        "abbreviation":  "CAT",
        "ianaTimeZoneId":  "Africa/Lusaka",
        "windowsTimeZoneId":  "South Africa Standard Time",
        "utcOffset":  "2:00"
    },
    {
        "genericName":  "South Africa Standard Time",
        "abbreviation":  "CAT",
        "ianaTimeZoneId":  "Africa/Blantyre",
        "windowsTimeZoneId":  "South Africa Standard Time",
        "utcOffset":  "2:00"
    },
    {
        "genericName":  "South Africa Standard Time",
        "abbreviation":  "CAT",
        "ianaTimeZoneId":  "Africa/Lubumbashi",
        "windowsTimeZoneId":  "South Africa Standard Time",
        "utcOffset":  "2:00"
    },
    {
        "genericName":  "South Africa Standard Time",
        "abbreviation":  "CAT",
        "ianaTimeZoneId":  "Africa/Bujumbura",
        "windowsTimeZoneId":  "South Africa Standard Time",
        "utcOffset":  "2:00"
    },
    {
        "genericName":  "South Africa Standard Time",
        "abbreviation":  "CAT",
        "ianaTimeZoneId":  "Africa/Kigali",
        "windowsTimeZoneId":  "South Africa Standard Time",
        "utcOffset":  "2:00"
    },
    {
        "genericName":  "Sudan Standard Time",
        "abbreviation":  "EAT",
        "ianaTimeZoneId":  "Africa/Khartoum",
        "windowsTimeZoneId":  "Sudan Standard Time",
        "utcOffset":  "2:00"
    },
    {
        "genericName":  "Egypt Standard Time",
        "abbreviation":  "EET",
        "ianaTimeZoneId":  "Africa/Cairo",
        "windowsTimeZoneId":  "Egypt Standard Time",
        "utcOffset":  "2:00"
    },
    {
        "genericName":  "Libya Standard Time",
        "abbreviation":  "EET",
        "ianaTimeZoneId":  "Africa/Tripoli",
        "windowsTimeZoneId":  "Libya Standard Time",
        "utcOffset":  "2:00"
    },
    {
        "genericName":  "Jerusalem Standard Time",
        "abbreviation":  "IST",
        "ianaTimeZoneId":  "Asia/Jerusalem",
        "windowsTimeZoneId":  "Israel Standard Time",
        "utcOffset":  "2:00"
    },
    {
        "genericName":  "West Bank Gaza Standard Time",
        "abbreviation":  "EET",
        "ianaTimeZoneId":  "Asia/Gaza",
        "windowsTimeZoneId":  "West Bank Standard Time",
        "utcOffset":  "2:00"
    },
    {
        "genericName":  "West Bank Gaza Standard Time",
        "abbreviation":  "EET",
        "ianaTimeZoneId":  "Asia/Hebron",
        "windowsTimeZoneId":  "West Bank Standard Time",
        "utcOffset":  "2:00"
    },
    {
        "genericName":  "Syria Standard Time",
        "abbreviation":  "EET",
        "ianaTimeZoneId":  "Asia/Damascus",
        "windowsTimeZoneId":  "Syria Standard Time",
        "utcOffset":  "2:00"
    },
    {
        "genericName":  "Middle East Standard Time",
        "abbreviation":  "EET",
        "ianaTimeZoneId":  "Asia/Beirut",
        "windowsTimeZoneId":  "Middle East Standard Time",
        "utcOffset":  "2:00"
    },
    {
        "genericName":  "GTB Standard Time",
        "abbreviation":  "EET",
        "ianaTimeZoneId":  "Asia/Nicosia",
        "windowsTimeZoneId":  "GTB Standard Time",
        "utcOffset":  "2:00"
    },
    {
        "genericName":  "GTB Standard Time",
        "abbreviation":  "EET",
        "ianaTimeZoneId":  "Europe/Athens",
        "windowsTimeZoneId":  "GTB Standard Time",
        "utcOffset":  "2:00"
    },
    {
        "genericName":  "FLE Standard Time",
        "abbreviation":  "EET",
        "ianaTimeZoneId":  "Europe/Sofia",
        "windowsTimeZoneId":  "FLE Standard Time",
        "utcOffset":  "2:00"
    },
    {
        "genericName":  "GTB Standard Time",
        "abbreviation":  "EET",
        "ianaTimeZoneId":  "Europe/Bucharest",
        "windowsTimeZoneId":  "GTB Standard Time",
        "utcOffset":  "2:00"
    },
    {
        "genericName":  "FLE Standard Time",
        "abbreviation":  "EET",
        "ianaTimeZoneId":  "Europe/Kiev",
        "windowsTimeZoneId":  "FLE Standard Time",
        "utcOffset":  "2:00"
    },
    {
        "genericName":  "E. Europe Standard Time",
        "abbreviation":  "EET",
        "ianaTimeZoneId":  "Europe/Chisinau",
        "windowsTimeZoneId":  "E. Europe Standard Time",
        "utcOffset":  "2:00"
    },
    {
        "genericName":  "FLE Standard Time",
        "abbreviation":  "EET",
        "ianaTimeZoneId":  "Europe/Zaporozhye",
        "windowsTimeZoneId":  "FLE Standard Time",
        "utcOffset":  "2:00"
    },
    {
        "genericName":  "FLE Standard Time",
        "abbreviation":  "EET",
        "ianaTimeZoneId":  "Europe/Uzhgorod",
        "windowsTimeZoneId":  "FLE Standard Time",
        "utcOffset":  "2:00"
    },
    {
        "genericName":  "FLE Standard Time",
        "abbreviation":  "EET",
        "ianaTimeZoneId":  "Europe/Vilnius",
        "windowsTimeZoneId":  "FLE Standard Time",
        "utcOffset":  "2:00"
    },
    {
        "genericName":  "Russia TZ 1 Standard Time",
        "abbreviation":  "EET",
        "ianaTimeZoneId":  "Europe/Kaliningrad",
        "windowsTimeZoneId":  "Kaliningrad Standard Time",
        "utcOffset":  "2:00"
    },
    {
        "genericName":  "FLE Standard Time",
        "abbreviation":  "EET",
        "ianaTimeZoneId":  "Europe/Riga",
        "windowsTimeZoneId":  "FLE Standard Time",
        "utcOffset":  "2:00"
    },
    {
        "genericName":  "FLE Standard Time",
        "abbreviation":  "EET",
        "ianaTimeZoneId":  "Europe/Tallinn",
        "windowsTimeZoneId":  "FLE Standard Time",
        "utcOffset":  "2:00"
    },
    {
        "genericName":  "FLE Standard Time",
        "abbreviation":  "EET",
        "ianaTimeZoneId":  "Europe/Helsinki",
        "windowsTimeZoneId":  "FLE Standard Time",
        "utcOffset":  "2:00"
    },
    {
        "genericName":  "FLE Standard Time",
        "abbreviation":  "EET",
        "ianaTimeZoneId":  "Europe/Mariehamn",
        "windowsTimeZoneId":  "FLE Standard Time",
        "utcOffset":  "2:00"
    },
    {
        "genericName":  "E. Africa Standard Time",
        "abbreviation":  "EAT",
        "ianaTimeZoneId":  "Indian/Antananarivo",
        "windowsTimeZoneId":  "E. Africa Standard Time",
        "utcOffset":  "3:00"
    },
    {
        "genericName":  "E. Africa Standard Time",
        "abbreviation":  "EAT",
        "ianaTimeZoneId":  "Indian/Mayotte",
        "windowsTimeZoneId":  "E. Africa Standard Time",
        "utcOffset":  "3:00"
    },
    {
        "genericName":  "E. Africa Standard Time",
        "abbreviation":  "EAT",
        "ianaTimeZoneId":  "Indian/Comoro",
        "windowsTimeZoneId":  "E. Africa Standard Time",
        "utcOffset":  "3:00"
    },
    {
        "genericName":  "E. Africa Standard Time",
        "abbreviation":  "EAT",
        "ianaTimeZoneId":  "Africa/Dar_es_Salaam",
        "windowsTimeZoneId":  "E. Africa Standard Time",
        "utcOffset":  "3:00"
    },
    {
        "genericName":  "E. Africa Standard Time",
        "abbreviation":  "EAT",
        "ianaTimeZoneId":  "Africa/Nairobi",
        "windowsTimeZoneId":  "E. Africa Standard Time",
        "utcOffset":  "3:00"
    },
    {
        "genericName":  "E. Africa Standard Time",
        "abbreviation":  "EAT",
        "ianaTimeZoneId":  "Africa/Mogadishu",
        "windowsTimeZoneId":  "E. Africa Standard Time",
        "utcOffset":  "3:00"
    },
    {
        "genericName":  "E. Africa Standard Time",
        "abbreviation":  "EAT",
        "ianaTimeZoneId":  "Africa/Kampala",
        "windowsTimeZoneId":  "E. Africa Standard Time",
        "utcOffset":  "3:00"
    },
    {
        "genericName":  "E. Africa Standard Time",
        "abbreviation":  "EAT",
        "ianaTimeZoneId":  "Africa/Juba",
        "windowsTimeZoneId":  "E. Africa Standard Time",
        "utcOffset":  "3:00"
    },
    {
        "genericName":  "E. Africa Standard Time",
        "abbreviation":  "EAT",
        "ianaTimeZoneId":  "Africa/Addis_Ababa",
        "windowsTimeZoneId":  "E. Africa Standard Time",
        "utcOffset":  "3:00"
    },
    {
        "genericName":  "E. Africa Standard Time",
        "abbreviation":  "EAT",
        "ianaTimeZoneId":  "Africa/Djibouti",
        "windowsTimeZoneId":  "E. Africa Standard Time",
        "utcOffset":  "3:00"
    },
    {
        "genericName":  "Arab Standard Time",
        "abbreviation":  "AST",
        "ianaTimeZoneId":  "Asia/Aden",
        "windowsTimeZoneId":  "Arab Standard Time",
        "utcOffset":  "3:00"
    },
    {
        "genericName":  "E. Africa Standard Time",
        "ianaTimeZoneId":  "Africa/Asmara",
        "windowsTimeZoneId":  "E. Africa Standard Time",
        "utcOffset":  "3:00"
    },
    {
        "genericName":  "Arab Standard Time",
        "abbreviation":  "AST",
        "ianaTimeZoneId":  "Asia/Riyadh",
        "windowsTimeZoneId":  "Arab Standard Time",
        "utcOffset":  "3:00"
    },
    {
        "genericName":  "Arab Standard Time",
        "abbreviation":  "AST",
        "ianaTimeZoneId":  "Asia/Qatar",
        "windowsTimeZoneId":  "Arab Standard Time",
        "utcOffset":  "3:00"
    },
    {
        "genericName":  "Arab Standard Time",
        "abbreviation":  "AST",
        "ianaTimeZoneId":  "Asia/Bahrain",
        "windowsTimeZoneId":  "Arab Standard Time",
        "utcOffset":  "3:00"
    },
    {
        "genericName":  "Arab Standard Time",
        "abbreviation":  "AST",
        "ianaTimeZoneId":  "Asia/Kuwait",
        "windowsTimeZoneId":  "Arab Standard Time",
        "utcOffset":  "3:00"
    },
    {
        "genericName":  "Arabic Standard Time",
        "abbreviation":  "AST",
        "ianaTimeZoneId":  "Asia/Baghdad",
        "windowsTimeZoneId":  "Arabic Standard Time",
        "utcOffset":  "3:00"
    },
    {
        "genericName":  "Jordan Standard Time",
        "abbreviation":  "EET",
        "ianaTimeZoneId":  "Asia/Amman",
        "windowsTimeZoneId":  "Jordan Standard Time",
        "utcOffset":  "3:00"
    },
    {
        "genericName":  "Turkey Standard Time",
        "abbreviation":  "EET",
        "ianaTimeZoneId":  "Europe/Istanbul",
        "windowsTimeZoneId":  "Turkey Standard Time",
        "utcOffset":  "3:00"
    },
    {
        "genericName":  "Russia TZ 2 Standard Time",
        "abbreviation":  "MSK",
        "ianaTimeZoneId":  "Europe/Moscow",
        "windowsTimeZoneId":  "Russian Standard Time",
        "utcOffset":  "3:00"
    },
    {
        "genericName":  "Russia TZ 2 Standard Time",
        "abbreviation":  "MSK",
        "ianaTimeZoneId":  "Europe/Simferopol",
        "windowsTimeZoneId":  "Russian Standard Time",
        "utcOffset":  "3:00"
    },
    {
        "genericName":  "Volgograd Standard Time",
        "abbreviation":  "MSK",
        "ianaTimeZoneId":  "Europe/Volgograd",
        "windowsTimeZoneId":  "Volgograd Standard Time",
        "utcOffset":  "3:00"
    },
    {
        "genericName":  "Belarus Standard Time",
        "abbreviation":  "MSK",
        "ianaTimeZoneId":  "Europe/Minsk",
        "windowsTimeZoneId":  "Belarus Standard Time",
        "utcOffset":  "3:00"
    },
    {
        "genericName":  "Russia TZ 2 Standard Time",
        "ianaTimeZoneId":  "Europe/Kirov",
        "windowsTimeZoneId":  "Russian Standard Time",
        "utcOffset":  "3:00"
    },
    {
        "genericName":  "Iran Standard Time",
        "abbreviation":  "IRST",
        "ianaTimeZoneId":  "Asia/Tehran",
        "windowsTimeZoneId":  "Iran Standard Time",
        "utcOffset":  "3:30"
    },
    {
        "genericName":  "Mauritius Standard Time",
        "abbreviation":  "RET",
        "ianaTimeZoneId":  "Indian/Reunion",
        "windowsTimeZoneId":  "Mauritius Standard Time",
        "utcOffset":  "4:00"
    },
    {
        "genericName":  "Mauritius Standard Time",
        "abbreviation":  "MUT",
        "ianaTimeZoneId":  "Indian/Mauritius",
        "windowsTimeZoneId":  "Mauritius Standard Time",
        "utcOffset":  "4:00"
    },
    {
        "genericName":  "Mauritius Standard Time",
        "abbreviation":  "SCT",
        "ianaTimeZoneId":  "Indian/Mahe",
        "windowsTimeZoneId":  "Mauritius Standard Time",
        "utcOffset":  "4:00"
    },
    {
        "genericName":  "Arabian Standard Time",
        "abbreviation":  "GST",
        "ianaTimeZoneId":  "Asia/Muscat",
        "windowsTimeZoneId":  "Arabian Standard Time",
        "utcOffset":  "4:00"
    },
    {
        "genericName":  "Arabian Standard Time",
        "abbreviation":  "GST",
        "ianaTimeZoneId":  "Asia/Dubai",
        "windowsTimeZoneId":  "Arabian Standard Time",
        "utcOffset":  "4:00"
    },
    {
        "genericName":  "Azerbaijan Standard Time",
        "abbreviation":  "AZT",
        "ianaTimeZoneId":  "Asia/Baku",
        "windowsTimeZoneId":  "Azerbaijan Standard Time",
        "utcOffset":  "4:00"
    },
    {
        "genericName":  "Caucasus Standard Time",
        "abbreviation":  "AMT",
        "ianaTimeZoneId":  "Asia/Yerevan",
        "windowsTimeZoneId":  "Caucasus Standard Time",
        "utcOffset":  "4:00"
    },
    {
        "genericName":  "Georgian Standard Time",
        "abbreviation":  "GET",
        "ianaTimeZoneId":  "Asia/Tbilisi",
        "windowsTimeZoneId":  "Georgian Standard Time",
        "utcOffset":  "4:00"
    },
    {
        "genericName":  "Astrakhan Standard Time",
        "abbreviation":  "SAMT",
        "ianaTimeZoneId":  "Europe/Astrakhan",
        "windowsTimeZoneId":  "Astrakhan Standard Time",
        "utcOffset":  "4:00"
    },
    {
        "genericName":  "Russia TZ 3 Standard Time",
        "abbreviation":  "SAMT",
        "ianaTimeZoneId":  "Europe/Samara",
        "windowsTimeZoneId":  "Russia Time Zone 3",
        "utcOffset":  "4:00"
    },
    {
        "genericName":  "Astrakhan Standard Time",
        "abbreviation":  "SAMT",
        "ianaTimeZoneId":  "Europe/Ulyanovsk",
        "windowsTimeZoneId":  "Astrakhan Standard Time",
        "utcOffset":  "4:00"
    },
    {
        "genericName":  "Afghanistan Standard Time",
        "abbreviation":  "AFT",
        "ianaTimeZoneId":  "Asia/Kabul",
        "windowsTimeZoneId":  "Afghanistan Standard Time",
        "utcOffset":  "4:30"
    },
    {
        "genericName":  "West Asia Standard Time",
        "abbreviation":  "TFT",
        "ianaTimeZoneId":  "Indian/Kerguelen",
        "windowsTimeZoneId":  "West Asia Standard Time",
        "utcOffset":  "5:00"
    },
    {
        "genericName":  "West Asia Standard Time",
        "abbreviation":  "MVT",
        "ianaTimeZoneId":  "Indian/Maldives",
        "windowsTimeZoneId":  "West Asia Standard Time",
        "utcOffset":  "5:00"
    },
    {
        "genericName":  "Pakistan Standard Time",
        "abbreviation":  "PKT",
        "ianaTimeZoneId":  "Asia/Karachi",
        "windowsTimeZoneId":  "Pakistan Standard Time",
        "utcOffset":  "5:00"
    },
    {
        "genericName":  "West Asia Standard Time",
        "abbreviation":  "TMT",
        "ianaTimeZoneId":  "Asia/Ashgabat",
        "windowsTimeZoneId":  "West Asia Standard Time",
        "utcOffset":  "5:00"
    },
    {
        "genericName":  "West Asia Standard Time",
        "abbreviation":  "TJT",
        "ianaTimeZoneId":  "Asia/Dushanbe",
        "windowsTimeZoneId":  "West Asia Standard Time",
        "utcOffset":  "5:00"
    },
    {
        "genericName":  "West Asia Standard Time",
        "abbreviation":  "UZT",
        "ianaTimeZoneId":  "Asia/Samarkand",
        "windowsTimeZoneId":  "West Asia Standard Time",
        "utcOffset":  "5:00"
    },
    {
        "genericName":  "West Asia Standard Time",
        "abbreviation":  "UZT",
        "ianaTimeZoneId":  "Asia/Tashkent",
        "windowsTimeZoneId":  "West Asia Standard Time",
        "utcOffset":  "5:00"
    },
    {
        "genericName":  "West Asia Standard Time",
        "abbreviation":  "AQTT",
        "ianaTimeZoneId":  "Asia/Aqtau",
        "windowsTimeZoneId":  "West Asia Standard Time",
        "utcOffset":  "5:00"
    },
    {
        "genericName":  "Qyzylorda Standard Time",
        "abbreviation":  "QYZT",
        "ianaTimeZoneId":  "Asia/Qyzylorda",
        "windowsTimeZoneId":  "Qyzylorda Standard Time",
        "utcOffset":  "5:00"
    },
    {
        "genericName":  "West Asia Standard Time",
        "abbreviation":  "AQTT",
        "ianaTimeZoneId":  "Asia/Aqtobe",
        "windowsTimeZoneId":  "West Asia Standard Time",
        "utcOffset":  "5:00"
    },
    {
        "genericName":  "West Asia Standard Time",
        "abbreviation":  "ORAT",
        "ianaTimeZoneId":  "Asia/Oral",
        "windowsTimeZoneId":  "West Asia Standard Time",
        "utcOffset":  "5:00"
    },
    {
        "genericName":  "Russia TZ 4 Standard Time",
        "abbreviation":  "YEKT",
        "ianaTimeZoneId":  "Asia/Yekaterinburg",
        "windowsTimeZoneId":  "Ekaterinburg Standard Time",
        "utcOffset":  "5:00"
    },
    {
        "genericName":  "Sri Lanka Standard Time",
        "abbreviation":  "IST",
        "ianaTimeZoneId":  "Asia/Colombo",
        "windowsTimeZoneId":  "Sri Lanka Standard Time",
        "utcOffset":  "5:30"
    },
    {
        "genericName":  "India Standard Time",
        "ianaTimeZoneId":  "Asia/Kolkata",
        "windowsTimeZoneId":  "India Standard Time",
        "utcOffset":  "5:30"
    },
    {
        "genericName":  "Nepal Standard Time",
        "ianaTimeZoneId":  "Asia/Kathmandu",
        "windowsTimeZoneId":  "Nepal Standard Time",
        "utcOffset":  "5:45"
    },
    {
        "genericName":  "Central Asia Standard Time",
        "abbreviation":  "IOT",
        "ianaTimeZoneId":  "Indian/Chagos",
        "windowsTimeZoneId":  "Central Asia Standard Time",
        "utcOffset":  "6:00"
    },
    {
        "genericName":  "Bangladesh Standard Time",
        "abbreviation":  "BDT",
        "ianaTimeZoneId":  "Asia/Dhaka",
        "windowsTimeZoneId":  "Bangladesh Standard Time",
        "utcOffset":  "6:00"
    },
    {
        "genericName":  "Bangladesh Standard Time",
        "abbreviation":  "BTT",
        "ianaTimeZoneId":  "Asia/Thimphu",
        "windowsTimeZoneId":  "Bangladesh Standard Time",
        "utcOffset":  "6:00"
    },
    {
        "genericName":  "Central Asia Standard Time",
        "abbreviation":  "KGT",
        "ianaTimeZoneId":  "Asia/Bishkek",
        "windowsTimeZoneId":  "Central Asia Standard Time",
        "utcOffset":  "6:00"
    },
    {
        "genericName":  "Central Asia Standard Time",
        "abbreviation":  "ALMT",
        "ianaTimeZoneId":  "Asia/Almaty",
        "windowsTimeZoneId":  "Central Asia Standard Time",
        "utcOffset":  "6:00"
    },
    {
        "genericName":  "Omsk Standard Time",
        "abbreviation":  "OMST",
        "ianaTimeZoneId":  "Asia/Omsk",
        "windowsTimeZoneId":  "Omsk Standard Time",
        "utcOffset":  "6:00"
    },
    {
        "genericName":  "Myanmar Standard Time",
        "abbreviation":  "CCT",
        "ianaTimeZoneId":  "Indian/Cocos",
        "windowsTimeZoneId":  "Myanmar Standard Time",
        "utcOffset":  "6:30"
    },
    {
        "genericName":  "Myanmar Standard Time",
        "ianaTimeZoneId":  "Asia/Rangoon",
        "windowsTimeZoneId":  "Myanmar Standard Time",
        "utcOffset":  "6:30"
    },
    {
        "genericName":  "SE Asia Standard Time",
        "abbreviation":  "CXT",
        "ianaTimeZoneId":  "Indian/Christmas",
        "windowsTimeZoneId":  "SE Asia Standard Time",
        "utcOffset":  "7:00"
    },
    {
        "genericName":  "SE Asia Standard Time",
        "abbreviation":  "WIB",
        "ianaTimeZoneId":  "Asia/Jakarta",
        "windowsTimeZoneId":  "SE Asia Standard Time",
        "utcOffset":  "7:00"
    },
    {
        "genericName":  "SE Asia Standard Time",
        "abbreviation":  "WIB",
        "ianaTimeZoneId":  "Asia/Pontianak",
        "windowsTimeZoneId":  "SE Asia Standard Time",
        "utcOffset":  "7:00"
    },
    {
        "genericName":  "SE Asia Standard Time",
        "abbreviation":  "ICT",
        "ianaTimeZoneId":  "Asia/Bangkok",
        "windowsTimeZoneId":  "SE Asia Standard Time",
        "utcOffset":  "7:00"
    },
    {
        "genericName":  "SE Asia Standard Time",
        "ianaTimeZoneId":  "Asia/Ho_Chi_Minh",
        "windowsTimeZoneId":  "SE Asia Standard Time",
        "utcOffset":  "7:00"
    },
    {
        "genericName":  "SE Asia Standard Time",
        "abbreviation":  "ICT",
        "ianaTimeZoneId":  "Asia/Phnom_Penh",
        "windowsTimeZoneId":  "SE Asia Standard Time",
        "utcOffset":  "7:00"
    },
    {
        "genericName":  "SE Asia Standard Time",
        "abbreviation":  "ICT",
        "ianaTimeZoneId":  "Asia/Vientiane",
        "windowsTimeZoneId":  "SE Asia Standard Time",
        "utcOffset":  "7:00"
    },
    {
        "genericName":  "W. Mongolia Standard Time",
        "abbreviation":  "HOVT",
        "ianaTimeZoneId":  "Asia/Hovd",
        "windowsTimeZoneId":  "W. Mongolia Standard Time",
        "utcOffset":  "7:00"
    },
    {
        "genericName":  "Altai Standard Time",
        "abbreviation":  "KRAT",
        "ianaTimeZoneId":  "Asia/Barnaul",
        "windowsTimeZoneId":  "Altai Standard Time",
        "utcOffset":  "7:00"
    },
    {
        "genericName":  "Russia TZ 6 Standard Time",
        "abbreviation":  "KRAT",
        "ianaTimeZoneId":  "Asia/Krasnoyarsk",
        "windowsTimeZoneId":  "North Asia Standard Time",
        "utcOffset":  "7:00"
    },
    {
        "genericName":  "Russia TZ 6 Standard Time",
        "abbreviation":  "KRAT",
        "ianaTimeZoneId":  "Asia/Novokuznetsk",
        "windowsTimeZoneId":  "North Asia Standard Time",
        "utcOffset":  "7:00"
    },
    {
        "genericName":  "Novosibirsk Standard Time",
        "abbreviation":  "NOVT",
        "ianaTimeZoneId":  "Asia/Novosibirsk",
        "windowsTimeZoneId":  "N. Central Asia Standard Time",
        "utcOffset":  "7:00"
    },
    {
        "genericName":  "Tomsk Standard Time",
        "ianaTimeZoneId":  "Asia/Tomsk",
        "windowsTimeZoneId":  "Tomsk Standard Time",
        "utcOffset":  "7:00"
    },
    {
        "genericName":  "W. Australia Standard Time",
        "abbreviation":  "AWST",
        "ianaTimeZoneId":  "Australia/Perth",
        "windowsTimeZoneId":  "W. Australia Standard Time",
        "utcOffset":  "8:00"
    },
    {
        "genericName":  "Malay Peninsula Standard Time",
        "abbreviation":  "WITA",
        "ianaTimeZoneId":  "Asia/Makassar",
        "windowsTimeZoneId":  "Singapore Standard Time",
        "utcOffset":  "8:00"
    },
    {
        "genericName":  "Singapore Standard Time",
        "abbreviation":  "SGT",
        "ianaTimeZoneId":  "Asia/Singapore",
        "windowsTimeZoneId":  "Singapore Standard Time",
        "utcOffset":  "8:00"
    },
    {
        "genericName":  "Malay Peninsula Standard Time",
        "abbreviation":  "MYT",
        "ianaTimeZoneId":  "Asia/Kuala_Lumpur",
        "windowsTimeZoneId":  "Singapore Standard Time",
        "utcOffset":  "8:00"
    },
    {
        "genericName":  "Malay Peninsula Standard Time",
        "abbreviation":  "MYT",
        "ianaTimeZoneId":  "Asia/Kuching",
        "windowsTimeZoneId":  "Singapore Standard Time",
        "utcOffset":  "8:00"
    },
    {
        "genericName":  "Malay Peninsula Standard Time",
        "abbreviation":  "BNT",
        "ianaTimeZoneId":  "Asia/Brunei",
        "windowsTimeZoneId":  "Singapore Standard Time",
        "utcOffset":  "8:00"
    },
    {
        "genericName":  "Malay Peninsula Standard Time",
        "abbreviation":  "PHT",
        "ianaTimeZoneId":  "Asia/Manila",
        "windowsTimeZoneId":  "Singapore Standard Time",
        "utcOffset":  "8:00"
    },
    {
        "genericName":  "China Standard Time",
        "abbreviation":  "CST",
        "ianaTimeZoneId":  "Asia/Shanghai",
        "windowsTimeZoneId":  "China Standard Time",
        "utcOffset":  "8:00"
    },
    {
        "genericName":  "Taipei Standard Time",
        "abbreviation":  "CST",
        "ianaTimeZoneId":  "Asia/Taipei",
        "windowsTimeZoneId":  "Taipei Standard Time",
        "utcOffset":  "8:00"
    },
    {
        "genericName":  "China Standard Time",
        "abbreviation":  "CST",
        "ianaTimeZoneId":  "Asia/Macau",
        "windowsTimeZoneId":  "China Standard Time",
        "utcOffset":  "8:00"
    },
    {
        "genericName":  "China Standard Time",
        "abbreviation":  "HKT",
        "ianaTimeZoneId":  "Asia/Hong_Kong",
        "windowsTimeZoneId":  "China Standard Time",
        "utcOffset":  "8:00"
    },
    {
        "genericName":  "Ulaanbaatar Standard Time",
        "abbreviation":  "ULAT",
        "ianaTimeZoneId":  "Asia/Ulaanbaatar",
        "windowsTimeZoneId":  "Ulaanbaatar Standard Time",
        "utcOffset":  "8:00"
    },
    {
        "genericName":  "Ulaanbaatar Standard Time",
        "abbreviation":  "CHOT",
        "ianaTimeZoneId":  "Asia/Choibalsan",
        "windowsTimeZoneId":  "Ulaanbaatar Standard Time",
        "utcOffset":  "8:00"
    },
    {
        "genericName":  "Russia TZ 7 Standard Time",
        "abbreviation":  "IRKT",
        "ianaTimeZoneId":  "Asia/Irkutsk",
        "windowsTimeZoneId":  "North Asia East Standard Time",
        "utcOffset":  "8:00"
    },
    {
        "genericName":  "Aus Central W. Standard Time",
        "abbreviation":  "ACWST",
        "ianaTimeZoneId":  "Australia/Eucla",
        "windowsTimeZoneId":  "Aus Central W. Standard Time",
        "utcOffset":  "8:45"
    },
    {
        "genericName":  "Tokyo Standard Time",
        "abbreviation":  "TLT",
        "ianaTimeZoneId":  "Asia/Dili",
        "windowsTimeZoneId":  "Tokyo Standard Time",
        "utcOffset":  "9:00"
    },
    {
        "genericName":  "Tokyo Standard Time",
        "abbreviation":  "EIT",
        "ianaTimeZoneId":  "Asia/Jayapura",
        "windowsTimeZoneId":  "Tokyo Standard Time",
        "utcOffset":  "9:00"
    },
    {
        "genericName":  "Tokyo Standard Time",
        "ianaTimeZoneId":  "Pacific/Palau",
        "windowsTimeZoneId":  "Tokyo Standard Time",
        "utcOffset":  "9:00"
    },
    {
        "genericName":  "Tokyo Standard Time",
        "abbreviation":  "JST",
        "ianaTimeZoneId":  "Asia/Tokyo",
        "windowsTimeZoneId":  "Tokyo Standard Time",
        "utcOffset":  "9:00"
    },
    {
        "genericName":  "Korea Standard Time",
        "abbreviation":  "KST",
        "ianaTimeZoneId":  "Asia/Seoul",
        "windowsTimeZoneId":  "Korea Standard Time",
        "utcOffset":  "9:00"
    },
    {
        "genericName":  "North Korea Standard Time",
        "abbreviation":  "KST",
        "ianaTimeZoneId":  "Asia/Pyongyang",
        "windowsTimeZoneId":  "North Korea Standard Time",
        "utcOffset":  "9:00"
    },
    {
        "genericName":  "Transbaikal Standard Time",
        "abbreviation":  "YAKT",
        "ianaTimeZoneId":  "Asia/Chita",
        "windowsTimeZoneId":  "Transbaikal Standard Time",
        "utcOffset":  "9:00"
    },
    {
        "genericName":  "Russia TZ 8 Standard Time",
        "abbreviation":  "YAKT",
        "ianaTimeZoneId":  "Asia/Yakutsk",
        "windowsTimeZoneId":  "Yakutsk Standard Time",
        "utcOffset":  "9:00"
    },
    {
        "genericName":  "Russia TZ 8 Standard Time",
        "abbreviation":  "YAKT",
        "ianaTimeZoneId":  "Asia/Khandyga",
        "windowsTimeZoneId":  "Yakutsk Standard Time",
        "utcOffset":  "9:00"
    },
    {
        "genericName":  "Cen. Australia Standard Time",
        "abbreviation":  "ACST",
        "ianaTimeZoneId":  "Australia/Adelaide",
        "windowsTimeZoneId":  "Cen. Australia Standard Time",
        "utcOffset":  "9:30"
    },
    {
        "genericName":  "Cen. Australia Standard Time",
        "abbreviation":  "ACST",
        "ianaTimeZoneId":  "Australia/Broken_Hill",
        "windowsTimeZoneId":  "Cen. Australia Standard Time",
        "utcOffset":  "9:30"
    },
    {
        "genericName":  "AUS Central Standard Time",
        "abbreviation":  "ACST",
        "ianaTimeZoneId":  "Australia/Darwin",
        "windowsTimeZoneId":  "AUS Central Standard Time",
        "utcOffset":  "9:30"
    },
    {
        "genericName":  "Tasmania Standard Time",
        "abbreviation":  "AEST",
        "ianaTimeZoneId":  "Australia/Hobart",
        "windowsTimeZoneId":  "Tasmania Standard Time",
        "utcOffset":  "10:00"
    },
    {
        "genericName":  "Tasmania Standard Time",
        "abbreviation":  "AEST",
        "ianaTimeZoneId":  "Australia/Currie",
        "windowsTimeZoneId":  "Tasmania Standard Time",
        "utcOffset":  "10:00"
    },
    {
        "genericName":  "AUS Eastern Standard Time",
        "abbreviation":  "AEST",
        "ianaTimeZoneId":  "Australia/Melbourne",
        "windowsTimeZoneId":  "AUS Eastern Standard Time",
        "utcOffset":  "10:00"
    },
    {
        "genericName":  "AUS Eastern Standard Time",
        "abbreviation":  "AEST",
        "ianaTimeZoneId":  "Australia/Sydney",
        "windowsTimeZoneId":  "AUS Eastern Standard Time",
        "utcOffset":  "10:00"
    },
    {
        "genericName":  "E. Australia Standard Time",
        "ianaTimeZoneId":  "Australia/Brisbane",
        "windowsTimeZoneId":  "E. Australia Standard Time",
        "utcOffset":  "10:00"
    },
    {
        "genericName":  "E. Australia Standard Time",
        "abbreviation":  "AEST",
        "ianaTimeZoneId":  "Australia/Lindeman",
        "windowsTimeZoneId":  "E. Australia Standard Time",
        "utcOffset":  "10:00"
    },
    {
        "genericName":  "West Pacific Standard Time",
        "abbreviation":  "PGT",
        "ianaTimeZoneId":  "Pacific/Port_Moresby",
        "windowsTimeZoneId":  "West Pacific Standard Time",
        "utcOffset":  "10:00"
    },
    {
        "genericName":  "West Pacific Standard Time",
        "abbreviation":  "CHUT",
        "ianaTimeZoneId":  "Pacific/Chuuk",
        "windowsTimeZoneId":  "West Pacific Standard Time",
        "utcOffset":  "10:00"
    },
    {
        "genericName":  "West Pacific Standard Time",
        "ianaTimeZoneId":  "Pacific/Yap",
        "windowsTimeZoneId":  "West Pacific Standard Time",
        "utcOffset":  "10:00"
    },
    {
        "genericName":  "West Pacific Standard Time",
        "abbreviation":  "CHST",
        "ianaTimeZoneId":  "Pacific/Guam",
        "windowsTimeZoneId":  "West Pacific Standard Time",
        "utcOffset":  "10:00"
    },
    {
        "genericName":  "West Pacific Standard Time",
        "abbreviation":  "CHST",
        "ianaTimeZoneId":  "Pacific/Saipan",
        "windowsTimeZoneId":  "West Pacific Standard Time",
        "utcOffset":  "10:00"
    },
    {
        "genericName":  "Russia TZ 9 Standard Time",
        "abbreviation":  "VLAT",
        "ianaTimeZoneId":  "Asia/Vladivostok",
        "windowsTimeZoneId":  "Vladivostok Standard Time",
        "utcOffset":  "10:00"
    },
    {
        "genericName":  "Russia TZ 9 Standard Time",
        "abbreviation":  "VLAT",
        "ianaTimeZoneId":  "Asia/Ust-Nera",
        "windowsTimeZoneId":  "Vladivostok Standard Time",
        "utcOffset":  "10:00"
    },
    {
        "genericName":  "Lord Howe Standard Time",
        "abbreviation":  "LHST",
        "ianaTimeZoneId":  "Australia/Lord_Howe",
        "windowsTimeZoneId":  "Lord Howe Standard Time",
        "utcOffset":  "10:30"
    },
    {
        "genericName":  "Central Pacific Standard Time",
        "abbreviation":  "MIST",
        "ianaTimeZoneId":  "Antarctica/Macquarie",
        "windowsTimeZoneId":  "Central Pacific Standard Time",
        "utcOffset":  "11:00"
    },
    {
        "genericName":  "Norfolk Standard Time",
        "abbreviation":  "NFT",
        "ianaTimeZoneId":  "Pacific/Norfolk",
        "windowsTimeZoneId":  "Norfolk Standard Time",
        "utcOffset":  "11:00"
    },
    {
        "genericName":  "Central Pacific Standard Time",
        "abbreviation":  "NCT",
        "ianaTimeZoneId":  "Pacific/Noumea",
        "windowsTimeZoneId":  "Central Pacific Standard Time",
        "utcOffset":  "11:00"
    },
    {
        "genericName":  "Central Pacific Standard Time",
        "abbreviation":  "VUT",
        "ianaTimeZoneId":  "Pacific/Efate",
        "windowsTimeZoneId":  "Central Pacific Standard Time",
        "utcOffset":  "11:00"
    },
    {
        "genericName":  "Central Pacific Standard Time",
        "abbreviation":  "SBT",
        "ianaTimeZoneId":  "Pacific/Guadalcanal",
        "windowsTimeZoneId":  "Central Pacific Standard Time",
        "utcOffset":  "11:00"
    },
    {
        "genericName":  "Bougainville Standard Time",
        "abbreviation":  "BST",
        "ianaTimeZoneId":  "Pacific/Bougainville",
        "windowsTimeZoneId":  "Bougainville Standard Time",
        "utcOffset":  "11:00"
    },
    {
        "genericName":  "Central Pacific Standard Time",
        "abbreviation":  "KOST",
        "ianaTimeZoneId":  "Pacific/Kosrae",
        "windowsTimeZoneId":  "Central Pacific Standard Time",
        "utcOffset":  "11:00"
    },
    {
        "genericName":  "Central Pacific Standard Time",
        "abbreviation":  "PONT",
        "ianaTimeZoneId":  "Pacific/Pohnpei",
        "windowsTimeZoneId":  "Central Pacific Standard Time",
        "utcOffset":  "11:00"
    },
    {
        "genericName":  "Sakhalin Standard Time",
        "abbreviation":  "SAKT",
        "ianaTimeZoneId":  "Asia/Sakhalin",
        "windowsTimeZoneId":  "Sakhalin Standard Time",
        "utcOffset":  "11:00"
    },
    {
        "genericName":  "Russia TZ 10 Standard Time",
        "abbreviation":  "SRET",
        "ianaTimeZoneId":  "Asia/Srednekolymsk",
        "windowsTimeZoneId":  "Russia Time Zone 10",
        "utcOffset":  "11:00"
    },
    {
        "genericName":  "Magadan Standard Time",
        "abbreviation":  "MAGT",
        "ianaTimeZoneId":  "Asia/Magadan",
        "windowsTimeZoneId":  "Magadan Standard Time",
        "utcOffset":  "11:00"
    },
    {
        "genericName":  "New Zealand Standard Time",
        "abbreviation":  "NZST",
        "ianaTimeZoneId":  "Pacific/Auckland",
        "windowsTimeZoneId":  "New Zealand Standard Time",
        "utcOffset":  "12:00"
    },
    {
        "genericName":  "Fiji Standard Time",
        "abbreviation":  "FJT",
        "ianaTimeZoneId":  "Pacific/Fiji",
        "windowsTimeZoneId":  "Fiji Standard Time",
        "utcOffset":  "12:00"
    },
    {
        "genericName":  "UTC+12",
        "ianaTimeZoneId":  "Pacific/Wallis",
        "windowsTimeZoneId":  "UTC+12",
        "utcOffset":  "12:00"
    },
    {
        "genericName":  "UTC+12",
        "abbreviation":  "TVT",
        "ianaTimeZoneId":  "Pacific/Funafuti",
        "windowsTimeZoneId":  "UTC+12",
        "utcOffset":  "12:00"
    },
    {
        "genericName":  "UTC+12",
        "abbreviation":  "GILT",
        "ianaTimeZoneId":  "Pacific/Tarawa",
        "windowsTimeZoneId":  "UTC+12",
        "utcOffset":  "12:00"
    },
    {
        "genericName":  "UTC+12",
        "ianaTimeZoneId":  "Pacific/Nauru",
        "windowsTimeZoneId":  "UTC+12",
        "utcOffset":  "12:00"
    },
    {
        "genericName":  "UTC+12",
        "abbreviation":  "MHT",
        "ianaTimeZoneId":  "Pacific/Majuro",
        "windowsTimeZoneId":  "UTC+12",
        "utcOffset":  "12:00"
    },
    {
        "genericName":  "UTC+12",
        "ianaTimeZoneId":  "Pacific/Kwajalein",
        "windowsTimeZoneId":  "UTC+12",
        "utcOffset":  "12:00"
    },
    {
        "genericName":  "UTC+12",
        "abbreviation":  "WAKT",
        "ianaTimeZoneId":  "Pacific/Wake",
        "windowsTimeZoneId":  "UTC+12",
        "utcOffset":  "12:00"
    },
    {
        "genericName":  "Russia TZ 11 Standard Time",
        "abbreviation":  "PETT",
        "ianaTimeZoneId":  "Asia/Kamchatka",
        "windowsTimeZoneId":  "Russia Time Zone 11",
        "utcOffset":  "12:00"
    },
    {
        "genericName":  "Russia TZ 11 Standard Time",
        "abbreviation":  "ANAT",
        "ianaTimeZoneId":  "Asia/Anadyr",
        "windowsTimeZoneId":  "Russia Time Zone 11",
        "utcOffset":  "12:00"
    },
    {
        "genericName":  "Chatham Islands Standard Time",
        "abbreviation":  "CHAST",
        "ianaTimeZoneId":  "Pacific/Chatham",
        "windowsTimeZoneId":  "Chatham Islands Standard Time",
        "utcOffset":  "12:45"
    },
    {
        "genericName":  "Tonga Standard Time",
        "abbreviation":  "TOT",
        "ianaTimeZoneId":  "Pacific/Tongatapu",
        "windowsTimeZoneId":  "Tonga Standard Time",
        "utcOffset":  "13:00"
    },
    {
        "genericName":  "Samoa Standard Time",
        "abbreviation":  "SST",
        "ianaTimeZoneId":  "Pacific/Apia",
        "windowsTimeZoneId":  "Samoa Standard Time",
        "utcOffset":  "13:00"
    },
    {
        "genericName":  "UTC+13",
        "abbreviation":  "TKT",
        "ianaTimeZoneId":  "Pacific/Fakaofo",
        "windowsTimeZoneId":  "UTC+13",
        "utcOffset":  "13:00"
    },
    {
        "genericName":  "UTC+13",
        "abbreviation":  "PHOT",
        "ianaTimeZoneId":  "Pacific/Enderbury",
        "windowsTimeZoneId":  "UTC+13",
        "utcOffset":  "13:00"
    },
    {
        "genericName":  "Line Islands Standard Time",
        "abbreviation":  "LINT",
        "ianaTimeZoneId":  "Pacific/Kiritimati",
        "windowsTimeZoneId":  "Line Islands Standard Time",
        "utcOffset":  "14:00"
    }
]'
$TimeZoneHashtable = $TimeZoneJSONValue | ConvertFrom-Json

$URI = "http://ip-api.com/json/" 
$IPGeoLocation_Response = Invoke-RestMethod -Uri $URI
$NewTimeZone_IANA = $IPGeoLocation_Response.timezone
$NewTimeZone = $TimeZoneHashtable | Where-Object {$NewTimeZone_IANA -contains $_.ianaTimeZoneId}


if ($IPGeoLocation_Response.status -eq 'success'){
    
    Write-Output "API Response from $URI" -
    $IPGeoLocation_Response

    Write-Output "Print Current TimeZone Settings ..." 
    $CurrentTimeZone = get-TimeZone ; $CurrentTimeZone

    if ($NewTimeZone.windowsTimeZoneId -match $CurrentTimeZone.id){
        Write-Output "Current TimeZone is correct. Terminating Script ..."
    }
    Else {
        Write-Output "Attempting to adjust TimeZone to $($NewTimeZone.windowsTimeZoneId) ..."
        Set-TimeZone -Id $NewTimeZone.windowsTimeZoneId
        Start-Sleep -Seconds 1
        Write-Output "Print New TimeZone Settings ..." 
        Get-TimeZone
    }

}Else {
    Write-Output "API call failed ..."
}


Stop-Transcript