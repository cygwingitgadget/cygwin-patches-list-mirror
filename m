Return-Path: <cygwin-patches-return-6384-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13066 invoked by alias); 11 Dec 2008 20:21:47 -0000
Received: (qmail 13054 invoked by uid 22791); 11 Dec 2008 20:21:46 -0000
X-Spam-Check-By: sourceware.org
Received: from mailout08.t-online.de (HELO mailout08.t-online.de) (194.25.134.20)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 11 Dec 2008 20:21:03 +0000
Received: from fwd11.aul.t-online.de  	by mailout08.sul.t-online.de with smtp  	id 1LAs1r-0004Wx-00; Thu, 11 Dec 2008 21:20:59 +0100
Received: from [10.3.2.2] (ZefOeTZHZhk87ST2l69OXDCl1a8t2tbEVjetmH3lZI6cVetAIP7NrUaj+8FXXKcQf6@[217.235.255.97]) by fwd11.aul.t-online.de 	with esmtp id 1LAs1l-1ca37Y0; Thu, 11 Dec 2008 21:20:53 +0100
Message-ID: <49417625.4030209@t-online.de>
Date: Thu, 11 Dec 2008 20:21:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.16) Gecko/20080702 SeaMonkey/1.1.11
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Avoid duplicate names in /proc/registry (which may crash  find)
References: <49384250.7080707@t-online.de> <20081205095742.GP12905@calimero.vinschen.de> <4939A9F7.1000400@t-online.de> <20081207171802.GV12905@calimero.vinschen.de> <493C1DF7.6090905@t-online.de> <20081208114800.GW12905@calimero.vinschen.de> <20081208115433.GX12905@calimero.vinschen.de>
In-Reply-To: <20081208115433.GX12905@calimero.vinschen.de>
Content-Type: multipart/mixed;  boundary="------------020606050804040806000907"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q4/txt/msg00028.txt.bz2

This is a multi-part message in MIME format.
--------------020606050804040806000907
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 582

Corinna Vinschen wrote:
>
> Oh, btw.
>
> I was wondering if you would be not too disgusted by the idea to add
> some documentation about this change to the Cygwin User's Guide.
> There's already some blurb in pathnames.sgml about the /proc/registry
> access.  Currently it lacks a description of the entire % handling.
> Maybe it would be helpful to break out an entire (small) section for the
> /proc/registry access...
>
>   


2008-12-11  Christian Franke  <franke@computer.org>

	* pathnames.sgml: New section for /proc/registry. Document registry
	name encoding.


Christian



--------------020606050804040806000907
Content-Type: text/x-diff;
 name="cygwin-1.7-registry-doc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin-1.7-registry-doc.patch"
Content-length: 3094

diff --git a/winsup/doc/pathnames.sgml b/winsup/doc/pathnames.sgml
index 2daad6d..f501606 100644
--- a/winsup/doc/pathnames.sgml
+++ b/winsup/doc/pathnames.sgml
@@ -510,11 +510,23 @@ displays information such as what model and speed processor you have.
 </para>
 <para>
 One unique aspect of the Cygwin <filename>/proc</filename> filesystem
-is <filename>/proc/registry</filename>, which displays the Windows
-registry with each <literal>KEY</literal> as a directory and each
-<literal>VALUE</literal> as a file. As anytime you deal with the
-Windows registry, use caution since changes may result in an unstable
-or broken system.  There are additionally subdirectories called
+is <filename>/proc/registry</filename>, see next section.
+</para>
+<para>
+The Cygwin <filename>/proc</filename> is not as complete as the
+one in Linux, but it provides significant capabilities. The
+<systemitem>procps</systemitem> package contains several utilities
+that use it.
+</para>
+</sect2>
+
+<sect2 id="pathnames-proc-registry"><title>The /proc/registry filesystem</title>
+<para>
+The <filename>/proc/registry</filename> filesystem provides read-only
+access to the Windows registry.  It displays each <literal>KEY</literal>
+as a directory and each <literal>VALUE</literal> as a file.  As anytime
+you deal with the Windows registry, use caution since changes may result
+in an unstable or broken system.  There are additionally subdirectories called
 <filename>/proc/registry32</filename> and <filename>/proc/registry64</filename>.
 They are identical to <filename>/proc/registry</filename> on 32 bit
 host OSes.  On 64 bit host OSes, <filename>/proc/registry32</filename>
@@ -522,10 +534,29 @@ opens the 32 bit processes view on the registry, while
 <filename>/proc/registry64</filename> opens the 64 bit processes view.
 </para>
 <para>
-The Cygwin <filename>/proc</filename> is not as complete as the
-one in Linux, but it provides significant capabilities. The
-<systemitem>procps</systemitem> package contains several utilities
-that use it.
+Reserved characters ('/', '\', ':', and '%') or reserved names
+(<filename>.</filename> and <filename>..</filename>) are converted by
+percent-encoding:
+<screen>
+<prompt>bash$</prompt> <userinput>regtool list -v '\HKEY_LOCAL_MACHINE\SYSTEM\MountedDevices'</userinput>
+...
+\DosDevices\C: (REG_BINARY) = cf a8 97 e8 00 08 fe f7
+...
+<prompt>bash$</prompt> <userinput>cd /proc/registry/HKEY_LOCAL_MACHINE/SYSTEM</userinput>
+<prompt>bash$</prompt> <userinput>ls -l MountedDevices</userinput>
+...
+-r--r----- 1 Admin SYSTEM  12 Dec 10 11:20 %5CDosDevices%5CC%3A
+...
+<prompt>bash$</prompt> <userinput>od -t x1 MountedDevices/%5CDosDevices%5CC%3A</userinput>
+0000000 cf a8 97 e8 00 08 fe f7 01 00 00 00
+</screen>
+The unnamed (default) value of a key can be accessed using the filename
+<filename>@</filename>.
+</para>
+<para>
+If a registry key contains a subkey and a value with the same name
+<filename>foo</filename>, Cygwin displays the subkey as
+<filename>foo</filename> and the value as <filename>foo%val</filename>.
 </para>
 </sect2>
 

--------------020606050804040806000907--
