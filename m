Return-Path: <cygwin-patches-return-7478-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31947 invoked by alias); 18 Aug 2011 18:50:54 -0000
Received: (qmail 31929 invoked by uid 22791); 18 Aug 2011 18:50:53 -0000
X-SWARE-Spam-Status: No, hits=-2.4 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,TW_CP,TW_FP,TW_UF
X-Spam-Check-By: sourceware.org
Received: from mail-vx0-f171.google.com (HELO mail-vx0-f171.google.com) (209.85.220.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 18 Aug 2011 18:50:38 +0000
Received: by vxh13 with SMTP id 13so2441525vxh.2        for <cygwin-patches@cygwin.com>; Thu, 18 Aug 2011 11:50:37 -0700 (PDT)
Received: by 10.52.69.132 with SMTP id e4mr1189517vdu.157.1313693437465;        Thu, 18 Aug 2011 11:50:37 -0700 (PDT)
Received: from [192.168.0.100] (S0106000cf16f58b1.wp.shawcable.net [174.5.115.130])        by mx.google.com with ESMTPS id l9sm314126vdv.2.2011.08.18.11.50.28        (version=SSLv3 cipher=OTHER);        Thu, 18 Aug 2011 11:50:35 -0700 (PDT)
Subject: Re: [PATCH] Add /proc/devices
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
Date: Thu, 18 Aug 2011 18:50:00 -0000
In-Reply-To: <CAGvSfexmqdO=i-Bpk_3T8h1knC17J9VHNa5geG33-fQujnwQ0Q@mail.gmail.com>
References: <CAGvSfexmqdO=i-Bpk_3T8h1knC17J9VHNa5geG33-fQujnwQ0Q@mail.gmail.com>
Content-Type: multipart/mixed; boundary="=-X4Q76bJF+NlJOpRM6gPP"
Message-ID: <1313693438.4916.2.camel@YAAKOV04>
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
X-SW-Source: 2011-q3/txt/msg00054.txt.bz2


--=-X4Q76bJF+NlJOpRM6gPP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 484

On Thu, 2011-08-04 at 00:20 -0500, Yaakov (Cygwin/X) wrote:
> This patchset implements /proc/devices[1]:
> 
> The question is how to handle /dev/tty and /dev/console as the
> apparently vary now, per cgf's remarks on the main list.
> 
> Patches for winsup/cygwin and winsup/doc attached.

Here is a second version which adds the closely related /proc/misc[1] as
well.


Yaakov

[1] http://docs.redhat.com/docs/en-US/Red_Hat_Enterprise_Linux/6/html/Deployment_Guide/s2-proc-misc.html


--=-X4Q76bJF+NlJOpRM6gPP
Content-Disposition: attachment; filename="cygwin-proc-devices.patch"
Content-Type: text/x-patch; name="cygwin-proc-devices.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 5045

2011-08-18  Yaakov Selkowitz  <yselkowitz@...>

	* devices.h (fh_devices): Define DEV_MISC_MAJOR, DEV_MEM_MAJOR,
	DEV_SOUND_MAJOR.  Use throughout.
	* fhandler_proc.cc (proc_tab): Add /proc/devices and /proc/misc
	virtual files.
	(format_proc_devices): New function.
	(format_proc_misc): New function.

Index: devices.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/devices.h,v
retrieving revision 1.32
diff -u -p -r1.32 devices.h
--- devices.h	12 Jun 2011 20:15:26 -0000	1.32
+++ devices.h	18 Aug 2011 17:01:47 -0000
@@ -44,8 +44,9 @@ enum fh_devices
   DEV_SERIAL_MAJOR = 117,
   FH_SERIAL  = FHDEV (117, 0),	/* /dev/ttyS? */
 
-  FH_WINDOWS = FHDEV (13, 255),
-  FH_CLIPBOARD=FHDEV (13, 254),
+  DEV_MISC_MAJOR = 13,
+  FH_WINDOWS = FHDEV (DEV_MISC_MAJOR, 255),
+  FH_CLIPBOARD=FHDEV (DEV_MISC_MAJOR, 254),
 
   /* begin /proc directories */
 
@@ -225,16 +226,19 @@ enum fh_devices
   FH_SDDW    = FHDEV (DEV_SD7_MAJOR, 224),
   FH_SDDX    = FHDEV (DEV_SD7_MAJOR, 240),
 
-  FH_MEM     = FHDEV (1, 1),
-  FH_KMEM    = FHDEV (1, 2),	/* not implemented yet */
-  FH_NULL    = FHDEV (1, 3),
-  FH_PORT    = FHDEV (1, 4),
-  FH_ZERO    = FHDEV (1, 5),
-  FH_FULL    = FHDEV (1, 7),
-  FH_RANDOM  = FHDEV (1, 8),
-  FH_URANDOM = FHDEV (1, 9),
-  FH_KMSG    = FHDEV (1, 11),
-  FH_OSS_DSP = FHDEV (14, 3),
+  DEV_MEM_MAJOR = 1,
+  FH_MEM     = FHDEV (DEV_MEM_MAJOR, 1),
+  FH_KMEM    = FHDEV (DEV_MEM_MAJOR, 2),	/* not implemented yet */
+  FH_NULL    = FHDEV (DEV_MEM_MAJOR, 3),
+  FH_PORT    = FHDEV (DEV_MEM_MAJOR, 4),
+  FH_ZERO    = FHDEV (DEV_MEM_MAJOR, 5),
+  FH_FULL    = FHDEV (DEV_MEM_MAJOR, 7),
+  FH_RANDOM  = FHDEV (DEV_MEM_MAJOR, 8),
+  FH_URANDOM = FHDEV (DEV_MEM_MAJOR, 9),
+  FH_KMSG    = FHDEV (DEV_MEM_MAJOR, 11),
+
+  DEV_SOUND_MAJOR = 14,
+  FH_OSS_DSP = FHDEV (DEV_SOUND_MAJOR, 3),
 
   DEV_CYGDRIVE_MAJOR = 98,
   FH_CYGDRIVE= FHDEV (DEV_CYGDRIVE_MAJOR, 0),
Index: fhandler_proc.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_proc.cc,v
retrieving revision 1.110
diff -u -p -r1.110 fhandler_proc.cc
--- fhandler_proc.cc	12 Aug 2011 12:35:37 -0000	1.110
+++ fhandler_proc.cc	18 Aug 2011 17:01:48 -0000
@@ -46,15 +46,19 @@ static _off64_t format_proc_self (void *
 static _off64_t format_proc_mounts (void *, char *&);
 static _off64_t format_proc_filesystems (void *, char *&);
 static _off64_t format_proc_swaps (void *, char *&);
+static _off64_t format_proc_devices (void *, char *&);
+static _off64_t format_proc_misc (void *, char *&);
 
 /* names of objects in /proc */
 static const virt_tab_t proc_tab[] = {
   { _VN ("."),		 FH_PROC,	virt_directory,	NULL },
   { _VN (".."),		 FH_PROC,	virt_directory,	NULL },
   { _VN ("cpuinfo"),	 FH_PROC,	virt_file,	format_proc_cpuinfo },
+  { _VN ("devices"),	 FH_PROC,	virt_file,	format_proc_devices },
   { _VN ("filesystems"), FH_PROC,	virt_file,	format_proc_filesystems },
   { _VN ("loadavg"),	 FH_PROC,	virt_file,	format_proc_loadavg },
   { _VN ("meminfo"),	 FH_PROC,	virt_file,	format_proc_meminfo },
+  { _VN ("misc"),	 FH_PROC,	virt_file,	format_proc_misc },
   { _VN ("mounts"),	 FH_PROC,	virt_symlink,	format_proc_mounts },
   { _VN ("net"),	 FH_PROCNET,	virt_directory,	NULL },
   { _VN ("partitions"),  FH_PROC,	virt_file,	format_proc_partitions },
@@ -1335,4 +1339,64 @@ format_proc_swaps (void *, char *&destbu
   return bufptr - buf;
 }
 
+static _off64_t
+format_proc_devices (void *, char *&destbuf)
+{
+  tmp_pathbuf tp;
+  char *buf = tp.c_get ();
+  char *bufptr = buf;
+
+  bufptr += __small_sprintf (bufptr,
+			     "Character devices:\n"
+			     "%3d mem\n"
+			     "%3d /dev/tty\n"
+			     "%3d /dev/console\n"
+			     "%3d /dev/ptmx\n"
+			     "%3d st\n"
+			     "%3d misc\n"
+			     "%3d sound\n"
+			     "%3d ttyS\n"
+			     "%3d tty\n"
+			     "\n"
+			     "Block devices:\n"
+			     "%3d fd\n"
+			     "%3d sd\n"
+			     "%3d sr\n"
+			     "%3d sd\n"
+			     "%3d sd\n"
+			     "%3d sd\n"
+			     "%3d sd\n"
+			     "%3d sd\n"
+			     "%3d sd\n"
+			     "%3d sd\n",
+			     DEV_MEM_MAJOR, _major (FH_TTY), _major (FH_CONSOLE),
+			     _major (FH_PTYM), DEV_TAPE_MAJOR, DEV_MISC_MAJOR,
+			     DEV_SOUND_MAJOR, DEV_SERIAL_MAJOR, DEV_TTYS_MAJOR,
+			     DEV_FLOPPY_MAJOR, DEV_SD_MAJOR, DEV_CDROM_MAJOR,
+			     DEV_SD1_MAJOR, DEV_SD2_MAJOR, DEV_SD3_MAJOR,
+			     DEV_SD4_MAJOR, DEV_SD5_MAJOR, DEV_SD6_MAJOR,
+			     DEV_SD7_MAJOR);
+
+  destbuf = (char *) crealloc_abort (destbuf, bufptr - buf);
+  memcpy (destbuf, buf, bufptr - buf);
+  return bufptr - buf;
+}
+
+static _off64_t
+format_proc_misc (void *, char *&destbuf)
+{
+  tmp_pathbuf tp;
+  char *buf = tp.c_get ();
+  char *bufptr = buf;
+
+  bufptr += __small_sprintf (bufptr,
+			     "%3d clipboard\n"
+			     "%3d windows\n",
+			     _minor (FH_CLIPBOARD), _minor (FH_WINDOWS));
+
+  destbuf = (char *) crealloc_abort (destbuf, bufptr - buf);
+  memcpy (destbuf, buf, bufptr - buf);
+  return bufptr - buf;
+}
+
 #undef print

--=-X4Q76bJF+NlJOpRM6gPP
Content-Disposition: attachment; filename="doc-proc-devices.patch"
Content-Type: text/x-patch; name="doc-proc-devices.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 765

2011-08-18  Yaakov Selkowitz  <yselkowitz@...>

	* new-features.sgml (ov-new1.7.10): Document /proc/devices
	and /proc/misc.

Index: new-features.sgml
===================================================================
RCS file: /cvs/src/src/winsup/doc/new-features.sgml,v
retrieving revision 1.90
diff -u -p -r1.90 new-features.sgml
--- new-features.sgml	16 Aug 2011 14:51:06 -0000	1.90
+++ new-features.sgml	18 Aug 2011 17:06:17 -0000
@@ -77,6 +77,11 @@ total number of processes.
 </para></listitem>
 
 <listitem><para>
+Added /proc/devices and /proc/misc, which lists supported device types and
+their device numbers.
+</para></listitem>
+
+<listitem><para>
 Added /proc/swaps, which shows the location and size of Windows paging file(s).
 </para></listitem>
 

--=-X4Q76bJF+NlJOpRM6gPP--
