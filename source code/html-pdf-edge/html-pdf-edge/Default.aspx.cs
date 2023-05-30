using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace System
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
          
        }

        protected void btPreview_Click(object sender, EventArgs e)
        {
            Response.Clear();
            Response.Write(textarea1.Text);
            Response.End();
        }

        protected void btGeneratePdfAttachment_Click(object sender, EventArgs e)
        {
            PDF.PublishHtml(textarea1.Text, "file.pdf");
        }

        protected void btGeneratePdfInline_Click(object sender, EventArgs e)
        {
            PDF.PublishHtml(textarea1.Text, null, PDF.TransmitMethod.Inline);
        }
    }
}