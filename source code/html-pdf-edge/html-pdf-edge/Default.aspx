<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="System.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <title></title>
    <style type="text/css">
        @import url('https://fonts.googleapis.com/css2?family=Bad+Script&display=swap');
        @import url('https://fonts.googleapis.com/css2?family=Roboto+Mono:wght@500&display=swap');

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

        #divCodeWrapper {
            height: calc(100vh - 320px);
            width: 95%;
            position: relative;
            overflow: hidden;
            border: 1px solid #a5a5a5;
            border-radius: 8px;
        }

        #preCode {
            height: 100%;
            width: 100%;
            position: absolute;
            top: 0;
            left: 0;
            overflow: hidden;
            padding: 0;
            margin: 0;
            background: #1b1b1b;
            border-radius: 8px;
        }

            #preCode code {
                height: calc(100% - 40px);
                width: calc(100% - 20px);
                padding: 10px 10px 30px 10px;
                font-family: "Roboto Mono", "Cascadia Mono", "Consolas", "Courier New", Courier, monospace;
                font-weight: 500;
                font-size: 10pt;
                line-height: 150%;
                overflow-y: scroll;
                overflow-x: scroll;
                border-radius: 8px;
            }

        textarea {
            font-family: "Roboto Mono", "Cascadia Mono", "Consolas", "Courier New", Courier, monospace;
            font-weight: 500;
            font-size: 10pt;
            line-height: 150%;
            position: absolute;
            top: 0;
            left: 0;
            height: calc(100% - 40px);
            width: calc(100% - 20px);
            padding: 10px 10px 30px 10px;
            z-index: 2;
            overflow-x: scroll;
            overflow-y: scroll;
            white-space: nowrap;
            background-color: rgba(0,0,0,0);
            color: rgba(255,255,255,0);
            caret-color: white;
            border-radius: 8px;
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

    <link href="vs2015.min.css" rel="stylesheet" type="text/css" />
    <script src="highlight.min.js"></script>

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
            <div id="divCodeWrapper">
                <pre id="preCode"><code id="codeBlock"></code></pre>
                <asp:TextBox ID="txt" runat="server" TextMode="MultiLine" Wrap="false" spellcheck="false" oninput="updateCode();"></asp:TextBox>
            </div>
        </form>



        <div id="divLoading" class="divLoading" onclick="hideLoading();">
            <img src="loading.gif" /><br />
            Generating PDF...
        </div>

    </div>



    <script type="text/javascript">

        var txt = document.getElementById('txt');
        var codeBlock = document.getElementById("codeBlock");

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

            xhr.send('text=' + encodeURIComponent(txt.value)); // data to send to server-side script
        }

        function generatePDF_FetchApi() {

            showLoading();

            fetch('/apiGetPDF.aspx', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: 'text=' + encodeURIComponent(txt.value)
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
                    txt.value = htmlText;
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

        function updateCode() {
            let text = txt.value;
            text = text.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
            codeBlock.innerHTML = text;
            highlightJS();
        }

        function highlightJS() {
            hljs.highlightAll();
        }




        txt.addEventListener('keydown', function (event) {

            if (event.key === 'Enter') {
                event.preventDefault();
                const currentPos = this.selectionStart;
                const currentLine = this.value.substr(0, currentPos).split('\n').pop();
                const indent = currentLine.match(/^\s*/)[0];
                const value = this.value;
                this.value = value.substring(0, currentPos) + '\n' + indent + value.substring(this.selectionEnd);
                this.selectionStart = this.selectionEnd = currentPos + indent.length + 1;

                updateCode();
            }

            else if (event.key === "Tab" && !event.shiftKey && txt.selectionStart !== txt.selectionEnd) {
                event.preventDefault();
                const start = txt.selectionStart;
                const end = txt.selectionEnd;
                const lines = txt.value.substring(start, end).split("\n");
                const indentedLines = lines.map((line) => "    " + line); // add 4 spaces to the beginning of each line
                const indentedText = indentedLines.join("\n");
                txt.value = txt.value.substring(0, start) + indentedText + txt.value.substring(end);
                txt.setSelectionRange(start, start + indentedText.length);

                updateCode();
            }

            else if (event.key === "Tab" && event.shiftKey && txt.selectionStart !== txt.selectionEnd) {
                event.preventDefault();
                const start = txt.selectionStart;
                const end = txt.selectionEnd;
                const lines = txt.value.substring(start, end).split("\n");
                const unindentedLines = lines.map((line) => line.replace(/^ {4}/, "")); // remove 4 spaces from the beginning of each line
                const unindentedText = unindentedLines.join("\n");
                txt.value = txt.value.substring(0, start) + unindentedText + txt.value.substring(end);
                txt.setSelectionRange(start, start + unindentedText.length);

                updateCode();
            }

            //codeBlock.scrollTop = txt.scrollTop;
            //codeBlock.scrollLeft = txt.scrollLeft;
        });

        txt.addEventListener("scroll", () => {
            codeBlock.scrollTop = txt.scrollTop;
            codeBlock.scrollLeft = txt.scrollLeft;
        });


        loadDoc("basic");

        setTimeout(updateCode, 500);
    </script>
</body>
</html>
