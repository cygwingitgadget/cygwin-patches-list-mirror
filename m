From: Brian Keener <bkeener@thesoftwaresource.com>
To: cygwin-patches <cygwin-patches@cygwin.com>
Subject: [Patch]  setup.exe changes to choose.cc for src files in choose list that shouldn't be
Date: Fri, 16 Mar 2001 20:32:00 -0000
Message-id: <VA.000006df.01efa247@thesoftwaresource.com>
X-SW-Source: 2001-q1/msg00190.html

Here are the changes to correct the Source files being listed in the current and version 
selection in choose.cc that Christopher Faylor reported.  

Also included is a change to allow the Checkbox for downloading the Source files when in 
Download mode to function as it should as reported by several people.  No we still don't 
have the one to allow us to re-download or re-install he current package or source files 
but it's on the list.

Also a change to the network file function for proper file size handling.  Hope these help.

2001-03-16  Brian Keener <bkeener@thesoftwaresource.com>

   * nio-file.cc (NetIO_File::NetIO_File (char *Purl) : NetIO (Purl)): 
   Use `get_file_size' instead of `stat'.
   * choose.cc (list_click): Correct inability to select source code
   for download.
   (scan2): Modify to skip source tarballs when scanning disk for
   installable packages.


Index: winsup/cinstall/choose.cc
===================================================================
RCS file: /cvs/src/src/winsup/cinstall/choose.cc,v
retrieving revision 2.12
diff -u -p -r2.12 choose.cc
--- choose.cc  2001/03/06 13:21:58 2.12
+++ choose.cc  2001/03/17 04:13:09
@@ -298,8 +298,7 @@ list_click (HWND hwnd, BOOL dblclk, int 
 
   if (x >= headers[SRC_COL].x - HMARGIN/2 && x <= headers[SRC_COL+1].x - HMARGIN/2)
     {
-      if (extra[p].chooser[extra[p].pick].src_avail && 
-          package[p].info[extra[p].chooser[extra[p].pick].trust].source_exists)
+      if (extra[p].chooser[extra[p].pick].src_avail ) 
   package[p].srcaction ^= (SRCACTION_NO^SRCACTION_YES);
     }
 
@@ -761,11 +760,12 @@ get_package_version(int p , int trust)
 static void
 scan2 (char *path, unsigned int size)
 {
-  int i, t;
+  int i, t, c;
   if (strcmp(path+strlen(path)-7,".tar.gz") == 0)
     {
-    char mainpkg[_MAX_PATH],pkginfo[_MAX_PATH], *ver, *verinfo;
+    char mainpkg[_MAX_PATH],pkginfo[_MAX_PATH],tarpkg[_MAX_PATH],*ver,*verinfo;
     strcpy (mainpkg,path);
+    strcpy (tarpkg,path);
     mainpkg[strlen(mainpkg)-7] = 0; /* strip off the tar.gz */
     for (ver=mainpkg; *ver; ver++)
       if ((*ver == '-' || *ver == '_') && isdigit(ver[1]))
@@ -796,31 +796,65 @@ scan2 (char *path, unsigned int size)
       if (strcmp(pkginfo,mainpkg) == 0 )
         {
         for (t=0; t<NTRUST; t++) 
-          if (package[i].info[t].install && 
-              strcmp (base (package[i].info[t].install), base (path)) == 0)
+          if ((package[i].info[t].install && 
+              strcmp (base (package[i].info[t].install), base (path)) == 0) ||
+        (package[i].info[t].source &&
+              strcmp (base (package[i].info[t].source), base (path)) == 0 )) 
       {
-              package[i].info[t].install_exists=1;
+              if (strcmp (base (package[i].info[t].install), base (path)) == 0)
+      package[i].info[t].install_exists=1;
+        else package[i].info[t].source_exists=1;
               break;
       }
           else if (t>=NTRUST-1)
             if (!package[i].info[TRUST_CURR].install)
               {
                 package[i].info[TRUST_CURR].version = 0;
-                package[i].info[TRUST_CURR].install = strdup(path);
-                package[i].info[TRUST_CURR].install_size = size;
-                package[i].info[TRUST_CURR].install_exists=1;
-                if (package[i].info[TRUST_CURR].version == 0) 
-            get_package_version(i,TRUST_CURR);
+                if (strcmp(path+strlen(path)-11 , "-src.tar.gz") == 0)
+                  {
+                    for (c=0 ; c<8 ;c ++ )
+            tarpkg[(strlen(tarpkg)-11)+c]=tarpkg[(strlen(tarpkg)-7)+c];
+          package[i].info[TRUST_CURR].install = strdup(tarpkg);
+          if (!package[i].info[TRUST_CURR].source )
+            package[i].info[TRUST_CURR].source = strdup(path);
+          package[i].info[TRUST_CURR].source_size = size;
+                    package[i].info[TRUST_CURR].source_exists=1;
+                    if (package[i].info[TRUST_CURR].version == 0) 
+                get_package_version(i,TRUST_CURR);
+        }
+      else
+        {
+          package[i].info[TRUST_CURR].install = strdup(path);
+          package[i].info[TRUST_CURR].install_size = size;
+                    package[i].info[TRUST_CURR].install_exists=1;
+                    if (package[i].info[TRUST_CURR].version == 0) 
+                get_package_version(i,TRUST_CURR);
+        }
                 break;
               }
             else if (!package[i].info[TRUST_PREV].install )
               {
                 package[i].info[TRUST_PREV].version = 0;
-                package[i].info[TRUST_PREV].install = strdup(path);
-                package[i].info[TRUST_PREV].install_size = size;
-                package[i].info[TRUST_PREV].install_exists=1;
-                if (package[i].info[TRUST_PREV].version == 0) 
-            get_package_version(i,TRUST_PREV);
+                if (strcmp(path+strlen(path)-11 , "-src.tar.gz") == 0)
+                  {
+                    for (c=0 ; c<8 ;c ++ )
+             tarpkg[(strlen(tarpkg)-11)+c]=tarpkg[(strlen(tarpkg)-7)+c];
+          package[i].info[TRUST_PREV].install = strdup(tarpkg);
+          if (!package[i].info[TRUST_PREV].source )
+            package[i].info[TRUST_PREV].source = strdup(path);
+          package[i].info[TRUST_PREV].source_size = size;
+                    package[i].info[TRUST_PREV].source_exists=1;
+                    if (package[i].info[TRUST_PREV].version == 0) 
+                get_package_version(i,TRUST_PREV);
+        }
+      else
+        {
+          package[i].info[TRUST_PREV].install = strdup(path);
+          package[i].info[TRUST_PREV].install_size = size;
+                    package[i].info[TRUST_PREV].install_exists=1;
+                    if (package[i].info[TRUST_PREV].version == 0) 
+                get_package_version(i,TRUST_PREV);
+        }
                 break;
               }
         break;
Index: winsup/cinstall/nio-file.cc
===================================================================
RCS file: /cvs/src/src/winsup/cinstall/nio-file.cc,v
retrieving revision 2.0
diff -u -p -r2.0 nio-file.cc
--- nio-file.cc    2000/08/08 00:27:54 2.0
+++ nio-file.cc    2001/03/17 04:13:10
@@ -28,6 +28,8 @@ static char *cvsid = "\n%%% $Id: nio-fil
 #include "resource.h"
 #include "msg.h"
 
+extern DWORD get_file_size (char *);
+
 NetIO_File::NetIO_File (char *Purl)
   : NetIO (Purl)
 {
@@ -35,8 +37,7 @@ NetIO_File::NetIO_File (char *Purl)
   fd = fopen (path, "rb");
   if (fd)
     {
-      stat (path, &s);
-      file_size = s.st_size;
+      file_size = get_file_size(path);
     }
   else
     {



