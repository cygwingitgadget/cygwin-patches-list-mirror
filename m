Return-Path: <cygwin-patches-return-1960-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 1247 invoked by alias); 9 Mar 2002 21:19:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1227 invoked from network); 9 Mar 2002 21:19:01 -0000
Message-ID: <20020309211901.71272.qmail@web20003.mail.yahoo.com>
Date: Sat, 09 Mar 2002 14:12:00 -0000
From: Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
Subject: getfacl.c help/version patch
To: cygwin-patches@cygwin.com
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1881427709-1015708741=:69203"
X-SW-Source: 2002-q1/txt/msg00317.txt.bz2

--0-1881427709-1015708741=:69203
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-length: 785

It would probably be good to have Corinna look at this one, too. 
I have been trying to verify that the utils in my build tree are
functioning identically (other than the help/version output) to the
ones in /bin/, but since I didn't write them there is always the
chance I missed a nuance.

2002-03-09  Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
* getfacl.c (usage) Standardize usage output. Change return type to static
void.
            Add exit point within function.
            (longopts) Added longopts for all options.
            (print_version) New function. 
            (main) Accommodate new help and version options. 


__________________________________________________
Do You Yahoo!?
Try FREE Yahoo! Mail - the world's greatest free email!
http://mail.yahoo.com/
--0-1881427709-1015708741=:69203
Content-Type: text/plain; name="getfacl.c-patch"
Content-Description: getfacl.c-patch
Content-Disposition: inline; filename="getfacl.c-patch"
Content-length: 5732

--- getfacl.c-orig	Sun Feb 24 13:28:27 2002
+++ getfacl.c	Sat Mar  9 15:05:05 2002
@@ -1,6 +1,6 @@
 /* getfacl.c
 
-   Copyright 2000, 2001 Red Hat Inc.
+   Copyright 2000, 2001, 2002 Red Hat Inc.
 
    Written by Corinna Vinschen <vinschen@redhat.com>
 
@@ -20,6 +20,9 @@ details. */
 #include <sys/stat.h>
 #include <string.h>
 
+static const char version[] = "$Revision: 1.13 $";
+static char *prog_name;
+
 char *
 permstr (mode_t perm)
 {
@@ -58,68 +61,86 @@ groupname (gid_t gid)
   return gbuf;
 }
 
-#define pn(txt)	fprintf (fp, txt "\n", name)
-#define p(txt)	fprintf (fp, txt "\n")
-
-int
-usage (const char *name, int help)
+static void
+usage (FILE * stream, int status)
 {
-  FILE *fp = help ? stdout : stderr;
-
-  pn ("usage: %s [-adn] file...");
-  if (!help)
-    pn ("Try `%s --help' for more information.");
-  else
-    {
-      p ("");
-      p ("Display file and directory access control lists (ACLs).");
-      p ("");
-      p ("For each argument that is a regular file, special file or");
-      p ("directory, getfacl displays the owner, the group, and the ACL.");
-      p ("For directories getfacl displays additionally the default ACL.");
-      p ("");
-      p ("With no options specified, getfacl displays the filename, the");
-      p ("owner, the group, and both the ACL and the default ACL, if it");
-      p ("exists.");
-      p ("");
-      p ("The following options are supported:");
-      p ("");
-      p ("-a   Display the filename, the owner, the group, and the ACL");
-      p ("     of the file.");
-      p ("");
-      p ("-d   Display the filename, the owner, the group, and the default");
-      p ("     ACL of the directory, if it exists.");
-      p ("");
-      p ("-n   Display user and group IDs instead of names.");
-      p ("");
-      p ("The format for ACL output is as follows:");
-      p ("     # file: filename");
-      p ("     # owner: name or uid");
-      p ("     # group: name or uid");
-      p ("     user::perm");
-      p ("     user:name or uid:perm");
-      p ("     group::perm");
-      p ("     group:name or gid:perm");
-      p ("     mask:perm");
-      p ("     other:perm");
-      p ("     default:user::perm");
-      p ("     default:user:name or uid:perm");
-      p ("     default:group::perm");
-      p ("     default:group:name or gid:perm");
-      p ("     default:mask:perm");
-      p ("     default:other:perm");
-      p ("");
-      p ("When multiple files are specified on the command line, a blank");
-      p ("line separates the ACLs for each file.");
-    }
-  return 1;
+  fprintf (stream, "usage: %s [-adn] FILE...\n", prog_name);
+  if (status)
+    fprintf (stream, "Try `%s --help' for more information.\n", prog_name);
+  else 
+    fprintf (stream, "\
+Display file and directory access control lists (ACLs).\n\
+\n\
+For each argument that is a regular file, special file or\n\
+directory, getfacl displays the owner, the group, and the ACL.\n\
+For directories getfacl displays additionally the default ACL.\n\
+\n\
+With no options specified, getfacl displays the filename, the\n\
+owner, the group, and both the ACL and the default ACL, if it\n\
+exists.\n\
+\n\
+The following options are supported:\n\
+\n\
+-a, --all      Display the filename, the owner, the group, and the ACL\n\
+               of the file.\n\
+-d, --dir      Display the filename, the owner, the group, and the default\n\
+               ACL of the directory, if it exists.\n\
+-n, --noname   Display user and group IDs instead of names.\n\
+\n\
+The format for ACL output is as follows:\n\
+     # file: filename\n\
+     # owner: name or uid\n\
+     # group: name or uid\n\
+     user::perm\n\
+     user:name or uid:perm\n\
+     group::perm\n\
+     group:name or gid:perm\n\
+     mask:perm\n\
+     other:perm\n\
+     default:user::perm\n\
+     default:user:name or uid:perm\n\
+     default:group::perm\n\
+     default:group:name or gid:perm\n\
+     default:mask:perm\n\
+     default:other:perm\n\
+\n\
+When multiple files are specified on the command line, a blank\n\
+line separates the ACLs for each file.\n\
+", prog_name);
+  exit (status);
 }
 
 struct option longopts[] = {
+  {"all", no_argument, NULL, 'a'},
+  {"dir", no_argument, NULL, 'd'},
+  {"noname", no_argument, NULL, 'n'},
   {"help", no_argument, NULL, 'h'},
+  {"version", no_argument, NULL, 'v'},
   {0, no_argument, NULL, 0}
 };
 
+static void
+print_version ()
+{
+  const char *v = strchr (version, ':');
+  int len;
+  if (!v)
+    {
+      v = "?";
+      len = 1;
+    }
+  else
+    {
+      v += 2;
+      len = strchr (v, ' ') - v;
+    }
+  printf ("\
+getfacl (cygwin) %.*s\n\
+ACL Utility\n\
+Copyright 2000, 2001, 2002 Red Hat, Inc.\n\
+Compiled on %s", len, v, __DATE__);
+}
+
 int
 main (int argc, char **argv)
 {
@@ -132,7 +153,15 @@ main (int argc, char **argv)
   struct stat st;
   aclent_t acls[MAX_ACL_ENTRIES];
 
-  while ((c = getopt_long (argc, argv, "adn", longopts, NULL)) != EOF)
+  prog_name = strrchr (argv[0], '/');
+  if (prog_name == NULL)
+    prog_name = strrchr (argv[0], '\\');
+  if (prog_name == NULL)
+    prog_name = argv[0];
+  else
+    prog_name++;
+
+  while ((c = getopt_long (argc, argv, "adhnv", longopts, NULL)) != EOF)
     switch (c)
       {
       case 'a':
@@ -145,12 +174,15 @@ main (int argc, char **argv)
 	nopt = 1;
 	break;
       case 'h':
-        return usage (argv[0], 1);
+        usage (stdout, 0);
+      case 'v':
+        print_version ();
+        exit (0);
       default:
-	return usage (argv[0], 0);
+	usage (stderr, 1);
       }
   if (optind > argc - 1)
-    return usage (argv[0], 0);
+    usage (stderr, 1);
   while ((c = optind++) < argc)
     {
       if (stat (argv[c], &st))

--0-1881427709-1015708741=:69203--
