# The ConvertTo-DisplayDate function is a PowerShell utility that formats a given date string into various human-readable formats. 
# It allows users to specify the date format and the time format (24-hour or 12-hour). 
# The function supports multiple regional date formats, making it versatile for international applications.
#
# **YYYY-MM-DD**  
#   - Example: 2025-02-27  
#   - This is the ISO 8601 standard, favored in tech, data systems, and internationally and practical for databases or when clarity is critical.
# **MM/DD/YYYY**  
#   - Example: 02/27/2025  
#   - Common in the United States and a few other places influenced by U.S. conventions, like parts of Canada. 
# **Month DD, YYYY**  
#   - Example: February 27, 2025  
#   - Standard in American English for letters, articles, or casual writing. 
# **DD/MM/YYYY**  
#   - Example: 27/02/2025  
#   - This is widely used internationally, especially in Europe, Australia, India, and much of Asia and Africa. 
# **DD.MM.YYYY**  
#   - Example: 27.02.2025  
#   - Common in Germany, Russia, and parts of Eastern Europe. Dots replace slashes, but it’s still day-month-year.
# **DD Month YYYY**  
#   - Example: 27 February 2025  
#   - A written-out style popular in formal documents, especially in the UK and Commonwealth countries. 
# **YYYY年MM月DD日**
#   - Example: 2025年02月27日
#   - Common in Japan reflecting their year-month-day order with kanji. 

function ConvertTo-DisplayDate {
    param (
        [Parameter(Mandatory=$true)]
        [string]$DateString,
        [ValidateSet('YYYY-MM-DD (ISO 8601 Standard)','MM/DD/YYYY (US)','MONTH DD, YYYY (US Long Form)','DD/MM/YYYY (International)','DD.MM.YYYY (Eastern Europe)','DD MONTH YEAR (UK Formal)','YYYY年MM月DD日 (Japan)')]
        [string]$DateFormat,
        [ValidateSet('24-Hour','12-Hour')]
        [String]$TimeFormat
    )
    $DisplayDate = ''
    if ($TimeFormat -eq '24-Hour') {
        $TimeFmt = 'HH:mm:ss'
    } elseif ($TimeFormat -eq '12-Hour') {
        $TimeFmt = 'hh:mm:ss tt'
    }
    try {
        switch ($DateFormat) {
            'YYYY-MM-DD (ISO 8601 Standard)' { $DisplayDate = (Get-Date -Date $DateString).ToString("yyyy-MM-dd $TimeFmt") }
            'MM/DD/YYYY (US)'                { $DisplayDate = (Get-Date -Date $DateString).ToString("MM/dd/yyyy $TimeFmt") }
            'MONTH DD, YYYY (US Long Form)'  { $DisplayDate = (Get-Date -Date $DateString).ToString("MMMM dd, yyyy $TimeFmt") }
            'DD/MM/YYYY (International)'     { $DisplayDate = (Get-Date -Date $DateString).ToString("dd/MM/yyyy $TimeFmt") }
            'DD.MM.YYYY (Eastern Europe)'    { $DisplayDate = (Get-Date -Date $DateString).ToString("dd.MM.yyyy $TimeFmt") }
            'DD MONTH YEAR (UK Formal)'      { $DisplayDate = (Get-Date -Date $DateString).ToString("dd MMMM yyyy $TimeFmt") }
            'YYYY年MM月DD日 (Japan)'          { 
                $baseDate = (Get-Date -Date $DateString).ToString('yyyy年MM月dd日')
                if ($TimeFormat -eq '12-Hour') {
                    $timePart = (Get-Date -Date $DateString).ToString('tt h時mm分') -replace 'AM', '午前' -replace 'PM', '午後'
                } else {
                    $timePart = (Get-Date -Date $DateString).ToString('HH時mm分')
                }
                $DisplayDate = "$baseDate $timePart"
            }
            default { Throw "Invalid DateFormat specified: $DateFormat" }
        }
    } catch {
        Throw "Invalid DateString: $_"
    }
    $DisplayDate
}
