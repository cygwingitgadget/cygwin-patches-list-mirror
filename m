Return-Path: <cygwin-patches-return-2096-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 26950 invoked by alias); 24 Apr 2002 05:20:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26916 invoked from network); 24 Apr 2002 05:20:32 -0000
Date: Tue, 23 Apr 2002 22:20:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Packaging information
Message-ID: <20020424052021.GA19545@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3CC63684.3010207@ece.gatech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3CC63684.3010207@ece.gatech.edu>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00080.txt.bz2

On Wed, Apr 24, 2002 at 12:37:24AM -0400, Charles Wilson wrote:
>Permission to apply?

AFAIAC, the setup.html is ok but I don't think that the generic-whatever
stuff belongs on the web site.  Maybe the ftp directory or the
cygwin-apps repository is more appropriate.

cgf

>(and where do I put the changelog entry?  htdocs doesn't have a 
>ChangeLog file)
>
>2002-04-24  Charles Wilson  <cwilson@ece.gatech.edu>
>
>	* setup.html: change all references to 'contrib/'
>	or 'latest/' to 'release/'.  Describe two accepted
>	methods for packaging -src.
>	* generic-readme: new file for use with -src
>	packaging standard, method 2.
>	* generic-build-script: new file for use with -src
>	packaging standard, method 2.
>
>--Chuck

>? generic-build-script
>? generic-readme
>Index: setup.html
>===================================================================
>RCS file: /cvs/cygwin/htdocs/setup.html,v
>retrieving revision 1.75
>diff -u -r1.75 setup.html
>--- setup.html	23 Apr 2002 17:30:56 -0000	1.75
>+++ setup.html	24 Apr 2002 04:21:23 -0000
>@@ -33,11 +33,11 @@
> </ul>
> 
> <h2><a id="naming" name="naming">Package file naming</a></h2>
>-<p> Package naming scheme: use the vendor's version plus a suffix for
>+<p> Package naming scheme: use the vendor's version plus a release suffix for
> ports of existing packages (i.e.  bash 2.04 becomes 2.04-1, 2.04-2, etc,
> until bash 2.05 is ported, which would be 2.05-1, etc).  Some packages
> also use a YYMMDD format for their versions, e.g.  binutils-20010901-1.tar.bz2.
>-The first release of a package should have a -1 suffix.</p>
>+The first release of a package should have a -1 release suffix.</p>
> 
> <p>A complete package currently consists of three files:</p>
> <ul>
>@@ -46,18 +46,18 @@
> <li>a setup.hint file
> </ul>
> 
>-<p>Binary tar files are named "package-version.tar.bz2".  They generally
>+<p>Binary tar files are named "package-version-release.tar.bz2".  They generally
> contain the executable files that will be installed on a user's system
> plus any auxilliary files needed by the package.  See the <a
> href="#package_contents">making packages</a> section below for more
> details on how to generate a binary tar file.</p>
> 
>-<p>Source tar files are named "package-version-src.tar.bz2".  Source tar files
>+<p>Source tar files are named "package-version-release-src.tar.bz2".  Source tar files
> should contain the source files needed to rebuild the package.  While
> installing these files is optional under setup.exe, the inclusion of a
> source tar file is part of the totality that makes up a cygwin package
> and so, these files are <em>not</em> optional.  See the <a
>-href="#package_contents"> making packages</a> section below for more
>+href="#srcpackage_contents"> making packages</a> section below for more
> details on the contents of a -src tar file..</p>
> 
> <p>The setup.hint file is discussed <a href="#setup.hint">below</a>.
>@@ -65,22 +65,31 @@
> <h2><a id="sources.redhat.com" name="sources.redhat.com">Automatic setup.ini generation on sources.redhat.com</a></h2>
> 
> <p>A script runs on sources.redhat.com which collects information from
>-(currently) the <tt>latest</tt> and <tt>contrib</tt> directories in the
>+(currently) the <tt>release</tt> directory in the
> ftp download area.  Information from subdirectories of these directories
> is parsed to automatically generate the default <a href="#setup.ini">
> setup.ini</a> file which is used by the cygwin setup.exe program for
> installation control.  If you are responsible for maintaining a cygwin
> package, it is important that you understand how this process works.</p>
> 
>-<p>Packages are grouped by directory under <tt>latest</tt> or
>-<tt>contrib</tt>.  The directory name is typically the same as the
>-package name.  For example, the <tt>boffo</tt> package will live in the
>-<tt>boffo</tt> subdirectory.  Exceptions to this rule are historical.
>-All new packages will follow the rule of package name == directory name.
>+<p>Packages are grouped by directory under <tt>release</tt>.  The directory
>+name is the same as the package name.  For example, the <tt>boffo</tt> package
>+will live in the <tt>boffo</tt> subdirectory.  Exceptions to this rule are
>+historical. All new packages will follow the rule of package name ==
>+directory name.  However, for closely related groups of packages, it is acceptable
>+to use a heirarchical tree under <tt>release/</tt>:
>+<pre><tt>
>+  release/
>+  release/boffo/
>+  release/boffo/&lt;boffo files&gt;
>+  release/boffo/boffo-devel/
>+  release/boffo/boffo-devel/&lt;boffo-devel file&gt;
>+</tt></pre>
> 
> <p>Each directory contains <a href="#naming">source and binary tar
> files</a> which have been been compressed using bzip2.  The required <a
>-href="#naming">format of these filenames</a> is: <tt>package-version[<i>-src</i>].tar.bz2</tt> .
>+href="#naming">format of these filenames</a> is:
>+<tt>package-version-release[<i>-src</i>].tar.bz2</tt> .
> The contents of these files is discussed <a href="#package_contents">
> below</a>.
> 
>@@ -89,10 +98,13 @@
> 
> <p>The version number <b>must</b> start with a digit and must adhere to
> the rules in <a href="#naming">package file naming</a> above.  Higher
>-version numbers are used for the current version of a package; the
>-previous stable version (if any) is used for the previous version
>-(however see <a href="#setup.hint">setup.hint</a> for exceptions to
>-this rule).</p>
>+version (and release) numbers are used for the current version of a
>+package; the previous stable version (if any) is used for the
>+previous version (however see <a href="#setup.hint">setup.hint</a> for
>+exceptions to this rule).  Lexically, when two packages have identical vendor
>+version numbers, the one with the higher release number is considered
>+newer.  Also, given two packages, the one with the higher vendor version
>+number is always considered newer, regardless of the release number.</p>
> 
> <p>The <i>-src</i> component of the filename is added to files which
> contain source code.</p>
>@@ -101,7 +113,7 @@
> tar file, the "source" tar file, and the "setup.hint" file, e.g.:
> 
> <pre>
>-bash$ ls contrib/boffo
>+bash$ ls release/boffo
> boffo-1.0-1.tar.bz2  boffo-1.0-1-src.tar.bz2  setup.hint
> </pre>
> 
>@@ -167,8 +179,8 @@
> ordering.  So, e.g., if you had previously released <tt>boffo-0.9-1</tt>
> and now have a new <tt>boffo-1.0-1</tt>, the version numbering is
> obvious and there is no need to use <tt>curr</tt> or <tt>prev</tt>.  It
>-is obvious that <tt>boffo-1.0-1</tt> is newer than <tt>boffo-0.9-1</tt> and the setup.ini
>-generator will do the right thing in this case.</p>
>+is obvious that <tt>boffo-1.0-1</tt> is newer than <tt>boffo-0.9-1</tt> and
>+the setup.ini generator will do the right thing in this case.</p>
> 
> <p>However, if you had discovered a serious error in the <tt>boffo-1.0</tt>
> release, and then decided that you want to drop back to <tt>boffo-0.9-1</tt>, you
>@@ -236,13 +248,13 @@
> description, e.g., this is incorrect:
> 
> <pre>
>-<tt>sdesc:	"boffo: A whackamole simulation in ASCII art"</tt>
>+<tt>sdesc:      "boffo: A whackamole simulation in ASCII art"</tt>
> </pre>
> 
> This is correct:
> 
> <pre>
>-<tt>sdesc:	"A whackamole simulation in ASCII art"</tt>
>+<tt>sdesc:      "A whackamole simulation in ASCII art"</tt>
> </pre>
> 
> <p>Quote text that takes up several lines e.g.:</p>
>@@ -288,7 +300,6 @@
> <td>System</td>
> <td>Text</td>
> <td>Utils</td>
>-<td>XFree86</td>
> <td>Web</td>
> </tr>
> </table>
>@@ -328,7 +339,7 @@
> <p>Multiple packages are separated by spaces.  Do not enclose multiple
> package names within quotation marks.</p>
> 
>-<p>Here's an example of a complete <i>contrib/current/boffo/setup.hint</i>:</p>
>+<p>Here's an example of a complete <i>release/boffo/setup.hint</i>:</p>
> <pre>
> <tt>
>     category: Games Text
>@@ -368,7 +379,7 @@
> 
> <p><tt>setup-version: <i>number</i></tt></p>
> 
>-This line follows the setup-timestamp in all setupl.ini files.  It
>+This line follows the setup-timestamp in all setup.ini files.  It
> indicates the version number of the setup.exe for which this setup.ini
> was generated.
> 
>@@ -435,22 +446,22 @@
> sdesc: Cygwin Runtime
> ldesc: A Posix runtime emulator for Windows platforms
> version: 1.1.4
>-install: latest/cygwin/cygwin-1.1.4.tar.bz2 1234567
>-source: latest/cygwin/cygwin-1.1.4.tar.bz2 1341245
>+install: release/cygwin/cygwin-1.1.4.tar.bz2 1234567
>+source: release/cygwin/cygwin-1.1.4.tar.bz2 1341245
> [prev]
> version: 1.1.3
>-install: latest/cygwin/cygwin-1.1.3.tar.bz2 1234580
>-source: latest/cygwin/cygwin-1.1.3.tar.bz2 1341123
>+install: release/cygwin/cygwin-1.1.3.tar.bz2 1234580
>+source: release/cygwin/cygwin-1.1.3.tar.bz2 1341123
> 
> @ bash
> [test]
> version: 20000901
>-install: latest/bash/bash-20000901.tar.bz2 276403
>-source:  latest/bash/bash-20000901-src.tar.bz2 1892899
>+install: release/bash/bash-20000901.tar.bz2 276403
>+source:  release/bash/bash-20000901-src.tar.bz2 1892899
> [curr]
> version: 2.04
>-install: latest/bash/bash-2.04.tar.bz2 277375
>-source:  latest/bash/bash-2.04-src.tar.bz2 1815177
>+install: release/bash/bash-2.04.tar.bz2 277375
>+source:  release/bash/bash-2.04-src.tar.bz2 1815177
> 
> </pre>
> 
>@@ -471,22 +482,160 @@
>   --localstatedir=/var
>   --datadir='$(prefix)/share'</pre></li>
>   <li><p>All executables in your binary package are stripped (run 'strip' on them). Some makefiles have a install-strip command you can use to do this automatically when you setup your 'installed' tree.</p></li>
>-  <li><p>Source packages are extracted in /usr/src.  On extraction, the tar file should put the sources in a directory with the same name as the package tar ball minus the -src.tar.bz2 part:<pre><tt>  boffo-1.0-1/Makefile.in
>-  boffo-1.0-1/README
>-  boffo-1.0-1/configure
>-  boffo-1.0-1/configure.in
>-  etc...
>-</tt></pre></li>
>-
>+  <li><p>Source packages are extracted in /usr/src.  See the <a href="#srcpackage_contents">Package Source</a> section for more information.
>   <li><p>In your binary package, include a file /usr/doc/Cygwin/foo-vendor-suffix.README containing (at a minimum) the information needed for an end user to recreate the package. This includes CFLAGS settings, configure parameters, etc.</p></li>
>   <li><p>In your binary package include a directory /usr/doc/foo-vendor/ that includes any binary-relevant vendor documentation, such as ChangeLog's, copyright licence's, README's etc.</p></li>
>-  <li><p>In your source package include the same foo-vendor-suffix.README as used in the binary package.</p></li>
>-  <li><p>Your source package should contain any patches you've applied to it pre-applied.</p></li>
>-  <li><p>Include a single file foo-vendor-suffix.patch in your source package, that when applied will remove all the patches you've applied to the package, leaving it as the vendor distributes it. This file should extract as /usr/src/foo-vendor-suffix.patch.<p><p>To create such a patch you might run <tt>diff -Nrup patched-src-dir vendor-src-dir &gt; foo-vendor-suffix.patch</tt></p><p>To apply the generated patch the user would run (from within the source tree) <tt>patch -p1 &lt; ../foo-vendor-suffix.patch</tt></p></li>
>   <li><p>If you are not creating your package from an installed virtual root, be sure to check that the file permissions are appropriate.</p></li>
>   <li><p>If you have any 'info' documention in your package, run install-info as part of your post-install script</p></li>
>   <li><p>If the package has any global settings (ie in files in /etc) that are not overrideable on a per user basis (sshd, as a daemon, is an example of this) do not include the relevant config files in your package. Instead include in your post-install script to install the settings files. Be sure that if you would overwrite an already present file that the user is offered the choice of keeping their own or overwriting with your defaults.</p></li>
>   <li><p>Ensure that your package handles binary only systems, textmode only systems, and hybrid systems correctly.</p></li>
>+</ul>
>+
>+<h2><a id="srcpackage_contents" name="srcpackage_contents">Package Source</a></h2>
>+<p>There are two accepted ways to package the source code for cygwin packages.
>+<h3>Method One</h3>
>+
>+<ul>
>+  <li><p>Source packages are extracted underneath /usr/src (so your -src tarball
>+  should not include /usr/src). On extraction, the tar file should put the sources in a directory with
>+  the same name as the package tar ball minus the -src.tar.bz2 part:
>+<pre><tt>  boffo-1.0-1/Makefile.in
>+  boffo-1.0-1/README
>+  boffo-1.0-1/configure
>+  boffo-1.0-1/configure.in
>+  etc...
>+</tt></pre></li>
>+  <li><p>In your source package include the same foo-vendor-suffix.README
>+  as used in the binary package.</p></li>
>+  <li><p>Your source package already be patched with any necessary cygwin
>+  specific changes.  The user should be able to just ./configure; make; and go.</p></li>
>+  <li><p>Include a single file foo-vendor-release.patch in your source package,
>+  that when applied (in reverse: 'patch -R') will remove all the patches
>+  you've applied to the package, leaving it as the vendor distributes it.
>+  This file should extract as : <tt>/usr/src/foo-vendor-release.patch</tt>
>+  (that is, since setup.exe extracts everything into <tt>/usr/src</tt>,
>+  the patch should be a &quot;top level&quot; member of the -src tarball.)<p>
>+  <p>Optionally, this patch could also unpack inside the source tree:
>+<pre><tt>  boffo-1.0-1/README
>+  boffo-1.0-1/configure
>+  boffo-1.0-1/CYGWIN-PATCHES/boffo-1.0-1.patch
>+  etc...
>+</tt></pre>
>+  However, that tends to complicate actually <b>creating</b> the patch itself.
>+  Unless one enjoys recursion, one must move the .patch file OUT of the source
>+  tree, regenerate the patch to incorporate any new changes, and then copy
>+  the new patch back into .../CYGWIN-PATCHES/.  This option is documented
>+  because some existing packages do it this way, but it is not recommended
>+  for new packages.  Make boffo-1.0-1.patch a top-level member of the -src
>+  tarball instead:
>+<pre><tt>  boffo-1.0-1.patch
>+  boffo-1.0-1/README
>+  boffo-1.0-1/configure
>+  etc...
>+</tt></pre>
>+  To create the patch file described above, you might run
>+  <pre><tt>  diff -Nrup vendor-src-dir patched-src-dir &gt; foo-vendor-release.patch</tt></pre>
>+  To apply the generated patch (in reverse; that is, to remove the cygwin
>+  specific changes from the unpacked -src tarball) the user would run (from
>+  within the source tree)
>+  <pre><tt>  patch -R -p1 &lt; ../foo-vendor-release.patch</tt></pre></p></li>
>+  <li><p>In general, any cygwin-specific &quot;packaging&quot; files -- such as
>+  cygwin-specific READMEs, a copy of the setup.hint file for your package,
>+  etc. -- should unpack within a /CYGWIN-PATCHES/ subdirectory in your
>+  sources.  Naturally, applying the patch (in reverse, as described above) would
>+  remove these files from the source tree.
>+  <li><p>So, returning to the boffo example, boffo-1.0-1-src.tar.bz2 would contain:
>+<pre><tt>  boffo-1.0-1.patch
>+  boffo-1.0-1/README
>+  boffo-1.0-1/configure
>+  boffo-1.0-1/configure.in
>+  boffo-1.0-1/Makefile.am
>+  boffo-1.0-1/Makefile.in
>+  boffo-1.0-1/boffo.c
>+  ...
>+  boffo-1.0-1/CYGWIN-PATCHES/boffo.README (cygwin-specific)
>+  boffo-1.0-1/CYGWIN-PATCHES/setup.hint
>+  ...
>+</tt></pre>
>+</ul>
>+
>+<h3>Method Two</h3>
>+<ul>
>+  <li><p>In a packaging technique inspired by rpms and debs, you may create a
>+  -src tarball which simply contains:
>+  <ol>
>+    <li><p><tt>foo-vendor.tar.[gz|bz2]</tt>:  The original source tarball,
>+    exactly as downloaded from the original vendor.
>+    <li><p><tt>foo-vendor-release.patch</tt>:  the patch file as described in
>+    Method One, above.</p>
>+    <li><p><tt>foo-vendor-release.sh</tt>:  A build script that drives the
>+    entire unpacking, configuration, build, and packaging (binary and -src)
>+    process.</p>
>+  </ol>
>+  <li><p>You can adapt <a href="generic-readme">this</a>
>+  generic readme file for script-driven -src packages.</p>
>+  <li><p><a href="generic-build-script">Here</a> is an example build script
>+  which can be adapted for your package.  By carefully modifying the details of
>+  this script, it can create the binary and -src packages for you, once you've
>+  finished porting your package.  How?  See the
>+  <b><i>Initial packaging procedure</i></b> below.  But first, a few facts:</p>
>+  <ul>
>+    <li><p>The buildscript will autodetect the package name, vendor version,
>+    and release number from its own filename.</p>
>+    <li><p>When the buildscript is used to compile the package, all building
>+    occurs within a hidden subdirectory inside the source tree:
>+    <tt>boffo-1.0/.build/</tt></p>
>+    <li><p>To create the binary package, the script redirects 'make install'
>+    into a hidden subdirectory <tt>boffo-1.0/.inst/</tt>, creating
>+    a faux tree <tt>boffo-1.0/.inst/usr/bin</tt>, etc.  This faux tree is
>+    tar'ed up into the new binary package.</p>
>+    <li><p>To create the -src package, the script generates a patch file, and
>+    copies the original tarball, the patch, and the script into yet another
>+    hidden subdirectory <tt>boffo-1.0/.sinst/</tt>.  The contents of this
>+    subdirectory are tar'ed up into the new -src package.</p>
>+    <li><p>Sometimes, you will find that a package cannot build outside of
>+    its source directory.  In this case, the script must recreate the
>+    source tree within the <tt>.build</tt> subdirectory.  The jbigkit -src
>+    package uses GNU shtool's mkshadow to do this.</p>
>+    <li><p><tt>generic-build-script</tt> is <b>not</b> a one-size-fits-all
>+    solution.  It <b>must</b> be customized for your package.</p>
>+  </ul>
>+  <li><p><b><i>Initial packaging procedure, script-based</i></b></p>
>+  <ul>
>+    <li><p>Suppose you've got your boffo package ported to cygwin.  It took
>+    some work, but it now builds and runs.  Further, suppose that the
>+    <tt>boffo-1.0.tar.bz2</tt> file that you downloaded from the boffo homepage
>+    unpacks into <tt>boffo-1.0/</tt>, so you've been doing all of your work
>+    in <tt>~/sources/boffo-1.0/</tt>.  That's good.</p>
>+    <li><p>Place a copy of <tt>boffo-1.0.tar.bz2</tt> in <tt>~/sources</tt>
>+    <li>copy <a href="generic-build-script"><tt>generic-build-script</tt></a>
>+    into <tt>~/sources/</tt> and rename it <tt>boffo-1.0-1.sh</tt>.  Carefully
>+    adapt this script for your purposes.  However, it should auto detect
>+    most of what it needs to know: the package name, vendor version, release
>+    number, etc.</p>
>+    <li><p>Clean up inside your <tt>~/sources/boffo-1.0/</tt> directory -- make sure
>+    that no files which are generated during the build process are lying around.
>+    Usually, a '<tt>make distclean</tt>' will do the trick, but not always.</p>
>+    <li><p>Ensure that you've put any cygwin-specific readme files, setup.hint files,
>+    etc, into <tt>~/sources/boffo-1.0/CYGWIN-PATCHES/</tt>.  You can adapt
>+    <a href="generic-readme">this generic readme file</a> for this purpose.  The build script
>+    expects that the cygwin-specific README file will be named
>+    <tt>.../CYGWIN-PATCHES/&lt;package&gt;.README</tt>.  In this example, it would
>+    be stored as <tt>~/sources/boffo-1.0/CYGWIN-PATCHES/boffo.README</tt>.  The
>+    build script will ensure that it gets installed as
>+    <tt>/usr/doc/Cygwin/boffo-1.0.README</tt>
>+    <li>Prepare the staging location for the -src package (yes, do the -src
>+    package first): From the directory above your boffo-1.0 tree (e.g.
>+    <tt>~/sources/</tt> in our example) execute '<tt>./boffo-1.0-1.sh mkdirs</tt>'</p>
>+    <li><p>Create the -src package: '<tt>./boffo-1.0-1.sh spkg</tt>'</p>
>+    <li><p>Now, let's go somewhere else and unpack this new -src package:
>+    <pre><tt>  cd /tmp
>+  tar xvjf ~/sources/boffo-1.0-1-src.tar.bz2</tt></pre></p>
>+    <li><p>Finally, rebuild the whole thing (you're still in /tmp):
>+    <pre><tt>  ./boffo-1.0-1.sh all</tt></pre>
>+    (Or, you may want to do each step in 'all'
>+    manually: prep, conf, build, (check), install, strip, pkg, spkg, finish.</p>
>+  </ul>
> </ul>
> 
> <h2><a id="postinstall" name="postinstall">Creating a package postinstall script</a></h2>

><package name>
>------------------------------------------
><short description, 2 or 3 lines>
>
>Runtime requirements:
>  cygwin-1.3.10 or newer
>  libintl1
>
>Build requirements:
>  cygwin-1.3.10 or newer
>  popt
>  gettext
>  libintl1
>
>Canonical homepage:
>  http://... <where the upstream, non-cygwinize package lives>
>
>Canonical download:
>  ftp://...  <diito>
>  
>------------------------------------
>
>Build instructions:
>  unpack <PKG>-VER-REL-src.tar.bz2
>    if you use setup to install this src package, it will be
>	 unpacked under /usr/src automatically
>  cd /usr/src
>  ./<PKG>-VER-REL.sh all
>
>This will create:
>  /usr/src/<PKG>-VER-REL.tar.bz2
>  /usr/src/<PKG>-VER-REL-src.tar.bz2
>
>-------------------------------------------
>
>Files included in the binary distro
>
>  /usr/bin/...
>  /usr/doc/<PKG>-<VER>/AUTHORS
>  /usr/doc/<PKG>-<VER>/...
>  /usr/doc/Cygwin/<PKG>-<VER>.README
>  /usr/man/man1/...
>  /etc/postinstall/<PKG>.sh
>
>------------------
>
>Port Notes:
>
>----- version <newer VER> -----
>Other information
>
>----- version <VER> -----
>Initial release
>
>
>Cygwin port maintained by: <Your Name Here>  <your email here> 

>#!/bin/sh
># find out where the build script is located
>tdir=`echo "$0" | sed 's%[\\/][^\\/][^\\/]*$%%'`
>test "x$tdir" = "x$0" && tdir=.
>scriptdir=`cd $tdir; pwd`
># find src directory.  
># If scriptdir ends in SPECS, then topdir is $scriptdir/.. 
># If scriptdir ends in CYGWIN-PATCHES, then topdir is $scriptdir/../..
># Otherwise, we assume that topdir = scriptdir
>topdir1=`echo ${scriptdir} | sed 's%/SPECS$%%'`
>topdir2=`echo ${scriptdir} | sed 's%/CYGWIN-PATCHES$%%'`
>if [ "x$topdir1" != "x$scriptdir" ] ; then # SPECS
>  topdir=`cd ${scriptdir}/..; pwd`
>else
>  if [ "x$topdir2" != "x$scriptdir" ] ; then # CYGWIN-PATCHES
>    topdir=`cd ${scriptdir}/../..; pwd`
>  else
>    topdir=`cd ${scriptdir}; pwd`
>  fi
>fi
>
>tscriptname=`basename $0 .sh`
>export PKG=`echo $tscriptname | sed -e 's/\-[^\-]*\-[^\-]*$//'`
>export VER=`echo $tscriptname | sed -e 's/^[^\-]*\-//' -e 's/\-[^\-]*$//'`
>export REL=`echo $tscriptname | sed -e 's/^[^\-]*\-[^\-]*\-//'`
>export FULLPKG=${PKG}-${VER}-${REL}
># if the orig src package is bzip2'ed, remember to
># change 'z' to 'j' in the 'tar xvzf' commands in the
># prep) and mkpatch) sections
>export src_orig_pkg_name=${PKG}-${VER}.tar.gz
>export src_pkg_name=${FULLPKG}-src.tar.bz2
>export src_patch_name=${FULLPKG}.patch
>export bin_pkg_name=${FULLPKG}.tar.bz2
>
>export src_orig_pkg=${topdir}/${src_orig_pkg_name}
>export src_pkg=${topdir}/${src_pkg_name}
>export src_patch=${topdir}/${src_patch_name}
>export bin_pkg=${topdir}/${bin_pkg_name}
>export srcdir=${topdir}/${PKG}-${VER}
>export objdir=${srcdir}/.build
>export instdir=${srcdir}/.inst
>export srcinstdir=${srcdir}/.sinst
>export checkfile=${topdir}/${FULLPKG}.check
># run on
>host=i686-pc-cygwin
># if this package creates binaries, they run on
>target=i686-pc-cygwin
>prefix=/usr
>sysconfdir=/etc
>MY_CFLAGS="-O2 -g"
>MY_LDFLAGS=
>
>mkdirs() {
>  (cd ${topdir} && \
>  mkdir -p ${objdir} && \
>  mkdir -p ${instdir} && \
>  mkdir -p ${srcinstdir} )
>}
>prep() {
>  (cd ${topdir} && \
>  tar xvzf ${src_orig_pkg} ; \
>  cd ${topdir} && \
>  patch -p0 < ${src_patch} 
>  && mkdirs )
>}
>conf() {
>  (cd ${objdir} && \
>  CFLAGS="${MY_CFLAGS}" LDFLAGS="${MY_LDFLAGS}" \
>  ${srcdir}/configure --host=${host} --target=${target} \
>  --srcdir=${srcdir} --prefix=${prefix} \
>  --exec-prefix=${prefix} --sysconfdir=${sysconfdir} \
>  --libdir=${prefix}/lib --includedir=${prefix}/include \
>  --libexecdir='${sbindir}' --localstatedir=/var \
>  --datadir='${prefix}/share'
>)
>}
>build() {
>  (cd ${objdir} && \
>  CFLAGS="${MY_CFLAGS}" make )
>}
>check() {
>  (cd ${objdir} && \
>  make test | tee ${checkfile} 2>&1 )
>}
>clean() {
>  (cd ${objdir} && \
>  make clean )
>}
>install() {
>  (cd ${objdir} && \
>  make install DESTDIR=${instdir} 
>  if [ -f ${instdir}${prefix}/info/dir ] ; then \
>    rm ${instdir}${prefix}/info/dir ; \
>  fi && \
>  if [ ! -d ${instdir}${prefix}/doc/${PKG}-${VER} ]; then \
>    mkdir -p ${instdir}${prefix}/doc/${PKG}-${VER} ; \
>  fi && \
>  if [ ! -d ${instdir}${prefix}/doc/Cygwin ]; then \
>    mkdir -p ${instdir}${prefix}/doc/Cygwin ; \
>  fi && \
>  if [ ! -d ${instdir}${sysconfdir}/postinstall ]; then \
>    mkdir -p ${instdir}${sysconfdir}/postinstall ; \
>  fi && \
>  templist=""; \
>  for f in ${srcdir}/ANNOUNCE ${srcdir}/CHANGES ${srcdir}/INSTALL \
>           ${srcdir}/KNOWNBUG ${srcdir}/LICENSE ${srcdir}/README \
>			  ${srcdir}/TODO ; do \
>    if [ -f $f ] ; then \
>      templist="$templist $f"; \
>    fi ; \
>  done && \
>  if [ ! "x$templist" = "x" ]; then \
>    /usr/bin/install -m 644 $templist \
>         ${instdir}${prefix}/doc/${PKG}-${VER} ;
>  fi && \
>  if [ -f ${srcdir}/CYGWIN-PATCHES/${PKG}.README ]; then \
>    /usr/bin/install -m 644 ${srcdir}/CYGWIN-PATCHES/${PKG}.README \
>      ${instdir}${prefix}/doc/Cygwin/${PKG}-${VER}.README ; \
>  else \
>    if [ -f ${srcdir}/CYGWIN-PATCHES/README ]; then \
>      /usr/bin/install -m 644 ${srcdir}/CYGWIN-PATCHES/README \
>        ${instdir}${prefix}/doc/Cygwin/${PKG}-${VER}.README ; \
>    fi ;\
>  fi ;\
>  /usr/bin/install -m 755 ${srcdir}/CYGWIN-PATCHES/postinstall.sh \
>    ${instdir}${sysconfdir}/postinstall/${PKG}.sh )
>}
>strip() {
>  (cd ${instdir} && \
>  find . -name "*.dll" | xargs strip > /dev/null 2>&1
>  find . -name "*.exe" | xargs strip > /dev/null 2>&1 )
>}
>pkg() {
>  (cd ${instdir} && \
>  tar cvjf ${bin_pkg} * )
>}
>mkpatch() {
>  (cd ${srcdir} && \
>  tar xvzf ${src_orig_pkg} ;\
>  mv ${PKG}-${VER} ../${PKG}-${VER}-orig && \
>  cd ${topdir} && \
>  diff -urN -x '.build' -x '.inst' -x '.sinst' \
>    ${PKG}-${VER}-orig ${PKG}-${VER} > \
>    ${srcinstdir}/${src_patch_name} ; \
>  rm -rf ${PKG}-${VER}-orig )
>}
>spkg() {
>  (mkpatch && \
>  cp ${src_orig_pkg} ${srcinstdir}/${src_orig_pkg_name} && \
>  cp $0 ${srcinstdir}/`basename $0` && \
>  cd ${srcinstdir} && \
>  tar cvjf ${src_pkg} * )
>}
>finish() {
>  rm -rf ${srcdir} 
>}
>case $1 in
>  prep)	prep ; STATUS=$? ;;
>  mkdirs)	mkdirs; STATUS=$? ;;
>  conf)	conf ; STATUS=$? ;;
>  build)	build ; STATUS=$? ;;
>  check)	check ; STATUS=$? ;;
>  clean)	clean ; STATUS=$? ;;
>  install)	install ; STATUS=$? ;;
>  strip)	strip ; STATUS=$? ;;
>  package)	pkg ; STATUS=$? ;;
>  pkg)	pkg ; STATUS=$? ;;
>  mkpatch)	mkpatch ; STATUS=$? ;;
>  src-package)	spkg ; STATUS=$? ;;
>  spkg)	spkg ; STATUS=$? ;;
>  finish) finish ; STATUS=$? ;;
>  all) prep && conf && build && install && \
>     strip && pkg && spkg && finish ; \
>	  STATUS=$? ;;
>  *) echo "Error: bad arguments" ; exit 1 ;;
>esac
>exit ${STATUS}
