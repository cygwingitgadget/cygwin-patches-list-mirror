Return-Path: <cygwin-patches-return-3743-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20071 invoked by alias); 23 Mar 2003 16:26:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20062 invoked from network); 23 Mar 2003 16:26:29 -0000
Date: Sun, 23 Mar 2003 16:26:00 -0000
From: Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
To: cygwin-patches@cygwin.com
Subject: Improve setup-net.sgml based on comments
Message-ID: <20030323162821.GA1164@world-gov>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-SW-Source: 2003-q1/txt/msg00392.txt.bz2


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-length: 145

I checked in some changes. 

2003-03-23  Joshua Daniel Franklin <joshuadfranklin@yahoo.com>

	* setup-net.sgml: Improve setup.exe documentation


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=foo
Content-length: 5731

Index: setup-net.sgml
===================================================================
RCS file: /cvs/src/src/winsup/doc/setup-net.sgml,v
retrieving revision 1.7
diff -u -p -r1.7 setup-net.sgml
--- setup-net.sgml	22 Mar 2003 21:16:25 -0000	1.7
+++ setup-net.sgml	23 Mar 2003 16:22:09 -0000
@@ -65,11 +65,16 @@ determine access to installed files.
 The <literal>Install For</literal> options of 
 <literal>All Users</literal> or 
 <literal>Just Me</literal> are especially for multiuser systems
-or Domain users. If you have a single-user workstation, this 
-option probably does not concern you. If you are seeking to rollout
-Cygwin on a large Domain, you will want to see <Xref Linkend="ntsec">
-in the Cygwin User's Guide and possibly consult the Cygwin
-mailing list archives about others' experiences.
+or Domain users. If you have access to a user account that is a local 
+Administrator or a member of the Administrators group, it is best to
+install for <literal>All Users</literal>. You should only install for
+<literal>Just Me</literal> if you do not have write access to 
+<literal>HKEY_LOCAL_MACHINE</literal> in the registry or the 
+All Users Start Menu, even if you are the only user planning to use 
+Cygwin on the machine.  If you are seeking to rollout
+Cygwin on a large Domain, you will want to read <Xref Linkend="ntsec">
+in the Cygwin User's Guide and consult the Cygwin mailing list archives 
+about others' experiences.
 </para>
 <para>
 The <literal>Default Text File Type</literal> should be left on
@@ -83,7 +88,7 @@ have a very good reason to switch it to 
 <para>
 The <literal>Local Package Directory</literal> is the cache where 
 <command>setup.exe</command> stores the packages before they are
-installed. The cache should not be the same folder as the Cygwin
+installed. The cache must not be the same folder as the Cygwin
 root. Within the cache, a separate directory is created for each
 Cygwin mirror, which allows <command>setup.exe</command> to use 
 multiple mirrors and custom packages. After installing Cygwin,
@@ -94,10 +99,11 @@ or in case you need to reinstall a packa
 
 <sect2><title>Connection Method</title>
 <para>
-For most users, the <literal>Direct Connection</literal> method
-of downloading is the best choice. If you have a proxy server,
-you can use the <literal>Use IE5 Settings</literal> if it is 
-already set up in Internet Exlporer, or manually type it into 
+The <literal>Direct Connection</literal> method of downloading will 
+directly download the packages, while the IE5 method will leverage your 
+IE5 cache for performance. If your organisation uses a proxy server or
+auto-configuration scripts, the IE5 method also uses these settings.
+If you have a proxy server, you can manually type it into 
 the <literal>Use Proxy</literal> section. Unfortunately, 
 <command>setup.exe</command> does not currently support password
 authorization for proxy servers.
@@ -120,16 +126,21 @@ mirror) you can add it.
 <sect2><title>Choosing Packages</title>
 <para>
 For each selected mirror site, <command>setup.exe</command> downloads a 
-small text file called <literal>setup.ini</literal> that contains a list
+small text file called <literal>setup.bz2</literal> that contains a list
 of packages available from that site along with some basic information about
-each package (version number, dependencies, checksum, etc.) which 
-<command>setup.exe</command> parses and uses to create the chooser window.
+each package which <command>setup.exe</command> parses and uses to create the 
+chooser window. For details about the format of this file, see
+<ulink URL="http://sources.redhat.com/cygwin-apps/setup.html#setup.ini">
+http://sources.redhat.com/cygwin-apps/setup.html</ulink>.
 </para>
 <para>
 The chooser is the most complex part of <command>setup.exe</command>. 
-Packages are divided into categories. By default <command>setup.exe</command>
+Packages are grouped into categories, and one package may belong to multiple 
+categories (assigned by the volunteer package maintainer). Each package
+can be found under any of those categories in the heirarchial chooser view.
+By default <command>setup.exe</command>
 will install only the packages in the <literal>Base</literal> category
-and their dependencies, resulting in a very basic Cygwin installation.
+and their dependencies, resulting in a minimal Cygwin installation.
 However, this will not include many commonly used tools such as 
 <command>gcc</command> (which you will find in the <literal>Devel</literal> 
 category). 
@@ -197,13 +208,13 @@ use these shortcuts as a guide to creati
 Last of all, <command>setup.exe</command> will run any post-install
 scripts to finish correctly setting up installed packages. Since each
 script is run separately, several windows may pop up. If you are 
-interested in what is being done, the scripts are kept in the 
-<literal>/etc/postinstall/</literal> directory, renamed with a 
-<literal>done</literal> extension after being run. When the last
-post-install script is completed, <command>setup.exe</command> will
-display a box announcing the completion. A few packages, such as
+interested in what is being done, see the Cygwin Package Contributor's
+Guide at <ulink 
+URL="http://cygwin.com/setup.html">http://cygwin.com/setup.html</ulink>
+When the last post-install script is completed, <command>setup.exe</command> 
+will display a box announcing the completion. A few packages, such as
 the OpenSSH server, require some manual site-specific configuration. 
-Relevant documentation can be found in the <literal>/usr/doc/Cygwin</literal> 
+Relevant documentation can be found in the <literal>/usr/doc/Cygwin/</literal> 
 directory.
 </para>
 </sect2>

--tKW2IUtsqtDRztdT--
