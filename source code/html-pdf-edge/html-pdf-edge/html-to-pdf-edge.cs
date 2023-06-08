using System;
using System.Diagnostics;
using System.IO;
using System.Linq;
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

        public const string Version = "2.1";

        /// <summary>
        /// Convert a webpage into pdf
        /// </summary>
        /// <param name="urlHtml">The webpage</param>
        /// <param name="filePathPDF">The file path of pdf</param>
        public static void GeneratePdf(string url, string filePathPDF)
        {
            string encodedUrl = Uri.EscapeUriString(url);

            string folderPath = Path.GetDirectoryName(filePathPDF);

            if (!Directory.Exists(folderPath))
            {
                Directory.CreateDirectory(folderPath);
            }

            using (var p = new Process())
            {
                p.StartInfo.FileName = "msedge";
                p.StartInfo.Arguments = $@"--headless --disable-gpu --run-all-compositor-stages-before-draw --print-to-pdf=""{filePathPDF}"" {encodedUrl}";
                p.Start();
                p.WaitForExit();
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

        /// <summary>
        /// Convert a webpage into pdf and transmit it for download
        /// </summary>
        /// <param name="url">The webpage</param>
        /// <param name="filenamePdf">The filename of pdf (without the file path)</param>
        /// <param name="transmitMethod">The transmit method</param>
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

        /// <summary>
        /// Convert html to pdf and transmit it for download as inline
        /// </summary>
        /// <param name="htmlContent"></param>
        public static void PublishHtmlInline(string htmlContent)
        {
            PublishHtml(htmlContent, "", TransmitMethod.Inline);
        }

        /// <summary>
        /// Convert html to pdf and transmit it for download as attachment.
        /// </summary>
        /// <param name="htmlContent">The html text</param>
        /// <param name="filenamePdf">Filename of PDF</param>
        public static void PublishHtmlAttachment(string htmlContent, string filenamePdf)
        {
            PublishHtml(htmlContent, filenamePdf, TransmitMethod.Attachment);
        }

        /// <summary>
        /// Convert html to pdf and transmit it for download
        /// </summary>
        /// <param name="htmlContent">The html text</param>
        /// <param name="filenamePdf">Filename of PDF (optional), this parameter can be blank inline download transmission</param>
        /// <param name="transmitMethod">Transmission type</param>
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

            filenamePdf = filenamePdf.Replace(" ", "_");

            filenamePdf = EscapeFileName(filenamePdf);

            string folderTemp = HttpContext.Current.Server.MapPath("~/temp/pdf");

            if (!Directory.Exists(folderTemp))
            {
                Directory.CreateDirectory(folderTemp);
            }

            Random rd = new Random();

            string htmlRandomFilename = rd.Next(100000, int.MaxValue).ToString();

            string fileHtmlTemp = HttpContext.Current.Server.MapPath($"~/temp/pdf/{htmlRandomFilename}.html");
            string filePdfTemp = HttpContext.Current.Server.MapPath($"~/temp/pdf/{filenamePdf}");

            File.WriteAllText(fileHtmlTemp, htmlContent);

            Uri r = HttpContext.Current.Request.Url;

            string urlHtml = $"{r.Scheme}://{r.Host}:{r.Port}/temp/pdf/{htmlRandomFilename}.html";

            GeneratePdf(urlHtml, filePdfTemp);

            try
            {
                File.Delete(fileHtmlTemp);
            }
            catch { }

            DeleteOldFiles(filenamePdf, folderTemp);

            Publish(transmitMethod, filenamePdf, filePdfTemp);
        }

        static string EscapeFileName(string fileName)
        {
            string escapedFileName = string.Concat(fileName.Select(c => IsValidFileNameChar(c) ? c.ToString() : "_"));
            return escapedFileName;
        }

        static bool IsValidFileNameChar(char c)
        {
            return !Path.GetInvalidFileNameChars().Contains(c);
        }
    }
}