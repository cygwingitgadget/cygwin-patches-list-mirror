From: Kazuhiro Fujieda <fujieda@jaist.ac.jp>
To: cygwin-patches@cygwin.com
Subject: mount flag of UNC paths.
Date: Wed, 09 May 2001 11:23:00 -0000
Message-id: <s1soft2xty6.fsf@jaist.ac.jp>
X-SW-Source: 2001-q2/msg00210.html

I think the mount flag of UNC paths should be picked up from the
mount table the same as paths including `:' or `\' for consistency.
The following patch can realize it.

2001-05-10  Kazuhiro Fujieda  <fujieda@jaist.ac.jp>

	* path.cc (mount_info::conv_to_win32_path): Treat UNC paths the same
	as paths including `:' or `\'.

Index: path.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.136
diff -u -p -r1.136 path.cc
--- path.cc	2001/05/08 15:16:49	1.136
+++ path.cc	2001/05/09 17:56:49
@@ -1171,7 +1171,7 @@ mount_info::conv_to_win32_path (const ch
 
   /* An MS-DOS spec has either a : or a \.  If this is found, short
      circuit most of the rest of this function. */
-  if (strpbrk (src_path, ":\\") != NULL)
+  if (strpbrk (src_path, ":\\") != NULL || slash_unc_prefix_p (src_path))
     {
       debug_printf ("%s already win32", src_path);
       rc = normalize_win32_path (src_path, dst);
