From: Chrisiasci@aol.com
To: <cygwin-patches@cygwin.com>
Cc: <chrisiasci@aol.com>
Subject: 1.1.8: access violation in dlopen
Date: Wed, 14 Feb 2001 08:13:00 -0000
Message-id: <56.735ed4b.27bc0850@aol.com>
X-SW-Source: 2001-q1/msg00070.html

Hi,

I add a problem where dlopen would access violate if passed a non-existent dll.

The problem is that is this case, LoadLibrary is called with a NULL pointer.
It also seems that this does not always AV (depending on Os version...).

What this patch does is only checking the null pointer case and returning without trying to call LoadLibrary.



--- dlfcn.cc.ori        Tue Oct 10 02:00:50 2000
+++ dlfcn.cc    Wed Feb 14 14:54:40 2001
@@ -177,7 +177,10 @@ dlopen (const char *name, int)
     {
       /* handle for the named library */
       const char *fullpath = get_full_path_of_dll (name);
-      ret = (void *) LoadLibrary (fullpath);
+      if (fullpath)
+      {
+       ret = (void *) LoadLibrary (fullpath);
+      }
     }

   if (!ret)
