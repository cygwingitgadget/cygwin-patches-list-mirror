Return-Path: <cygwin-patches-return-7611-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10641 invoked by alias); 1 Mar 2012 05:56:56 -0000
Received: (qmail 10400 invoked by uid 22791); 1 Mar 2012 05:56:53 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,TW_LG
X-Spam-Check-By: sourceware.org
Received: from mail-iy0-f171.google.com (HELO mail-iy0-f171.google.com) (209.85.210.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 01 Mar 2012 05:56:39 +0000
Received: by iadj38 with SMTP id j38so424901iad.2        for <cygwin-patches@cygwin.com>; Wed, 29 Feb 2012 21:56:38 -0800 (PST)
Received-SPF: pass (google.com: domain of yselkowitz@gmail.com designates 10.50.222.137 as permitted sender) client-ip=10.50.222.137;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of yselkowitz@gmail.com designates 10.50.222.137 as permitted sender) smtp.mail=yselkowitz@gmail.com; dkim=pass header.i=yselkowitz@gmail.com
Received: from mr.google.com ([10.50.222.137])        by 10.50.222.137 with SMTP id qm9mr6494672igc.45.1330581398961 (num_hops = 1);        Wed, 29 Feb 2012 21:56:38 -0800 (PST)
Received: by 10.50.222.137 with SMTP id qm9mr5381632igc.45.1330581398923;        Wed, 29 Feb 2012 21:56:38 -0800 (PST)
Received: from [192.168.0.100] (S0106000cf16f58b1.wp.shawcable.net. [24.79.200.150])        by mx.google.com with ESMTPS id ch2sm878989igb.4.2012.02.29.21.56.37        (version=SSLv3 cipher=OTHER);        Wed, 29 Feb 2012 21:56:38 -0800 (PST)
Message-ID: <1330581398.7632.35.camel@YAAKOV04>
Subject: [PATCH] doc: update tcl/tk FAQ
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches@cygwin.com
Date: Thu, 01 Mar 2012 05:56:00 -0000
In-Reply-To: <20120301011504.GA19191@ednor.casa.cgf.cx>
References: <70952A932255A2489522275A628B97C3129F4A01@xmb-sjc-233.amer.cisco.com>	 <1330563447.7632.19.camel@YAAKOV04>	 <20120301011504.GA19191@ednor.casa.cgf.cx>
Content-Type: multipart/mixed; boundary="=-h3Dz6tf4slul2TwFIO+p"
Mime-Version: 1.0
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2012-q1/txt/msg00034.txt.bz2


--=-h3Dz6tf4slul2TwFIO+p
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 463

On Wed, 2012-02-29 at 20:15 -0500, Christopher Faylor wrote:
> On Wed, Feb 29, 2012 at 06:57:27PM -0600, Yaakov (Cygwin/X) wrote:
> >Using X requires user intervention to start an X server first.  No
> >amount of automatic dependencies will change this, and therefore I don't
> >expect that the number of questions would change one iota.
> 
> I agree 100% but this now qualifies as a FAQ so maybe we should add an
> entry about tcl/tk.

Patch attached.


Yaakov


--=-h3Dz6tf4slul2TwFIO+p
Content-Disposition: attachment; filename="faq-tcltk.patch"
Content-Type: text/x-patch; name="faq-tcltk.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 4364

2012-02-??  Yaakov Selkowitz  <yselkowitz@...>

	* faq-programming.xml (faq.programming.make-execvp): Remove obsolete
	information about Tcl/Tk.
	(faq.programming.dll-relocatable): Ditto.
	* faq-using.xml (faq.using.tcl-tk): Rewrite to reflect switch to
	X11 Tcl/Tk.

Index: faq-programming.xml
===================================================================
RCS file: /cvs/src/src/winsup/doc/faq-programming.xml,v
retrieving revision 1.17
diff -u -p -r1.17 faq-programming.xml
--- faq-programming.xml	13 Aug 2010 11:52:13 -0000	1.17
+++ faq-programming.xml	1 Mar 2012 05:51:21 -0000
@@ -93,18 +93,6 @@ C:/cygwin/bin /bin ntfs binary,cygexec 0
 C:/cygwin/bin /usr/bin ntfs binary,cygexec 0 0
 </screen>
 
-<para>Note that if you have Tcl/Tk installed, you must additionally
-exclude <literal>tclsh84</literal> and <literal>wish84</literal>, which
-are linked to the Cygwin DLL but are not actually Cygwin programs:
-</para>
-
-<screen>
-C:/cygwin/bin/tclsh84.exe /bin/tclsh84.exe ntfs binary,notexec 0 0
-C:/cygwin/bin/tclsh84.exe /usr/bin/tclsh84.exe ntfs binary,notexec 0 0
-C:/cygwin/bin/wish84.exe /bin/wish84.exe ntfs binary,notexec 0 0
-C:/cygwin/bin/wish84.exe /usr/bin/wish84.exe ntfs binary,notexec 0 0
-</screen>
-
 <para>If you have added other non-Cygwin programs to a path you want to mount
 cygexec, you can find them with a script like this:
 </para>
@@ -574,8 +562,6 @@ $(LD) EXPFILE --dll -o DLLNAME OBJS LIBS
 </para>
 <para>LIBS is the list of libraries you want to link the DLL against.  For
 example, you may or may not want -lcygwin.  You may want -lkernel32.
-Tcl links against -lcygwin -ladvapi32 -luser32 -lgdi32 -lcomdlg32
--lkernel32.
 </para>
 <para>DEFFILE is the name of your definitions file.  A simple DEFFILE would
 consist of ``EXPORTS'' followed by a list of all symbols which should
@@ -614,9 +600,8 @@ int entry (HINSTANT hinst, DWORD reason,
 }
 </screen>
 
-<para>You may put an optional `--subsystem windows' on the $(LD) lines.  The
-Tcl build does this, but I admit that I no longer remember whether
-this is important.  Note that if you specify a --subsytem &lt;x&gt; flag to ld,
+<para>You may put an optional `--subsystem windows' on the $(LD) lines.
+Note that if you specify a --subsytem &lt;x&gt; flag to ld,
 the -e entry must come after the subsystem flag, since the subsystem flag
 sets a different default entry point.
 </para>
Index: faq-using.xml
===================================================================
RCS file: /cvs/src/src/winsup/doc/faq-using.xml,v
retrieving revision 1.43
diff -u -p -r1.43 faq-using.xml
--- faq-using.xml	27 Feb 2012 19:45:26 -0000	1.43
+++ faq-using.xml	1 Mar 2012 05:51:21 -0000
@@ -1060,16 +1060,27 @@ usually all set and you can start the ss
 </answer></qandaentry>
 
 <qandaentry id="faq.using.tcl-tk">
-<question><para>Why doesn't Cygwin tcl/tk understand Cygwin paths?</para></question>
+<question><para>Why do my Tk programs not work anymore?</para></question>
 <answer>
 
-<para>The versions of Tcl/Tk distributed with Cygwin (e.g. cygtclsh80.exe,
-cygwish80.exe) are not actually "Cygwin versions" of those tools.
-They are built as native libraries, which means they do not understand
-Cygwin mounts or symbolic links.
-</para>
-<para>See the entry "How do I convert between Windows and UNIX paths?"
-elsewhere in this FAQ.
+<para>Previous versions of Tcl/Tk distributed with Cygwin (e.g. tclsh84.exe,
+wish84.exe) were not actually "Cygwin versions" of those tools.
+They were built as native libraries, which means they did not understand
+Cygwin mounts or symbolic links. This lead to all sorts of problems interacting
+with true Cygwin programs.</para>
+
+<para>As of February 2012, this was replaced with a version of Tcl/Tk which
+uses Cygwin's POSIX APIs and X11 for GUI functionality.  If you get a message
+such as this when trying to start a Tk app:</para>
+
+<screen>
+  Application initialization failed: couldn't connect to display ""
+</screen>
+
+<para>Then you need to start an X server, or if one is already running, set the
+<literal>DISPLAY</literal> variable to the proper value.  The Cygwin distribution
+includes an X server; please see the <ulink url="http://x.cygwin.com/docs/ug/cygwin-x-ug.html">Cygwin/X User Guide</ulink>
+for installation and startup instructions.
 </para></answer></qandaentry>
 
 <qandaentry id="faq.using.ipv6">

--=-h3Dz6tf4slul2TwFIO+p--
