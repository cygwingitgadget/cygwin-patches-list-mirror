Return-Path: <cygwin-patches-return-3788-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7594 invoked by alias); 5 Apr 2003 00:51:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7584 invoked from network); 5 Apr 2003 00:51:50 -0000
Message-Id: <3.0.5.32.20030404195241.007f4a40@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com (Unverified)
Date: Sat, 05 Apr 2003 00:51:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: mkpasswd and mkgroup
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1049521961==_"
X-SW-Source: 2003-q2/txt/msg00015.txt.bz2

--=====================_1049521961==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 1009

Corinna,

Following remarks made on the list this patch
- allows to specify several domains at once with -d
- only prints SYSTEM and specials when the -l switch is given
- prints all uids and gids as unsigned
- limits the uid values to < 1000 on Win9x (for lastlog)

mkpasswd had a pesky bug where memory was freed twice without 
netapibufferfree complaining, but subsequent net calls failed.

Pierre

2003-04-05  Pierre Humblet  <pierre.humblet@ieee.org>

	* mkpasswd.c (current_user): print uid and gid as unsigned.
	(enum_users): Ditto. Do not free servername.
	(usage): Update to allow several domains and improve -p.
	(main): On Win9x limit uids to 1000. Only print specials
	when -l is specified. Add a loop to allow several domains
	and free servername in the loop.
	* mkgroup.c (enum_groups): Do not free servername.
	(usage): Update to allow several domains. Change uid to gid.
	(main): Only print specials when -l is specified. Add a 
	loop to allow several domains and free servername in the loop.

--=====================_1049521961==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="pwdgrp.diff"
Content-length: 10217

Index: mkpasswd.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/utils/mkpasswd.c,v
retrieving revision 1.29
diff -u -p -r1.29 mkpasswd.c
--- mkpasswd.c	1 Mar 2003 16:38:26 -0000	1.29
+++ mkpasswd.c	4 Apr 2003 01:44:53 -0000
@@ -199,7 +199,7 @@ current_user (int print_sids, int print_
       strlcat (homedir_psx, envname, sizeof (homedir_psx));
     }

-  printf ("%s:unused_by_nt/2000/xp:%d:%d:%s%s%s%s%s%s%s%s:%s:/bin/bash\n",
+  printf ("%s:unused_by_nt/2000/xp:%u:%u:%s%s%s%s%s%s%s%s:%s:/bin/bash\n",
 	  envname,
 	  uid + id_offset,
 	  gid + id_offset,
@@ -331,7 +331,7 @@ enum_users (LPWSTR servername, int print
 		    }
 		}
 	    }
-	  printf ("%s:unused_by_nt/2000/xp:%d:%d:%s%s%s%s%s%s%s%s:%s:/bin/bash\n",
+	  printf ("%s:unused_by_nt/2000/xp:%u:%u:%s%s%s%s%s%s%s%s:%s:/bin/bash\n",
 	  	  username,
 		  uid + id_offset,
 		  gid + id_offset,
@@ -351,9 +351,6 @@ enum_users (LPWSTR servername, int print
     }
   while (rc =3D=3D ERROR_MORE_DATA);

-  if (servername)
-    netapibufferfree (servername);
-
   return 0;
 }

@@ -487,14 +484,14 @@ print_special (int print_sids,
 int
 usage (FILE * stream, int isNT)
 {
-  fprintf (stream, "Usage: mkpasswd [OPTION]... [domain]\n\n"
+  fprintf (stream, "Usage: mkpasswd [OPTION]... [domain]...\n\n"
 	           "This program prints a /etc/passwd file to stdout\n\n"
 	           "Options:\n");
   if (isNT)
     fprintf (stream, "   -l,--local              print local user accounts=
\n"
 	             "   -c,--current            print current account, if a doma=
in account\n"
                      "   -d,--domain             print domain accounts (fr=
om current domain\n"
-                     "                           if no domain specified)\n"
+                     "                           if no domains specified)\=
n"
                      "   -o,--id-offset offset   change the default offset=
 (10000) added to uids\n"
                      "                           in domain accounts.\n"
                      "   -g,--local-groups       print local group informa=
tion too\n"
@@ -502,7 +499,7 @@ usage (FILE * stream, int isNT)
                      "   -m,--no-mount           don't use mount points fo=
r home dir\n"
                      "   -s,--no-sids            don't print SIDs in GCOS =
field\n"
 	             "                           (this affects ntsec)\n");
-  fprintf (stream, "   -p,--path-to-home path  use specified path instead =
of user account home dir\n"
+  fprintf (stream, "   -p,--path-to-home path  use specified path and not =
user account home dir or /home\n"
                    "   -u,--username username  only return information for=
 the specified user\n"
                    "   -h,--help               displays this message\n"
 	           "   -v,--version            version information and exit\n\n");
@@ -649,7 +646,7 @@ main (int argc, char **argv)
 	  unsigned long uid =3D 0, i;
 	  for (i =3D 0; disp_username[i]; i++)
 	    uid +=3D toupper (disp_username[i]) << ((6 * i) % 25);
-	  uid =3D (uid % (65535 - DOMAIN_USER_RID_ADMIN - 1))
+	  uid =3D (uid % (1000 - DOMAIN_USER_RID_ADMIN - 1))
 	    + DOMAIN_USER_RID_ADMIN + 1;

 	  printf ("%s:use_crypt:%lu:%lu:%s:%s%s:/bin/bash\n",
@@ -675,7 +672,6 @@ main (int argc, char **argv)
 		   "when `-d' is given.\n", argv[0]);
 	  return 1;
 	}
-      mbstowcs (domain_name, argv[optind], (strlen (argv[optind]) + 1));
       domain_name_specified =3D 1;
     }
   if (!load_netapi ())
@@ -686,57 +682,62 @@ main (int argc, char **argv)

   if (disp_username =3D=3D NULL)
     {
+      if (print_local)
+        {
 #if 0
-      /*
-       * Get `Everyone' group
-      */
-      print_special (print_sids, &sid_world_auth, 1, SECURITY_WORLD_RID,
-		     0, 0, 0, 0, 0, 0, 0);
+	  /*
+	   * Get `Everyone' group
+	   */
+	  print_special (print_sids, &sid_world_auth, 1, SECURITY_WORLD_RID,
+			 0, 0, 0, 0, 0, 0, 0);
 #endif
-      /*
-       * Get `system' group
-      */
-      print_special (print_sids, &sid_nt_auth, 1, SECURITY_LOCAL_SYSTEM_RI=
D,
-		     0, 0, 0, 0, 0, 0, 0);
-      /*
-       * Get `administrators' group
-      */
-      if (!print_local_groups)
-	print_special (print_sids, &sid_nt_auth, 2, SECURITY_BUILTIN_DOMAIN_RID,
-		       DOMAIN_ALIAS_RID_ADMINS, 0, 0, 0, 0, 0, 0);
-
+	  /*
+	   * Get `system' group
+	   */
+	  print_special (print_sids, &sid_nt_auth, 1, SECURITY_LOCAL_SYSTEM_RID,
+			 0, 0, 0, 0, 0, 0, 0);
+	  /*
+	   * Get `administrators' group
+	   */
+	  if (!print_local_groups)
+	    print_special (print_sids, &sid_nt_auth, 2, SECURITY_BUILTIN_DOMAIN_R=
ID,
+			   DOMAIN_ALIAS_RID_ADMINS, 0, 0, 0, 0, 0, 0);
+	}
       if (print_local_groups)
 	enum_local_groups (print_sids);
     }

-  if (print_domain)
-    {
-      if (domain_name_specified)
-	rc =3D netgetdcname (NULL, domain_name, (LPBYTE *) & servername);
-
-      else
-	rc =3D netgetdcname (NULL, NULL, (LPBYTE *) & servername);
-
-      if (rc !=3D ERROR_SUCCESS)
-	{
-	  print_win_error(rc);
-	  return 1;
-	}
-
-      enum_users (servername, print_sids, print_cygpath, passed_home_path,
-		  id_offset, disp_username);
-    }
-
   if (print_local)
     enum_users (NULL, print_sids, print_cygpath, passed_home_path, 0,
     		disp_username);

+  i =3D 1;
+  if (print_domain)
+    do
+      {
+	if (domain_name_specified)
+	  {
+	    mbstowcs (domain_name, argv[optind], (strlen (argv[optind]) + 1));
+	    rc =3D netgetdcname (NULL, domain_name, (LPBYTE *) & servername);
+	  }
+	else
+	  rc =3D netgetdcname (NULL, NULL, (LPBYTE *) & servername);
+
+	if (rc !=3D ERROR_SUCCESS)
+	  {
+	    print_win_error(rc);
+	    return 1;
+	  }
+
+	enum_users (servername, print_sids, print_cygpath, passed_home_path,
+		    id_offset * i++, disp_username);
+	netapibufferfree (servername);
+      }
+    while (++optind < argc);
+
   if (print_current && !print_domain)
     current_user(print_sids, print_cygpath, passed_home_path,
 		 id_offset, disp_username);
-
-  if (servername)
-    netapibufferfree (servername);

   return 0;
 }
Index: mkgroup.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/utils/mkgroup.c,v
retrieving revision 1.20
diff -u -p -r1.20 mkgroup.c
--- mkgroup.c	1 Mar 2003 16:38:26 -0000	1.20
+++ mkgroup.c	4 Apr 2003 01:45:02 -0000
@@ -372,9 +372,6 @@ enum_groups (LPWSTR servername, int prin

     }
   while (rc =3D=3D ERROR_MORE_DATA);
-
-  if (servername)
-    netapibufferfree (servername);
 }

 void
@@ -484,16 +481,15 @@ current_group (int print_sids, int print
 int
 usage (FILE * stream, int isNT)
 {
-  fprintf (stream, "Usage: mkgroup [OPTION]... [domain]\n\n"
+  fprintf (stream, "Usage: mkgroup [OPTION]... [domain]...\n\n"
 	           "This program prints a /etc/group file to stdout\n\n"
 	           "Options:\n");
   if (isNT)
     fprintf (stream, "   -l,--local             print local group informat=
ion\n"
 	             "   -c,--current           print current group, if a domain =
account\n"
-		     "   -d,--domain            print global group information from the =
domain\n"
-		     "                          specified (or from the current domain if=
 there is\n"
-		     "                          no domain specified)\n"
-		     "   -o,--id-offset offset  change the default offset (10000) added =
to uids\n"
+		     "   -d,--domain            print global group information (from cur=
rent\n"
+	             "                          domain if no domains specified)\n"
+		     "   -o,--id-offset offset  change the default offset (10000) added =
to gids\n"
 		     "                          in domain accounts.\n"
 		     "   -s,--no-sids           don't print SIDs in pwd field\n"
 		     "                          (this affects ntsec)\n"
@@ -629,7 +625,6 @@ main (int argc, char **argv)
 		   "when `-d' is given.\n", argv[0]);
 	  return 1;
 	}
-      mbstowcs (domain_name, argv[optind], (strlen (argv[optind]) + 1));
       domain_specified =3D 1;
     }
   if (!load_netapi ())
@@ -639,22 +634,14 @@ main (int argc, char **argv)
       return 1;
     }

-#if 0
-  /*
-   * Get `Everyone' group
-  */
-  print_special (print_sids, &sid_world_auth, 1, SECURITY_WORLD_RID,
-			     0, 0, 0, 0, 0, 0, 0);
-#endif
-
-  /*
-   * Get `system' group
-  */
-  print_special (print_sids, &sid_nt_auth, 1, SECURITY_LOCAL_SYSTEM_RID,
-			     0, 0, 0, 0, 0, 0, 0);
   if (print_local)
     {
       /*
+       * Get `system' group
+       */
+      print_special (print_sids, &sid_nt_auth, 1, SECURITY_LOCAL_SYSTEM_RI=
D,
+		     0, 0, 0, 0, 0, 0, 0);
+      /*
        * Get `None' group
       */
       len =3D 256;
@@ -696,27 +683,32 @@ main (int argc, char **argv)
 				   0,
 				   0,
 				   0);
-    }
-
-  if (print_domain)
-    {
-      if (domain_specified)
-	rc =3D netgetdcname (NULL, domain_name, (LPBYTE *) & servername);
-
-      else
-	rc =3D netgetdcname (NULL, NULL, (LPBYTE *) & servername);
-
-      if (rc !=3D ERROR_SUCCESS)
-	{
-	  fprintf (stderr, "Cannot get PDC, code =3D %ld\n", rc);
-	  return 1;
-	}

-      enum_groups (servername, print_sids, print_users, id_offset);
+      enum_local_groups (print_sids, print_users);
     }

-  if (print_local)
-    enum_local_groups (print_sids, print_users);
+  i =3D 1;
+  if (print_domain)
+    do
+      {
+	if (domain_specified)
+          {
+	    mbstowcs (domain_name, argv[optind], (strlen (argv[optind]) + 1));
+	    rc =3D netgetdcname (NULL, domain_name, (LPBYTE *) & servername);
+	  }
+	else
+	  rc =3D netgetdcname (NULL, NULL, (LPBYTE *) & servername);
+
+	if (rc !=3D ERROR_SUCCESS)
+	  {
+	    fprintf (stderr, "Cannot get PDC, code =3D %ld\n", rc);
+	    return 1;
+	  }
+
+	enum_groups (servername, print_sids, print_users, id_offset * i++);
+	netapibufferfree (servername);
+      }
+    while (++optind < argc);

   if (print_current && !print_domain)
     current_group (print_sids, print_users, id_offset);

--=====================_1049521961==_--
