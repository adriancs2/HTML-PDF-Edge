<!DOCTYPE html>

<html>
<head>
    <title>Syntax Highlightning for Textarea - adriancs
    </title>

    <style type="text/css">
        @import url('https://fonts.googleapis.com/css2?family=Roboto+Mono:wght@400&display=swap');

        #divCodeWrapper {
            height: calc(100vh - 200px);
            max-height: 600px;
            width: 900px;
            overflow: hidden;
            border: 1px solid #a5a5a5;
            position: relative;
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
                padding: 15px;
                height: calc(100% - 30px);
                width: calc(100% - 30px);
                font-family: "Roboto Mono", monospace;
                font-weight: 400;
                font-size: 12pt;
                line-height: 150%;
                overflow-y: scroll;
                overflow-x: auto;
            }

        textarea {
            font-family: "Roboto Mono", monospace;
            font-weight: 400;
            font-size: 12pt;
            line-height: 150%;
            position: absolute;
            top: 0;
            left: 0;
            height: calc(100% - 30px);
            width: calc(100% - 30px);
            padding: 15px;
            z-index: 2;
            overflow-x: auto;
            overflow-y: scroll;
            white-space: nowrap;
            background-color: rgba(0,0,0,0);
            color: rgba(0,0,0,0);
            caret-color: white;
        }
    </style>

    <style id="style2" type="text/css"></style>

    <link id="theme1" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.8.0/styles/vs2015.min.css" rel="stylesheet" />


    <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.8.0/highlight.min.js" type="text/javascript"></script>

</head>
<body>

    <h1>Syntax Highlightning for Textarea</h1>

    <p>
        <string>Using Textarea as Code Editor</string>
        | 
        Article: 
        <a href="https://adriancs.com/html-css-js/1015/syntax-highlightning-in-textarea-html/">adriancs.com</a>,  
        <a href="https://www.codeproject.com/Articles/5361561/Syntax-Highlightning-for-Textarea-HTML">codeproject.com</a>
        | Source Code: <a href="https://github.com/adriancs2/HTML-PDF-Edge/blob/main/source%20code/html-pdf-edge/html-pdf-edge/Textarea-As-Editor.aspx">github.com</a>
    </p>

    <p>
        Addon Functions: [Enter] will maintain indentation. [Tab] / [Shift]+[Tab] will increase/decrease indentation (support multiline).
    </p>


    <p>
        Theme:
        <select id="dropStyle" onchange="updateThemeStyle(this);">
            <option>a11y-dark.min.css</option>
            <option>a11y-light.min.css</option>
            <option>agate.min.css</option>
            <option>an-old-hope.min.css</option>
            <option>androidstudio.min.css</option>
            <option>arduino-light.min.css</option>
            <option>arta.min.css</option>
            <option>ascetic.min.css</option>
            <option>atom-one-dark-reasonable.min.css</option>
            <option>atom-one-dark.min.css</option>
            <option>atom-one-light.min.css</option>
            <option>brown-paper.min.css</option>
            <option>codepen-embed.min.css</option>
            <option>color-brewer.min.css</option>
            <option>dark.min.css</option>
            <option>default.min.css</option>
            <option>devibeans.min.css</option>
            <option>docco.min.css</option>
            <option>far.min.css</option>
            <option>felipec.min.css</option>
            <option>foundation.min.css</option>
            <option>github-dark-dimmed.min.css</option>
            <option>github-dark.min.css</option>
            <option>github.min.css</option>
            <option>gml.min.css</option>
            <option>googlecode.min.css</option>
            <option>gradient-dark.min.css</option>
            <option>gradient-light.min.css</option>
            <option>grayscale.min.css</option>
            <option>hybrid.min.css</option>
            <option>idea.min.css</option>
            <option>intellij-light.min.css</option>
            <option>ir-black.min.css</option>
            <option>isbl-editor-dark.min.css</option>
            <option>isbl-editor-light.min.css</option>
            <option>kimbie-dark.min.css</option>
            <option>kimbie-light.min.css</option>
            <option>lightfair.min.css</option>
            <option>lioshi.min.css</option>
            <option>magula.min.css</option>
            <option>mono-blue.min.css</option>
            <option>monokai-sublime.min.css</option>
            <option>monokai.min.css</option>
            <option>night-owl.min.css</option>
            <option>nnfx-dark.min.css</option>
            <option>nnfx-light.min.css</option>
            <option>nord.min.css</option>
            <option>obsidian.min.css</option>
            <option>panda-syntax-dark.min.css</option>
            <option>panda-syntax-light.min.css</option>
            <option>paraiso-dark.min.css</option>
            <option>paraiso-light.min.css</option>
            <option>pojoaque.min.css</option>
            <option>purebasic.min.css</option>
            <option>qtcreator-dark.min.css</option>
            <option>qtcreator-light.min.css</option>
            <option>rainbow.min.css</option>
            <option>routeros.min.css</option>
            <option>school-book.min.css</option>
            <option>shades-of-purple.min.css</option>
            <option>srcery.min.css</option>
            <option>stackoverflow-dark.min.css</option>
            <option>stackoverflow-light.min.css</option>
            <option>sunburst.min.css</option>
            <option>tokyo-night-dark.min.css</option>
            <option>tokyo-night-light.min.css</option>
            <option>tomorrow-night-blue.min.css</option>
            <option>tomorrow-night-bright.min.css</option>
            <option>vs.min.css</option>
            <option selected>vs2015.min.css</option>
            <option>xcode.min.css</option>
            <option>xt256.min.css</option>
            <option>base16/3024.min.css</option>
            <option>base16/apathy.min.css</option>
            <option>base16/apprentice.min.css</option>
            <option>base16/ashes.min.css</option>
            <option>base16/atelier-cave-light.min.css</option>
            <option>base16/atelier-cave.min.css</option>
            <option>base16/atelier-dune-light.min.css</option>
            <option>base16/atelier-dune.min.css</option>
            <option>base16/atelier-estuary-light.min.css</option>
            <option>base16/atelier-estuary.min.css</option>
            <option>base16/atelier-forest-light.min.css</option>
            <option>base16/atelier-forest.min.css</option>
            <option>base16/atelier-heath-light.min.css</option>
            <option>base16/atelier-heath.min.css</option>
            <option>base16/atelier-lakeside-light.min.css</option>
            <option>base16/atelier-lakeside.min.css</option>
            <option>base16/atelier-plateau-light.min.css</option>
            <option>base16/atelier-plateau.min.css</option>
            <option>base16/atelier-savanna-light.min.css</option>
            <option>base16/atelier-savanna.min.css</option>
            <option>base16/atelier-seaside-light.min.css</option>
            <option>base16/atelier-seaside.min.css</option>
            <option>base16/atelier-sulphurpool-light.min.css</option>
            <option>base16/atelier-sulphurpool.min.css</option>
            <option>base16/atlas.min.css</option>
            <option>base16/bespin.min.css</option>
            <option>base16/black-metal-bathory.min.css</option>
            <option>base16/black-metal-burzum.min.css</option>
            <option>base16/black-metal-dark-funeral.min.css</option>
            <option>base16/black-metal-gorgoroth.min.css</option>
            <option>base16/black-metal-immortal.min.css</option>
            <option>base16/black-metal-khold.min.css</option>
            <option>base16/black-metal-marduk.min.css</option>
            <option>base16/black-metal-mayhem.min.css</option>
            <option>base16/black-metal-nile.min.css</option>
            <option>base16/black-metal-venom.min.css</option>
            <option>base16/black-metal.min.css</option>
            <option>base16/brewer.min.css</option>
            <option>base16/bright.min.css</option>
            <option>base16/brogrammer.min.css</option>
            <option>base16/brush-trees-dark.min.css</option>
            <option>base16/brush-trees.min.css</option>
            <option>base16/chalk.min.css</option>
            <option>base16/circus.min.css</option>
            <option>base16/classic-dark.min.css</option>
            <option>base16/classic-light.min.css</option>
            <option>base16/codeschool.min.css</option>
            <option>base16/colors.min.css</option>
            <option>base16/cupcake.min.css</option>
            <option>base16/cupertino.min.css</option>
            <option>base16/danqing.min.css</option>
            <option>base16/darcula.min.css</option>
            <option>base16/dark-violet.min.css</option>
            <option>base16/darkmoss.min.css</option>
            <option>base16/darktooth.min.css</option>
            <option>base16/decaf.min.css</option>
            <option>base16/default-dark.min.css</option>
            <option>base16/default-light.min.css</option>
            <option>base16/dirtysea.min.css</option>
            <option>base16/dracula.min.css</option>
            <option>base16/edge-dark.min.css</option>
            <option>base16/edge-light.min.css</option>
            <option>base16/eighties.min.css</option>
            <option>base16/embers.min.css</option>
            <option>base16/equilibrium-dark.min.css</option>
            <option>base16/equilibrium-gray-dark.min.css</option>
            <option>base16/equilibrium-gray-light.min.css</option>
            <option>base16/equilibrium-light.min.css</option>
            <option>base16/espresso.min.css</option>
            <option>base16/eva-dim.min.css</option>
            <option>base16/eva.min.css</option>
            <option>base16/flat.min.css</option>
            <option>base16/framer.min.css</option>
            <option>base16/fruit-soda.min.css</option>
            <option>base16/gigavolt.min.css</option>
            <option>base16/github.min.css</option>
            <option>base16/google-dark.min.css</option>
            <option>base16/google-light.min.css</option>
            <option>base16/grayscale-dark.min.css</option>
            <option>base16/grayscale-light.min.css</option>
            <option>base16/green-screen.min.css</option>
            <option>base16/gruvbox-dark-hard.min.css</option>
            <option>base16/gruvbox-dark-medium.min.css</option>
            <option>base16/gruvbox-dark-pale.min.css</option>
            <option>base16/gruvbox-dark-soft.min.css</option>
            <option>base16/gruvbox-light-hard.min.css</option>
            <option>base16/gruvbox-light-medium.min.css</option>
            <option>base16/gruvbox-light-soft.min.css</option>
            <option>base16/hardcore.min.css</option>
            <option>base16/harmonic16-dark.min.css</option>
            <option>base16/harmonic16-light.min.css</option>
            <option>base16/heetch-dark.min.css</option>
            <option>base16/heetch-light.min.css</option>
            <option>base16/helios.min.css</option>
            <option>base16/hopscotch.min.css</option>
            <option>base16/horizon-dark.min.css</option>
            <option>base16/horizon-light.min.css</option>
            <option>base16/humanoid-dark.min.css</option>
            <option>base16/humanoid-light.min.css</option>
            <option>base16/ia-dark.min.css</option>
            <option>base16/ia-light.min.css</option>
            <option>base16/icy-dark.min.css</option>
            <option>base16/ir-black.min.css</option>
            <option>base16/isotope.min.css</option>
            <option>base16/kimber.min.css</option>
            <option>base16/london-tube.min.css</option>
            <option>base16/macintosh.min.css</option>
            <option>base16/marrakesh.min.css</option>
            <option>base16/materia.min.css</option>
            <option>base16/material-darker.min.css</option>
            <option>base16/material-lighter.min.css</option>
            <option>base16/material-palenight.min.css</option>
            <option>base16/material-vivid.min.css</option>
            <option>base16/material.min.css</option>
            <option>base16/mellow-purple.min.css</option>
            <option>base16/mexico-light.min.css</option>
            <option>base16/mocha.min.css</option>
            <option>base16/monokai.min.css</option>
            <option>base16/nebula.min.css</option>
            <option>base16/nord.min.css</option>
            <option>base16/nova.min.css</option>
            <option>base16/ocean.min.css</option>
            <option>base16/oceanicnext.min.css</option>
            <option>base16/one-light.min.css</option>
            <option>base16/onedark.min.css</option>
            <option>base16/outrun-dark.min.css</option>
            <option>base16/papercolor-dark.min.css</option>
            <option>base16/papercolor-light.min.css</option>
            <option>base16/paraiso.min.css</option>
            <option>base16/pasque.min.css</option>
            <option>base16/phd.min.css</option>
            <option>base16/pico.min.css</option>
            <option>base16/pop.min.css</option>
            <option>base16/porple.min.css</option>
            <option>base16/qualia.min.css</option>
            <option>base16/railscasts.min.css</option>
            <option>base16/rebecca.min.css</option>
            <option>base16/ros-pine-dawn.min.css</option>
            <option>base16/ros-pine-moon.min.css</option>
            <option>base16/ros-pine.min.css</option>
            <option>base16/sagelight.min.css</option>
            <option>base16/sandcastle.min.css</option>
            <option>base16/seti-ui.min.css</option>
            <option>base16/shapeshifter.min.css</option>
            <option>base16/silk-dark.min.css</option>
            <option>base16/silk-light.min.css</option>
            <option>base16/snazzy.min.css</option>
            <option>base16/solar-flare-light.min.css</option>
            <option>base16/solar-flare.min.css</option>
            <option>base16/solarized-dark.min.css</option>
            <option>base16/solarized-light.min.css</option>
            <option>base16/spacemacs.min.css</option>
            <option>base16/summercamp.min.css</option>
            <option>base16/summerfruit-dark.min.css</option>
            <option>base16/summerfruit-light.min.css</option>
            <option>base16/synth-midnight-terminal-dark.min.css</option>
            <option>base16/synth-midnight-terminal-light.min.css</option>
            <option>base16/tango.min.css</option>
            <option>base16/tender.min.css</option>
            <option>base16/tomorrow-night.min.css</option>
            <option>base16/tomorrow.min.css</option>
            <option>base16/twilight.min.css</option>
            <option>base16/unikitty-dark.min.css</option>
            <option>base16/unikitty-light.min.css</option>
            <option>base16/vulcan.min.css</option>
            <option>base16/windows-10-light.min.css</option>
            <option>base16/windows-10.min.css</option>
            <option>base16/windows-95-light.min.css</option>
            <option>base16/windows-95.min.css</option>
            <option>base16/windows-high-contrast-light.min.css</option>
            <option>base16/windows-high-contrast.min.css</option>
            <option>base16/windows-nt-light.min.css</option>
            <option>base16/windows-nt.min.css</option>
            <option>base16/woodland.min.css</option>
            <option>base16/xcode-dusk.min.css</option>
            <option>base16/zenburn.min.css</option>
        </select>
        Font:
        <select id="selectFont">
            <option value="https://fonts.googleapis.com/css2?family=Roboto+Mono&display=swap">Roboto Mono</option>
            <option value="Consolas">Consolas</option>
            <option value="Cascadia Mono">Cascadia Mono</option>
            <option value="https://fonts.googleapis.com/css2?family=Inconsolata&display=swap">Inconsolata</option>
            <option value="https://fonts.googleapis.com/css2?family=Source+Code+Pro&display=swap">Source Code Pro</option>
            <option value="https://fonts.googleapis.com/css2?family=IBM+Plex+Mono&display=swap">IBM Plex Mono</option>
            <option value="https://fonts.googleapis.com/css2?family=Space+Mono:ital@1&display=swap">Space Mono</option>
            <option value="https://fonts.googleapis.com/css2?family=PT+Mono&display=swap">PT Mono</option>
            <option value="https://fonts.googleapis.com/css2?family=Ubuntu+Mono&display=swap">Ubuntu Mono</option>
            <option value="https://fonts.googleapis.com/css2?family=&family=Ubuntu+Mono&display=swap">Nanum Gothic Coding</option>
            <option value="https://fonts.googleapis.com/css2?family=Cousine&display=swap">Cousine</option>
            <option value="https://fonts.googleapis.com/css2?family=Cousine&display=swap">Fira Mono</option>
            <option value="https://fonts.googleapis.com/css2?family=Share+Tech+Mono&display=swap">Share Tech Mono</option>
            <option value="https://fonts.googleapis.com/css2?family=Courier+Prime&display=swap">Courier Prime</option>
            <option value="https://fonts.googleapis.com/css2?family=Anonymous+Pro&display=swap">Anonymous Pro</option>
            <option value="https://fonts.googleapis.com/css2?family=Cutive+Mono&display=swap">Cutive Mono</option>
            <option value="https://fonts.googleapis.com/css2?family=VT323&display=swap">VT323</option>
            <option value="https://fonts.googleapis.com/css2?family=JetBrains+Mono&display=swap">JetBrains Mono</option>
            <option value="https://fonts.googleapis.com/css2?family=Cutive+Mono&family=Noto+Sans+Mono&display=swap">Noto Sans Mono</option>
            <option value="https://fonts.googleapis.com/css2?family=Red+Hat+Mono&display=swap">Red Hat Mono</option>
            <option value="'https://fonts.googleapis.com/css2?family=Martian+Mono&display=swap">Martian Mono</option>
            <option value="https://fonts.googleapis.com/css2?family=Major+Mono+Display&display=swap">Major Mono Display</option>
            <option value="https://fonts.googleapis.com/css2?family=Nova+Mono&display=swap">Nova Mono</option>
            <option value="https://fonts.googleapis.com/css2?family=Syne+Mono&display=swap">Syne Mono</option>
            <option value="https://fonts.googleapis.com/css2?family=Xanh+Mono&display=swap">Xanh Mono</option>
            <option value="https://fonts.googleapis.com/css2?family=Monofett&display=swap">Monofett</option>
        </select>
        Font Size (pt):
        <input id="inputFontSize" type="number" step=".1" value="12" style="width: 40px;" />
        Language:
        <select id="selectLanguage">
            <option value="language-html">HTML</option>
            <option value="language-javascript">JavaScript</option>
            <option value="language-python">Python</option>
            <option value="language-java">Java</option>
            <option value="language-csharp">C#</option>
            <option value="language-php">PHP</option>
            <option value="language-cpp">C++</option>
            <option value="language-typescript">TypeScript</option>
            <option value="language-ruby">Ruby</option>
            <option value="language-swift">Swift</option>
            <option value="language-kotlin">Kotlin</option>
        </select>
    </p>


    <!-- Textarea, the code editor -->

    <div id="divCodeWrapper">
        <pre id="preCode"><code id="codeBlock" class="language-html"></code></pre>
        <textarea id="textarea1" wrap="soft" spellcheck="false"></textarea>
    </div>

    <!-- End of the code editor -->



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

        // applying indentation
        textarea1.addEventListener('keydown', function (e) {

            // [Enter] key pressed detected
            if (e.key === 'Enter') {

                // Prevent the default behavior (new line)
                e.preventDefault();

                // Get the cursor position
                var cursorPos = textarea1.selectionStart;

                // Get the previous line
                var prevLine = textarea1.value.substring(0, cursorPos).split('\n').slice(-1)[0];

                // Get the indentation of the previous line
                var indent = prevLine.match(/^\s*/)[0];

                // Add a new line with the same indentation
                textarea1.setRangeText('\n' + indent, cursorPos, cursorPos, 'end');

                // copy the code from textarea to code block      
                updateCode();
                return;
            }

            // [Tab] pressed, but no [Shift]
            if (e.key === "Tab" && !e.shiftKey &&

                // and no highlight detected
                textarea1.selectionStart == textarea1.selectionEnd) {

                // suspend default behaviour
                e.preventDefault();

                // Get the current cursor position
                let cursorPosition = textarea1.selectionStart;

                // Insert 4 white spaces at the cursor position
                let newValue = textarea1.value.substring(0, cursorPosition) + "    " +
                    textarea1.value.substring(cursorPosition);

                // Update the textarea value and cursor position
                textarea1.value = newValue;
                textarea1.selectionStart = cursorPosition + 4;
                textarea1.selectionEnd = cursorPosition + 4;

                // copy the code from textarea to code block      
                updateCode();
                return;
            }

            // [Tab] and [Shift] keypress presence
            if (e.key === "Tab" && e.shiftKey &&

                // no highlight detected
                textarea1.selectionStart == textarea1.selectionEnd) {

                // suspend default behaviour
                e.preventDefault();

                // Get the current cursor position
                let cursorPosition = textarea1.selectionStart;

                // Check the previous characters for spaces
                let leadingSpaces = 0;
                for (let i = 0; i < 4; i++) {
                    if (textarea1.value[cursorPosition - i - 1] === " ") {
                        leadingSpaces++;
                    } else {
                        break;
                    }
                }

                if (leadingSpaces > 0) {
                    // Remove the spaces
                    let newValue = textarea1.value.substring(0, cursorPosition - leadingSpaces) +
                        textarea1.value.substring(cursorPosition);

                    // Update the textarea value and cursor position
                    textarea1.value = newValue;
                    textarea1.selectionStart = cursorPosition - leadingSpaces;
                    textarea1.selectionEnd = cursorPosition - leadingSpaces;
                }

                // copy the code from textarea to code block
                updateCode();
                return;
            }


            // [Tab] key pressed and range selection detected
            if (e.key == 'Tab' & textarea1.selectionStart != textarea1.selectionEnd) {
                e.preventDefault();

                // split the textarea content into lines
                var lines = this.value.split('\n');

                // find the start/end lines
                var startPos = this.value.substring(0, this.selectionStart).split('\n').length - 1;
                var endPos = this.value.substring(0, this.selectionEnd).split('\n').length - 1;

                // calculating total white spaces are removed
                // these values will be used for adjusting new cursor position
                var spacesRemovedFirstLine = 0;
                var spacesRemoved = 0;

                // [Shift] key was pressed (this means we're un-indenting)
                if (e.shiftKey) {

                    // iterate over all lines
                    for (var i = startPos; i <= endPos; i++) {

                        // /^ = from the start of the line,
                        // {1,4} = remove in between 1 to 4 white spaces that may existed
                        lines[i] = lines[i].replace(/^ {1,4}/, function (match) {

                            // "match" is a string (white space) extracted

                            // obtaining total white spaces removed

                            // total white space removed at first line
                            if (i == startPos)
                                spacesRemovedFirstLine = match.length;

                            // total white space removed overall
                            spacesRemoved += match.length;

                            return '';
                        });
                    }
                }

                // no shift key, so we're indenting
                else {
                    // iterate over all lines
                    for (var i = startPos; i <= endPos; i++) {
                        // add a tab to the start of the line
                        lines[i] = '    ' + lines[i]; // four spaces
                    }
                }

                // remember the cursor position
                var start = this.selectionStart;
                var end = this.selectionEnd;

                // put the modified lines back into the textarea
                this.value = lines.join('\n');

                // adjust the position of cursor start selection
                this.selectionStart = e.shiftKey ?
                    start - spacesRemovedFirstLine : start + 4;

                // adjust the position of cursor end selection
                this.selectionEnd = e.shiftKey ?
                    end - spacesRemoved : end + 4 * (endPos - startPos + 1);

                // copy the code from textarea to code block      
                updateCode();
                return;
            }
        });

        // change theme
        document.getElementById("dropStyle").addEventListener("change", (e) => {
            document.getElementById("theme1").href = `https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.8.0/styles/${e.target.value}`;
        });

        // change font
        function updateFont() {
            let selectFont = document.getElementById("selectFont");
            let inputFontSize = document.getElementById("inputFontSize");
            document.getElementById("style2").textContent = `
            @import url('${selectFont.value}');
            pre, code, textarea {
                font-family: "${selectFont.options[selectFont.selectedIndex].text}", monospace !important;
                font-size: ${inputFontSize.value}pt !important;
            }`;
        }

        // change programming language
        document.getElementById("selectLanguage").addEventListener("change", function () {
            document.getElementById("codeBlock").className = this.value;
            highlightJS();
        });

        // change font size
        document.getElementById("inputFontSize").addEventListener("input", () => { updateFont(); });

        // change font
        document.getElementById("selectFont").addEventListener("change", () => { updateFont(); });

        // load sample html
        function loadSampleHtml() {

            // using fetch api to load a sample html document
            fetch('/sampledoc.html')
                .then(response => response.text())
                .then(html => {
                    textarea1.value = html;
                    updateCode();
                });
        }

        // wait for all files (css, js) finished laoding
        window.onload = function () {

            // use a timer to delay the execution
            // (highlight.js require some time to be ready)
            setTimeout(loadSampleHtml, 250);
        };

    </script>
</body>
</html>
