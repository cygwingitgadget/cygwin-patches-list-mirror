From: Mathew Boorman <mathew.boorman@au.cmg.com>
To: "'cygwin-patches@cygwin.com'" <cygwin-patches@cygwin.com>
Subject: mkpasswd support for current user option (-c)
Date: Mon, 12 Nov 2001 19:19:00 -0000
Message-ID: <FB7B5F146C8CD5118E0D00306E005CDA02EA5D@AP-CAN-MAIL01>
X-SW-Source: 2001-q4/msg00210.html
Message-ID: <20011112191900.MYX7I4WHT0WuOvAF5A4l_vPC6Dw4V9qVqaknGyEo72w@z>

2001-11-13  Mathew Boorman  <mathew.boorman@au.cmg.com>

	* mkpasswd.c (load_netapi) Add dll entry points to determine current
user.
	Used explicit cast to avoid warnings.
	(psx_dir) Fixed const-ness of parameter.
	(uni2ansi) dito.
	(ansi2uni) New function.
      (print_user_info) New function refactored from enum_users.
      (enum_users) Use new function print_user_info.
	(print_current_user_info) New function.
	(usage) Add current user option.
	(main) Add suport for current user option.



--- /usr/src/cygwin-1.3.3-2/winsup/utils/mkpasswd.c	Thu Sep  6 12:38:49
2001
+++ mkpasswd.c	Tue Nov 13 14:05:18 2001
@@ -17,6 +17,8 @@
 #include <getopt.h>
 #include <lmaccess.h>
 #include <lmapibuf.h>
+#include <lmwksta.h>
+#include <lmerr.h>
 #include <sys/fcntl.h>
 
 SID_IDENTIFIER_AUTHORITY sid_world_auth = {SECURITY_WORLD_SID_AUTHORITY};
@@ -26,6 +28,8 @@ NET_API_STATUS WINAPI (*netapibufferfree
 NET_API_STATUS WINAPI
(*netuserenum)(LPWSTR,DWORD,DWORD,PBYTE*,DWORD,PDWORD,PDWORD,PDWORD);
 NET_API_STATUS WINAPI
(*netlocalgroupenum)(LPWSTR,DWORD,PBYTE*,DWORD,PDWORD,PDWORD,PDWORD);
 NET_API_STATUS WINAPI (*netgetdcname)(LPWSTR,LPWSTR,PBYTE*);
+NET_API_STATUS WINAPI (*netwkstusergetinfo)(LPWSTR,DWORD,PBYTE*);
+NET_API_STATUS WINAPI (*netusergetinfo)(LPWSTR,LPWSTR,DWORD,PBYTE*);
 
 #ifndef min
 #define min(a,b) (((a)<(b))?(a):(b))
@@ -39,13 +43,17 @@ load_netapi ()
   if (!h)
     return FALSE;
 
-  if (!(netapibufferfree = GetProcAddress (h, "NetApiBufferFree")))
+  if (!(netapibufferfree = (void *)GetProcAddress (h, "NetApiBufferFree")))
     return FALSE;
-  if (!(netuserenum = GetProcAddress (h, "NetUserEnum")))
+  if (!(netuserenum = (void *)GetProcAddress (h, "NetUserEnum")))
     return FALSE;
-  if (!(netlocalgroupenum = GetProcAddress (h, "NetLocalGroupEnum")))
+  if (!(netlocalgroupenum = (void *)GetProcAddress (h,
"NetLocalGroupEnum")))
     return FALSE;
-  if (!(netgetdcname = GetProcAddress (h, "NetGetDCName")))
+  if (!(netgetdcname = (void *)GetProcAddress (h, "NetGetDCName")))
+    return FALSE;
+  if (!(netwkstusergetinfo = (void *)GetProcAddress (h,
"NetWkstaUserGetInfo")))
+    return FALSE;
+  if (!(netusergetinfo = (void *)GetProcAddress (h, "NetUserGetInfo")))
     return FALSE;
 
   return TRUE;
@@ -70,7 +78,7 @@ put_sid (PSID sid)
 }
 
 void
-psx_dir (char *in, char *out)
+psx_dir (const char *in, char *out)
 {
   if (isalpha (in[0]) && in[1] == ':')
     {
@@ -93,7 +101,7 @@ psx_dir (char *in, char *out)
 }
 
 void
-uni2ansi (LPWSTR wcs, char *mbs, int size)
+uni2ansi (LPCWSTR wcs, char * mbs, int size)
 {
   if (wcs)
     WideCharToMultiByte (CP_ACP, 0, wcs, -1, mbs, size, NULL, NULL);
@@ -101,6 +109,102 @@ uni2ansi (LPWSTR wcs, char *mbs, int siz
     *mbs = '\0';
 }
 
+void
+ansi2uni (const char * mbs, LPWSTR wcs, int size)
+{
+  if (mbs)
+    MultiByteToWideChar (CP_ACP, 0, mbs, -1, wcs, size);
+  else
+    *wcs = '\0';
+}
+
+
+void 
+print_user_info(const USER_INFO_3 * info, int print_sids, int
print_cygpath,
+	    const char * passed_home_path, int id_offset, LPCWSTR
servername)
+{
+  char username[256];
+  char fullname[256];
+  char homedir_psx[MAX_PATH];
+  char homedir_w32[MAX_PATH];
+  char domain_name[100];
+  DWORD domname_len = 100;
+  char psid_buffer[1024];
+  PSID psid = (PSID) psid_buffer;
+  DWORD sid_length = 1024;
+  SID_NAME_USE acc_type;
+  char ansi_srvname[256];
+  
+  int uid = info->usri3_user_id;
+  int gid = info->usri3_primary_group_id;
+  uni2ansi (info->usri3_name, username, sizeof (username));
+  uni2ansi (info->usri3_full_name, fullname, sizeof (fullname));
+  homedir_w32[0] = homedir_psx[0] = '\0';
+  uni2ansi (info->usri3_home_dir, homedir_w32, sizeof (homedir_w32));
+  if (print_cygpath)
+    cygwin_conv_to_posix_path (homedir_w32, homedir_psx);
+  else
+    psx_dir (homedir_w32, homedir_psx);
+  
+  if (homedir_psx[0] == '\0')
+  {
+    strcat (homedir_psx, passed_home_path);
+    strcat (homedir_psx, username);
+  }
+
+  
+  if (servername)
+    uni2ansi (servername, ansi_srvname, sizeof (ansi_srvname));
+  
+  if (print_sids)
+  {
+    if (!LookupAccountName (servername ? ansi_srvname : NULL,
+      username,
+      psid, &sid_length,
+      domain_name, &domname_len,
+      &acc_type))
+    {
+      fprintf (stderr,
+        "LookupAccountName(%s,%s) failed with error %ld\n",
+        servername ? ansi_srvname : "NULL",
+        username,
+        GetLastError ());
+      return;
+    }
+    else if (acc_type == SidTypeDomain)
+    {
+      char domname[356];
+      
+      strcpy (domname, domain_name);
+      strcat (domname, "\\");
+      strcat (domname, username);
+      sid_length = 1024;
+      domname_len = 100;
+      if (!LookupAccountName (servername ? ansi_srvname : NULL,
+        domname,
+        psid, &sid_length,
+        domain_name, &domname_len,
+        &acc_type))
+      {
+        fprintf (stderr,
+          "LookupAccountName2(%s,%s) failed with error %ld\n",
+          servername ? ansi_srvname : "NULL",
+          domname,
+          GetLastError ());
+        return;
+      }
+    }
+  }
+  printf
("%s:This_field_is_not_used_by_cygwin_on_nt/2000/xp:%d:%d:%s%s%s:%s:/bin/bas
h\n", username,
+    uid + id_offset,
+    gid + id_offset,
+    fullname,
+    print_sids ? "," : "",
+    print_sids ? put_sid (psid) : "",
+    homedir_psx);
+}
+
+
 int
 enum_users (LPWSTR servername, int print_sids, int print_cygpath,
 	    const char * passed_home_path, int id_offset)
@@ -110,122 +214,101 @@ enum_users (LPWSTR servername, int print
   DWORD totalentries = 0;
   DWORD resume_handle = 0;
   DWORD rc;
-  char ansi_srvname[256];
-
-  if (servername)
-    uni2ansi (servername, ansi_srvname, sizeof (ansi_srvname));
-
+  
   do
-    {
-      DWORD i;
-
-      rc = netuserenum (servername, 3, FILTER_NORMAL_ACCOUNT,
-			(LPBYTE *) & buffer, 1024,
-			&entriesread, &totalentries, &resume_handle);
-      switch (rc)
-	{
-	case ERROR_ACCESS_DENIED:
-	  fprintf (stderr, "Access denied\n");
-	  exit (1);
-
-	case ERROR_MORE_DATA:
-	case ERROR_SUCCESS:
-	  break;
-
-	default:
-	  fprintf (stderr, "NetUserEnum() failed with %ld\n", rc);
-	  exit (1);
-	}
-
-      for (i = 0; i < entriesread; i++)
-	{
-	  char username[100];
-	  char fullname[100];
-	  char homedir_psx[MAX_PATH];
-	  char homedir_w32[MAX_PATH];
-	  char domain_name[100];
-	  DWORD domname_len = 100;
-	  char psid_buffer[1024];
-	  PSID psid = (PSID) psid_buffer;
-	  DWORD sid_length = 1024;
-	  SID_NAME_USE acc_type;
-
-	  int uid = buffer[i].usri3_user_id;
-	  int gid = buffer[i].usri3_primary_group_id;
-	  uni2ansi (buffer[i].usri3_name, username, sizeof (username));
-	  uni2ansi (buffer[i].usri3_full_name, fullname, sizeof (fullname));
-	  homedir_w32[0] = homedir_psx[0] = '\0';
-	  uni2ansi (buffer[i].usri3_home_dir, homedir_w32, sizeof
(homedir_w32));
-	  if (print_cygpath)
-	    cygwin_conv_to_posix_path (homedir_w32, homedir_psx);
-	  else
-	    psx_dir (homedir_w32, homedir_psx);
-
-	  if (homedir_psx[0] == '\0')
-	    {
-	      strcat (homedir_psx, passed_home_path);
-	      strcat (homedir_psx, username);
-	    }
-
-	  if (print_sids)
-	    {
-	      if (!LookupAccountName (servername ? ansi_srvname : NULL,
-				      username,
-				      psid, &sid_length,
-				      domain_name, &domname_len,
-				      &acc_type))
-		{
-		  fprintf (stderr,
-			   "LookupAccountName(%s,%s) failed with error
%ld\n",
-			   servername ? ansi_srvname : "NULL",
-			   username,
-			   GetLastError ());
-		  continue;
-		}
-	      else if (acc_type == SidTypeDomain)
-		{
-		  char domname[356];
-
-		  strcpy (domname, domain_name);
-		  strcat (domname, "\\");
-		  strcat (domname, username);
-		  sid_length = 1024;
-		  domname_len = 100;
-		  if (!LookupAccountName (servername ? ansi_srvname : NULL,
-					  domname,
-					  psid, &sid_length,
-					  domain_name, &domname_len,
-					  &acc_type))
-		    {
-		      fprintf (stderr,
-			       "LookupAccountName(%s,%s) failed with error
%ld\n",
-			       servername ? ansi_srvname : "NULL",
-			       domname,
-			       GetLastError ());
-		      continue;
-		    }
-		}
-	    }
-	  printf
("%s:This_field_is_not_used_by_cygwin_on_nt/2000/xp:%d:%d:%s%s%s:%s:/bin/bas
h\n", username,
-		  uid + id_offset,
-		  gid + id_offset,
-		  fullname,
-		  print_sids ? "," : "",
-		  print_sids ? put_sid (psid) : "",
-		  homedir_psx);
-	}
-
+  {
+    DWORD i;
+    
+    rc = netuserenum (servername, 3, FILTER_NORMAL_ACCOUNT,
+      (LPBYTE *) & buffer, 1024,
+      &entriesread, &totalentries, &resume_handle);
+    switch (rc)
+    {
+    case ERROR_ACCESS_DENIED:
+      fprintf (stderr, "Access denied\n");
+      exit (1);
+      
+    case ERROR_MORE_DATA:
+    case ERROR_SUCCESS:
+      break;
+      
+    default:
+      fprintf (stderr, "NetUserEnum() failed with %ld\n", rc);
+      exit (1);
+    }
+    
+    for (i = 0; i < entriesread; i++)
+    {
+      print_user_info(buffer, print_sids, print_cygpath,
+        passed_home_path, id_offset, servername);
+      
       netapibufferfree (buffer);
-
+      
     }
+  }
   while (rc == ERROR_MORE_DATA);
-
+  
   if (servername)
     netapibufferfree (servername);
-
+  
   return 0;
 }
 
+void print_current_user_info(int print_sids, int print_cygpath,
+      const char * passed_home_path, int id_offset)
+{
+  /* find account of logged in user
+   */
+  WKSTA_USER_INFO_1* buffer;
+  DWORD rc;
+  USER_INFO_3* info;
+  char ansiUsername[255];
+  /* ansi verion of the server name.  Note pre-pend of \\ to server name
+   */
+  char ansiServername[255] = "\\\\";  
+  WCHAR servername[255];
+
+  rc = netwkstusergetinfo(NULL, 1, (LPBYTE *) &buffer);
+
+  if (rc != ERROR_SUCCESS)
+  {
+    fprintf (stderr, "Cannot determine current user, code = %ld\n", rc);
+    exit (1);
+  }
+
+  /* Prepend the '\\' to the server name
+   */
+  uni2ansi (buffer->wkui1_logon_server, ansiServername+2, sizeof
(ansiServername) - 2);
+  ansi2uni (ansiServername, servername, sizeof (servername));
+
+  /* lookup detailed account info from the logon server (local or domain)
+   */
+  rc = netusergetinfo(servername, buffer->wkui1_username, 3,
(PBYTE*)&info);
+
+  if (rc != ERROR_SUCCESS)
+  {
+    const char* msg = 0;
+    if(rc == NERR_InvalidComputer)
+      msg = "InvalidComputer";
+    else if(rc == NERR_UserNotFound)
+      msg = "User Not Found";
+    else
+      msg = "Unknown Error";
+
+    uni2ansi (buffer->wkui1_username, ansiUsername, sizeof (ansiUsername));
+    fprintf (stderr, "Cannot retrieve current user %s info from %s, code =
%s (%ld)\n",
+      ansiUsername, ansiServername, msg, rc);
+    exit (1);
+  }
+  
+  print_user_info(info, print_sids, print_cygpath, passed_home_path,
id_offset, servername);
+
+};
+ 
+
+
+
+
 int
 enum_local_groups (int print_sids)
 {
@@ -315,7 +398,7 @@ enum_local_groups (int print_sids)
 int
 usage ()
 {
-  fprintf (stderr, "Usage: mkpasswd [OPTION]... [domain]\n\n");
+  fprintf (stderr, "Usage: mkpasswd [OPTION]... [-d [domain]]
[users]\n\n");
   fprintf (stderr, "This program prints a /etc/passwd file to stdout\n\n");
   fprintf (stderr, "Options:\n");
   fprintf (stderr, "   -l,--local              print local user
accounts\n");
@@ -325,6 +408,7 @@ usage ()
   fprintf (stderr, "                           in domain accounts.\n");
   fprintf (stderr, "   -g,--local-groups       print local group
information too\n");
   fprintf (stderr, "                           if no domain specified\n");
+  fprintf (stderr, "   -c,--current-user       print information only for
current user\n");
   fprintf (stderr, "   -m,--no-mount           don't use mount points for
home dir\n");
   fprintf (stderr, "   -s,--no-sids            don't print SIDs in GCOS
field\n");
   fprintf (stderr, "                           (this affects ntsec)\n");
@@ -340,6 +424,7 @@ struct option longopts[] = {
   {"domain", no_argument, NULL, 'd'},
   {"id-offset", required_argument, NULL, 'o'},
   {"local-groups", no_argument, NULL, 'g'},
+  {"current-user", no_argument, NULL, 'c'},
   {"no-mount", no_argument, NULL, 'm'},
   {"no-sids", no_argument, NULL, 's'},
   {"path-to-home",required_argument, NULL, 'p'},
@@ -347,7 +432,7 @@ struct option longopts[] = {
   {0, no_argument, NULL, 0}
 };
 
-char opts[] = "ldo:gsmhp:";
+char opts[] = "ldo:gcsmhp:";
 
 int
 main (int argc, char **argv)
@@ -358,6 +443,7 @@ main (int argc, char **argv)
   int print_local = 0;
   int print_domain = 0;
   int print_local_groups = 0;
+  int print_current_user = 0;
   int domain_name_specified = 0;
   int print_sids = 1;
   int print_cygpath = 1;
@@ -392,6 +478,9 @@ main (int argc, char **argv)
 	    case 'g':
 	      print_local_groups = 1;
 	      break;
+	    case 'c':
+	      print_current_user = 1;
+	      break;
 	    case 's':
 	      print_sids = 0;
 	      break;
@@ -415,9 +504,9 @@ main (int argc, char **argv)
 	      fprintf (stderr, "Try `%s --help' for more information.\n",
argv[0]);
 	      return 1;
 	    }
-	if (!print_local && !print_domain && !print_local_groups)
+	if (!print_local && !print_domain && !print_local_groups &&
!print_current_user)
 	  {
-	    fprintf (stderr, "%s: Specify one of `-l', `-d' or `-g'\n",
argv[0]);
+	    fprintf (stderr, "%s: Specify one of `-l', `-d', `-c' or
`-g'\n", argv[0]);
 	    return 1;
 	  }
 	if (optind < argc)
@@ -459,63 +548,67 @@ main (int argc, char **argv)
       return 1;
     }
 
-  /*
-   * Get `Everyone' group
-  */
-  if (AllocateAndInitializeSid (&sid_world_auth, 1, SECURITY_WORLD_RID,
-				0, 0, 0, 0, 0, 0, 0, &sid))
-    {
-      if (LookupAccountSid (NULL, sid,
-			    name, (len = 256, &len),
-			    dom, (len2 = 256, &len),
-			    &use))
-	printf ("%s:*:%d:%d:%s%s::\n", name,
-					 SECURITY_WORLD_RID,
-					 SECURITY_WORLD_RID,
-					 print_sids ? "," : "",
-					 print_sids ? put_sid (sid) : "");
-      FreeSid (sid);
-    }
-
-  /*
-   * Get `system' group
-  */
-  if (AllocateAndInitializeSid (&sid_nt_auth, 1, SECURITY_LOCAL_SYSTEM_RID,
-				0, 0, 0, 0, 0, 0, 0, &sid))
-    {
-      if (LookupAccountSid (NULL, sid,
-			    name, (len = 256, &len),
-			    dom, (len2 = 256, &len),
-			    &use))
-	printf ("%s:*:%d:%d:%s%s::\n", name,
-					 SECURITY_LOCAL_SYSTEM_RID,
-					 SECURITY_LOCAL_SYSTEM_RID,
-					 print_sids ? "," : "",
-					 print_sids ? put_sid (sid) : "");
-      FreeSid (sid);
-    }
-
-  /*
-   * Get `administrators' group
-  */
-  if (!print_local_groups
-      && AllocateAndInitializeSid (&sid_nt_auth, 2,
-				   SECURITY_BUILTIN_DOMAIN_RID,
-				   DOMAIN_ALIAS_RID_ADMINS,
-				   0, 0, 0, 0, 0, 0, &sid))
-    {
-      if (LookupAccountSid (NULL, sid,
-			    name, (len = 256, &len),
-			    dom, (len2 = 256, &len),
-			    &use))
-	printf ("%s:*:%ld:%ld:%s%s::\n", name,
-					 DOMAIN_ALIAS_RID_ADMINS,
-					 DOMAIN_ALIAS_RID_ADMINS,
-					 print_sids ? "," : "",
-					 print_sids ? put_sid (sid) : "");
-      FreeSid (sid);
-    }
 
+  if (!print_current_user)
+  {
+    /*
+    * Get `Everyone' group
+    */
+	  if (AllocateAndInitializeSid (&sid_world_auth, 1,
SECURITY_WORLD_RID,
+					0, 0, 0, 0, 0, 0, 0, &sid))
+	    {
+	      if (LookupAccountSid (NULL, sid,
+				    name, (len = 256, &len),
+				    dom, (len2 = 256, &len),
+				    &use))
+		printf ("%s:*:%d:%d:%s%s::\n", name,
+						 SECURITY_WORLD_RID,
+						 SECURITY_WORLD_RID,
+						 print_sids ? "," : "",
+						 print_sids ? put_sid (sid)
: "");
+	      FreeSid (sid);
+	    }
+
+	  /*
+	   * Get `system' group
+	  */
+	  if (AllocateAndInitializeSid (&sid_nt_auth, 1,
SECURITY_LOCAL_SYSTEM_RID,
+					0, 0, 0, 0, 0, 0, 0, &sid))
+	    {
+	      if (LookupAccountSid (NULL, sid,
+				    name, (len = 256, &len),
+				    dom, (len2 = 256, &len),
+				    &use))
+		printf ("%s:*:%d:%d:%s%s::\n", name,
+						 SECURITY_LOCAL_SYSTEM_RID,
+						 SECURITY_LOCAL_SYSTEM_RID,
+						 print_sids ? "," : "",
+						 print_sids ? put_sid (sid)
: "");
+	      FreeSid (sid);
+	    }
+
+	  /*
+	   * Get `administrators' group
+	  */
+	  if (!print_local_groups
+	      && AllocateAndInitializeSid (&sid_nt_auth, 2,
+					   SECURITY_BUILTIN_DOMAIN_RID,
+					   DOMAIN_ALIAS_RID_ADMINS,
+					   0, 0, 0, 0, 0, 0, &sid))
+	    {
+	      if (LookupAccountSid (NULL, sid,
+				    name, (len = 256, &len),
+				    dom, (len2 = 256, &len),
+				    &use))
+		printf ("%s:*:%ld:%ld:%s%s::\n", name,
+						 DOMAIN_ALIAS_RID_ADMINS,
+						 DOMAIN_ALIAS_RID_ADMINS,
+						 print_sids ? "," : "",
+						 print_sids ? put_sid (sid)
: "");
+	      FreeSid (sid);
+	    }
+  }
+  
   if (print_local_groups)
     enum_local_groups (print_sids);
 
@@ -539,6 +632,9 @@ main (int argc, char **argv)
   if (print_local)
     enum_users (NULL, print_sids, print_cygpath, passed_home_path, 0);
 
+  if (print_current_user)
+    print_current_user_info (print_sids, print_cygpath, passed_home_path,
0);
+  
   if (servername)
     netapibufferfree (servername);
 
