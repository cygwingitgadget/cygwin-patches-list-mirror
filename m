From: Mark Bradshaw <bradshaw@staff.crosswalk.com>
To: Mark Bradshaw <bradshaw@staff.crosswalk.com>, "'cygwin-patches@cygwin.com'" <cygwin-patches@cygwin.com>
Subject: patch to mkpasswd.c - allows selection of specific user
Date: Fri, 09 Nov 2001 15:55:00 -0000
Message-id: <911C684A29ACD311921800508B7293BA010A8FEF@cnmail>
X-SW-Source: 2001-q4/msg00182.html

This patch allows a person to specify that only information for a particular
user should be returned by mkpasswd.  It doesn't affect way mkpasswd gets
its information, but only restricts what is actually output.  

I had it go ahead and stop requesting more users when it had a user
specified AND got a match.  I guess it could be rewritten to only request
info on a specific user.  I'm just not sure how.  Oh well.  

This patch worked fine on my win2k machine.

Mark

=============================================
Fri 9 Nov 2001 18:15:00  Mark Bradshaw <bradshaw@staff.crosswalk.com>

        * mkpasswd.c : Add -u option to allow specifying only one user

=============================================

--- /usr/src/cygwin-1.3.4-4/winsup/utils/mkpasswd.c	Wed Oct 31 19:30:04
2001
+++ ./mkpasswd.c	Fri Nov  9 18:50:19 2001
@@ -104,7 +104,7 @@ uni2ansi (LPWSTR wcs, char *mbs, int siz
 
 int
 enum_users (LPWSTR servername, int print_sids, int print_cygpath,
-	    const char * passed_home_path, int id_offset)
+	    const char * passed_home_path, int id_offset, const char *
disp_username)
 {
   USER_INFO_3 *buffer;
   DWORD entriesread = 0;
@@ -112,6 +112,7 @@ enum_users (LPWSTR servername, int print
   DWORD resume_handle = 0;
   DWORD rc;
   char ansi_srvname[256];
+  int stop_reading = 0;
 
   if (servername)
     uni2ansi (servername, ansi_srvname, sizeof (ansi_srvname));
@@ -207,25 +208,29 @@ enum_users (LPWSTR servername, int print
 		    }
 		}
 	    }
-	  printf
("%s:unused_by_nt/2000/xp:%d:%d:%s%s%s%s%s%s%s%s:%s:/bin/bash\n",
-	  	  username,
-		  uid + id_offset,
-		  gid + id_offset,
-		  fullname,
-		  print_sids && fullname[0] ? "," : "",
-		  print_sids ? "U-" : "",
-		  print_sids ? domain_name : "",
-		  print_sids && domain_name[0] ? "\\" : "",
-		  print_sids ? username : "",
-		  print_sids ? "," : "",
-		  print_sids ? put_sid (psid) : "",
-		  homedir_psx);
+	  if ( disp_username[0] == '\0' || !strcmp(disp_username, username)
) 
+		  printf
("%s:unused_by_nt/2000/xp:%d:%d:%s%s%s%s%s%s%s%s:%s:/bin/bash\n",
+		  	  username,
+			  uid + id_offset,
+			  gid + id_offset,
+			  fullname,
+			  print_sids && fullname[0] ? "," : "",
+			  print_sids ? "U-" : "",
+			  print_sids ? domain_name : "",
+			  print_sids && domain_name[0] ? "\\" : "",
+			  print_sids ? username : "",
+			  print_sids ? "," : "",
+			  print_sids ? put_sid (psid) : "",
+			  homedir_psx);
+	  if ( username[0] != '\0' && disp_username[0] != '\0' ) 
+			if ( !strcmp(disp_username, username) ) 
+				stop_reading = 1;
 	}
 
       netapibufferfree (buffer);
 
     }
-  while (rc == ERROR_MORE_DATA);
+  while (rc == ERROR_MORE_DATA && !stop_reading);
 
   if (servername)
     netapibufferfree (servername);
@@ -381,6 +386,7 @@ usage ()
   fprintf (stderr, "                           (this affects ntsec)\n");
   fprintf (stderr, "   -p,--path-to-home path  if user account has no home
dir, use\n");
   fprintf (stderr, "                           path instead of /home/\n");
+  fprintf (stderr, "   -u,--username username  only return information for
the specified user\n");
   fprintf (stderr, "   -?,--help               displays this message\n\n");
   fprintf (stderr, "One of `-l', `-d' or `-g' must be given on NT/W2K.\n");
   return 1;
@@ -394,11 +400,12 @@ struct option longopts[] = {
   {"no-mount", no_argument, NULL, 'm'},
   {"no-sids", no_argument, NULL, 's'},
   {"path-to-home",required_argument, NULL, 'p'},
+  {"username",required_argument, NULL, 'u'},
   {"help", no_argument, NULL, 'h'},
   {0, no_argument, NULL, 0}
 };
 
-char opts[] = "ldo:gsmhp:";
+char opts[] = "ldo:gsmhpu:";
 
 int
 main (int argc, char **argv)
@@ -414,6 +421,7 @@ main (int argc, char **argv)
   int print_cygpath = 1;
   int id_offset = 10000;
   int i;
+  char *disp_username = "";
 
   char name[256], passed_home_path[MAX_PATH];
   DWORD len;
@@ -459,6 +467,9 @@ main (int argc, char **argv)
 		if (optarg[strlen (optarg)-1] != '/')
 		  strcat (passed_home_path, "/");
 		break;
+	      case 'u':
+		disp_username = optarg;
+	    break;
 	      case 'h':
 		return usage ();
 	      default:
@@ -513,19 +524,23 @@ main (int argc, char **argv)
   /*
    * Get `Everyone' group
   */
-  print_special (print_sids, &sid_world_auth, 1, SECURITY_WORLD_RID, 0, 0,
0, 0, 0, 0, 0);
+  if ( disp_username[0] == '\0' ) 
+	print_special (print_sids, &sid_world_auth, 1, SECURITY_WORLD_RID,
0, 0, 0, 0, 0, 0, 0);
   /*
    * Get `system' group
   */
-  print_special (print_sids, &sid_nt_auth, 1, SECURITY_LOCAL_SYSTEM_RID, 0,
0, 0, 0, 0, 0, 0);
+  if ( disp_username[0] == '\0' ) 
+	  print_special (print_sids, &sid_nt_auth, 1,
SECURITY_LOCAL_SYSTEM_RID, 0, 0, 0, 0, 0, 0, 0);
   /*
    * Get `administrators' group
   */
-  if (!print_local_groups)
-    print_special (print_sids, &sid_nt_auth, 2,
SECURITY_BUILTIN_DOMAIN_RID, DOMAIN_ALIAS_RID_ADMINS, 0, 0, 0, 0, 0, 0);
-
-  if (print_local_groups)
-    enum_local_groups (print_sids);
+  if ( disp_username[0] == '\0' ) { 
+	  if (!print_local_groups)
+    	print_special (print_sids, &sid_nt_auth, 2,
SECURITY_BUILTIN_DOMAIN_RID, DOMAIN_ALIAS_RID_ADMINS, 0, 0, 0, 0, 0, 0);
+
+	  if (print_local_groups)
+    	enum_local_groups (print_sids);
+  }
 
   if (print_domain)
     {
@@ -541,11 +556,11 @@ main (int argc, char **argv)
 	  exit (1);
 	}
 
-      enum_users (servername, print_sids, print_cygpath, passed_home_path,
id_offset);
+      enum_users (servername, print_sids, print_cygpath, passed_home_path,
id_offset, disp_username);
     }
 
   if (print_local)
-    enum_users (NULL, print_sids, print_cygpath, passed_home_path, 0);
+    enum_users (NULL, print_sids, print_cygpath, passed_home_path, 0,
disp_username);
 
   if (servername)
     netapibufferfree (servername);
