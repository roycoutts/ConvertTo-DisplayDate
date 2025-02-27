# ConvertTo-DisplayDate

# ConvertTo-DisplayDate.ps1

PowerShell Function Documentation

## Overview
The `ConvertTo-DisplayDate` function is a PowerShell utility that formats a given date string into various human-readable formats. It allows users to specify the date format and the time format (24-hour or 12-hour). The function supports multiple regional date formats, making it versatile for international applications.

## Syntax
```powershell

ConvertTo-DisplayDate -DateString <string> -DateFormat <string> [-TimeFormat <string>]
```

## Parameters

### `-DateString` (Mandatory)
- **Type:** String
- **Description:** Specifies the date input to be formatted. The input must be a valid date string recognizable by PowerShell.
- **Example:** `"2025-02-27"`

### `-DateFormat` (Mandatory)
- **Type:** String
- **Description:** Determines the format in which the date should be displayed. Acceptable values are:
  - `YYYY-MM-DD (ISO 8601 Standard)` → `2025-02-27`
  - `MM/DD/YYYY (US)` → `02/27/2025`
  - `MONTH DD, YYYY (US Long Form)` → `February 27, 2025`
  - `DD/MM/YYYY (International)` → `27/02/2025`
  - `DD.MM.YYYY (Eastern Europe)` → `27.02.2025`
  - `DD MONTH YEAR (UK Formal)` → `27 February 2025`
  - `YYYY年MM月DD日 (Japan)` → `2025年02月27日 午前10時30分`
- **Example:** `"MM/DD/YYYY (US)"`

### `-TimeFormat` (Optional)
- **Type:** String
- **Description:** Specifies whether to display the time in 24-hour or 12-hour format. Acceptable values are:
  - `24-Hour` → `HH:mm:ss`
  - `12-Hour` → `hh:mm:ss tt`
- **Default:** If not specified, the function assumes a default time format of `24-Hour`.
- **Example:** `"12-Hour"`

## Functionality
1. Parses the input date string.
2. Formats the date according to the specified `-DateFormat`.
3. Appends the time in the selected `-TimeFormat`.
4. Returns the formatted date string.
5. Throws an error if the date string is invalid or if an unsupported format is specified.

## Error Handling
- If an invalid date string is provided, the function throws: `"Invalid DateString"`.
- If an unsupported date format is specified, the function throws: `"Invalid DateFormat specified"`.

## Example Usages

### Example 1: Convert a date to US format with 24-hour time

```powershell

ConvertTo-DisplayDate -DateString "2025-02-27T15:45:00" -DateFormat "MM/DD/YYYY (US)" -TimeFormat "24-Hour"
```

**Output:**
```
02/27/2025 15:45:00
```

### Example 2: Convert a date to UK Formal format with 12-hour time

```powershell

ConvertTo-DisplayDate -DateString "2025-02-27" -DateFormat "DD MONTH YEAR (UK Formal)" -TimeFormat "12-Hour"
```

**Output:**
```
27 February 2025 03:30:00 PM
```

### Example 3: Convert a date to Japanese format with 12-hour time

```powershell

ConvertTo-DisplayDate -DateString "2025-02-27T10:30:00" -DateFormat "YYYY年MM月DD日 (Japan)" -TimeFormat "12-Hour"
```

**Output:**
```
2025年02月27日 午前10時30分
```

## Notes
- The function uses PowerShell's `Get-Date` cmdlet to process the date.
- The function supports localization, including Japanese date representation with AM/PM conversion to 午前 (AM) and 午後 (PM).
- It provides easy formatting for a variety of international standards.

## Conclusion
The `ConvertTo-DisplayDate` function is a powerful tool for converting date strings into various display formats with customizable time formats. It ensures clarity and consistency in date representation across different locales and applications.

## Version
- **Author**: Roy Coutts
- **Version**: 1.0
- **Last Updated**: February 27, 2025
