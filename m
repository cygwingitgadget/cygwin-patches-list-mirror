Return-Path: <cygwin-patches-return-8009-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9627 invoked by alias); 2 Aug 2014 13:27:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 9608 invoked by uid 89); 2 Aug 2014 13:27:27 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.3 required=5.0 tests=AWL,BAYES_00,RP_MATCHES_RCVD,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.2
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Sat, 02 Aug 2014 13:27:23 +0000
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s72DRLmn008952	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)	for <cygwin-patches@cygwin.com>; Sat, 2 Aug 2014 09:27:21 -0400
Received: from [10.3.113.147] (ovpn-113-147.phx2.redhat.com [10.3.113.147])	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s72DRLVx009597	for <cygwin-patches@cygwin.com>; Sat, 2 Aug 2014 09:27:21 -0400
Message-ID: <53DCE738.3090406@redhat.com>
Date: Sat, 02 Aug 2014 13:27:00 -0000
From: Eric Blake <eblake@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.7.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: docs: improve package maintainer instructions
OpenPGP: url=http://people.redhat.com/eblake/eblake.gpg
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="9v1xK6Vo7J7h8nODAKNlUrDplosIQSHe7"
X-IsSubscribed: yes
X-SW-Source: 2014-q3/txt/msg00004.txt.bz2

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9v1xK6Vo7J7h8nODAKNlUrDplosIQSHe7
Content-Type: multipart/mixed;
 boundary="------------060404020204070103030408"

This is a multi-part message in MIME format.
--------------060404020204070103030408
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-length: 491

I noticed that the main link on the cygwin.com left navbar
(https://cygwin.com/setup.html#submitting) has outdated instructions;
rather than duplicate things, I'd rather have a link to the more
up-to-date page
(https://sourceware.org/cygwin-apps/package-upload.html).  Okay to push?

2014-08-02  Eric Blake  <eblake@redhat.com>

	* setup.html: Modernize, point to package-upload.html

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org

--------------060404020204070103030408
Content-Type: text/x-patch;
 name="setup.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="setup.patch"
Content-length: 18655

? setup.patch
Index: setup.html
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/cygwin/htdocs/setup.html,v
retrieving revision 1.130
diff -u -p -r1.130 setup.html
--- setup.html	8 May 2014 18:16:33 -0000	1.130
+++ setup.html	2 Aug 2014 13:24:21 -0000
@@ -25,15 +25,20 @@
   <li><a href=3D"#submitting">Submitting a package</a></li>
 </ul>
 <h2><a id=3D"naming" name=3D"naming">Package file naming</a></h2>
-<p>Package naming scheme: use the vendor's version plus a release suffix f=
or ports of existing packages (i.e. bash 2.04 becomes 2.04-1, 2.04-2, etc.,=
 until bash 2.05 is ported, which would be 2.05-1, etc). Some packages also=
 use a YYMMDD format for their versions, e.g. binutils-20010901-1.tar.bz2. =
The first release of a package should have a -1 release suffix.</p>
+<p>Package naming scheme: use the vendor's version plus a release
+  suffix for ports of existing packages (i.e. findutils 4.5.12 becomes
+  4.5.12-1, 4.5.12-2, etc., until findutils 4.5.13 is ported, which
+  would be 4.5.13-1, etc). Some packages also use a YYMMDD format for
+  their versions, e.g. terminfo-5.9-20140524-1.tar.xz. The first release
+  of a package should have a -1 release suffix.</p>
 <p>A complete package currently consists of three files:</p>
 <ul>
   <li>a binary tar file</li>
   <li>a source tar file</li>
   <li>a setup.hint file</li>
 </ul>
-<p>Binary tar files are named "package-version-release.tar.bz2". They gene=
rally contain the executable files that will be installed on a user's syste=
m plus any auxiliary files needed by the package. See the <a href=3D"#packa=
ge_contents">package contents</a> section below for more details on the con=
tents of a binary tar file.</p>
-<p>Source tar files are named "package-version-release-src.tar.bz2". Sourc=
e tar files should contain the source files, patches and scripts needed to =
rebuild the package. While installing these files is optional, the inclusio=
n of a source tar file is part of the totality that makes up a Cygwin packa=
ge and so, these files are <em>not</em> optional. In some cases, there may =
be multiple packages generated from the same source; for instance, one migh=
t have a "boffo" package and its associated shared library in "libboffo7", =
where both are generated from the same -src tarball. See the <a href=3D"#pa=
ckage_contents">package contents</a> section below for more details on the =
contents of a -src tar file, and the <a href=3D"#setup.hint">setup.hint</a>=
 section for information on the "external-source:" option.</p>
+<p>Binary tar files are named "package-version-release.tar.xz". They gener=
ally contain the executable files that will be installed on a user's system=
 plus any auxiliary files needed by the package. See the <a href=3D"#packag=
e_contents">package contents</a> section below for more details on the cont=
ents of a binary tar file.</p>
+<p>Source tar files are named "package-version-release-src.tar.xz". Source=
 tar files should contain the source files, patches and scripts needed to r=
ebuild the package. While installing these files is optional, the inclusion=
 of a source tar file is part of the totality that makes up a Cygwin packag=
e and so, these files are <em>not</em> optional. In some cases, there may b=
e multiple packages generated from the same source; for instance, one might=
 have a "boffo" package and its associated shared library in "libboffo7", w=
here both are generated from the same -src tarball. See the <a href=3D"#pac=
kage_contents">package contents</a> section below for more details on the c=
ontents of a -src tar file, and the <a href=3D"#setup.hint">setup.hint</a> =
section for information on the "external-source:" option.</p>
 <p>The setup.hint file is discussed <a href=3D"#setup.hint">below</a>.</p>
 <h2><a id=3D"sourceware.org" name=3D"sourceware.org">Automatic setup.ini g=
eneration on sourceware.org</a></h2>
 <p>A script runs on sourceware.org which collects information from (curren=
tly) the <tt>release</tt> directory in the ftp download area. Information f=
rom subdirectories of these directories is parsed to automatically generate=
 the default <a href=3D"http://sourceware.org/cygwin-apps/setup.html#setup.=
ini">setup.ini</a> file which is used by the Cygwin setup program for insta=
llation control. If you are responsible for maintaining a Cygwin package, i=
t is important that you understand how this process works.</p>
@@ -45,14 +50,14 @@ release/boffo/&lt;boffo files&gt;
 release/boffo/boffo-devel/
 release/boffo/boffo-devel/&lt;boffo-devel file&gt;
 </pre>
-<p>Each directory contains <a href=3D"#naming">source and binary tar files=
</a> which have been been compressed using bzip2. The required <a href=3D"#=
naming">format of these filenames</a> is: <tt>package-version-release[<i>-s=
rc</i>].tar.bz2</tt> . The contents of these files is discussed <a href=3D"=
#package_contents">below</a>.</p>
+<p>Each directory contains <a href=3D"#naming">source and binary tar files=
</a> which have been been compressed using xz. The required <a href=3D"#nam=
ing">format of these filenames</a> is: <tt>package-version-release[<i>-src<=
/i>].tar.xz</tt> . The contents of these files is discussed <a href=3D"#pac=
kage_contents">below</a>.</p>
 <p>The "package" part of the filename is the name mentioned above.</p>
 <p>The version number <b>must</b> start with a digit and must adhere to th=
e rules in <a href=3D"#naming">package file naming</a> above. Higher versio=
n (and release) numbers are used for the current version of a package; the =
previous stable version (if any) is used for the previous version (however =
see <a href=3D"#setup.hint">setup.hint</a> for exceptions to this rule). Le=
xically, when two packages have identical vendor version numbers, the one w=
ith the higher release number is considered newer. Also, given two packages=
, the one with the higher vendor version number is always considered newer,=
 regardless of the release number.</p>
 <p>The <i>-src</i> component of the filename is added to files which conta=
in source code.</p>
 <p>A complete "package" is made up of three files: the "binary" package ta=
r file, the "source" tar file, and the "setup.hint" file, e.g.:</p>
 <pre>
 bash$ ls release/boffo
-boffo-1.0-1.tar.bz2  boffo-1.0-1-src.tar.bz2  setup.hint
+boffo-1.0-1.tar.xz  boffo-1.0-1-src.tar.z  setup.hint
 </pre>
 <p>Setup is currently unable to list more than three versions of each pack=
age. Therefore you should not keep more than three versions of each package=
 around: The current version, the previous stable version, and, optionally,=
 one test version. By keeping a previous stable version around, you isolate=
 yourself (somewhat) from problems with partial mirrors. When you add a new=
 "current" version, you can either keep the old "previous" version, or make=
 the old current version the new previous version, depending on how stable =
they each were.</p>
 <p>Test versions are specified via the setup.hint file as described <a hre=
f=3D"#setup.hint">below</a>. It is not required that your package have a <t=
t>test</tt> version. Use of a <tt>test</tt> version of a package is at the =
discretion of the package maintainer.</p>
@@ -187,11 +192,11 @@ No actual moles will be harmed during ex
 <h3><a id=3D"advanced_setup.hint" name=3D"advanced_setup.hint"><tt>setup.h=
int (Advanced Options)</tt></a></h3>
 <p>The <tt>external-source</tt> line is used when multiple installation pa=
ckages are generated from a single -src package. For example, suppose the <=
tt>boffo</tt> package contains the executables and documentation for boffo,=
 but there is also a shared library <tt>cygboffo-7.dll</tt> that might be u=
sed by other packages; say, the <tt>fobbo</tt> program. It would be nice to=
 separate that <tt>cygboffo-7.dll</tt> shared library into a second install=
ation package, so that users of the <tt>fobbo</tt> program can install <em>=
just</em> the library, and not the entire <tt>boffo</tt> package. However, =
all of the <tt>boffo</tt> executables and the DLL are generated from the sa=
me source. To support this usage, the <tt>boffo</tt> maintainer would creat=
e three packages:</p>
 <ul>
-  <li><tt>boffo-2.4.1-2.tar.bz2</tt>: an installable package that contains=
 all of the normal contents of <tt>boffo</tt> -- except for the shared libr=
ary.</li>
-  <li><tt>libboffo7-2.4.1-2.tar.bz2</tt>: an installable package that cont=
ains only the shared library from <tt>boffo</tt></li>
-  <li><tt>boffo-2.4.1-2-src.tar.bz2</tt>: the -src tarball for boffo.</li>
+  <li><tt>boffo-2.4.1-2.tar.xz</tt>: an installable package that contains =
all of the normal contents of <tt>boffo</tt> -- except for the shared libra=
ry.</li>
+  <li><tt>libboffo7-2.4.1-2.tar.xz</tt>: an installable package that conta=
ins only the shared library from <tt>boffo</tt></li>
+  <li><tt>boffo-2.4.1-2-src.tar.xz</tt>: the -src tarball for boffo.</li>
 </ul>
-<p><tt>boffo-2.4.1-2.tar.bz2</tt>, <tt>boffo-2.4.1-2-src.tar.bz2</tt>, and=
 the boffo <tt>setup.hint</tt> would go into the <tt>release/boffo/</tt> su=
bdirectory on the Cygwin server. <tt>libboffo7-2.4.1-2.tar.bz2</tt> would g=
o into a separate subdirectory, such as <tt>release/boffo/libboffo7/</tt>, =
along with a separate libboffo7 <tt>setup.hint</tt>. The two <tt>setup.hint=
</tt> files would look something like this:</p>
+<p><tt>boffo-2.4.1-2.tar.xz</tt>, <tt>boffo-2.4.1-2-src.tar.xz</tt>, and t=
he boffo <tt>setup.hint</tt> would go into the <tt>release/boffo/</tt> subd=
irectory on the Cygwin server. <tt>libboffo7-2.4.1-2.tar.xz</tt> would go i=
nto a separate subdirectory, such as <tt>release/boffo/libboffo7/</tt>, alo=
ng with a separate libboffo7 <tt>setup.hint</tt>. The two <tt>setup.hint</t=
t> files would look something like this:</p>
 <center>
   <table border=3D"2">
     <tr>
@@ -230,13 +235,13 @@ No actual moles will be harmed during ex
 @ boffo
 requires: libboffo7 libncurses6 cygwin
 version: 2.4.1-2
-install: release/boffo/boffo-2.4.1-2.tar.bz2
-source: release/boffo/boffo-2.4.1-2-src.tar.bz2
+install: release/boffo/boffo-2.4.1-2.tar.xz
+source: release/boffo/boffo-2.4.1-2-src.tar.xz
 @ libboffo7
 requires: cygwin
 version: 2.4.1-2
-install: release/boffo/libboffo7/libboffo7-2.4.1-2.tar.bz2
-source: release/boffo/boffo-2.4.1-2-src.tar.bz2
+install: release/boffo/libboffo7/libboffo7-2.4.1-2.tar.xz
+source: release/boffo/boffo-2.4.1-2-src.tar.xz
 </pre>
 <p>Note that both packages point to the same -src tarball. Also, it is req=
uired that the version strings match (libboffo7-5.2 won't point to boffo-1.=
4-src). The same logic is used to "match up" prev: and test: versions.</p>
 <h2><a id=3D"package_contents" name=3D"package_contents">Package contents<=
/a></h2>
@@ -264,10 +269,10 @@ etc...
 </pre>
   </li>
   <li>All executables in your binary package are stripped.  </li>
-  <li>Source packages are extracted in /usr/src (so the paths in your -src=
 tarball should not include /usr/src). On extraction, the tar file should p=
ut the sources in a directory with the same name as the package tarball min=
us the -src.tar.bz2 part:
+  <li>Source packages are extracted in /usr/src (so the paths in your -src=
 tarball should not include /usr/src). On extraction, the tar file should p=
ut the sources in a directory with the same name as the package tarball min=
us the -src.tar.xz part:
 <pre>
 boffo-1.0-1/boffo.cygport
-boffo-1.0-1/boffo-1.0.tar.bz2
+boffo-1.0-1/boffo-1.0.tar.xz
 boffo-1.0-1/boffo-1.0-1.src.patch
 etc...
 </pre>
@@ -293,7 +298,7 @@ automatically handles most of the above=20
 on <a href=3D"setup-packaging-historical.html">previous Cygwin build scrip=
ts</a>, and
 borrows concepts from the Gentoo portage system.</p>
=20
-<p>Suppose that the vendor's <tt>boffo-1.0.tar.bz2</tt> source tarball, th=
at you
+<p>Suppose that the vendor's <tt>boffo-1.0.tar.xz</tt> source tarball, tha=
t you
 downloaded from the boffo homepage, unpacks into <tt>boffo-1.0/</tt>.</p>
=20
 <p>Further, suppose you've got "boffo" ported to Cygwin. It took some work=
, but
@@ -365,15 +370,19 @@ and sample .cygport files.</p>
   <li>
     Place the package files in a web accessible http/ftp site somewhere. I=
f at all possible the files should have a directory structure in order to g=
et them all with a single command. For example, if I am proposing "foo" and=
 "libfoo", an upload site should look like:
     <ul>
-      <li><tt>myserver.com/whatever/foo/foo-0.20.3-1.tar.bz2</tt></li>
-      <li><tt>myserver.com/whatever/foo/foo-0.20.3-1-src.tar.bz2</tt></li>
+      <li><tt>myserver.com/whatever/foo/foo-0.20.3-1.tar.xz</tt></li>
+      <li><tt>myserver.com/whatever/foo/foo-0.20.3-1-src.tar.xz</tt></li>
       <li><tt>myserver.com/whatever/foo/setup.hint</tt></li>
-      <li><tt>myserver.com/whatever/foo/libfoo/libfoo-0.20.3-1.tar.bz2</tt=
></li>
+      <li><tt>myserver.com/whatever/foo/libfoo/libfoo-0.20.3-1.tar.xz</tt>=
</li>
       <li><tt>myserver.com/whatever/foo/libfoo/setup.hint</tt></li>
     </ul>
   </li>
   <li>Announce on the <tt>cygwin-apps</tt> mailing list that you have the =
package ready for uploading. Provide the URLs of all package files to your =
mail.</li>
   <li>Each new package must in any case receive one <a href=3D"acronyms/#G=
TG">GTG</a> vote from a package maintainer, meaning that an existing mainta=
iner has downloaded the package, inspected the tarball contents, tested the=
 applications, and rebuilt the package from the source tarball without inci=
dent. Once a successful package is produced, you become a maintainer yourse=
lf and can provide GTG reviews for others as well.</li>
+  <li>Once you have your first GTG,
+  follow <a href=3D"http://sourceware.org/cygwin-apps/package-upload.html"=
>these
+  instructions</a> for setting up your upload ssh key, and uploading
+  your files.</li>
   <li>Feel free to delete your temporary copy once the files have been upl=
oaded to sourceware.org.</li>
   <li>Announce via the <tt>cygwin-announce</tt> mailing list that the new =
package is available. Use the <a href=3D"#announcement">announce message ex=
ample</a> listed later in this page as a template for your announcement.<br=
 />
    Be sure the unsubscribe instructions are included at the end of the ema=
il, since cygwin-announce does not add any.<br />
@@ -384,27 +393,21 @@ and sample .cygport files.</p>
   <li>Build the package and make sure that you have time to maintain it.</=
li>
   <li>Send an ITP to the cygwin mailing list.  If the package is part of a=
 distribution, include the URL which demonstrates this.  Include a <tt>setu=
p.hint</tt>.</li>
   <li>If you have received the correct number of votes or if the package i=
s part of a distribution, include URL(s) for the package binary and source =
so that someone can download them to check the package for any obvious prob=
lems.</li>
-  <li>Once you get a GTG from a package maintainer, send a "Please upload"=
 to the <tt>cygwin-apps</tt> mailing list.</li>
+  <li>Once you get a GTG from a package maintainer,
+  follow <a href=3D"http://sourceware.org/cygwin-apps/package-upload.html"=
>these
+  instructions</a> for uploading your package.</li>
   <li>When you get the "uploaded" confirmation, send an immediate note to =
the <tt>cygwin-announce</tt> mailing list.</li>
 </ol>
 <h2><a id=3D"updating" name=3D"updating">Updating a package</a></h2>
-<p>So you've got an updated package you want to submit. Follow the followi=
ng checklist before emailing the <tt>cygwin-apps</tt> mailing list and you'=
ll almost certainly save time.</p>
+<p>So you've got an updated package you want to submit. You should
+  already have upload privileges, and should be able to do the entire
+  process yourself, by
+  following <a href=3D"http://sourceware.org/cygwin-apps/package-upload.ht=
ml">these
+  instructions</a>.  If you encounter any problems, email
+  the <tt>cygwin-apps</tt> mailing list.
 <ol>
-  <li>
-    Place the package files in a web accessible http/ftp site somewhere. I=
f at all possible the files should have a directory structure in order to g=
et them all with a single command. For example, if I am updating "foo" and =
"libfoo", an upload site should look like:
-    <ul>
-      <li><tt>myserver.com/whatever/foo/foo-0.21.1-1.tar.bz2</tt></li>
-      <li><tt>myserver.com/whatever/foo/foo-0.21.1-1-src.tar.bz2</tt></li>
-      <li><tt>myserver.com/whatever/foo/libfoo/libfoo-0.21.1-1.tar.bz2</tt=
></li>
-    </ul>
-  </li>
   <li>There is no need to increase the version number if the package has n=
ot been officially released.  So, if you are releasing a -1 version of a pa=
ckage keep using -1 for any refinements <em>until</em> the package has been=
 uploaded.</li>
-  <li>Announce on the <tt>cygwin-apps</tt> mailing list that you have the =
package ready for uploading. Include in the mail the URLs of all the new pa=
ckage files.<br />
-   Be concise in your message: as package maintainer you're trusted to kno=
w when and how your packages should be updated, no reason to explain it.<br=
 />
-   Just provide URLs for files that have actually changed, i.e. it is not =
necessary to provide a new link to a <tt>setup.hint</tt> file every time yo=
u update your packages unless the actual content changed (e.g. because vers=
ion numbers are not parsable or ordered and have to be specified manually).=
<br />
-   Please do specify which version must be kept as "old", all the others w=
ill be deleted from the server.</li>
-  <li>Feel free to delete your temporary copy once the files have been upl=
oaded to sourceware.org. This fact will be made clear by an "Uploaded." rep=
ly to your announcement by someone with upload privileges.</li>
-  <li>Announce via the <tt>cygwin-announce</tt> mailing list that the new =
package is available. Use the <a href=3D"#announcement">announce message ex=
ample</a> listed later in this page as a template for your announcement..<b=
r />
+  <li>After doing a self-upload, announce via the <tt>cygwin-announce</tt>=
 mailing list that the new package is available. Use the <a href=3D"#announ=
cement">announce message example</a> listed later in this page as a templat=
e for your announcement..<br />
    Once sent, your message will be reviewed by one of the cygwin-announce =
moderators and, once approved, will be automatically forwarded to the cygwi=
n mailing list with an [ANNOUNCEMENT] prepended to the subject.</li>
 </ol>
 <p>NOTE: On any major version upgrade, you may want to mark the release as=
 <tt>Test</tt>.</p>

--------------060404020204070103030408--

--9v1xK6Vo7J7h8nODAKNlUrDplosIQSHe7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 539

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg

iQEcBAEBCAAGBQJT3Oc4AAoJEKeha0olJ0Nqvs0IAIX+ZZHZrT8X+rYKgf6vg6un
baz8KV9StR6hwsRswvxl22/aVMJn5eNYAf4ZqRW0Qsjgez5yhSJqPMpeOh21noPB
RuF/+7Nv+gHB7NwDXSi9Lm5EPicLSY5vogupWI7aok+PRU3wWtMJagy2tlUpbXqj
uM6pj/0IPPcZnfG6vLAcWlTkfruP/0LONsIHBrvWZ2tFCAmHqNRrUDWwkg4zBgHf
e2W6rhGseY23dzB1JxGyKv7l2UsgkrvsHJXVMdgGQi1sVw+MS45YAa2zCQAnGZZ+
BX6E2pxbZk2cRypOSmu2+RUDz9r9so+dxIV44o+LnWhMlm5eW+MxAKTr960Roog=
=NW+y
-----END PGP SIGNATURE-----

--9v1xK6Vo7J7h8nODAKNlUrDplosIQSHe7--
