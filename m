From: Warren Young <warren@etr-usa.com>
To: Cygwin Patches <cygwin-patches@sourceware.cygnus.com>
Subject: *.cwp file recognition patch for setup.exe, part 1/2
Date: Fri, 07 Sep 2001 14:32:00 -0000
Message-id: <3B993CE7.B6A91F4@etr-usa.com>
X-SW-Source: 2001-q3/msg00111.html

This patch adds "*.cwp" ("CygWin Package") file name recognition to
setup.exe.  .tar.gz and .tar.bz2 recognition appears to still work.

.cwp files can be either bzip2 or gzip files, as the program now does
magic number checking.  This also applies to .tar.gz and .tar.bz2 -- if
the file is named .tar.gz and is not actually a gzip file, or whatever,
the program will refuse to even try to open it.

The choose.cc patch is below, and the tar.cc patch follows in the next
message.


Change log entry:

2001-09-05  Warren Young  <warren@etr-usa.com>
        * choose.cc (find_tar_ext): Add *.cwp extension recognition

        * tar.cc (tar_open): Now calls decomp_factory() to create gzbz
        instance by examining the file name given.

        * tar.cc (decomp_factory): new function
          

--- cinstall/choose.cc   Wed Sep  5 18:38:57 2001
+++ cinstall/choose.cc.new       Wed Sep  5 18:36:06 2001
@@ -1208,6 +1208,29 @@ base (const char *s)
 int
 find_tar_ext (const char *path)
 {
+#if 1
+  char temp_path[_MAX_PATH];
+  strncpy(temp_path, path, sizeof(temp_path));
+  temp_path[sizeof(temp_path) - 1] = '\0';
+
+  char* p = strrchr(temp_path, '.');
+  if (!p)
+    return 0;
+
+  if (strcmp(p, ".cwp") == 0)
+    return p - temp_path;
+  else if ((strcmp(p, ".gz") == 0) || (strcmp(p, ".bz2") == 0))
+    {
+      // found .gz or .bz2, make sure ".tar" is before that.
+      *p = '\0';
+      p = strrchr(temp_path, '.');
+      if (p && (strcmp(p, ".tar") == 0))
+        return p - temp_path;
+      return 0;
+    }
+  else
+    return 0;
+#else
   char *p = strchr (path, '\0') - 7;
   if (p <= path)
     return 0;
@@ -1220,6 +1243,7 @@ find_tar_ext (const char *path)
     return 0;

   return p - path;
+#endif
 }

 /* Parse a filename into package, version, and extension components. */







--
= Warren -- ICBM Address: 36.8274040 N, 108.0204086 W, alt. 1714m
