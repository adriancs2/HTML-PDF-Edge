using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace System
{
    public partial class apiGetPDF : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string text = Request.Form["text"] + "";

            if (text.Length == 0)
            {
                return;
            }

            PDF.PublishHtmlInline(text);
        }
    }
}