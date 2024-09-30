# Define input and output files
$inputPdfFile = "$HOME\Desktop\input.pdf" #this line is modifiable replace with the name of the input file #Input PDF file on Desktop
$outputMdFile = "output.md"                           #Intermediate Markdown file
$outputPdfFile = "output.pdf"                         #Final output PDF file

$extractedTextFile = "extracted.txt"
pdftotext $inputPdfFile $extractedTextFile

$content = Get-Content $extractedTextFile -Raw -Encoding UTF8

#Perform the text substitution
$processedContent = $content -replace '\b([A-Za-z])([A-Za-z]{0,2})\b', '**$1**$2'
$processedContent = $processedContent -replace '\b([A-Za-z]{2})([A-Za-z]{2,})\b', '**$1**$2'

#Write the processed content to the output markdown file
Set-Content $outputMdFile $processedContent -Encoding UTF8

#Convert the markdown file to PDF using pandoc
Start-Process -NoNewWindow -Wait pandoc -ArgumentList "$outputMdFile", "-o", "$outputPdfFile"

#utput success message
Write-Host "PDF generated: $outputPdfFile"
