Return-Path: <cygwin-patches-return-4672-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8742 invoked by alias); 12 Apr 2004 23:09:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8580 invoked from network); 12 Apr 2004 23:09:36 -0000
Message-Id: <3.0.5.32.20040412190645.00809e10@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Mon, 12 Apr 2004 23:09:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch]: path.cc
In-Reply-To: <20040410134918.GO26558@cygbert.vinschen.de>
References: <20040410110343.GM26558@cygbert.vinschen.de>
 <3.0.5.32.20040404234622.00800100@incoming.verizon.net>
 <3.0.5.32.20040404095756.00804cc0@incoming.verizon.net>
 <3.0.5.32.20040403214940.007f2650@incoming.verizon.net>
 <3.0.5.32.20040403214940.007f2650@incoming.verizon.net>
 <3.0.5.32.20040404095756.00804cc0@incoming.verizon.net>
 <3.0.5.32.20040404234622.00800100@incoming.verizon.net>
 <3.0.5.32.20040409231957.00857bb0@incoming.verizon.net>
 <20040410110343.GM26558@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q2/txt/msg00024.txt.bz2

This fixes the /proc bug reported on the list.

I have also observed abnormal behavior on NT4.0
1) ls uses ntsec even on remote drives without smbntsec

/> echo $CYGWIN
bash: CYGWIN: unbound variable
~> uname -a
CYGWIN_NT-4.0 myhost 1.5.9(0.112/4/2) 2004-03-18 23:05 i686 unknown unknown
Cygwin
~> ls -ld ~
drwxr-xr-x    1 PHumblet Clearuse        0 Apr 12 10:16 /h/


~> uname -a
CYGWIN_NT-4.0 myhost 1.5.10(0.113/4/2) 2004-04-12 00:16 i686 unknown
unknown Cygwin
~> ls -ld ~
d---------+  22 Administ Domain A        0 Apr 12 10:16 /h/


2) The system has become unbearably slow.
 
 2771   45904 [main] ls 410 get_file_attribute: file: h:\Job
1091290 1137194 [main] ls 410 cygpsid::debug_print: get_sids_info: owner
SID = S-1-5-32-544

I think it's related to
http://www.cygwin.com/ml/cygwin/2003-03/msg01760.html
 

2004-04-12  Pierre Humblet <pierre.humblet@ieee.org>

	* path.cc (path_conv::check): Fix "tail filling" logic.



Index: path.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.297
diff -u -p -r1.297 path.cc
--- path.cc     10 Apr 2004 19:24:55 -0000      1.297
+++ path.cc     12 Apr 2004 23:04:32 -0000
@@ -499,7 +499,7 @@ path_conv::check (const char *src, unsig
   bool need_directory = 0;
   bool saw_symlinks = 0;
   int is_relpath;
-  char *tail;
+  char *tail, *path_end;
 
 #if 0
   static path_conv last_path_conv;
@@ -544,7 +544,7 @@ path_conv::check (const char *src, unsig
          need_directory = 1;
          *--tail = '\0';
        }
-      char *path_end = tail;
+      path_end = tail;
 
       /* Scan path_copy from right to left looking either for a symlink
         or an actual existing file.  If an existing file is found, just
@@ -872,7 +872,7 @@ out:
     normalized_path_size = 0;
   else
     {
-      if (tail[1] != '\0')
+      if (tail < path_end && tail > path_copy + 1)
        *tail = '/';
       set_normalized_path (path_copy);
     }


