# Convert HTML to PDF by Using Microsoft Edge
Convert HTML to PDF by Using Microsoft Edge

Live Demo: [http://html-pdf-edge.adriancs.com/](http://html-pdf-edge.adriancs.com/)

Available at Nuget: [https://www.nuget.org/packages/Html-PDF-Edge](https://www.nuget.org/packages/Html-PDF-Edge)

PM> NuGet\Install-Package Html-PDF-Edge

![](https://raw.githubusercontent.com/adriancs2/HTML-PDF-Edge/main/wiki/screenshot1.png)

Install the NUGET Package, or download the source code. Extract and add the C# class file "pdf_edge.cs" into your project.

To generate PDF and download as attachment:
```
pdf_edge.GeneratePdfAttachment(html, "file.pdf");
```
To generate PDF and display in browser:
```
pdf_edge.GeneratePdfInline(html);
```
Using Microsoft Edge as PDF generator is better than Chrome.exe.

Learn more about using Chrome.exe as PDF Generator: [https://github.com/adriancs2/HTML-PDF-Chrome](https://github.com/adriancs2/HTML-PDF-Chrome)

I have tested this implementation (using Edge) in the following environment:

- Local IIS hosting
- Web Hosting (smarterasp.net)
- VPS Web Hosting

All above environment are able to generate PDF without issues. It runs smoothly without the need to configure the permission, Application Pool Identity and Website IIS authentication. I have a  more seemless integration experience if compared to using Chrome.

The following screenshot shows that the execution of MS Edge is allowed even with default permission settings:

![](https://raw.githubusercontent.com/adriancs2/HTML-PDF-Edge/main/wiki/screenshot2.png)

Chrome.exe, however is not so permissive in most environment. This is because executing an EXE over a web server is generally prohibitted due to security issues.

For Chrome.exe, I failed to run it at web hosting environment (smarterasp.net).

Even in Local IIS hosting, I have to set the Application Pool Identify to "LocalSystem" in order for Chrome.exe to run properly.

![](https://raw.githubusercontent.com/adriancs2/HTML-PDF-Edge/main/wiki/screenshot3.png)

But Microsoft Edge does not have such requirements. Microsoft Edge is able to be executed with lowest/default permission and security settings.

Therefore, it is highly recommended to use Microsoft Edge than Chrome.exe.

## Important CSS Properties
There are a few necessary CSS that you have to include in the HTML page in order for this to work properly.

1. Set page margin to 0 (zero)
2. Set paper size
3. Wrap all content within a "div" with fixed width and margin
4. Use CSS of page-break-always to split between pages.
5. All fonts must already installed or hosted in your website
6. URL links for images, external css stylesheet reference must include the root path.

**1. Set page margin to 0 (zero)**
```
@page {
    margin: 0;
}
```
The purpose of doing this is to hide the header and footer:

![](https://raw.githubusercontent.com/adriancs2/HTML-PDF-Edge/main/wiki/screenshot4.png)

**2. Set paper size**

Example 1:
```
@page {
    margin: 0;
    size: A4 portrait;
}
```
Example 2:
```
@page {
    margin: 0;
    size: letter landscape;
}
```
Example 3: custom size (inch) *width then height
```
@page {
    margin: 0;
    size: 4in 6in;
}
```
Example 4: custom size (cm) *width then height
```
@page {
    margin: 0;
    size: 14cm 14cm;
}
```
For more options/info on the CSS of @page, you may refer:

https://developer.mozilla.org/en-US/docs/Web/CSS/@page/size

**3. Wrap all content within a DIV with fixed width and margin**

Example:
```
<div class="page">
    <h1>Page 1</h1>
    <img src="/pdf.jpg" style="width: 100%; height: auto;" />
    <!-- The rest of the body content -->
</div>
```
Style the "div" with class "page" (act as the main block/wrapper/container). Since the page has zero margin, we need to manually specified the top margin in CSS:
```
CSS
.page {
    width: 18cm;
    margin: auto;
    margin-top: 10mm;
}
```
The **width** has to be specified.

The "**margin: auto**" will align the div block at center horizontally.

"**margin-top: 10mm**", will provide space between the main block and the edge of the paper at top section.

**4. Use CSS of "page-break-always" to split between pages.**

To split pages, use a "div" and style with CSS of "page-break-after".
```
page-break-after: always
```
Example:
```
<div class="page">
    <h1>Page 1</h1>
    <img src="/pdf.jpg" style="width: 100%; height: auto;" />
</div>

<div style="page-break-after: always"></div>

<div class="page">
    <h1>Page 2</h1>
    <img src="/pdf.jpg" style="width: 100%; height: auto;" />
</div>

<div style="page-break-after: always"></div>

<div class="page">
    <h1>Page 3</h1>
    <img src="/pdf.jpg" style="width: 100%; height: auto;" />
</div>
```
**5. All fonts must already installed or hosted in your website**

The font rendering might not be working properly if the fonts are hosted at 3rd party's server, for example: Google Fonts. Try install the fonts into your server Windows OS or host the fonts within your website.

**6. URL links for images, external css stylesheet reference must include the root path.**

For example, the following img tag might not be rendered properly. The image has the potential to be missing in the final rendered PDF output.

```
<img src="logo.png" />
<img src="images/logo.png" />
```
In stead, include the root path like this:
```
<img src="/logo.png" />
<img src="/images/logo.png" />
```

## The sample of full HTML page:
``` 
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style type="text/css">
        h1 {
            margin: 0;
            padding: 0;
        }
        .page {
            margin: auto;
            margin-top: 10mm;
            border: 1px solid black;
            width: 18cm;
            height: 27cm;
        }

        @page {
            margin: 0;
            size: A4 portrait;
        }
    </style>
</head>

<body>

    <div class="page">
        <h1>Page 1</h1>
        <img src="/pdf.jpg" style="width: 100%; height: auto;" />
    </div>

    <div style="page-break-after: always"></div>

    <div class="page">
        <h1>Page 2</h1>
        <img src="/pdf.jpg" style="width: 100%; height: auto;" />
    </div>

    <div style="page-break-after: always"></div>

    <div class="page">
        <h1>Page 3</h1>
        <img src="/pdf.jpg" style="width: 100%; height: auto;" />
    </div>

</body>

</html>
```
## The Code Behind
 Here I'll explain a bit how the C# class works in behind.

As mentioned, the real work is done within the C# class of "pdf_edge.cs".

Start off by adding 2 using statements:

```
using System.Diagnostics;
using System.IO;
```
Here is the main method that runs Microsoft Edge for converting HTML into PDF file:

```
public static void GeneratePdf(string url, string filePath)
{
    using (var p = new Process())
    {
        p.StartInfo.FileName = "msedge";
        p.StartInfo.Arguments = $"--headless --disable-gpu 
            --run-all-compositor-stages-before-draw
            --print-to-pdf=\"{filePath}\" {url}";
        p.Start();
        p.WaitForExit();
    }
}
```
The enum for defining the Transmit Method:
```
public enum TransmitMethod
{
    None,
    Attachment,
    Inline
}
```
Here is the code for preparing the URL for Microsoft Edge to generate the PDF:
```
static void EdgePublish(string html, TransmitMethod transmitMethod, string filename)
{
    // Create a temporary folder for storing the PDF

    string folderTemp = HttpContext.Current.Server.MapPath("~/temp/pdf");

    if (!Directory.Exists(folderTemp))
    {
        Directory.CreateDirectory(folderTemp);
    }

    // Create 2 temporary filename

    Random rd = new Random();
    string randomstr = rd.Next(100000000, int.MaxValue).ToString();
            
    string fileHtml = HttpContext.Current.Server.MapPath($"~/temp/pdf/{randomstr}.html");
    string filePdf = HttpContext.Current.Server.MapPath($"~/temp/pdf/{randomstr}.pdf");

    // Create the HTML file

    File.WriteAllText(fileHtml, html);

    // Obtain the URL of the HTML file

    var r = HttpContext.Current.Request.Url;
    string url = $"{r.Scheme}://{r.Host}:{r.Port}/temp/pdf/{randomstr}.html";

    // Create the PDF file

    GeneratePdf(url, filePdf);

    // Obtain the file size
            
    FileInfo fi = new FileInfo(filePdf);
    string filelength = fi.Length.ToString();

    // Load the file into memory (byte array)

    byte[] ba = File.ReadAllBytes(filePdf);

    // Delete the 2 temp files from server

    try
    {
        File.Delete(filePdf);
    }
    catch { }

    try
    {
        File.Delete(fileHtml);
    }
    catch { }

    // Transmit the PDF for download

    HttpContext.Current.Response.Clear();

    if (transmitMethod == TransmitMethod.Inline)
        HttpContext.Current.Response.AddHeader("Content-Disposition", "inline");
    else if (transmitMethod == TransmitMethod.Attachment)
        HttpContext.Current.Response.AddHeader("Content-Disposition", $"attachment; filename=\"{filename}\"");

    HttpContext.Current.Response.ContentType = "application/pdf";
    HttpContext.Current.Response.AddHeader("Content-Length", filelength);
    HttpContext.Current.Response.BinaryWrite(ba);
    HttpContext.Current.Response.End();
}

```
