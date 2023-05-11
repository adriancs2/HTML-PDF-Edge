using System;
using System.Diagnostics;
using System.IO;
using System.Net.Http;
using System.Web;
using static System.PDF;

namespace System
{
    public class PDF
    {
        public enum TransmitMethod
        {
            None,
            Attachment,
            Inline,
            Redirect
        }

        public static void GeneratePdf(string urlHtml, string filePathPDF)
        {
            if (File.Exists(filePathPDF))
            {
                try
                {
                    File.Delete(filePathPDF);
                }
                catch { }
            }

            using (var p = new Process())
            {
                p.StartInfo.FileName = "msedge";
                p.StartInfo.Arguments = $@"--headless --disable-gpu --run-all-compositor-stages-before-draw --print-to-pdf=""{filePathPDF}"" {urlHtml}";
                p.Start();
                p.WaitForExit();
            }

            while (!File.Exists(filePathPDF))
            {
                System.Threading.Thread.Sleep(500);
            }
        }

        static void Publish(TransmitMethod transmitMethod, string filenamePdf, string filePdfTemp)
        {
            if (transmitMethod == TransmitMethod.None)
            {

            }
            else if (transmitMethod == TransmitMethod.Attachment)
            {
                HttpContext.Current.Response.Clear();
                HttpContext.Current.Response.ContentType = "application/pdf";
                string encodedFilename = HttpUtility.UrlEncode(filenamePdf);
                HttpContext.Current.Response.AddHeader("Content-Disposition", $"attachment; filename*=UTF-8''{encodedFilename}");
                HttpContext.Current.Response.AddHeader("Content-Length", new FileInfo(filePdfTemp).Length.ToString());
                byte[] ba = File.ReadAllBytes(filePdfTemp);
                try
                {
                    File.Delete(filePdfTemp);
                }
                catch { }
                HttpContext.Current.Response.BinaryWrite(ba);
                HttpContext.Current.Response.End();
            }
            else if (transmitMethod == TransmitMethod.Inline)
            {
                HttpContext.Current.Response.Clear();
                HttpContext.Current.Response.ContentType = "application/pdf";
                string encodedFilename = HttpUtility.UrlEncode(filenamePdf);
                HttpContext.Current.Response.AddHeader("Content-Disposition", $"inline; filename*=UTF-8''{encodedFilename}");
                HttpContext.Current.Response.AddHeader("Content-Length", new FileInfo(filePdfTemp).Length.ToString());
                byte[] ba = File.ReadAllBytes(filePdfTemp);
                try
                {
                    File.Delete(filePdfTemp);
                }
                catch { }
                HttpContext.Current.Response.BinaryWrite(ba);
                HttpContext.Current.Response.End();
            }
            else if (transmitMethod == TransmitMethod.Redirect)
            {
                HttpContext.Current.Response.Redirect($"~/temp/pdf/{filenamePdf}", true);
            }
        }

        static void DeleteOldFiles(string filenameToKeep, string folderTemp)
        {
            string[] oldFiles = Directory.GetFiles(folderTemp);

            DateTime dateexpiry = DateTime.Now.AddMinutes(-30);

            foreach (var file in oldFiles)
            {
                FileInfo fi = new FileInfo(file);
                if (fi.CreationTime < dateexpiry)
                {
                    if (file.EndsWith($"{filenameToKeep}"))
                        continue;

                    try
                    {
                        File.Delete(file);
                    }
                    catch { }
                }
            }
        }

        public static void PublishUrl(string url, string filenamePdf, TransmitMethod transmitMethod)
        {
            if (!filenamePdf.ToLower().EndsWith(".pdf"))
            {
                filenamePdf = filenamePdf + ".pdf";
            }

            string folderTemp = HttpContext.Current.Server.MapPath("~/temp/pdf");

            if (!Directory.Exists(folderTemp))
            {
                Directory.CreateDirectory(folderTemp);
            }

            string filePdfTemp = HttpContext.Current.Server.MapPath($"~/temp/pdf/{filenamePdf}");

            GeneratePdf(url, filePdfTemp);

            DeleteOldFiles(filenamePdf, folderTemp);

            Publish(transmitMethod, filenamePdf, filePdfTemp);
        }

        public static void PublishHtml(string htmlContent)
        {
            PublishHtml(htmlContent, "", TransmitMethod.Inline);
        }

        public static void PublishHtml(string htmlContent, string filenamePdf)
        {
            PublishHtml(htmlContent, filenamePdf, TransmitMethod.Attachment);
        }

        public static void PublishHtml(string htmlContent, string filenamePdf, TransmitMethod transmitMethod)
        {
            if (filenamePdf == null || filenamePdf.Length == 0)
            {
                filenamePdf = DateTime.Now.ToString("yyyyMMddHHmmss") + ".pdf";
            }

            if (!filenamePdf.ToLower().EndsWith(".pdf"))
            {
                filenamePdf = filenamePdf + ".pdf";
            }

            string folderTemp = HttpContext.Current.Server.MapPath("~/temp/pdf");

            if (!Directory.Exists(folderTemp))
            {
                Directory.CreateDirectory(folderTemp);
            }

            string fileHtmlTemp = HttpContext.Current.Server.MapPath($"~/temp/pdf/{filenamePdf}.html");
            string filePdfTemp = HttpContext.Current.Server.MapPath($"~/temp/pdf/{filenamePdf}");

            File.WriteAllText(fileHtmlTemp, htmlContent);

            Uri r = HttpContext.Current.Request.Url;

            string urlHtml = $"{r.Scheme}://{r.Host}:{r.Port}/temp/pdf/{filenamePdf}.html";

            GeneratePdf(urlHtml, filePdfTemp);

            try
            {
                File.Delete(fileHtmlTemp);
            }
            catch { }

            DeleteOldFiles(filenamePdf, folderTemp);

            Publish(transmitMethod, filenamePdf, filePdfTemp);
        }
    }
}