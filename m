Return-Path: <cygwin-patches-return-4969-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14733 invoked by alias); 22 Sep 2004 02:03:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14708 invoked from network); 22 Sep 2004 02:03:05 -0000
Message-Id: <3.0.5.32.20040921215840.0081d100@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Wed, 22 Sep 2004 02:03:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: [PATCH]: Still path.cc
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q3/txt/msg00121.txt.bz2

It's a safe time to take care of a few nits...

While testing, I noticed in dir.cc that __d_dirent->d_ino
is always set by hashing the pathname :(

Pierre

2004-09-22  Pierre Humblet <pierre.humblet@ieee.org>

	* path.cc (normalize_win32_path): Only look for : in second position.
	Avoid infinite loop with names starting in double dots.
	(mount_info::conv_to_win32_path): Do not worry about a trailing dot. 
	(hash_path_name): Ditto.


Index: path.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.320
diff -u -p -r1.320 path.cc
--- path.cc     12 Sep 2004 03:47:56 -0000      1.320
+++ path.cc     21 Sep 2004 02:34:26 -0000
@@ -978,7 +978,7 @@ normalize_win32_path (const char *src, c
          src += 2;
        }
     }
-  else if (strchr (src, ':') == NULL && *src != '/')
+  else if (!isdrive(src) && *src != '/')
     {
       if (beg_src_slash)
        dst += cygheap->cwd.get_drive (dst);
@@ -1023,6 +1023,7 @@ normalize_win32_path (const char *src, c
              int n = strspn (src, ".");
              if (!src[n] || isdirsep (src[n])) /* just dots... */
                return ENOENT;
+             *dst++ = *src++;
            }
        }
       /* Otherwise, add char to result.  */
@@ -1454,8 +1455,7 @@ mount_info::conv_to_win32_path (const ch
       int n = mount_table->cygdrive_len - 1;
       int unit;
 
-      if (!src_path[n] ||
-         (src_path[n] == '/' && src_path[n + 1] == '.' && !src_path[n + 2]))
+      if (!src_path[n])
        {
          unit = 0;
          dst[0] = '\0';
@@ -3249,15 +3249,13 @@ hash_path_name (__ino64_t hash, const ch
     }
 
 hashit:
-  /* Build up hash.  Ignore single trailing slash or \a\b\ != \a\b or
-     \a\b\.  but allow a single \ if that's all there is. */
+  /* Build up hash. Name is already normalized */
   do
     {
       int ch = cyg_tolower (*name);
       hash = ch + (hash << 6) + (hash << 16) - hash;
     }
-  while (*++name != '\0' &&
-        !(*name == '\\' && (!name[1] || (name[1] == '.' && !name[2]))));
+  while (*++name != '\0');
   return hash;
 }
 
