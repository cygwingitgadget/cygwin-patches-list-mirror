Return-Path: <cygwin-patches-return-3356-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27554 invoked by alias); 8 Jan 2003 01:27:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27545 invoked from network); 8 Jan 2003 01:27:38 -0000
Message-Id: <3.0.5.32.20030107202647.00852a30@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Wed, 08 Jan 2003 01:27:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: mk{passwd, group}
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1042007207==_"
X-SW-Source: 2003-q1/txt/msg00005.txt.bz2

--=====================_1042007207==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 718

Corinna,

this patch 
- allows the --help, --version and a few others to work on Win95/98/ME
- implements the -c switch for possible use in postinstall scripts


Pierre

2003-01-07  Pierre Humblet <pierre.humblet@ieee.org>

	* mkpasswd.cc (current_user): Create.
	(usage): Reorganize to support Win95/98/ME.
	(main): Add option for -c. Reorganize to parse options for 
	Win95/98/ME and to call current_user. Add username in gecos field
	on Win95/98/ME.
	* mkgroup.cc (enum_groups): Print gid with %u.
	(print_win_error): Create from passwd.cc.
	(current_group): Create.
	(usage): Reorganize to support Win95/98/ME.
	(main): Add option for -c. Reorganize to parse options for 
	Win95/98/ME and to call current_group. 
	
--=====================_1042007207==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="mk.diff"
Content-length: 20603

Index: mkpasswd.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/utils/mkpasswd.c,v
retrieving revision 1.26
diff -u -p -r1.26 mkpasswd.c
--- mkpasswd.c	25 Nov 2002 15:12:50 -0000	1.26
+++ mkpasswd.c	8 Jan 2003 00:49:50 -0000
@@ -21,6 +21,7 @@
 #include <lmapibuf.h>
 #include <sys/fcntl.h>
 #include <lmerr.h>
+#include <lmcons.h>

 static const char version[] =3D "$Revision: 1.20 $";

@@ -125,6 +126,94 @@ print_win_error(DWORD code)
     fprintf (stderr, "mkpasswd: error %lu", code);
 }

+void
+current_user (int print_sids, int print_cygpath,
+	      const char * passed_home_path, int id_offset, const char * disp_use=
rname)
+{
+  char name[UNLEN + 1], *envname, *envdomain;
+  DWORD len;
+  HANDLE ptok;
+  int errpos =3D 0;
+  struct {
+    PSID psid;
+    int buffer[10];
+  } tu, tg;
+
+
+  if ((!GetUserName (name, (len =3D sizeof (name), &len)) && (errpos =3D _=
_LINE__))
+      || !name[0]
+      || !(envname =3D getenv("USERNAME"))
+      || strcasecmp (envname, name)
+      || (disp_username && strcasecmp(envname, disp_username))
+      || (!GetComputerName (name, (len =3D sizeof (name), &len))
+	  && (errpos =3D __LINE__))
+      || !(envdomain =3D getenv("USERDOMAIN"))
+      || !envdomain[0]
+      || !strcasecmp (envdomain, name)
+      || (!OpenProcessToken (GetCurrentProcess (), TOKEN_QUERY, &ptok)
+	  && (errpos =3D __LINE__))
+      || (!GetTokenInformation (ptok, TokenUser, &tu, sizeof tu, &len)
+	  && (errpos =3D __LINE__))
+      || (!GetTokenInformation (ptok, TokenPrimaryGroup, &tg, sizeof tg, &=
len)
+	  && (errpos =3D __LINE__))
+      || (!CloseHandle (ptok) && (errpos =3D __LINE__)))
+    {
+      if (errpos)
+	{
+	  print_win_error (GetLastError ());
+	  fprintf(stderr, " on line %d\n", errpos);
+	}
+      return;
+    }
+
+  int uid =3D *GetSidSubAuthority (tu.psid, *GetSidSubAuthorityCount(tu.ps=
id) - 1);
+  int gid =3D *GetSidSubAuthority (tg.psid, *GetSidSubAuthorityCount(tg.ps=
id) - 1);
+  char homedir_psx[MAX_PATH] =3D {0}, homedir_w32[MAX_PATH] =3D {0};
+
+  char *envhomedrive =3D getenv ("HOMEDRIVE");
+  char *envhomepath =3D getenv ("HOMEPATH");
+
+  if (passed_home_path[0] =3D=3D '\0')
+    {
+      if (envhomepath && envhomepath[0])
+        {
+	  if (envhomedrive)
+	    strlcpy (homedir_w32, envhomedrive, sizeof (homedir_w32));
+	  if (envhomepath[0] !=3D '\\')
+	    strlcat (homedir_w32, "\\", sizeof (homedir_w32));
+	  strlcat (homedir_w32, envhomepath, sizeof (homedir_w32));
+	  if (print_cygpath)
+	    cygwin_conv_to_posix_path (homedir_w32, homedir_psx);
+	  else
+	    psx_dir (homedir_w32, homedir_psx);
+	}
+      else
+        {
+	  strlcpy (homedir_psx, "/home/", sizeof (homedir_psx));
+	  strlcat (homedir_psx, envname, sizeof (homedir_psx));
+	}
+    }
+  else
+    {
+      strlcpy (homedir_psx, passed_home_path, sizeof (homedir_psx));
+      strlcat (homedir_psx, envname, sizeof (homedir_psx));
+    }
+
+  printf ("%s:unused_by_nt/2000/xp:%d:%d:%s%s%s%s%s%s%s%s:%s:/bin/bash\n",
+	  envname,
+	  uid + id_offset,
+	  gid + id_offset,
+	  envname,
+	  print_sids ? "," : "",
+	  print_sids ? "U-" : "",
+	  print_sids ? envdomain : "",
+	  print_sids ? "\\" : "",
+	  print_sids ? envname : "",
+	  print_sids ? "," : "",
+	  print_sids ? put_sid (tu.psid) : "",
+	  homedir_psx);
+}
+
 int
 enum_users (LPWSTR servername, int print_sids, int print_cygpath,
 	    const char * passed_home_path, int id_offset, char *disp_username)
@@ -396,31 +485,35 @@ print_special (int print_sids,
 }

 int
-usage (FILE * stream, int status)
+usage (FILE * stream, int isNT)
 {
   fprintf (stream, "Usage: mkpasswd [OPTION]... [domain]\n\n"
-                   "This program prints a /etc/passwd file to stdout\n\n"
-                   "Options:\n"
-                   "   -l,--local              print local user accounts\n"
-                   "   -d,--domain             print domain accounts (from=
 current domain\n"
-                   "                           if no domain specified)\n"
-                   "   -o,--id-offset offset   change the default offset (=
10000) added to uids\n"
-                   "                           in domain accounts.\n"
-                   "   -g,--local-groups       print local group informati=
on too\n"
-                   "                           if no domain specified\n"
-                   "   -m,--no-mount           don't use mount points for =
home dir\n"
-                   "   -s,--no-sids            don't print SIDs in GCOS fi=
eld\n"
-                   "                           (this affects ntsec)\n"
-                   "   -p,--path-to-home path  use specified path instead =
of user account home dir\n"
+	           "This program prints a /etc/passwd file to stdout\n\n"
+	           "Options:\n");
+  if (isNT)
+    fprintf (stream, "   -l,--local              print local user accounts=
\n"
+	             "   -c,--current            print current account, if a doma=
in account\n"
+                     "   -d,--domain             print domain accounts (fr=
om current domain\n"
+                     "                           if no domain specified)\n"
+                     "   -o,--id-offset offset   change the default offset=
 (10000) added to uids\n"
+                     "                           in domain accounts.\n"
+                     "   -g,--local-groups       print local group informa=
tion too\n"
+                     "                           if no domain specified\n"
+                     "   -m,--no-mount           don't use mount points fo=
r home dir\n"
+                     "   -s,--no-sids            don't print SIDs in GCOS =
field\n"
+	             "                           (this affects ntsec)\n");
+  fprintf (stream, "   -p,--path-to-home path  use specified path instead =
of user account home dir\n"
                    "   -u,--username username  only return information for=
 the specified user\n"
                    "   -h,--help               displays this message\n"
-                   "   -v,--version            version information and exi=
t\n\n"
-                   "One of `-l', `-d' or `-g' must be given on NT/W2K.\n");
-  return status;
+	           "   -v,--version            version information and exit\n\n");
+  if (isNT)
+    fprintf (stream, "One of `-l', `-d' or `-g' must be given.\n");
+  return 1;
 }

 struct option longopts[] =3D {
   {"local", no_argument, NULL, 'l'},
+  {"current", no_argument, NULL, 'c'},
   {"domain", no_argument, NULL, 'd'},
   {"id-offset", required_argument, NULL, 'o'},
   {"local-groups", no_argument, NULL, 'g'},
@@ -433,7 +526,7 @@ struct option longopts[] =3D {
   {0, no_argument, NULL, 0}
 };

-char opts[] =3D "ldo:gsmhp:u:v";
+char opts[] =3D "lcdo:gsmhp:u:v";

 static void
 print_version ()
@@ -465,6 +558,7 @@ main (int argc, char **argv)
   DWORD rc =3D ERROR_SUCCESS;
   WCHAR domain_name[200];
   int print_local =3D 0;
+  int print_current =3D 0;
   int print_domain =3D 0;
   int print_local_groups =3D 0;
   int domain_name_specified =3D 0;
@@ -472,103 +566,108 @@ main (int argc, char **argv)
   int print_cygpath =3D 1;
   int id_offset =3D 10000;
   int i;
+  int isNT;
   char *disp_username =3D NULL;
-
   char name[256], passed_home_path[MAX_PATH];
   DWORD len;

+  isNT =3D (GetVersion () < 0x80000000);
   passed_home_path[0] =3D '\0';
   if (!isatty (1))
     setmode (1, O_BINARY);

-  if (GetVersion () < 0x80000000)
+  if (isNT && argc =3D=3D 1)
+    return usage (stderr, isNT);
+  else
     {
-      if (argc =3D=3D 1)
-	return usage (stderr, 1);
-      else
-	{
-	  while ((i =3D getopt_long (argc, argv, opts, longopts, NULL)) !=3D EOF)
-	    switch (i)
-	      {
-	      case 'l':
-		print_local =3D 1;
-		break;
-	      case 'd':
-		print_domain =3D 1;
-		break;
-	      case 'o':
-		id_offset =3D strtol (optarg, NULL, 10);
-		break;
-	      case 'g':
-		print_local_groups =3D 1;
-		break;
-	      case 's':
-		print_sids =3D 0;
-		break;
-	      case 'm':
-		print_cygpath =3D 0;
-		break;
-	      case 'p':
-		if (optarg[0] !=3D '/')
-		  {
-		    fprintf (stderr, "%s: `%s' is not a fully qualified path.\n",
-			     argv[0], optarg);
-		    return 1;
-		  }
-		strcpy (passed_home_path, optarg);
-		if (optarg[strlen (optarg)-1] !=3D '/')
-		  strcat (passed_home_path, "/");
-		break;
-	      case 'u':
-		disp_username =3D optarg;
-		break;
-	      case 'h':
-		return usage (stdout, 0);
-	      case 'v':
-               print_version ();
-		return 0;
-	      default:
-		fprintf (stderr, "Try `%s --help' for more information.\n", argv[0]);
-		return 1;
-	      }
-	  if (!print_local && !print_domain && !print_local_groups)
+      while ((i =3D getopt_long (argc, argv, opts, longopts, NULL)) !=3D E=
OF)
+	switch (i)
+	  {
+	  case 'l':
+	    print_local =3D 1;
+	    break;
+	  case 'c':
+	    print_current =3D 1;
+	    break;
+	  case 'd':
+	    print_domain =3D 1;
+	    break;
+	  case 'o':
+	    id_offset =3D strtol (optarg, NULL, 10);
+	    break;
+	  case 'g':
+	    print_local_groups =3D 1;
+	    break;
+	  case 's':
+	    print_sids =3D 0;
+	    break;
+	  case 'm':
+	    print_cygpath =3D 0;
+	    break;
+	  case 'p':
+	    if (optarg[0] !=3D '/')
 	    {
-	      fprintf (stderr, "%s: Specify one of `-l', `-d' or `-g'\n", argv[0]=
);
+	      fprintf (stderr, "%s: `%s' is not a fully qualified path.\n",
+		       argv[0], optarg);
 	      return 1;
 	    }
-	  if (optind < argc)
-	    {
-	      if (!print_domain)
-		{
-		  fprintf (stderr, "%s: A domain name is only accepted "
-				   "when `-d' is given.\n", argv[0]);
-		  return 1;
-		}
-	      mbstowcs (domain_name, argv[optind], (strlen (argv[optind]) + 1));
-	      domain_name_specified =3D 1;
-	    }
+	    strcpy (passed_home_path, optarg);
+	    if (optarg[strlen (optarg)-1] !=3D '/')
+	      strcat (passed_home_path, "/");
+	    break;
+	  case 'u':
+	    disp_username =3D optarg;
+	    break;
+	  case 'h':
+	    usage (stdout, isNT);
+	    return 0;
+	  case 'v':
+	    print_version ();
+	    return 0;
+	  default:
+	    fprintf (stderr, "Try `%s --help' for more information.\n", argv[0]);
+	    return 1;
+	  }
+    }
+  if (!isNT)
+    {
+      /* This takes Windows 9x/ME into account. */
+      if (!disp_username)
+        {
+	  if (GetUserName (name, (len =3D 256, &len)))
+	    disp_username =3D name;
+	  else
+	    /* Same behaviour as in cygwin/shared.cc (memory_init). */
+	    disp_username =3D (char *) "unknown";
 	}
-    }
-
-  /* This takes Windows 9x/ME into account. */
-  if (GetVersion () >=3D 0x80000000)
-    {
-      /* Same behaviour as in cygwin/uinfo.cc (internal_getlogin). */
-      if (!GetUserName (name, (len =3D 256, &len)))
-	strcpy (name, "unknown");

       if (passed_home_path[0] =3D=3D '\0')
 	strcpy (passed_home_path, "/home/");

-      printf ("%s:*:%ld:%ld::%s%s:/bin/bash\n", name,
+      printf ("%s:*:%ld:%ld:%s:%s%s:/bin/bash\n", disp_username,
 					        DOMAIN_USER_RID_ADMIN,
 					        DOMAIN_ALIAS_RID_ADMINS,
+	                                        disp_username,
 					        passed_home_path,
-					        name);
-
+					        disp_username);
       return 0;
     }
-
+  if (!print_local && !print_domain && !print_local_groups)
+    {
+      fprintf (stderr, "%s: Specify one of `-l', `-d' or `-g'\n", argv[0]);
+      return 1;
+    }
+  if (optind < argc)
+    {
+      if (!print_domain)
+        {
+	  fprintf (stderr, "%s: A domain name is only accepted "
+		   "when `-d' is given.\n", argv[0]);
+	  return 1;
+	}
+      mbstowcs (domain_name, argv[optind], (strlen (argv[optind]) + 1));
+      domain_name_specified =3D 1;
+    }
   if (!load_netapi ())
     {
       print_win_error(GetLastError ());
@@ -621,6 +720,10 @@ main (int argc, char **argv)
   if (print_local)
     enum_users (NULL, print_sids, print_cygpath, passed_home_path, 0,
     		disp_username);
+
+  if (print_current && !print_domain)
+    current_user(print_sids, print_cygpath, passed_home_path,
+		 id_offset, disp_username);

   if (servername)
     netapibufferfree (servername);
Index: mkgroup.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/utils/mkgroup.c,v
retrieving revision 1.17
diff -u -p -r1.17 mkgroup.c
--- mkgroup.c	30 Sep 2002 03:01:17 -0000	1.17
+++ mkgroup.c	8 Jan 2003 00:50:58 -0000
@@ -360,7 +360,7 @@ enum_groups (LPWSTR servername, int prin
                     }
                 }
             }
-	  printf ("%s:%s:%d:", groupname,
+	  printf ("%s:%s:%u:", groupname,
                                print_sids ? put_sid (psid) : "",
                                gid + id_offset);
 	  if (print_users)
@@ -420,29 +420,95 @@ print_special (int print_sids,
     }
 }

+void
+print_win_error(DWORD code)
+{
+  char buf[4096];
+
+  if (FormatMessage (FORMAT_MESSAGE_FROM_SYSTEM
+      | FORMAT_MESSAGE_IGNORE_INSERTS,
+      NULL,
+      code,
+      MAKELANGID (LANG_NEUTRAL, SUBLANG_DEFAULT),
+      (LPTSTR) buf, sizeof (buf), NULL))
+    fprintf (stderr, "mkgroup: [%lu] %s", code, buf);
+  else
+    fprintf (stderr, "mkgroup: error %lu", code);
+}
+
+void
+current_group (int print_sids, int print_users, int id_offset)
+{
+  char name[UNLEN + 1], *envname, *envdomain;
+  DWORD len;
+  HANDLE ptok;
+  int errpos =3D 0;
+  struct {
+    PSID psid;
+    int buffer[10];
+  } tg;
+
+
+  if ((!GetUserName (name, (len =3D sizeof (name), &len)) && (errpos =3D _=
_LINE__))
+      || !name[0]
+      || !(envname =3D getenv("USERNAME"))
+      || strcasecmp (envname, name)
+      || (!GetComputerName (name, (len =3D sizeof (name), &len))
+	  && (errpos =3D __LINE__))
+      || !(envdomain =3D getenv("USERDOMAIN"))
+      || !envdomain[0]
+      || !strcasecmp (envdomain, name)
+      || (!OpenProcessToken (GetCurrentProcess (), TOKEN_QUERY, &ptok)
+	  && (errpos =3D __LINE__))
+      || (!GetTokenInformation (ptok, TokenPrimaryGroup, &tg, sizeof tg, &=
len)
+	  && (errpos =3D __LINE__))
+      || (!CloseHandle (ptok) && (errpos =3D __LINE__)))
+    {
+      if (errpos)
+	{
+	  print_win_error (GetLastError ());
+	  fprintf(stderr, " on line %d\n", errpos);
+	}
+      return;
+    }
+
+  int gid =3D *GetSidSubAuthority (tg.psid, *GetSidSubAuthorityCount(tg.ps=
id) - 1);
+
+  printf ("mkgroup_l_d:%s:%u:", print_sids ? put_sid (tg.psid) : "",
+                                gid + id_offset);
+  if (print_users)
+    printf("%s", envname);
+  printf ("\n");
+}
+
 int
-usage (FILE * stream, int status)
+usage (FILE * stream, int isNT)
 {
   fprintf (stream, "Usage: mkgroup [OPTION]... [domain]\n\n"
-		   "This program prints a /etc/group file to stdout\n\n"
-		   "Options:\n"
-		   "   -l,--local             print local group information\n"
-		   "   -d,--domain            print global group information from the do=
main\n"
-		   "                          specified (or from the current domain if t=
here is\n"
-		   "                          no domain specified)\n"
-		   "   -o,--id-offset offset  change the default offset (10000) added to=
 uids\n"
-		   "                          in domain accounts.\n"
-		   "   -s,--no-sids           don't print SIDs in pwd field\n"
-		   "                          (this affects ntsec)\n"
-		   "   -u,--users             print user list in gr_mem field\n"
-		   "   -h,--help              print this message\n\n"
-		   "   -v,--version           print version information and exit\n\n"
-		   "One of `-l' or `-d' must be given on NT/W2K.\n");
-  return status;
+	           "This program prints a /etc/group file to stdout\n\n"
+	           "Options:\n");
+  if (isNT)
+    fprintf (stream, "   -l,--local             print local group informat=
ion\n"
+	             "   -c,--current           print current group, if a domain =
account\n"
+		     "   -d,--domain            print global group information from the =
domain\n"
+		     "                          specified (or from the current domain if=
 there is\n"
+		     "                          no domain specified)\n"
+		     "   -o,--id-offset offset  change the default offset (10000) added =
to uids\n"
+		     "                          in domain accounts.\n"
+		     "   -s,--no-sids           don't print SIDs in pwd field\n"
+		     "                          (this affects ntsec)\n"
+	             "   -u,--users             print user list in gr_mem field\n=
");
+  fprintf (stream, "   -h,--help              print this message\n"
+	           "   -v,--version           print version information and exit\=
n\n");
+  if (isNT)
+    fprintf (stream, "One of `-l' or `-d' must be given.\n");
+
+  return 1;
 }

 struct option longopts[] =3D {
   {"local", no_argument, NULL, 'l'},
+  {"current", no_argument, NULL, 'c'},
   {"domain", no_argument, NULL, 'd'},
   {"id-offset", required_argument, NULL, 'o'},
   {"no-sids", no_argument, NULL, 's'},
@@ -452,7 +518,7 @@ struct option longopts[] =3D {
   {0, no_argument, NULL, 0}
 };

-char opts[] =3D "ldo:suhv";
+char opts[] =3D "lcdo:suhv";

 void
 print_version ()
@@ -484,11 +550,13 @@ main (int argc, char **argv)
   DWORD rc =3D ERROR_SUCCESS;
   WCHAR domain_name[100];
   int print_local =3D 0;
+  int print_current =3D 0;
   int print_domain =3D 0;
   int print_sids =3D 1;
   int print_users =3D 0;
   int domain_specified =3D 0;
   int id_offset =3D 10000;
+  int isNT;
   int i;

   char name[256], dom[256];
@@ -502,65 +570,68 @@ main (int argc, char **argv)
   NTSTATUS ret;
   PPOLICY_PRIMARY_DOMAIN_INFO pdi;

-  if (GetVersion () < 0x80000000)
+  isNT =3D (GetVersion () < 0x80000000);
+
+  if (isNT && argc =3D=3D 1)
+    return usage(stderr, isNT);
+  else
     {
-      if (argc =3D=3D 1)
-	return usage(stderr, 1);
-      else
+      while ((i =3D getopt_long (argc, argv, opts, longopts, NULL)) !=3D E=
OF)
+	switch (i)
 	{
-	  while ((i =3D getopt_long (argc, argv, opts, longopts, NULL)) !=3D EOF)
-	    switch (i)
-	      {
-	      case 'l':
-		print_local =3D 1;
-		break;
-	      case 'd':
-		print_domain =3D 1;
-		break;
-	      case 'o':
-		id_offset =3D strtol (optarg, NULL, 10);
-		break;
-	      case 's':
-		print_sids =3D 0;
-		break;
-	      case 'u':
-		print_users =3D 1;
-		break;
-	      case 'h':
-		return usage (stdout, 0);
-	      case 'v':
-		print_version ();
-		return 0;
-	      default:
-		fprintf (stderr, "Try `%s --help' for more information.\n", argv[0]);
-		return 1;
-	      }
-	  if (!print_local && !print_domain)
-	    {
-	      fprintf (stderr, "%s: Specify one of `-l' or `-d'\n", argv[0]);
-	      return 1;
-	    }
-	  if (optind < argc)
-	    {
-	      if (!print_domain)
-		{
-		  fprintf (stderr, "%s: A domain name is only accepted "
-				   "when `-d' is given.\n", argv[0]);
-		  return 1;
-		}
-	      mbstowcs (domain_name, argv[optind], (strlen (argv[optind]) + 1));
-	      domain_specified =3D 1;
-	    }
+	case 'l':
+	  print_local =3D 1;
+	  break;
+	case 'c':
+	  print_current =3D 1;
+	  break;
+	case 'd':
+	  print_domain =3D 1;
+	  break;
+	case 'o':
+	  id_offset =3D strtol (optarg, NULL, 10);
+	  break;
+	case 's':
+	  print_sids =3D 0;
+	  break;
+	case 'u':
+	  print_users =3D 1;
+	  break;
+	case 'h':
+	  usage (stdout, isNT);
+	  return 0;
+	case 'v':
+	  print_version ();
+	  return 0;
+	default:
+	  fprintf (stderr, "Try `%s --help' for more information.\n", argv[0]);
+	  return 1;
 	}
     }

   /* This takes Windows 9x/ME into account. */
-  if (GetVersion () >=3D 0x80000000)
+  if (!isNT)
     {
       printf ("unknown::%ld:\n", DOMAIN_ALIAS_RID_ADMINS);
       return 0;
     }
-
+
+  if (!print_local && !print_domain)
+    {
+      fprintf (stderr, "%s: Specify one of `-l' or `-d'\n", argv[0]);
+      return 1;
+    }
+  if (optind < argc)
+    {
+      if (!print_domain)
+        {
+	  fprintf (stderr, "%s: A domain name is only accepted "
+		   "when `-d' is given.\n", argv[0]);
+	  return 1;
+	}
+      mbstowcs (domain_name, argv[optind], (strlen (argv[optind]) + 1));
+      domain_specified =3D 1;
+    }
   if (!load_netapi ())
     {
       fprintf (stderr, "Failed loading symbols from netapi32.dll "
@@ -646,6 +717,9 @@ main (int argc, char **argv)

   if (print_local)
     enum_local_groups (print_sids, print_users);
+
+  if (print_current && !print_domain)
+    current_group (print_sids, print_users, id_offset);

   return 0;
 }

--=====================_1042007207==_--
