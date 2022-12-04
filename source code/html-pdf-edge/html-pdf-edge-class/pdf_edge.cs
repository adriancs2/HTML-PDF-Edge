using System;
using System.Diagnostics;
using System.IO;
using System.Web;

namespace System
{
    public class pdf_edge
    {
        public enum TransmitMethod
        {
            None,
            Attachment,
            Inline
        }

        public static void GeneratePdf(string url, string filePath)
        {
            using (var p = new Process())
            {
                p.StartInfo.FileName = "msedge";
                p.StartInfo.Arguments = $"--headless --disable-gpu --run-all-compositor-stages-before-draw --print-to-pdf=\"{filePath}\" {url}";
                p.Start();
                p.WaitForExit();
            }

            GC.Collect();
        }

        public static void GeneratePdfInline(string html)
        {
            EdgePublish(html, TransmitMethod.Inline, null);
        }

        public static void GeneratePdfAttachment(string html, string filenameWithPdf)
        {
            EdgePublish(html, TransmitMethod.Attachment, filenameWithPdf);
        }

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
    }
}