From: Kazuhiro Fujieda <fujieda@jaist.ac.jp>
To: cygwin-patches@cygwin.com
Subject: Re: uid and gid for domain accounts.
Date: Thu, 12 Apr 2001 13:20:00 -0000
Message-id: <s1slmp5q390.fsf@jaist.ac.jp>
References: <s1sofu2oyxc.fsf@jaist.ac.jp> <3AD5E2A6.A0B35CD1@yahoo.com>
X-SW-Source: 2001-q2/msg00043.html

>>> On Thu, 12 Apr 2001 13:15:18 -0400
>>> Earnie Boyd <earnie_boyd@yahoo.com> said:

> Sounds great, when can we expect the patches?

Just now.

2001-04-13  Kazuhiro Fujieda  <fujieda@jaist.ac.jp>

	* mkgroup.c (enum_groups): Use RID + offset specified an additional
	argument as ID.
	(usage): Add description of -o option.
	(longopts, opts): Add specifications of -o/--id-offset option.
	(main): Add -o option. Invoke enum_groups with specified offset.
	* mkpasswd.c (enum_users): Just like mkgroup.c.
	(usage, longopts, opts): Ditto.
	(main): Add -o option. Invoke enum_users with specified offset
	only against domain accounts.

Index: mkgroup.c
===================================================================
RCS file: /cvs/src/src/winsup/utils/mkgroup.c,v
retrieving revision 1.5
diff -u -p -r1.5 mkgroup.c
--- mkgroup.c	2001/04/11 09:38:55	1.5
+++ mkgroup.c	2001/04/12 19:57:41
@@ -187,7 +187,7 @@ enum_local_groups (int print_sids)
 }
 
 void
-enum_groups (LPWSTR servername, int print_sids)
+enum_groups (LPWSTR servername, int print_sids, int id_offset)
 {
   GROUP_INFO_2 *buffer;
   DWORD entriesread = 0;
@@ -273,7 +273,7 @@ enum_groups (LPWSTR servername, int prin
             }
 	  printf ("%s:%s:%d:\n", groupname,
                                  print_sids ? put_sid (psid) : "",
-                                 gid);
+                                 gid + id_offset);
 	}
 
       netapibufferfree (buffer);
@@ -291,13 +291,15 @@ usage ()
   fprintf (stderr, "Usage: mkgroup [OPTION]... [domain]\n\n");
   fprintf (stderr, "This program prints a /etc/group file to stdout\n\n");
   fprintf (stderr, "Options:\n");
-  fprintf (stderr, "   -l,--local           print local group information\n");
-  fprintf (stderr, "   -d,--domain          print global group information from the domain\n");
-  fprintf (stderr, "                        specified (or from the current domain if there is\n");
-  fprintf (stderr, "                        no domain specified)\n");
-  fprintf (stderr, "   -s,--no-sids         don't print SIDs in pwd field\n");
-  fprintf (stderr, "                         (this affects ntsec)\n");
-  fprintf (stderr, "   -?,--help            print this message\n\n");
+  fprintf (stderr, "   -l,--local             print local group information\n");
+  fprintf (stderr, "   -d,--domain            print global group information from the domain\n");
+  fprintf (stderr, "                          specified (or from the current domain if there is\n");
+  fprintf (stderr, "                          no domain specified)\n");
+  fprintf (stderr, "   -o,--id-offset offset  change the default offset (10000) added to uids\n");
+  fprintf (stderr, "                          in domain accounts.\n");
+  fprintf (stderr, "   -s,--no-sids           don't print SIDs in pwd field\n");
+  fprintf (stderr, "                          (this affects ntsec)\n");
+  fprintf (stderr, "   -?,--help              print this message\n\n");
   fprintf (stderr, "One of `-l' or `-d' must be given on NT/W2K.\n");
   return 1;
 }
@@ -305,12 +307,13 @@ usage ()
 struct option longopts[] = {
   {"local", no_argument, NULL, 'l'},
   {"domain", no_argument, NULL, 'd'},
+  {"id-offset", required_argument, NULL, 'o'},
   {"no-sids", no_argument, NULL, 's'},
   {"help", no_argument, NULL, 'h'},
   {0, no_argument, NULL, 0}
 };
 
-char opts[] = "ldsh";
+char opts[] = "ldo:sh";
 
 int
 main (int argc, char **argv)
@@ -322,6 +325,7 @@ main (int argc, char **argv)
   int print_domain = 0;
   int print_sids = 1;
   int domain_specified = 0;
+  int id_offset = 10000;
   int i;
 
   char name[256], dom[256];
@@ -343,6 +347,9 @@ main (int argc, char **argv)
 	    case 'd':
 	      print_domain = 1;
 	      break;
+	    case 'o':
+	      id_offset = strtol (optarg, NULL, 10);
+	      break;
 	    case 's':
 	      print_sids = 0;
 	      break;
@@ -464,7 +471,7 @@ main (int argc, char **argv)
 	  exit (1);
 	}
 
-      enum_groups (servername, print_sids);
+      enum_groups (servername, print_sids, id_offset);
     }
 
   if (print_local)
Index: mkpasswd.c
===================================================================
RCS file: /cvs/src/src/winsup/utils/mkpasswd.c,v
retrieving revision 1.8
diff -u -p -r1.8 mkpasswd.c
--- mkpasswd.c	2001/04/11 09:38:55	1.8
+++ mkpasswd.c	2001/04/12 19:57:41
@@ -102,7 +102,7 @@ uni2ansi (LPWSTR wcs, char *mbs, int siz
 
 int
 enum_users (LPWSTR servername, int print_sids, int print_cygpath,
-	    const char * passed_home_path)
+	    const char * passed_home_path, int id_offset)
 {
   USER_INFO_3 *buffer;
   DWORD entriesread = 0;
@@ -205,7 +205,9 @@ enum_users (LPWSTR servername, int print
 		    }
 		}
 	    }
-	  printf ("%s::%d:%d:%s%s%s:%s:/bin/sh\n", username, uid, gid,
+	  printf ("%s::%d:%d:%s%s%s:%s:/bin/sh\n", username,
+		  uid + id_offset,
+		  gid + id_offset,
 		  fullname,
 		  print_sids ? "," : "",
 		  print_sids ? put_sid (psid) : "",
@@ -318,6 +320,8 @@ usage ()
   fprintf (stderr, "   -l,--local              print local user accounts\n");
   fprintf (stderr, "   -d,--domain             print domain accounts (from current domain\n");
   fprintf (stderr, "                           if no domain specified)\n");
+  fprintf (stderr, "   -o,--id-offset offset   change the default offset (10000) added to uids\n");
+  fprintf (stderr, "                           in domain accounts.\n");
   fprintf (stderr, "   -g,--local-groups       print local group information too\n");
   fprintf (stderr, "                           if no domain specified\n");
   fprintf (stderr, "   -m,--no-mount           don't use mount points for home dir\n");
@@ -333,6 +337,7 @@ usage ()
 struct option longopts[] = {
   {"local", no_argument, NULL, 'l'},
   {"domain", no_argument, NULL, 'd'},
+  {"id-offset", required_argument, NULL, 'o'},
   {"local-groups", no_argument, NULL, 'g'},
   {"no-mount", no_argument, NULL, 'm'},
   {"no-sids", no_argument, NULL, 's'},
@@ -341,7 +346,7 @@ struct option longopts[] = {
   {0, no_argument, NULL, 0}
 };
 
-char opts[] = "ldgsmhp:";
+char opts[] = "ldo:gsmhp:";
 
 int
 main (int argc, char **argv)
@@ -355,6 +360,7 @@ main (int argc, char **argv)
   int domain_name_specified = 0;
   int print_sids = 1;
   int print_cygpath = 1;
+  int id_offset = 10000;
   int i;
 
   char name[256], dom[256], passed_home_path[MAX_PATH];
@@ -378,6 +384,9 @@ main (int argc, char **argv)
 	    case 'd':
 	      print_domain = 1;
 	      break;
+	    case 'o':
+	      id_offset = strtol (optarg, NULL, 10);
+	      break;
 	    case 'g':
 	      print_local_groups = 1;
 	      break;
@@ -522,11 +531,11 @@ main (int argc, char **argv)
 	  exit (1);
 	}
 
-      enum_users (servername, print_sids, print_cygpath, passed_home_path);
+      enum_users (servername, print_sids, print_cygpath, passed_home_path, id_offset);
     }
 
   if (print_local)
-    enum_users (NULL, print_sids, print_cygpath, passed_home_path);
+    enum_users (NULL, print_sids, print_cygpath, passed_home_path, 0);
 
   if (servername)
     netapibufferfree (servername);

____
  | AIST      Kazuhiro Fujieda <fujieda@jaist.ac.jp>
  | HOKURIKU  School of Information Science
o_/ 1990      Japan Advanced Institute of Science and Technology
