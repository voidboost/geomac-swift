<h1>geomac-swift</h1>
<p>A simple program (written in swift) to get geolocation of Wi-Fi access points by their BSSIDs. Requires macOS 14 Sonoma or later.</p>
<h2>Features</h2>
<ul>
    <li>searches for a location using data from five network location providers</li>
    <li>sends HTTP requests asynchronously to speed up lookups</li>
    <li>accepts MAC addresses in various formats</li>
    <li>simple GUI</li>
</ul>
<p>And more!</p>
<h2>Releases</h2>
<a href="https://github.com/voidboost/geomac-swift/releases/latest/download/Geomac.dmg">Download latest version</a>
<h2>Sponsor & Support</h2>
<p>
    To keep this app maintained and up-to-date please consider sponsoring it on GitHub. Or if you are looking for a private support or help in customizing the experience, then reach out to me on Telegram
    <a href="https://t.me/voidboost">@voidboost</a>.
</p>
<h2>Troubleshooting</h2>
<h3>Error during installation/launch of the application</h3>
<p>These two commands usually help — you need to run them in the terminal (when entering the password, it will be hidden — that’s normal).</p>
<pre><code>sudo xattr -cr /Applications/Geomac.app</code></pre>
<p>and</p>
<pre><code>sudo codesign --force --deep --sign - /Applications/Geomac.app</code></pre>
<h2>Screenshots</h2>
<img width="100%" src="https://github.com/user-attachments/assets/05cdd5a0-55a9-4ee4-8e43-f1ca909b9cd5" />
<h2>License</h2>
<a href="./LICENSE">MIT</a>
