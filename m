From: "Schaible, Jorg" <Joerg.Schaible@gft.com>
To: cygwin-patches@sources.redhat.com
Subject: patch for cygpath
Date: Tue, 07 Aug 2001 02:39:00 -0000
Message-id: <C2D7D58DBFE9D111B0480060086E963504AC5262@mail.gft.de>
X-SW-Source: 2001-q3/msg00066.html

Sent again to cygwin-patches.

-----Original Message-----
From: MAILER-DAEMON@sourceware.cygnus.com
[ mailto:MAILER-DAEMON@sourceware.cygnus.com ]
Sent: Monday, August 06, 2001 3:40 PM
To: Schaible, Jorg
Subject: failure notice

[snip]

--- Below this line is a copy of the message.

Return-Path: <Joerg.Schaible@gft.com>
Received: (qmail 29321 invoked from network); 6 Aug 2001 13:40:15 -0000
Received: from unknown (HELO mail.gft.de) (213.68.142.133)
  by sourceware.cygnus.com with SMTP; 6 Aug 2001 13:40:15 -0000
Received: by mail.gft.de with Internet Mail Service (5.5.2653.19)
	id <PXK2THGB>; Mon, 6 Aug 2001 15:40:08 +0200
Message-ID: <C2D7D58DBFE9D111B0480060086E963504AC521E@mail.gft.de>
From: "Schaible, Jorg" <Joerg.Schaible@gft.com>
To: cygwin@sources.redhat.com
Cc: cygwin-patches@sources.redhat.com
Subject: RE: check_case:strict / cygpath
Date: Mon, 6 Aug 2001 15:40:01 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain

Hi Gerrit,

it seems this is hard-coded by Windows (at least for my W2k). cygpath just
calls WIn-API GetSystemDirectory. I've provided a patch for this scenario.

Greetings,
Jorg


2001-08-06  Joerg Schaible <joerg.schaible@gmx.de>

	* cygpath.cc (main): Support -w for Windows (System) directories and
	return physical correct orthography for the Windows System dir.



--- cygpath.cc-orig	Mon Aug  6 13:32:29 2001
+++ cygpath.cc	Mon Aug  6 13:24:11 2001
@@ -208,6 +208,7 @@ main (int argc, char **argv)
   int options_from_file_flag;
   char *filename;
   char buf[MAX_PATH], buf2[MAX_PATH];
+  WIN32_FIND_DATA w32_fd;
 
   prog_name = strrchr (argv[0], '/');
   if (prog_name == NULL)
@@ -266,13 +267,21 @@ main (int argc, char **argv)
 
 	case 'W':
 	  GetWindowsDirectory(buf, MAX_PATH);
-	  cygwin_conv_to_posix_path(buf, buf2);
+	  if (!windows_flag)
+	    cygwin_conv_to_posix_path(buf, buf2);
+	  else
+	    strcpy(buf2, buf);
 	  printf("%s\n", buf2);
 	  exit(0);
 
 	case 'S':
 	  GetSystemDirectory(buf, MAX_PATH);
-	  cygwin_conv_to_posix_path(buf, buf2);
+	  FindFirstFile(buf, &w32_fd);
+	  strcpy(strrchr(buf, '\\')+1, w32_fd.cFileName);
+	  if (!windows_flag)
+	    cygwin_conv_to_posix_path(buf, buf2);
+	  else
+	    strcpy(buf2, buf);
 	  printf("%s\n", buf2);
 	  exit(0);



>-----Original Message-----
>From: Gerrit P. Haase [ mailto:haase@convey.de ]
>Sent: Thursday, August 02, 2001 7:29 PM
>To: cygwin@sources.redhat.com
>Subject: check_case:strict / cygpath
>
>
>Hi, 
>
>cygpath reports the following to me:
>
>$ cygpath -u -S
>/cygdrive/c/WINNT/System32
>
>But my Sysdir is named not 'System32', but 'system32' .
>
>Is this a bug?
>
>gph
>
>
>-- 
>gerrit.haase@convey.de
>
>--
>Unsubscribe info:      http://cygwin.com/ml/#unsubscribe-simple
>Bug reporting:         http://cygwin.com/bugs.html
>Documentation:         http://cygwin.com/docs.html
>FAQ:                   http://cygwin.com/faq/
>
