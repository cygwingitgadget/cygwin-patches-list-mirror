Return-Path: <cygwin-patches-return-1504-listarch-cygwin-patches=sourceware.cygnus.com@sources.redhat.com>
Received: (qmail 19833 invoked by alias); 17 Nov 2001 19:59:30 -0000
Mailing-List: contact cygwin-patches-help@sourceware.cygnus.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@sources.redhat.com>
List-Post: <mailto:cygwin-patches@sources.redhat.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@sources.redhat.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@sources.redhat.com
Received: (qmail 19812 invoked from network); 17 Nov 2001 19:59:30 -0000
To: cygwin-patches@sources.redhat.com
From: Nick Duffek <nick@duffek.com>
Subject: [PATCH] Don't modify const string in conv_path_list()
Message-Id: <20011117195929.7886D1BF249@duffek.com>
Date: Sun, 14 Oct 2001 06:38:00 -0000
X-SW-Source: 2001-q4/txt/msg00036.txt.bz2

Hi,

On 15-Oct-2001, Robert Bogomip <bob.bogo@milohedge.com> wrote:

>  bash-2.05$ (exec -c sh -c 'export PATH; ls')
>        0 [main] sh 8724 open_stackdumpfile: Dumping stack trace to sh.exe.stackdump

Here's a patch to fix that.

Starting ash as above causes PATH to be a read-only compile-time string.
When forking a subprocess, that string:
  1. gets passed to execve() as part of the environment;
  2. subsequently gets passed as a const char * parameter to
     conv_path_list() in winsup/cygwin/path.cc;
  3. becomes the target of an assignment in conv_path_list(), resulting in
     the segmentation violation.

The appended patch fixes the bug by copying PATH components instead of
modifying PATH itself.

winsup/cygwin/ChangeLog:

	* path.cc (conv_path_list): Copy source paths before modifying
	them.

Nick Duffek
<nick@duffek.com>

[patch follows]

Index: winsup/cygwin/path.cc
===================================================================
diff -up winsup/cygwin/path.cc winsup/cygwin/path.cc
--- winsup/cygwin/path.cc	Fri Nov 16 22:57:52 2001
+++ winsup/cygwin/path.cc	Fri Nov 16 22:57:32 2001
@@ -1234,17 +1234,22 @@ conv_path_list (const char *src, char *d
   int (*conv_fn) (const char *, char *) = (to_posix_p
 					   ? cygwin_conv_to_posix_path
 					   : cygwin_conv_to_win32_path);
+  char srcbuf[MAX_PATH];
+  int len;
 
   do
     {
       s = strchr (src, src_delim);
       if (s)
 	{
-	  *s = 0;
-	  (*conv_fn) (src[0] != 0 ? src : ".", d);
+	  len = s - src;
+	  if (len >= MAX_PATH)
+	    len = MAX_PATH - 1;
+	  memcpy (srcbuf, src, len);
+	  srcbuf[len] = 0;
+	  (*conv_fn) (len ? srcbuf : ".", d);
 	  d += strlen (d);
 	  *d++ = dst_delim;
-	  *s = src_delim;
 	  src = s + 1;
 	}
       else
