<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="System.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <title></title>
    <style type="text/css">
        @import url('https://fonts.googleapis.com/css2?family=Bad+Script&display=swap');

        body, a, input {
            font-size: 12pt;
            font-family: Arial, Helvetica, sans-serif;
        }

        h1 {
            font-family: 'Bad Script', cursive;
            padding: 10px 0;
            margin: auto;
            margin-bottom: 10px;
            border-bottom: 1px solid #b5b5b5;
        }

        .page {
            width: 100%;
            max-width: 1000px;
            margin: auto;
        }

        .divButtons a, input[type=submit] {
            background: #3b59ad;
            color: white;
            display: inline-block;
            border-radius: 6px;
            text-decoration: none;
            font-style: normal;
            padding: 5px 10px;
            cursor: pointer;
            outline: none;
            border: none;
        }

            .divButtons a:hover, input[type=submit]:hover {
                color: #ffec55;
                background: #203a85;
                text-decoration: none;
                font-style: normal;
                position: relative;
                top: 1px;
                bottom: 1px;
            }

        textarea {
            font-family: "Cascadia Mono", Consolas, "Courier New", Courier, monospace;
            font-weight: bold;
            font-size: 10pt;
            color: #5b5b5b;
            height: calc(100vh - 320px);
            width: 95%;
            margin-top: 10px;
            padding: 10px;
        }

        .divLoading {
            width: 360px;
            font-size: 20pt;
            font-style: italic;
            font-family: Arial;
            z-index: 9;
            position: fixed;
            top: calc(50vh - 160px);
            left: calc(50vw - 180px);
            border: 10px solid #7591ef;
            border-radius: 25px;
            padding: 10px;
            text-align: center;
            background: #dce5ff;
            display: none;
            font-weight: bold;
        }
    </style>

</head>
<body>

    <div class="page">

        <h1>
            <img src="Edge-logo.png" style="height: 50px; width: auto;" />
            Convert HTML to PDF by Using Microsoft Edge in ASP.NET
        </h1>

        Project Site: <a href="https://github.com/adriancs2/HTML-PDF-Edge">github.com</a> | 
        <a href="https://adriancs.com/aspnet-webforms/466/convert-html-to-pdf-by-using-microsoft-edge-in-asp-net/">adriancs.com</a> | 
        <a href="https://www.codeproject.com/Articles/5348585/Convert-HTML-to-PDF-by-Using-Mcrosoft-Edge-in-ASP-NET">CodeProject.com</a>

        <br />
        <br />

        <form id="form1" runat="server">

            <div class="divButtons">
                Generate PDF:
                <a href="#" onclick="generatePDF_Ajax(); return false;">Using AJAX</a>
                <a href="#" onclick="generatePDF_FetchApi(); return false;">Using Fetch API</a>
                <asp:Button ID="btGeneratePdfAttachment" runat="server" Text="Postback (attachment)" OnClick="btGeneratePdfAttachment_Click" OnClientClick="showLoading();" />
                <asp:Button ID="btGeneratePdfInline" runat="server" Text="Postback (inline)" OnClick="btGeneratePdfInline_Click" OnClientClick="showLoading();" />
                <asp:Button ID="btPreview" runat="server" Text="Preview HTML Rendering" OnClick="btPreview_Click" /><br />
            </div>

            <hr />

            <div class="divButtons">
                Load Sample HTML:
                <a href="#" onclick="loadDoc('basic'); return false;">basic</a>
                <a href="#" onclick="loadDoc('form1'); return false;">form1</a>
                <a href="#" onclick="loadDoc('invoice1'); return false;">invoice1</a>
                <a href="#" onclick="loadDoc('invoice2'); return false;">invoice2</a>
                <a href="#" onclick="loadDoc('invoice3'); return false;">invoice3</a>
                <a href="#" onclick="loadDoc('invoice4'); return false;">invoice4</a>
            </div>

            <br />

            Special Thanks to: <a href="https://htmlpdfapi.com/blog/free_html5_invoice_templates">htmlpdfapi.com</a> and Document Templates provided by Microsoft Word 2021 for sample HTML.

        <br />
            <br />

            Edit HTML Here:
            <asp:TextBox ID="txt" runat="server" TextMode="MultiLine" spellcheck="false"></asp:TextBox>
        </form>



        <div id="divLoading" class="divLoading" onclick="hideLoading();">
            <img src="loading.gif" /><br />
            Generating PDF...
        </div>

    </div>

    <script type="text/javascript">

        function generatePDF_Ajax() {

            showLoading();

            var xhr = new XMLHttpRequest();
            xhr.open('POST', '/apiGetPDF.aspx'); // URL of server-side script that generates PDF
            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            xhr.responseType = 'arraybuffer'; // receive PDF file as binary data

            xhr.onload = function () {
                if (this.status === 200) {
                    // create a blob URL from the binary data
                    var blob = new Blob([this.response], { type: 'application/pdf' });
                    var url = URL.createObjectURL(blob);
                    // redirect to the PDF file
                    window.location.href = url;
                } else {
                    console.log('Error generating PDF: ' + this.statusText);
                }
            };

            xhr.onerror = function () {
                console.log('Error generating PDF: ' + this.statusText);
            };

            xhr.send('text=' + encodeURIComponent(document.getElementById('txt').value)); // data to send to server-side script
        }

        function generatePDF_FetchApi() {

            showLoading();

            fetch('/apiGetPDF.aspx', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: 'text=' + encodeURIComponent(document.getElementById('txt').value)
            })
                .then(response => {
                    if (response.ok) {
                        return response.arrayBuffer();
                    } else {
                        throw new Error('Error generating PDF: ' + response.statusText);
                    }
                })
                .then(data => {
                    // create a blob URL from the binary data
                    var blob = new Blob([data], { type: 'application/pdf' });
                    var url = URL.createObjectURL(blob);
                    // redirect to the PDF file
                    window.location.href = url;
                })
                .catch(error => {
                    console.log(error);
                });
        }

        function loadDoc(filename) {
            var xhr = new XMLHttpRequest();
            xhr.open('GET', `/sample_html/${filename}.html`, true);
            xhr.responseType = 'text';
            xhr.onload = function () {
                if (xhr.status === 200) {
                    var htmlText = xhr.responseText;
                    document.getElementById('txt').value = htmlText;
                }
            };
            xhr.send();
        }

        function showLoading() {
            let d = document.getElementById("divLoading");
            d.style.display = "block";
            setTimeout(hideLoading, 2000);
        }

        function hideLoading() {
            let d = document.getElementById("divLoading");
            d.style.display = "none";
        }

        loadDoc("basic");
    </script>
</body>
</html>
