From: Warren Young <warren@etr-usa.com>
To: Cygwin Patches <cygwin-patches@sourceware.cygnus.com>
Subject: *.cwp file recognition patch for setup.exe, part 2/2
Date: Fri, 07 Sep 2001 14:32:00 -0000
Message-id: <3B993CEB.6640A99@etr-usa.com>
X-SW-Source: 2001-q3/msg00112.html

--- cinstall/tar.cc      Wed Sep  5 18:38:58 2001
+++ cinstall/tar.cc.new  Wed Sep  5 17:58:36 2001
@@ -151,6 +151,40 @@ xstrdup (char *c)
   return r;
 }

+static gzbz*
+decomp_factory(const char* pathname)
+{
+#if 1
+  HANDLE h = CreateFile(pathname, GENERIC_READ, 0, 0, OPEN_EXISTING,
+                  FILE_ATTRIBUTE_NORMAL, 0);
+  char ac[3];
+  DWORD n = sizeof(ac);
+
+  if (!h)
+    return 0;
+
+  if (!ReadFile(h, ac, sizeof(ac), &n, 0))
+    {
+         CloseHandle(h);
+      return 0;
+       }
+  CloseHandle(h);
+
+  if (memcmp(ac, "\037\213", 2) == 0)
+    return new gz (pathname);
+  else if (memcmp(ac, "BZh", 3) == 0)
+    return new bz (pathname);
+  else
+    return 0;
+#else
+       if (strstr(pathname, "bz2"))
+               return new bz(pathname);
+       else
+               return new gz(pathname);
+#endif
+}
+
+
 int
 tar_open (const char *pathname)
 {
@@ -163,10 +197,14 @@ tar_open (const char *pathname)
     return 1;
   _tar_file_size = size;

-  if (strstr (pathname, ".bz2"))
-    z = new bz (pathname);
-  else
-    z = new gz (pathname);
+  z = decomp_factory(pathname);
+  if (!z)
+    {
+         fprintf (stderr, "error: could not figure out compression type
"
+                       "for file '%s'\n", pathname);
+         return 1;
+       }
+
   if (sizeof (tar_header) != 512)
     {
       /* drastic, but important */

-- 
= Warren -- ICBM Address: 36.8274040 N, 108.0204086 W, alt. 1714m
