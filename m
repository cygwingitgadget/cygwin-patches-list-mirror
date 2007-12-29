Return-Path: <cygwin-patches-return-6216-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14939 invoked by alias); 29 Dec 2007 17:43:22 -0000
Received: (qmail 14928 invoked by uid 22791); 29 Dec 2007 17:43:22 -0000
X-Spam-Check-By: sourceware.org
Received: from mail.artimi.com (HELO mail.artimi.com) (194.72.81.2)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sat, 29 Dec 2007 17:43:12 +0000
Received: from rainbow ([192.168.8.46]) by mail.artimi.com with Microsoft SMTPSVC(6.0.3790.3959); 	 Sat, 29 Dec 2007 17:43:09 +0000
From: "Dave Korn" <dave.korn@artimi.com>
To: "Cygwin patches" <cygwin-patches@cygwin.com>
Subject: BLODA FAQ entry.
Date: Sat, 29 Dec 2007 17:43:00 -0000
Message-ID: <074301c84a42$46df85d0$2e08a8c0@CAM.ARTIMI.COM>
MIME-Version: 1.0
Content-Type: multipart/mixed; 	boundary="----=_NextPart_000_0744_01C84A42.46DF85D0"
X-Mailer: Microsoft Office Outlook 11
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q4/txt/msg00068.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0744_01C84A42.46DF85D0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-length: 362


  The long-promised FAQ entry.

winsup/doc/ChangeLog

2007-29-12  Dave Korn  <dave.korn@artimi.com>

	* faq-using.xml (faq.using.bloda):  New entry.
	(faq.using.firewall, faq.using.anti-virus):  Link to faq.using.bloda.
	* faq-setup.xml (faq.setup.hang):  Likewise link to faq.using.bloda.

    cheers,
      DaveK
-- 
Can't think of a witty .sigline today....

------=_NextPart_000_0744_01C84A42.46DF85D0
Content-Type: application/octet-stream;
	name="bloda-faq.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="bloda-faq.patch"
Content-length: 8225

Index: winsup/doc/faq-setup.xml=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/doc/faq-setup.xml,v=0A=
retrieving revision 1.9=0A=
diff -p -u -r1.9 faq-setup.xml=0A=
--- winsup/doc/faq-setup.xml	26 Aug 2006 19:11:00 -0000	1.9=0A=
+++ winsup/doc/faq-setup.xml	29 Dec 2007 17:30:22 -0000=0A=
@@ -155,6 +155,10 @@ disk if you are paranoid.=0A=
 <para>This should be safe, but only if Cygwin Setup is not substituted by=
=0A=
 something malicious, and no mirror has been compromised.=0A=
 </para>=0A=
+<para>See also <ulink url=3D"http://cygwin.com/faq/faq.using.html#faq.usin=
g.bloda" />=0A=
+for a list of applications that have been known, at one time or another, t=
o=0A=
+interfere with the normal functioning of Cygwin.=0A=
+</para>=0A=
 </answer></qandaentry>=0A=
=20=0A=
 <qandaentry id=3D"faq.setup.what-packages">=0A=
Index: winsup/doc/faq-using.xml=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/doc/faq-using.xml,v=0A=
retrieving revision 1.7=0A=
diff -p -u -r1.7 faq-using.xml=0A=
--- winsup/doc/faq-using.xml	18 Jul 2007 15:43:37 -0000	1.7=0A=
+++ winsup/doc/faq-using.xml	29 Dec 2007 17:30:22 -0000=0A=
@@ -633,6 +633,10 @@ of poorly written firewall-type software=0A=
 Note that with many of these products, simply disabling the firewall=0A=
 does not remove these changes; it must be completely uninstalled.=0A=
 </para>=0A=
+<para>See also <ulink url=3D"http://cygwin.com/faq/faq.using.html#faq.usin=
g.bloda" />=0A=
+for a list of applications that have been known, at one time or another, t=
o=20=0A=
+interfere with the normal functioning of Cygwin.=0A=
+</para>=0A=
 </answer></qandaentry>=0A=
=20=0A=
 <qandaentry id=3D"faq.using.sharing-files">=0A=
@@ -782,6 +786,10 @@ contents are exempt from scanning.  In a=0A=
 would be <literal>C:\cygwin\bin</literal>.  Obviously, this could be=0A=
 exploited by a hostile non-Cygwin program, so do this at your own risk.=0A=
 </para>=0A=
+<para>See also <ulink url=3D"http://cygwin.com/faq/faq.using.html#faq.usin=
g.bloda" />=0A=
+for a list of applications that have been known, at one time or another, t=
o=0A=
+interfere with the normal functioning of Cygwin.=0A=
+</para>=0A=
 </answer></qandaentry>=0A=
=20=0A=
 <qandaentry id=3D"faq.using.emacs">=0A=
@@ -950,3 +958,86 @@ means they do not understand Cygwin moun=0A=
 elsewhere in this FAQ.=0A=
 </para></answer></qandaentry>=0A=
=20=0A=
+<qandaentry id=3D"faq.using.bloda">=0A=
+<question><para>What applications have been found to interfere with Cygwin=
?</para></question>=0A=
+<answer>=0A=
+=0A=
+<para>From time to time, people have reported strange failures and problem=
s in=0A=
+Cygwin and Cygwin packages that seem to have no rational explanation.  Amo=
ng=0A=
+the most common symptoms they report are fork failures, memory leaks, and =
file=0A=
+access denied problems.  These problems, when they have been traced, often=
 appear=0A=
+to be caused by interference from other software installed on the same PC.=
  Security=0A=
+software, in particular, such as anti-virus, anti-spyware, and firewall ap=
plications,=0A=
+often implements its functions by installing hooks into various parts of t=
he system,=0A=
+including both the Explorer shell and the underlying kernel.  Sometimes th=
ese hooks=0A=
+are not implemented in an entirely transparent fashion, and cause changes =
in the=0A=
+behaviour which affect the operation of other programs, such as Cygwin.=0A=
+</para>=0A=
+<para>Among the software that has been found to cause difficulties are:</p=
ara>=0A=
+<para><itemizedlist>=0A=
+<listitem><para>Sonic Solutions burning software containing DLA component<=
/para></listitem>=0A=
+<listitem><para>Norton/MacAffee/Symantec antivirus or antispyware</para></=
listitem>=0A=
+<listitem><para>Logitech webcam software with "Logitech process monitor" s=
ervice</para></listitem>=0A=
+<listitem><para>Kerio, Agnitum or ZoneAlarm Personal Firewall</para></list=
item>=0A=
+<listitem><para>Iolo System Mechanic/AntiVirus/Firewall</para></listitem>=
=0A=
+<listitem><para>LanDesk</para></listitem>=0A=
+<listitem><para>Windows Defender </para></listitem>=0A=
+<listitem><para>Embassy Trust Suite fingerprint reader software wxvault.dl=
l</para></listitem>=0A=
+<listitem><para>NOD32 Antivirus</para></listitem>=0A=
+<listitem><para>ByteMobile laptop optimization client</para></listitem>=0A=
+</itemizedlist></para>=0A=
+<para>Sometimes these problems can be worked around, by temporarily or par=
tially=0A=
+disabling the offending software.  For instance, it may be possible to dis=
able=0A=
+on-access scanning in your antivirus, or configure it to ignore files unde=
r the=0A=
+Cygwin installation root.  Often, unfortunately, this is not possible; eve=
n disabling=0A=
+the software may not work, since many applications that hook the operating=
 system=0A=
+leave their hooks installed when disabled, and simply set them into what i=
s intended=0A=
+to be a completely transparent pass-through mode.  Sometimes this pass-thr=
ough is not=0A=
+as transparent as all that, and the hooks still interfere with Cygwin; in =
these cases,=0A=
+it may be necessary to uninstall the software altogether to restore normal=
 operation.=0A=
+</para>=0A=
+<para>Some of the symptoms you may experience are:</para>=0A=
+<para><itemizedlist>=0A=
+<listitem>=0A=
+<para>Random fork() failures.</para>=0A=
+<para>Caused by hook DLLs that load themselves into every process in the=
=0A=
+system.  POSIX fork() semantics require that the memory map of the child p=
rocess=0A=
+must be an exact duplicate of the parent process' layout.  If one of these=
 DLLs=0A=
+loads itself at a different base address in the child's memory space as co=
mpared=0A=
+to the address it was loaded at in the parent, it can end up taking the sp=
ace that=0A=
+belonged to a different DLL in the parent.  When Cygwin can't load the ori=
ginal=0A=
+DLL at that same address in the child, the fork() call has to fail.=0A=
+</para>=0A=
+</listitem>=0A=
+<listitem>=0A=
+<para>File access problems.</para>=0A=
+<para>Some programs (e.g., virus scanners with on-access scanning) scan or=
=0A=
+otherwise operate on every file accessed by all the other software running=
 on=0A=
+your computer.  In some cases they may retain an open handle on the file e=
ven=0A=
+after the software that is really using the file has closed it.  This has =
been=0A=
+known to cause operations such as deletes, renames and moves to fail with=
=0A=
+access denied errors.  In extreme cases it has been known for scanners to =
leak=0A=
+file handles, leading to kernel memory starvation.=0A=
+</para>=0A=
+</listitem>=0A=
+<listitem>=0A=
+<para>Networking issues</para>=0A=
+<para>Firewall software sometimes gets a bit funny about Cygwin.  It's not=
=0A=
+currently understood why; Cygwin only uses the standard Winsock2 API, but=
=0A=
+perhaps in some less-commonly used fashion that doesn't get as well tested=
=0A=
+by the publishers of firewalls.  Symptoms include mysterious failures to=
=0A=
+connect, or corruption of network data being sent or received.</para>=0A=
+</listitem>=0A=
+<listitem>=0A=
+<para>Memory and/or handle leaks</para>=0A=
+<para>Some applications that hook into the Windows operating system exhibi=
t=0A=
+bugs when interacting with Cygwin that cause them to leak allocated memory=
=0A=
+or other system resources.  Symptoms include complaints about out-of-memor=
y=0A=
+errors and even virtual memory exhaustion dialog boxes from the O/S; it is=
=0A=
+often possible to see the excess memory allocation using a tool such as=0A=
+Task Manager or Sysinternals' Process Explorer, although interpreting the=
=0A=
+statistics they present is not always straightforward owing to complicatio=
ns=0A=
+such as virtual memory paging and file caching.</para>=0A=
+</listitem>=0A=
+</itemizedlist></para>=0A=
+</answer></qandaentry>=0A=

------=_NextPart_000_0744_01C84A42.46DF85D0--
