Return-Path: <cygwin-patches-return-7483-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30105 invoked by alias); 19 Aug 2011 01:54:29 -0000
Received: (qmail 29923 invoked by uid 22791); 19 Aug 2011 01:54:27 -0000
X-SWARE-Spam-Status: No, hits=-2.4 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,TW_CP,TW_FP,TW_UF
X-Spam-Check-By: sourceware.org
Received: from mail-yw0-f43.google.com (HELO mail-yw0-f43.google.com) (209.85.213.43)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 19 Aug 2011 01:54:12 +0000
Received: by ywm3 with SMTP id 3so2368826ywm.2        for <cygwin-patches@cygwin.com>; Thu, 18 Aug 2011 18:54:11 -0700 (PDT)
Received: by 10.151.10.9 with SMTP id n9mr1556027ybi.390.1313718851468;        Thu, 18 Aug 2011 18:54:11 -0700 (PDT)
Received: from [192.168.0.100] (S0106000cf16f58b1.wp.shawcable.net [174.5.115.130])        by mx.google.com with ESMTPS id j45sm1563620yhe.78.2011.08.18.18.54.09        (version=SSLv3 cipher=OTHER);        Thu, 18 Aug 2011 18:54:10 -0700 (PDT)
Subject: Re: [PATCH] Add /proc/devices
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
Date: Fri, 19 Aug 2011 01:54:00 -0000
In-Reply-To: <20110818195537.GD4955@calimero.vinschen.de>
References: <CAGvSfexmqdO=i-Bpk_3T8h1knC17J9VHNa5geG33-fQujnwQ0Q@mail.gmail.com>	 <1313693438.4916.2.camel@YAAKOV04>	 <20110818195537.GD4955@calimero.vinschen.de>
Content-Type: multipart/mixed; boundary="=-HPcqrW27h0CZsoTHxqqb"
Message-ID: <1313718853.10964.0.camel@YAAKOV04>
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
X-SW-Source: 2011-q3/txt/msg00059.txt.bz2


--=-HPcqrW27h0CZsoTHxqqb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 564

On Thu, 2011-08-18 at 21:55 +0200, Corinna Vinschen wrote:
> > 2011-08-18  Yaakov Selkowitz  <yselkowitz@...>
> > 
> > 	* devices.h (fh_devices): Define DEV_MISC_MAJOR, DEV_MEM_MAJOR,
> > 	DEV_SOUND_MAJOR.  Use throughout.
> > 	* fhandler_proc.cc (proc_tab): Add /proc/devices and /proc/misc
> > 	virtual files.
> > 	(format_proc_devices): New function.
> > 	(format_proc_misc): New function.
> 
> I think the patch is basically ok, but it's missing the "cons" entry
> for consoles, equivalent to the "tty" entry.

Revised patch attached.  OK to commit?


Yaakov


--=-HPcqrW27h0CZsoTHxqqb
Content-Disposition: attachment; filename="cygwin-proc-devices.patch"
Content-Type: text/x-patch; name="cygwin-proc-devices.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 5083

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
+++ devices.h	19 Aug 2011 01:48:43 -0000
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
+++ fhandler_proc.cc	19 Aug 2011 01:48:44 -0000
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
@@ -1335,4 +1339,65 @@ format_proc_swaps (void *, char *&destbu
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
+			     "%3d cons\n"
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
+			     DEV_MEM_MAJOR, DEV_CONS_MAJOR, _major (FH_TTY),
+			     _major (FH_CONSOLE), _major (FH_PTYM),
+			     DEV_TAPE_MAJOR, DEV_MISC_MAJOR, DEV_SOUND_MAJOR,
+			     DEV_SERIAL_MAJOR, DEV_TTYS_MAJOR, DEV_FLOPPY_MAJOR,
+			     DEV_SD_MAJOR, DEV_CDROM_MAJOR, DEV_SD1_MAJOR,
+			     DEV_SD2_MAJOR, DEV_SD3_MAJOR, DEV_SD4_MAJOR,
+			     DEV_SD5_MAJOR, DEV_SD6_MAJOR, DEV_SD7_MAJOR);
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

--=-HPcqrW27h0CZsoTHxqqb--
