From: Kazuhiro Fujieda <fujieda@jaist.ac.jp>
To: cygwin-patches@sources.redhat.com
Subject: preliminary patch3 for i18n: eliminate calls to wcstombs.
Date: Fri, 21 Jul 2000 12:53:00 -0000
Message-id: <s1sn1jb45yi.fsf@jaist.ac.jp>
X-SW-Source: 2000-q3/msg00021.html

The current implementation of wcstombs() can't convert a
wide-character string encoded by UNICODE to a correct multi-byte
string. So we should use WideCharToMultiByte instead of it.

ChangeLog:
2000/07/21  Kazuhiro Fujieda <fujieda@jaist.ac.jp>	

	* uinfo.cc (internal_getlogin): Eliminate calls to wcstombs and
	mbstowcs, and an usage of a magic number 256.

Index: uinfo.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/uinfo.cc,v
retrieving revision 1.13
diff -w -u -p -r1.13 uinfo.cc
--- uinfo.cc	2000/07/02 10:17:44	1.13
+++ uinfo.cc	2000/07/21 19:34:00
@@ -30,34 +30,38 @@ internal_getlogin (struct pinfo *pi)
   if (os_being_run == winNT)
     {
       LPWKSTA_USER_INFO_1 wui;
-      char buf[256], *env;
+      char *un, *env;
 
       /* First trying to get logon info from environment */
-      buf[0] = '\0';
+      un = NULL;
+      pi->domain[0] = pi->logsrv[0] = '\0';
       if ((env = getenv ("USERNAME")) != NULL)
-        strcpy (buf, env);
+	un = env;
       if ((env = getenv ("LOGONSERVER")) != NULL)
         strcpy (pi->logsrv, env + 2); /* filter leading double backslashes */
       if ((env = getenv ("USERDOMAIN")) != NULL)
         strcpy (pi->domain, env);
       /* Trust only if usernames are identical */
-      if (strcasematch (pi->username, buf) && pi->domain[0] && pi->logsrv[0])
+      if (un && strcasematch (pi->username, un)
+	  && pi->domain[0] && pi->logsrv[0])
         debug_printf ("Domain: %s, Logon Server: %s", pi->domain, pi->logsrv);
       /* If that failed, try to get that info from NetBIOS */
       else if (!NetWkstaUserGetInfo (NULL, 1, (LPBYTE *)&wui))
         {
-          wcstombs (pi->username, wui->wkui1_username,
-                    (wcslen (wui->wkui1_username) + 1) * sizeof (WCHAR));
-          wcstombs (pi->logsrv, wui->wkui1_logon_server,
-                    (wcslen (wui->wkui1_logon_server) + 1) * sizeof (WCHAR));
-          wcstombs (pi->domain, wui->wkui1_logon_domain,
-                    (wcslen (wui->wkui1_logon_domain) + 1) * sizeof (WCHAR));
+	  WideCharToMultiByte (CP_ACP, 0, wui->wkui1_username, -1,
+			       pi->username, MAX_USER_NAME, NULL, NULL);
+	  WideCharToMultiByte (CP_ACP, 0, wui->wkui1_logon_server, -1,
+			       pi->logsrv, MAX_HOST_NAME, NULL, NULL);
+	  WideCharToMultiByte (CP_ACP, 0, wui->wkui1_logon_domain, -1,
+			       pi->domain, MAX_COMPUTERNAME_LENGTH + 1,
+			       NULL, NULL);
           /* Save values in environment */
           if (!strcasematch (pi->username, "SYSTEM")
               && pi->domain[0] && pi->logsrv[0])
             {
               LPUSER_INFO_3 ui = NULL;
-              WCHAR wbuf[256];
+	      WCHAR wbuf[MAX_HOST_NAME + 2];
+	      char buf[MAX_HOST_NAME + 2];
 
               strcat (strcpy (buf, "\\\\"), pi->logsrv);
               setenv ("USERNAME", pi->username, 1);
@@ -65,21 +69,32 @@ internal_getlogin (struct pinfo *pi)
               setenv ("USERDOMAIN", pi->domain, 1);
               /* HOMEDRIVE and HOMEPATH are wrong most of the time, too,
                  after changing user context! */
-              mbstowcs (wbuf, buf, 256);
+	      MultiByteToWideChar (CP_ACP, 0, buf, -1,
+				   wbuf, MAX_HOST_NAME + 2);
               if (!NetUserGetInfo (NULL, wui->wkui1_username, 3, (LPBYTE *)&ui)
                   || !NetUserGetInfo (wbuf,wui->wkui1_username,3,(LPBYTE *)&ui))
                 {
-                  wcstombs (buf, ui->usri3_home_dir,  256);
+		  char buf[MAX_PATH];
+		  WideCharToMultiByte (CP_ACP, 0, ui->usri3_home_dir, -1,
+				       buf, MAX_PATH, NULL, NULL);
                   if (!buf[0])
-                    {
-                      wcstombs (buf, ui->usri3_home_dir_drive, 256);
-                      if (buf[0])
-                        strcat (buf, "\\");
-                    }
+		    strcpy (buf, "\\");
+		  setenv ("HOMEPATH", buf, 1);
+
+		  WideCharToMultiByte(CP_ACP, 0,
+				      ui->usri3_home_dir_drive, -1,
+				      buf, MAX_PATH, NULL, NULL);
                   if (!buf[0])
-                    strcat (strcpy (buf, getenv ("SYSTEMDRIVE")), "\\");
-                  setenv ("HOMEPATH", buf + 2, 1);
+		    {
+		      env = getenv ("SYSTEMDRIVE");
+		      if (env && env[0])
+			strcpy (buf, env);
+		      else
+			{
+			  GetSystemDirectory (buf, MAX_PATH);
                   buf[2] = '\0';
+			}
+		    }
                   setenv ("HOMEDRIVE", buf, 1);
                   NetApiBufferFree (ui);
                 }
@@ -118,6 +133,7 @@ internal_getlogin (struct pinfo *pi)
              and a domain user may have the same name. */
           if (!ret && pi->domain[0])
             {
+	      char buf[MAX_COMPUTERNAME_LENGTH + 1 + MAX_USER_NAME + 2];
               /* Concat DOMAIN\USERNAME for the next lookup */
               strcat (strcat (strcpy (buf, pi->domain), "\\"), pi->username);
               if (!(ret = lookup_name (buf, NULL, (PSID) pi->sidbuf)))
@@ -142,6 +158,7 @@ internal_getlogin (struct pinfo *pi)
               if (!strcasematch (pi->username, "SYSTEM")
                   && pi->domain[0] && pi->logsrv[0])
                 {
+		  char buf[MAX_PATH];
                   if (get_registry_hive_path (pi->psid, buf))
                     setenv ("USERPROFILE", buf, 1);
                 }

____
  | AIST      Kazuhiro Fujieda <fujieda@jaist.ac.jp>
  | HOKURIKU  School of Information Science
o_/ 1990      Japan Advanced Institute of Science and Technology
