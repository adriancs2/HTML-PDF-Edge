<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SimpleTest.aspx.cs" Inherits="System.SimpleTest" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Simple Test</title>
    <style type="text/css">
        body, input {
            font-family: monospace;
        }
    </style>
</head>
<body>
    <h1>Simple Test</h1>
    <form id="form1" runat="server">
        
        <asp:Button ID="btGeneratePdf" runat="server" Text="GeneratePdf(string url, string filePathPDF)" OnClick="btGeneratePdf_Click" />
        
        <asp:PlaceHolder ID="ph1" runat="server"></asp:PlaceHolder><br /><br />

        <asp:Button ID="btPublishUrl" runat="server" Text="PublishUrl(string url, string filenamePdf, TransmitMethod transmitMethod)" OnClick="btPublishUrl_Click" /><br /><br />

        <asp:Button ID="btPublishHtmlInline" runat="server" Text="PublishHtmlInline(string htmlContent)" OnClick="btPublishHtmlInline_Click" /><br /><br />

        <asp:Button ID="btPublishHtmlAttachment" runat="server" Text="PublishHtmlAttachment(string htmlContent, string filenamePdf)" OnClick="btPublishHtmlAttachment_Click" /><br /><br />

        <asp:Button ID="btPublishHtml" runat="server" Text="PublishHtml(string htmlContent, string filenamePdf, TransmitMethod transmitMethod)" OnClick="btPublishHtml_Click" />

    </form>
</body>
</html>
