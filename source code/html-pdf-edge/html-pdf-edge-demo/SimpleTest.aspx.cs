using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Http;
using System.Threading.Tasks;

namespace System
{
    public partial class SimpleTest : System.Web.UI.Page
    {
        string url = "https://www.adriancs.com/demo/invoice.html";
        // string url = "file:///C:/Users/Username/Documents/invoice.html";

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        string GetHtml()
        {
            HttpClient client = new HttpClient();
            HttpResponseMessage response = client.GetAsync(url).Result;
            string html = response.Content.ReadAsStringAsync().Result;
            return html;
        }

        protected void btGeneratePdf_Click(object sender, EventArgs e)
        {
            string filePathPDF = Server.MapPath("~/file.pdf");
            PDF.GeneratePdf(url, filePathPDF);

            ph1.Controls.Add(new LiteralControl($"Done! File downloaded at: {filePathPDF}"));
        }

        protected void btPublishUrl_Click(object sender, EventArgs e)
        {
            PDF.TransmitMethod transmitMethod = PDF.TransmitMethod.Inline;
            PDF.PublishUrl(url, "file.pdf", transmitMethod);
        }

        protected void btPublishHtmlInline_Click(object sender, EventArgs e)
        {
            string html = GetHtml();
            PDF.PublishHtmlInline(html);
        }

        protected void btPublishHtmlAttachment_Click(object sender, EventArgs e)
        {
            string html = GetHtml();
            PDF.PublishHtmlAttachment(html, "file.pdf");
        }

        protected void btPublishHtml_Click(object sender, EventArgs e)
        {
            string html = GetHtml();
            PDF.TransmitMethod transmitMethod = PDF.TransmitMethod.Inline;
            PDF.PublishHtml(html, "file.pdf", transmitMethod);
        }
    }
}