From: "Michael A. Chase" <mchase@ix.netcom.com>
To: <cygwin-patches@cygwin.com>
Subject: [PATCH]Improper static on function in winsup/cygwin/path.cc
Date: Sun, 03 Jun 2001 11:22:00 -0000
Message-id: <002001c0ec59$ec9fbd30$1a6e1a3f@ca.boeing.com>
X-SW-Source: 2001-q2/msg00275.html

path_prefix_p() is referred to in winsup/cygwin/cygheap.h as extern, so it
shouldn't be declared static in winsup/cygwin/path.cc.
--
Mac :})
Give a hobbit a fish and he'll eat fish for a day.
Give a hobbit a ring and he'll eat fish for an age.

ChangeLog:

2001-06-03 Michael A Chase <mchase@ix.netcom.com>

    * path.cc:  Remove static from declaration of path_prefix_p

Patch:

--- path.cc-orig        Sun Jun  3 09:24:12 2001
+++ path.cc     Sun Jun  3 11:05:50 2001
@@ -89,7 +89,8 @@
 static int normalize_win32_path (const char *src, char *dst);
 static void slashify (const char *src, char *dst, int trailing_slash_p);
 static void backslashify (const char *src, char *dst, int
trailing_slash_p);
-static int path_prefix_p (const char *path1, const char *path2, int len1);
+
+int path_prefix_p (const char *path1, const char *path2, int len1);

 struct symlink_info
 {

