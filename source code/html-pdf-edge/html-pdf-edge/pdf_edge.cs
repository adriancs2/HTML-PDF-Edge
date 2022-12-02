using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Web;

namespace html_pdf_edge
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
            string folderTemp = HttpContext.Current.Server.MapPath("~/temp/pdf");

            if (!Directory.Exists(folderTemp))
            {
                Directory.CreateDirectory(folderTemp);
            }

            Random rd = new Random();

            string randomstr = rd.Next(100000000, int.MaxValue).ToString();

            string fileHtml = HttpContext.Current.Server.MapPath($"~/temp/pdf/{randomstr}.html");
            string filePdf = HttpContext.Current.Server.MapPath($"~/temp/pdf/{randomstr}.pdf");

            File.WriteAllText(fileHtml, html);

            var r = HttpContext.Current.Request.Url;
            string url = $"{r.Scheme}://{r.Host}:{r.Port}/temp/pdf/{randomstr}.html";

            GeneratePdf(url, filePdf);

            FileInfo fi = new FileInfo(filePdf);
            string filelength = fi.Length.ToString();
            byte[] ba = File.ReadAllBytes(filePdf);

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