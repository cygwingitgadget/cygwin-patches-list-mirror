Return-Path: <SRS0=xB0n=DG=gmail.com=johnhaugabook@sourceware.org>
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
	by sourceware.org (Postfix) with ESMTPS id 6D6744BA2E14
	for <cygwin-patches@cygwin.com>; Sat,  9 May 2026 01:28:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6D6744BA2E14
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6D6744BA2E14
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::1134
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1778290111; cv=none;
	b=V2GZqB26SVT40bVuCqtfeNX3l5bauAk7e+/N3omjSPQVeBwLUN8vZcwrwWMCA4YqRoTN2L4x27/+1jpe179r/V02N1tb+rveTKjJIazd3czwAu//C6BdTpJuGRCcPAJmBBa+QFKGgxIQ4iZqPuwXu4uqntClnry8v1delbELMNc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1778290111; c=relaxed/simple;
	bh=biM7IgVyreyMxX9uMu3Njrs87v0ZocXm8O9RSnK5swg=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=sljvvTpoAFKKs901Z40kt46Yd3mvHsIoC9+UpncSF9zT2rwXIQmFVdgbxsrbZPJszWxHzEd74ZW+KupAgQIbb/k/tn35BGMZIRBmUgrXzItFs33/plPHsheUbOQmN4TFbi922r+lBcuVncq37NHHKrAGd59t8zvXNL3q1y5juBE=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=L3wbdndw
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6D6744BA2E14
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=L3wbdndw
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-7982c3b7da9so23190727b3.1
        for <cygwin-patches@cygwin.com>; Fri, 08 May 2026 18:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778290110; x=1778894910; darn=cygwin.com;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N5Y00iB5YfIMrWgyhiEDkL1YfeD+tUgoJPe72CT+A7Q=;
        b=L3wbdndwMz30khQFLkoIl9BbnNCMddrM3cUBytRmFYe98kLqG2Yv77BWEV7gMEfkPk
         vXewBoQ4rOXmvgLPp/JzypR6YysqYbm0sV2n0eNNUCpKS92Ls8i0bBRuttMf4Q10uabl
         K++tnjomY4Gg91QLwPbNtglu3YDVof3HKVgOhZn3icDFIMk03oW8BpxZQgtw5C3asiWd
         lNnB4bba2hg99+0Ws5E/HaNsMSTb7dWECu6ahhM6uWHPIi1wyH9DdruaPD5E/9tgE6/N
         pegcS19jmYJ5h8G1RzPSxA9V8VpRSeMNUM0lP+kDkrOl/Wma9+pPVFNHcynRamNnofKk
         f0Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778290110; x=1778894910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N5Y00iB5YfIMrWgyhiEDkL1YfeD+tUgoJPe72CT+A7Q=;
        b=dXuu3Gafy3Q5nzOSnNI9tQ8M2lRsxQHhvzjizoGCNuxIzcaToK43wnNcqo/SuuuSW5
         O64k1V7rW6zfkUlgI14W5zbwuYk88Uti3feYz8VUUoNkcS3ScSvlh7VlEdy8Ms0lhBZp
         VRovE2PesuUrkUvQO668aFZKf8Lh9yUHkWWq3+LoxpvXOaKKTz7Mx/1ZotRbMFdY6p66
         1dx/cZtzjsEOkbfhydySo/EBNlLMLxYMHBHeu76tS1rxdCokbdes4XLF386/tiAqg8SK
         al458vqCyf3AejOtbW5UANAqvabyZjISNSoCAC4u+EmjLkX/26mHqLHmZ2OChLAMDcee
         tsCw==
X-Gm-Message-State: AOJu0Yx1DcSDYnTC67klorKWnvbzLZC0FxVX2kDZd2VAcGkk0M+ZP17l
	4WlKJXQ85DChb8SNjAPLMArNxCOhhZTVzATpNEOE/YqLHIsN3gg+O2xPjjsNQQ==
X-Gm-Gg: Acq92OF//3KkoO9eNgVhP2tNqB6rMyz5D+njRfwObkMQEyJyA3SPmbjN4DFhFSjp5hj
	OPgMotfTmEo0a2KBnWC3aXIKFegxgdIDljmeb3LUlytOo1jc9gdTXMfSeYVuuTgqLNKz5cr2OdP
	XteNlay4I2EixM7fmXNDiVdoo9foSZ5qz2kxaqDli28OOYEL/5gPnDy4NrnuHnlUqsyfFlaon/i
	GFm6JTE++yUy8f2LgL4K6TOsrZ91wNahGBew8DJxo8TuSvqF3f26UMig1gQ6TvIa4g1CRU7F7rl
	8+Y28MK3RqA+IzucAZuGJKRtrrif6BK2aYqawkMLvNWJxY5ORv1RfyDlJiL3Loec6qOWPc+ZFDU
	1ckAp3SUTxon7PMXjSspOimFJ9Cpe4oZWJJz0A8Ivv1XHnFbHLjIOVmsktUqdUZ99L8nV4tSIVh
	eKkzgmMZUs3pGnXb0vuSUxVild879TRaARO9UyKoA+UD/OTHn3PnDRIHF5rRAQxmn1uWNSVxmD4
	m3J2DzlBMSmc24q99ftssupAZImVZeBsyLZtA==
X-Received: by 2002:a05:690c:16:b0:7c0:de77:f466 with SMTP id 00721157ae682-7c0de780c18mr16011997b3.2.1778290109973;
        Fri, 08 May 2026 18:28:29 -0700 (PDT)
Received: from localhost.localdomain (h231.205.88.75.dynamic.ip.windstream.net. [75.88.205.231])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd66888cc7sm113210917b3.44.2026.05.08.18.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 18:28:29 -0700 (PDT)
From: johnhaugabook@gmail.com
To: cygwin-patches@cygwin.com
Cc: John Haugabook <johnhaugabook@gmail.com>
Subject: [PATCH 2/7] cygwin-htdocs: website fresh coat of paint
Date: Fri,  8 May 2026 21:27:44 -0400
Message-ID: <20260509012815.1157-3-johnhaugabook@gmail.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20260509012815.1157-1-johnhaugabook@gmail.com>
References: <20260509012815.1157-1-johnhaugabook@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,KAM_SHORT,POISEN_SPAM_PILL,POISEN_SPAM_PILL_1,POISEN_SPAM_PILL_3,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: John Haugabook <johnhaugabook@gmail.com>

html: add class screen to pre tag without class

Signed-off-by: John Haugabook <johnhaugabook@gmail.com>
---
 contrib/dll.html                  |  4 ++--
 git.html                          |  4 ++--
 install.html                      |  2 +-
 package-server.html               | 10 +++++-----
 package-upload.html               | 10 +++++-----
 packaging-contributors-guide.html |  2 +-
 packaging-hint-files.html         | 14 +++++++-------
 packaging-package-files.html      |  8 ++++----
 packaging/build.html              |  2 +-
 packaging/cygport_tips.html       |  8 ++++----
 packaging/key.html                |  6 +++---
 profiling/index.html              |  4 ++--
 setup-packaging-historical.html   | 16 ++++++++--------
 xfree/docs/man1/Xserver.1.html    |  6 +++---
 xfree/docs/man1/startxwin.1.html  |  2 +-
 xfree/docs/xlaunch/finish.html    |  4 ++--
 xfree/docs/xlaunch/program.html   | 16 ++++++++--------
 xfree/docs/xlaunch/xdmcp.html     |  6 +++---
 18 files changed, 62 insertions(+), 62 deletions(-)

diff --git a/contrib/dll.html b/contrib/dll.html
index c6eeb6e6..b442f63a 100755
--- a/contrib/dll.html
+++ b/contrib/dll.html
@@ -101,7 +101,7 @@ in git format-patch format.</p>
 <p>As an example, if you have modified several files in
 /oss/newlib-cygwin/winsup, then do the following in bash:</p>
 
-<pre>
+<pre class="screen">
       [hack, hack, hack]
       git add
       git commit
@@ -127,7 +127,7 @@ sending a patch series to simplify discussing it on the mailing list.</p>
 patches as they got created by git format-patch.  The git send-email
 command will usually do the right thing:</p>
 
-<pre>
+<pre class="screen">
       git send-email --to="cygwin-patches@cygwin.com" &lt;format-patch-files&gt;
 </pre>
 
diff --git a/git.html b/git.html
index e5ad2902..cd05a8d1 100755
--- a/git.html
+++ b/git.html
@@ -29,14 +29,14 @@ commands:</p>
 
 <dt><b>Anonymous Git read-only access</b></dt>
 <dd>
-<pre>
+<pre class="screen">
 git clone https://cygwin.com/git/newlib-cygwin.git
 </pre>
 </dd>
 
 <dt><b>Git for developers with read/write access</b></dt>
 <dd>
-<pre>
+<pre class="screen">
 git clone ssh://cygwin.com:/git/newlib-cygwin.git
 </pre>
 </dd>
diff --git a/install.html b/install.html
index 3a4d9a91..ec7a4815 100755
--- a/install.html
+++ b/install.html
@@ -117,7 +117,7 @@ using <code>-p package</code> or <code>-e package1 package2 ...</code> options.
 
 <p>A: e.g.</p>
 
-<pre>
+<pre class="screen">
 $ gpg --recv-key 56405CF6FCC81574682A5D561A698DE9E2E56300
 gpg: key 1A698DE9E2E56300: "Cygwin &lt;cygwin@cygwin.com&gt;" imported
 gpg: Total number processed: 1
diff --git a/package-server.html b/package-server.html
index 04f1708b..cfdadf9a 100755
--- a/package-server.html
+++ b/package-server.html
@@ -48,7 +48,7 @@ you just want a copy of an existing directory tree. Simply follow these steps:
   public mirror and only add your own custom packages as described in the
   next section.  (Substitute your chosen mirror
   for <em>example.com</em> and your DocumentRoot for <em>/var/www/</em>):
-  <pre>
+  <pre class="screen">
     rsync -vaz rsync://<em>example.com/pub/cygwin/ /var/www/</em>cygwin
   </pre>
 </li>
@@ -86,7 +86,7 @@ script <code>mksetupini</code>.
   </li>
   <li>
     directly from  <a href="https://cygwin.com/cgit/cygwin-apps/calm/">Cygwin-apps git</a>.
-    <pre>
+    <pre class="screen">
       pip3 install git+https://cygwin.com/git/cygwin-apps/calm.git
     </pre>
   </li>
@@ -107,7 +107,7 @@ discussed and announced.
   Create a directory to store your files (i.e., the arch/release/ directory
   tree).  I use <code>/var/www/custom-cygwin/</code>.  If you also created a local
   mirror as described above, you can link those files:
-  <pre>
+  <pre class="screen">
     #!/bin/sh
     mkdir custom-cygwin
     cd custom-cygwin
@@ -128,7 +128,7 @@ discussed and announced.
   you can add an empty package in the <code>Base</code> category that depends on
   several other packages to automatically install them for anyone using your
   custom mirror. For example:
-  <pre>
+  <pre class="screen">
     #!/bin/sh
     mkdir custompackage
     cd custompackage
@@ -144,7 +144,7 @@ discussed and announced.
 <li>
   Run <code>mksetupini</code> and create compressed <code>setup.ini</code> files for the
   setup program:
-  <pre>
+  <pre class="screen">
     #!/bin/sh
     cd /var/www/custom-cygwin/
     for ARCH in x86_64 ; do
diff --git a/package-upload.html b/package-upload.html
index 4bb5a54c..8e656f10 100755
--- a/package-upload.html
+++ b/package-upload.html
@@ -25,7 +25,7 @@ script for your packages, you can upload your finished packages
 using <a href="https://cygwin.github.io/cygport/pkg_upload_cygpart.html">
 <code>cygport up</code></a>, e.g.:</p>
 
-<pre>    cygport pkg.cygport up</pre>
+<pre class="screen">    cygport pkg.cygport up</pre>
 
 <p><code>calm</code> will scan the upload directories for packages that are ready,
 verify them, and, if there are no errors, move the packages into the real
@@ -56,7 +56,7 @@ area will remain unchanged.</p>
 
 Package maintainers can promote their own packages from test to current using:
 
-<pre>    ssh cygwin@cygwin.com untest <i>sourcepackage-version-release</i></pre>
+<pre class="screen">    ssh cygwin@cygwin.com untest <i>sourcepackage-version-release</i></pre>
 
 Historical alternatives were:
 
@@ -129,7 +129,7 @@ file with the name of the file that you want deleted, prefixed with a
 <p>You may also upload files directly, using an sftp client such as sftp or lftp. An upload
 directory on cygwin.com will look like this:</p>
 
-<pre>
+<pre class="screen">
        Your Name                          # directory is currently your full name (you won't actually see this)
         x86_64    noarch                  # arch directory
          release   release                # release directory
@@ -139,7 +139,7 @@ directory on cygwin.com will look like this:</p>
 
 <h4>Example using <a href="http://lftp.yar.ru/">lftp</a> to upload packages:</h4>
 
-<pre>
+<pre class="screen">
     % lftp sftp://cygwin@cygwin.com
     cd ok, cwd=/
 
@@ -181,7 +181,7 @@ directory on cygwin.com will look like this:</p>
 
 <h4>Example <code>lftp</code> upload command line</h4>
 
-<pre>
+<pre class="screen">
     # command line to upload the time packages
     cd wherever
     lftp -c 'connect sftp://cygwin@cygwin.com/; cd x86_64/release; mirror -eR time; put /dev/null -o !ready'
diff --git a/packaging-contributors-guide.html b/packaging-contributors-guide.html
index 226b321e..9aa815d0 100755
--- a/packaging-contributors-guide.html
+++ b/packaging-contributors-guide.html
@@ -157,7 +157,7 @@ moment.  Two common techniques to achieve this:
     package file and then running any
     <a href="packaging-package-files.html#postinstall">postinstall scripts</a>
     manually:
-    <pre>
+    <pre class="screen">
       $ tar -C / -xvf boffo-1.0-1.x86_64/dist/boffo/boffo-1.0-1.tar.xz
       $ /etc/postinstall/boffo.sh</pre>
   </li>
diff --git a/packaging-hint-files.html b/packaging-hint-files.html
index 291f9ddc..17900ed3 100755
--- a/packaging-hint-files.html
+++ b/packaging-hint-files.html
@@ -26,7 +26,7 @@
 <p>Lines in <code>package-version-release.hint</code> consist of one of the
 following:</p>
 
-<pre>
+<pre class="screen">
 # <i>comment</i>
 sdesc: <i>"some text"</i>
 ldesc: <i>"some text"</i>
@@ -64,7 +64,7 @@ disable-check: <i>check-name [check-name...]</i>
       installing packages via setup, e.g.
     </p>
 
-<pre>
+<pre class="screen">
 sdesc: "A whackamole simulation in ASCII art"
 </pre>
 
@@ -84,7 +84,7 @@ sdesc: "A whackamole simulation in ASCII art"
       package, enclosed in double-quotes.  e.g.:
     </p>
 
-<pre>
+<pre class="screen">
 ldesc: "A whackamole simulation in ASCII art.
 
 Intended for use on VT100 terminals at BAUD rates 1200 and
@@ -302,7 +302,7 @@ No actual moles will be harmed during execution of this game."
   </li>
 </ul>
 <p>Here's an example of a complete <i>release/boffo/boffo-1.0-1.hint</i>:</p>
-<pre>
+<pre class="screen">
 category: Games Text
 requires: libncurses6 cygwin
 sdesc:    "A whackamole simulation in ASCII art"
@@ -361,7 +361,7 @@ No actual moles will be harmed during execution of this game."</pre>
   </table>
 </div>
 <p>The setup.ini generated from these .hint files will include these lines (only relevant lines shown):</p>
-<pre>
+<pre class="screen">
 @ boffo
 requires: libboffo7 libncurses6 cygwin
 version: 2.4.1-2
@@ -383,7 +383,7 @@ source: release/boffo/boffo-2.4.1-2-src.tar.xz
 
 <h2 class="cartouche" id="pvr-src.hint"><code>package-version-release-src.hint</code> file</h2>
 
-<pre>
+<pre class="screen">
 # <i>comment</i>
 build-depends: <i>dependency-atom[ dependency-atom...]</i>
 category: <i>name1[ name2...]</i>
@@ -445,7 +445,7 @@ version: <i>version-identifier</i>
   with a specific <i>version-release</i>.
 </p>
 
-<pre>
+<pre class="screen">
 # <i>comment</i>
 keep: <i>version-identifier</i>[ <i>version-identifier</i>...]
 keep-count: <i>count</i>
diff --git a/packaging-package-files.html b/packaging-package-files.html
index 6e084da7..23efb5e5 100755
--- a/packaging-package-files.html
+++ b/packaging-package-files.html
@@ -97,7 +97,7 @@
 e.g.:
 </p>
 
-<pre>
+<pre class="screen">
 bash$ ls -1 release/boffo
 boffo-1.0-1-src.hint
 boffo-1.0-1-src.tar.xz
@@ -150,7 +150,7 @@ boffo-1.0-1.tar.xz
   <li>
     Binary packages are extracted in /, include all file paths from the root in
     your archive, e.g.:
-<pre>
+<pre class="screen">
 usr/bin/boffo.exe
 usr/share/boffo/boffo.dat
 etc...
@@ -158,7 +158,7 @@ etc...
   </li>
   <li>
     The package is configured using (at a minimum) the following paths:
-<pre>
+<pre class="screen">
 --prefix=/usr
 --sysconfdir=/etc
 --libexecdir=/usr/lib
@@ -197,7 +197,7 @@ etc...
   <li>Source packages are extracted in /usr/src (so the paths in your source tar
   file should not include /usr/src). On extraction, the tar file should put the
   sources in a directory with the same name as the package, e.g.:
-<pre>
+<pre class="screen">
 boffo-1.0-1/boffo.cygport
 boffo-1.0-1/boffo-1.0.tar.xz
 boffo-1.0-1/boffo-1.0-1.src.patch
diff --git a/packaging/build.html b/packaging/build.html
index aad1afc9..d5123ce3 100755
--- a/packaging/build.html
+++ b/packaging/build.html
@@ -18,7 +18,7 @@
   automatic build of the package is queued:
 </p>
 
-<pre>
+<pre class="screen">
   remote: scallywag: build <i>nnnn</i> queued
   remote: scallywag: https://cygwin.com/cgi-bin2/jobs.cgi?id=<i>nnnn</i>
 </pre>
diff --git a/packaging/cygport_tips.html b/packaging/cygport_tips.html
index 4bd5713d..16ea5fe2 100755
--- a/packaging/cygport_tips.html
+++ b/packaging/cygport_tips.html
@@ -111,7 +111,7 @@
       means something like:
     </p>
 
-<pre>
+<pre class="screen">
 libboffo0_CONTENTS="
   usr/bin/*-0.dll
   usr/share
@@ -173,7 +173,7 @@ libboffo0_CONTENTS="
     use <a href="https://cygwin.github.io/cygport/src_compile_cygpart.html#lndirs"><code>lndirs</code></a>,
     e.g.:
 
-<pre>
+<pre class="screen">
 src_compile() {
   cd ${S}
   cygautoreconf
@@ -210,7 +210,7 @@ src_compile() {
       you can use <code>declare</code> to set it's contents etc., e.g.:
     </p>
 
-<pre>
+<pre class="screen">
 inherit python3 meson
 ...
 PKG_NAMES="foo libfoo1 libfoo-devel python3-foo python${PYTHON3_PKGVERSION}-foo"
@@ -247,7 +247,7 @@ declare python${PYTHON3_PKGVERSION}_foo_CATEGORY="Python"
     A data only package probably wants a <code>src_compile</code> function which
     does nothing, e.g.:
 
-<pre>
+<pre class="screen">
 src_compile() {
   true
 }
diff --git a/packaging/key.html b/packaging/key.html
index 0cfd006f..0282cb77 100755
--- a/packaging/key.html
+++ b/packaging/key.html
@@ -21,7 +21,7 @@ If you are a package maintainer, you will need to provide an SSH key.
 
 <p>Send your SSH public key to the <a href="http://cygwin.com/lists.html#cygwin-apps">cygwin-apps</a> mailing list using this format:</p>
 
-<pre>
+<pre class="screen">
     Name: Your Name
     ---- BEGIN SSH2 PUBLIC KEY ----
     &nbsp;&nbsp;&nbsp;<em>RFC 4716 format ssh public key here</em>
@@ -29,7 +29,7 @@ If you are a package maintainer, you will need to provide an SSH key.
 </pre>
 
 <p>An ssh key-pair can be generated, and the public key exported as follows:</p>
-<pre>
+<pre class="screen">
     ssh-keygen -f ~/.ssh/cygwin
     ssh-keygen -e -f ~/.ssh/cygwin.pub
 </pre>
@@ -86,7 +86,7 @@ provided.
   <li>
     Add a section to <code>~/.ssh/config</code> selecting that SSH private key when
     connecting to cygwin.com, e.g.:
-    <pre>
+    <pre class="screen">
 Host cygwin.com
   User cygwin
   IdentityFile ~/.ssh/cygwin</pre>
diff --git a/profiling/index.html b/profiling/index.html
index f7c12c5a..23d2cd66 100644
--- a/profiling/index.html
+++ b/profiling/index.html
@@ -20,7 +20,7 @@ build, and install gprof.</p>
 <p>Delete all of your <code>.o</code>'s in newlib and winsup.  Rebuild
 them all with profiling options:</p>
 
-<pre>
+<pre class="screen">
 make -k -w CFLAGS='-pg -O2 -g' CXXFLAGS='-pg -O2 -g'
 </pre>
 
@@ -46,7 +46,7 @@ modified to work for this context.</p>
 <p>Now that you have <code>libcpg.a</code>, <code>libwinpg.a</code>, and
 <code>malloc.o</code>, you can build your programs like this:</p>
 
-<pre>
+<pre class="screen">
 CFLAGS = -g -pg -O2
 
 D = djmalloc.o libwinpg.a libcpg.a libwinpg.a
diff --git a/setup-packaging-historical.html b/setup-packaging-historical.html
index 344fdac3..12c8bdc0 100755
--- a/setup-packaging-historical.html
+++ b/setup-packaging-historical.html
@@ -26,7 +26,7 @@ use cygport.</p>
 <ul class="compact">
   <li>
     Source packages are extracted underneath /usr/src (so your -src tarball should not include /usr/src). On extraction, the tar file should put the sources in a directory with the same name as the package tar ball minus the -src.tar.bz2 part:
-<pre>
+<pre class="screen">
 boffo-1.0-1/Makefile.in
 boffo-1.0-1/README
 boffo-1.0-1/configure
@@ -39,31 +39,31 @@ etc...
   <li>Include a single file foo-version-release.patch in your source package, that when applied (in reverse: 'patch -R') will remove all the patches you've applied to the package, leaving it as the vendor distributes it. This file should extract as : <code>/usr/src/foo-version-release.patch</code> (that is, since setup extracts everything into <code>/usr/src</code>, the patch should be a "top level" member of the -src tarball.)<br />
     <br />
     Optionally, this patch could also unpack inside the source tree:
-<pre>
+<pre class="screen">
 boffo-1.0-1/README
 boffo-1.0-1/configure
 boffo-1.0-1/CYGWIN-PATCHES/boffo-1.0-1.patch
 etc...
 </pre>
     However, that tends to complicate actually <b>creating</b> the patch itself. Unless one enjoys recursion, one must move the .patch file OUT of the source tree, regenerate the patch to incorporate any new changes, and then copy the new patch back into .../CYGWIN-PATCHES/. This option is documented because some existing packages do it this way, but it is not recommended for new packages. Make boffo-1.0-1.patch a top-level member of the -src tarball instead:
-<pre>
+<pre class="screen">
 boffo-1.0-1.patch
 boffo-1.0-1/README
 boffo-1.0-1/configure
 etc...
 </pre>
     To create the patch file described above, you might run
-<pre>
+<pre class="screen">
 diff -Nrup vendor-src-dir patched-src-dir &gt; foo-version-release.patch
 </pre>
     To apply the generated patch (in reverse; that is, to remove the Cygwin specific changes from the unpacked -src tarball) the user would run (from within the source tree)
-<pre>
+<pre class="screen">
 patch -R -p1 &lt; ../foo-version-release.patch
 </pre>
   </li>
   <li>In general, any Cygwin-specific "packaging" files -- such as cygwin-specific READMEs, a copy of the setup.hint file for your package, etc. -- should unpack within a /CYGWIN-PATCHES/ subdirectory in your sources. Naturally, applying the patch (in reverse, as described above) would remove these files from the source tree.</li>
   <li>So, returning to the boffo example, boffo-1.0-1-src.tar.bz2 would contain:
-<pre>
+<pre class="screen">
 boffo-1.0-1.patch
 boffo-1.0-1/README
 boffo-1.0-1/configure
@@ -110,13 +110,13 @@ boffo-1.0-1/CYGWIN-PATCHES/setup.hint
       <li>Prepare the staging location for the -src package (yes, do the -src package first): From the directory above your boffo-1.0 tree (e.g. <code>~/sources/</code> in our example) execute '<code>./boffo-1.0-1.sh mkdirs</code>'</li>
       <li>Create the -src package: '<code>./boffo-1.0-1.sh spkg</code>'</li>
       <li>Now, let's go somewhere else and unpack this new -src package:
-<pre>
+<pre class="screen">
 cd /tmp
 tar xvjf ~/sources/boffo-1.0-1-src.tar.bz2
 </pre>
       </li>
       <li>Finally, rebuild the whole thing (you're still in /tmp):
-<pre>
+<pre class="screen">
 ./boffo-1.0-1.sh all
 </pre>
 	(Or, you may want to do each step in 'all' manually: prep, conf, build, (check), install, strip, pkg, spkg, finish.
diff --git a/xfree/docs/man1/Xserver.1.html b/xfree/docs/man1/Xserver.1.html
index 8b44e6ac..cbe9704c 100644
--- a/xfree/docs/man1/Xserver.1.html
+++ b/xfree/docs/man1/Xserver.1.html
@@ -566,7 +566,7 @@ or a complete name in the format
 There should be no leading or trailing spaces on any lines.  For example:
 <P>
 
-<PRE>
+<PRE class="screen">
 joesworkstation
 corporate.company.com
 inet:bigcpu
@@ -666,7 +666,7 @@ the font paths specified by the symlinks.
 <P>
 An example configuration:
 <P>
-<PRE>
+<PRE class="screen">
     75dpi:unscaled:pri=20 -&gt; /usr/share/X11/fonts/75dpi
     ghostscript:pri=60 -&gt; /usr/share/fonts/default/ghostscript
     misc:unscaled:pri=10 -&gt; /usr/share/X11/fonts/misc
@@ -680,7 +680,7 @@ N'39'unscaled', second FPE will be /usr/share/X11/fonts/75dpi, also with
 the attribute 'unscaled' etc. This is functionally equivalent to setting
 the following font path:
 <P>
-<PRE>
+<PRE class="screen">
     /usr/share/X11/fonts/misc:unscaled,
     /usr/share/X11/fonts/75dpi:unscaled,
     /usr/share/X11/fonts/Type1,
diff --git a/xfree/docs/man1/startxwin.1.html b/xfree/docs/man1/startxwin.1.html
index b76dbf79..cd2c2844 100644
--- a/xfree/docs/man1/startxwin.1.html
+++ b/xfree/docs/man1/startxwin.1.html
@@ -174,7 +174,7 @@ the window manager has been configured properly, the user
 then chooses the ''Exit'' menu item to shut down X.
 <P>
 
-<PRE>
+<PRE class="screen">
 xrdb -load $HOME/.Xresources
 xbiff -geometry -430+5 &amp;
 oclock -geometry 75x75-0-0 &amp;
diff --git a/xfree/docs/xlaunch/finish.html b/xfree/docs/xlaunch/finish.html
index 4b7bef48..e0b05af6 100644
--- a/xfree/docs/xlaunch/finish.html
+++ b/xfree/docs/xlaunch/finish.html
@@ -17,12 +17,12 @@ Select Finish to run the options selected and start the X server and any additio
 Click this option to save your configuration for reuse.<p>
 You can use XLaunch to start the X server with a saved configuration by double clicking the .xlaunch file,
 choosing <b>Open</b> from the right-click context menu for the .xlaunch file, or like this
-<pre>XLaunch -run &lt;config.xlaunch&gt;
+<pre class="screen">XLaunch -run &lt;config.xlaunch&gt;
 </pre>
 <p>
 To edit an existing configuration or use a configuration as a preset for new configuration choose <b>Edit</b>
 from the right-click context menu for the .xlaunch file or
-<pre>XLaunch -load &lt;config.xlaunch&gt;
+<pre class="screen">XLaunch -load &lt;config.xlaunch&gt;
 </pre>
 <h3><a name="3"></a>Finish</h3>
 The wizard is closed and the X server is run with your settings.
diff --git a/xfree/docs/xlaunch/program.html b/xfree/docs/xlaunch/program.html
index f1de2225..90b84a6d 100644
--- a/xfree/docs/xlaunch/program.html
+++ b/xfree/docs/xlaunch/program.html
@@ -13,7 +13,7 @@
 <h2><a name="1"></a>Start program</h2>
 Enter the name and parameters of an X client you want to start and display on the X server.
 For example, to run <b>xeyes</b>
-<pre>xeyes -fg red
+<pre class="screen">xeyes -fg red
 </pre>
 <h3><a name="3"></a>Start program on this computer</h3>
 Start the chosen or entered program (with parameters as required) on the local machine.
@@ -25,7 +25,7 @@ An X client program can be started remotely via SSH.<p>
 There is no mechanism to save a ssh password for security reasons.<p>
 SSH X11 forwarding must be enabled in the <b>sshd</b> daemon's sshd_config file on the remote machine, e.g.
 
-<pre>
+<pre class="screen">
 X11Forwarding yes
 </pre>
 
@@ -41,7 +41,7 @@ so that subsequent non-interactive shells, such as used by xlaunch can source
 the file and make passwordless ssh connections).<p>
 
 e.g. to start <b>ssh-agent</b> and load the key ~/.ssh/ida_rsa into it:
-<pre>
+<pre class="screen">
 $ keychain id_rsa
 </pre>
 You will be prompted for the key's passphrase.
@@ -51,7 +51,7 @@ Subsequently, xlaunch can run <b>ssh</b> using this key to authenticate without
 prompting for the passphrase.<p>
 
 When finished, use <b>keychain</b> to stop <b>ssh-agent</b>
-<pre>
+<pre class="screen">
 $ keychain -k all
 </pre>
 <p>
@@ -75,16 +75,16 @@ to a local private key which has no passphrase.
 
 e.g.
 Create a passphrase-less key-pair, using
-<pre>
+<pre class="screen">
 ssh-keygen -f ~/.ssh/example-key -N ''
 </pre>
 append the public key to your ~/.ssh/authorized_keys file on the remote machine,
-<pre>
+<pre class="screen">
 ssh-copy-id -i ~/.ssh/example-key.pub <i>user@server</i>
 </pre>
 and instruct the local ssh to use the corresponding private key, by adding to ~/.ssh/config
 (possibly under an appropriate Host section)
-<pre>
+<pre class="screen">
 IdentityFile ~/.ssh/example-key
 </pre>
 <p>
@@ -96,7 +96,7 @@ the "IdentityFile" section of <b>man ssh_config</b> for more details.
 <h5><a name="11"></a>Troubleshooting SSH</h5>
 
 The command run automatically after the X server has started is
-<pre>ssh -Y &lt;user@computer&gt; &lt;program&gt;
+<pre class="screen">ssh -Y &lt;user@computer&gt; &lt;program&gt;
 </pre>
 Try this by hand, from a shell, if you have problems.<p>
 
diff --git a/xfree/docs/xlaunch/xdmcp.html b/xfree/docs/xlaunch/xdmcp.html
index b926a515..070b6446 100644
--- a/xfree/docs/xlaunch/xdmcp.html
+++ b/xfree/docs/xlaunch/xdmcp.html
@@ -27,18 +27,18 @@ On the remote *nix machine edit the following files, restart the X Display Manag
 <ul><li>
 Edit the file Xaccess (each Display Manager has its own).
 Make sure you have a line like this that is uncommented.
-<pre>*     	#any host can get a login window
+<pre class="screen">*     	#any host can get a login window
 </pre></li>
 <li>
 Edit the X Display Manager config file (kdmrc, gdm.config, xdm-config or wdm-config) and change
-<pre>[Xdmcp]
+<pre class="screen">[Xdmcp]
 Enable=false <i>(may be shown as 0 in some distributions)</i>
   <i>to</i>
 [Xdmcp]
 Enable=true <i>(or 1 in some distributions)</i>
 </pre>
 or for a xdm style configuration
-<pre>DisplayManager.requestPort:	0
+<pre class="screen">DisplayManager.requestPort:	0
   <i>to</i>
 !DisplayManager.requestPort:	0
 </pre></li></ul>
-- 
2.49.0.windows.1

