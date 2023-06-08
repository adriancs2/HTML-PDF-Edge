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
            margin: auto;
            margin-bottom: 10px;
            border-bottom: 1px solid #b5b5b5;
            font-size: 16pt;
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
            height: calc(100vh - 280px);
            width: 95%;
            position: relative;
            overflow: hidden;
            border: 1px solid #a5a5a5;
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
        }

            #preCode code {
                height: calc(100% - 30px);
                width: calc(100% - 30px);
                padding: 15px;
                font-family: "Roboto Mono", monospace;
                font-weight: 500;
                font-size: 10pt;
                line-height: 150%;
                overflow-y: scroll;
                overflow-x: auto;
            }

        textarea {
            padding: 15px;
            font-family: "Roboto Mono", monospace;
            font-weight: 500;
            font-size: 10pt;
            line-height: 150%;
            position: absolute;
            top: 0;
            left: 0;
            height: calc(100% - 30px);
            width: calc(100% - 30px);
            z-index: 2;
            overflow-x: auto;
            overflow-y: scroll;
            white-space: nowrap;
            background-color: rgba(0,0,0,0);
            color: rgba(255,255,255,0);
            caret-color: #d8d8d8;
        }

            textarea::-webkit-scrollbar, #preCode code::-webkit-scrollbar {
                width: 10px;
                height: 10px;
            }

            textarea::-webkit-scrollbar-track, #preCode code::-webkit-scrollbar-track {
                background: #979797;
            }

            textarea::-webkit-scrollbar-thumb, #preCode code::-webkit-scrollbar-thumb {
                background: #7a7a7a;
                border-radius: 10px;
            }

                textarea::-webkit-scrollbar-thumb:hover, #preCode code::-webkit-scrollbar-thumb:hover {
                    background: #656565;
                }

                textarea::-webkit-scrollbar-thumb:active, #preCode code::-webkit-scrollbar-thumb:active {
                    background: #383838;
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

    <script src="bindCodeEditorShortcutKeys.js"></script>
    <link href="vs2015.min.css" rel="stylesheet" type="text/css" />
    <script src="highlight.min.js"></script>

</head>
<body>

    <div class="page">

        <h1>
            <img src="Edge-logo.png" style="height: 35px; width: auto;" />
            Convert HTML to PDF by Using Microsoft Edge in ASP.NET
        </h1>

        Project Site: <a href="https://github.com/adriancs2/HTML-PDF-Edge">github.com</a> | 
        <a href="https://adriancs.com/aspnet-webforms/466/convert-html-to-pdf-by-using-microsoft-edge-in-asp-net/">adriancs.com</a> | 
        <a href="https://www.codeproject.com/Articles/5348585/Convert-HTML-to-PDF-by-Using-Mcrosoft-Edge-in-ASP-NET">CodeProject.com</a> |
        Nuget: <a href="https://www.nuget.org/packages/html-pdf-edge">https://www.nuget.org/packages/html-pdf-edge</a>

        <hr />

        <form id="form1" runat="server">

            <div class="divButtons" style="margin-bottom: 10px;">
                Load Sample HTML:
                <a href="#" onclick="loadDoc('basic'); return false;">basic</a>
                <a href="#" onclick="loadDoc('form1'); return false;">form1</a>
                <a href="#" onclick="loadDoc('invoice1'); return false;">invoice1</a>
                <a href="#" onclick="loadDoc('invoice2'); return false;">invoice2</a>
                <a href="#" onclick="loadDoc('invoice3'); return false;">invoice3</a>
                <a href="#" onclick="loadDoc('invoice4'); return false;">invoice4</a>
            </div>

            Special Thanks to: <a href="https://htmlpdfapi.com/blog/free_html5_invoice_templates">htmlpdfapi.com</a> and Document Templates provided by Microsoft Word 2021 for sample HTML.

            <hr />

            <div class="divButtons">
                Generate PDF:
                <a href="#" onclick="generatePDF_Ajax(); return false;">Using AJAX</a>
                <a href="#" onclick="generatePDF_FetchApi(); return false;">Using Fetch API</a>
                <asp:Button ID="btGeneratePdfAttachment" runat="server" Text="Postback (attachment)" OnClick="btGeneratePdfAttachment_Click" OnClientClick="showLoading();" />
                <asp:Button ID="btGeneratePdfInline" runat="server" Text="Postback (inline)" OnClick="btGeneratePdfInline_Click" OnClientClick="showLoading();" />
                <asp:Button ID="btPreview" runat="server" Text="Preview HTML Rendering" OnClick="btPreview_Click" /><br />
            </div>

            <hr />

            Edit HTML Here: 
            <div id="divCodeWrapper">
                <pre id="preCode"><code id="codeBlock"></code></pre>
                <asp:TextBox ID="textarea1" runat="server" TextMode="MultiLine" Wrap="false" spellcheck="false" oninput="updateCode();"></asp:TextBox>
            </div>

            <br />
            Shortcut Keys:<br />
            [Enter]: Maintain indentation as previous line.<br />
            [Tab] / [Shift]+[Tab]: Increase/decrease indentation (multiline supported)<br />
            [Shift] + [Del]/[Backspace]: Delete entire row.<br />
            [Home]: Move cursor to the front of first non-white space character.<br />
            <br />
            Read More About <a href="https://adriancs.com/html-css-js/1015/syntax-highlightning-in-textarea-html/">Tranform Textarea Into Code Editor With Syntax Highlight Support</a>

        </form>

        <div id="divLoading" class="divLoading" onclick="hideLoading();">
            <img src="loading.gif" /><br />
            Generating PDF...
        </div>

    </div>

    <script type="text/javascript">

        const textarea1 = document.getElementById("textarea1");
        const codeBlock = document.getElementById("codeBlock");

        // copy code from textarea to code block
        function updateCode() {

            let content = textarea1.value;

            // encode the special characters 
            content = content.replace(/&/g, '&amp;');
            content = content.replace(/</g, '&lt;');
            content = content.replace(/>/g, '&gt;');

            // fill the encoded text to the code
            codeBlock.innerHTML = content;

            // call highlight.js to render the syntax highligtning
            highlightJS();
        }

        // syntax highlight
        function highlightJS() {
            document.querySelectorAll('pre code').forEach((el) => {
                hljs.highlightElement(el);
            });
        }

        // detect content changes in the textarea
        textarea1.addEventListener("input", () => {
            updateCode();
        });

        // sync the scroll bar position between textarea and code block
        textarea1.addEventListener("scroll", () => {
            codeBlock.scrollTop = textarea1.scrollTop;
            codeBlock.scrollLeft = textarea1.scrollLeft;
        });
        
        function generatePDF_Ajax() {

            showLoading();

            let xhr = new XMLHttpRequest();
            xhr.open('POST', '/apiGetPDF.aspx'); // URL of server-side script that generates PDF
            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            xhr.responseType = 'arraybuffer'; // receive PDF file as binary data

            xhr.onload = function () {
                if (this.status === 200) {
                    // create a blob URL from the binary data
                    let blob = new Blob([this.response], { type: 'application/pdf' });
                    let url = URL.createObjectURL(blob);
                    // redirect to the PDF file
                    window.location.href = url;
                } else {
                    console.log('Error generating PDF: ' + this.statusText);
                }
            };

            xhr.onerror = function () {
                console.log('Error generating PDF: ' + this.statusText);
            };

            xhr.send('text=' + encodeURIComponent(textarea1.value)); // data to send to server-side script
        }

        function generatePDF_FetchApi() {

            showLoading();

            fetch('/apiGetPDF.aspx', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: 'text=' + encodeURIComponent(textarea1.value)
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
                    let blob = new Blob([data], { type: 'application/pdf' });
                    let url = URL.createObjectURL(blob);
                    // redirect to the PDF file
                    window.location.href = url;
                })
                .catch(error => {
                    console.log(error);
                });
        }

        function loadDoc(filename) {
            try {

                let xhr = new XMLHttpRequest();
                xhr.open('GET', `/sample_html/${filename}.html`, true);
                xhr.responseType = 'text';
                xhr.onload = function () {
                    if (xhr.status === 200) {
                        let htmlText = xhr.responseText;
                        textarea1.value = htmlText;
                        updateCode();
                    }
                };
                xhr.send();
            }
            catch (err) { alert(err); }
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

        function loadFirstSample() {
            loadDoc("basic");
        }

        setTimeout(loadFirstSample, 250);

        // applying shortcut keys
        bindCodeEditorShortcutKeys(textarea1);

    </script>
</body>
</html>
