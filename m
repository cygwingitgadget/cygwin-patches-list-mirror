From: Corinna Vinschen <vinschen@cygnus.com>
To: Kazuhiro Fujieda <fujieda@jaist.ac.jp>
Cc: cygwin-patches@sources.redhat.com
Subject: Re: preliminary patch3 for i18n: eliminate calls to wcstombs.
Date: Sat, 22 Jul 2000 03:13:00 -0000
Message-id: <39797348.194FB06F@cygnus.com>
References: <s1sn1jb45yi.fsf@jaist.ac.jp> <20000721155529.B26237@cygnus.com> <s1sk8ef422b.fsf@jaist.ac.jp>
X-SW-Source: 2000-q3/msg00026.html

Kazuhiro Fujieda wrote:
> 
> >>> On Fri, 21 Jul 2000 15:55:29 -0400
> >>> Chris Faylor <cgf@cygnus.com> said:
> 
> > Hmm.  I wonder if it wouldn't make sense to implement wcstombs using
> > WideChartoMultiByte instead.
> 
> I have already implemented it. But wcstombs() must be sensitive
> to a locale selected by an application according to ISO C and
> the Single Unix Specification. As for the inside of Cygwin, the
> conversion must be always done in the system default locale.  So
> we must use WideCharToMultiByte in any case.

I see. I will use local macros `sys_wcstombs' and `sys_mbstowcs' for
that because the calls to WideCharToBlurb and MultiByte... are
somewhat complex. If there's a need to use WideChar... and MultiByte...
functions more often later, it might help to define those macros in
winsup.h.

> > However, using defines instead of the `magic' 256 is definitely a
> > good idea.
> 
> We can use MAX_PATH as the largest number among MAX_PATH,
> MAX_HOST_NAME+2, MAX_COMPUTER_NAME+MAX_USER_NAME+3; and allocate
> `buf' only once. Do you prefer to do so?

I'm just doing so.

I don't understand the HOMEDRIVE/HOMEPATH part of your patch.
It seems wrong to me. You are using the content of
ui->usri3_home_dir for HOMEPATH and the content of
ui->usri3_home_dir_drive for HOMEPATH. The problem is on one hand
that ui->usri3_home_dir contains a drive letter while HOMEPATH
does not. On the other hand, if ui->usri3_home_dir contains a path,
ui->usri3_home_dir_drive is typically empty. The drive letter given
in ui->usri3_home_dir has to be always the first choice.

That's the reason for my way to create a full path first and after
that extracting the HOMEPATH - containing only the path component -
and HOMEDRIVE - containing only the drive letter and the trailing
colon.
However, I like your suggestion to call GetSystemDirectory
if anything else failed.

I have attached my variation of the patch. If nobody objects,
I will check that in at least Sunday morning (CEST).

Corinna

-- 
Corinna Vinschen
Cygwin Developer
Cygnus Solutions, a Red Hat company
Index: uinfo.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/uinfo.cc,v
retrieving revision 1.13
diff -u -p -r1.13 uinfo.cc
--- uinfo.cc	2000/07/02 10:17:44	1.13
+++ uinfo.cc	2000/07/22 10:09:19
@@ -18,6 +18,11 @@ details. */
 #include <wchar.h>
 #include <lm.h>
 
+#define sys_wcstombs(tgt,src,len) \
+                    WideCharToMultiByte(CP_ACP,0,(src),-1,(tgt),(len),NULL,NULL)
+#define sys_mbstowcs(tgt,src,len) \
+                    MultiByteToWideChar(CP_ACP,0,(src),-1,(tgt),(len))
+
 char *
 internal_getlogin (struct pinfo *pi)
 {
@@ -30,34 +35,33 @@ internal_getlogin (struct pinfo *pi)
   if (os_being_run == winNT)
     {
       LPWKSTA_USER_INFO_1 wui;
-      char buf[256], *env;
+      char buf[MAX_PATH], *env;
+      char *un = NULL;
 
       /* First trying to get logon info from environment */
-      buf[0] = '\0';
       if ((env = getenv ("USERNAME")) != NULL)
-        strcpy (buf, env);
+        un = env;
       if ((env = getenv ("LOGONSERVER")) != NULL)
         strcpy (pi->logsrv, env + 2); /* filter leading double backslashes */
       if ((env = getenv ("USERDOMAIN")) != NULL)
         strcpy (pi->domain, env);
       /* Trust only if usernames are identical */
-      if (strcasematch (pi->username, buf) && pi->domain[0] && pi->logsrv[0])
+      if (un && strcasematch (pi->username, un)
+          && pi->domain[0] && pi->logsrv[0])
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
+          sys_wcstombs (pi->username, wui->wkui1_username, MAX_USER_NAME);
+          sys_wcstombs (pi->logsrv, wui->wkui1_logon_server, MAX_HOST_NAME);
+          sys_wcstombs (pi->domain, wui->wkui1_logon_domain,
+                        MAX_COMPUTERNAME_LENGTH + 1);
           /* Save values in environment */
           if (!strcasematch (pi->username, "SYSTEM")
               && pi->domain[0] && pi->logsrv[0])
             {
               LPUSER_INFO_3 ui = NULL;
-              WCHAR wbuf[256];
+              WCHAR wbuf[MAX_HOST_NAME + 2];
 
               strcat (strcpy (buf, "\\\\"), pi->logsrv);
               setenv ("USERNAME", pi->username, 1);
@@ -65,19 +69,25 @@ internal_getlogin (struct pinfo *pi)
               setenv ("USERDOMAIN", pi->domain, 1);
               /* HOMEDRIVE and HOMEPATH are wrong most of the time, too,
                  after changing user context! */
-              mbstowcs (wbuf, buf, 256);
+              sys_mbstowcs (wbuf, buf, MAX_HOST_NAME + 2);
               if (!NetUserGetInfo (NULL, wui->wkui1_username, 3, (LPBYTE *)&ui)
                   || !NetUserGetInfo (wbuf,wui->wkui1_username,3,(LPBYTE *)&ui))
                 {
-                  wcstombs (buf, ui->usri3_home_dir,  256);
+                  sys_wcstombs (buf, ui->usri3_home_dir, MAX_PATH);
                   if (!buf[0])
                     {
-                      wcstombs (buf, ui->usri3_home_dir_drive, 256);
+                      sys_wcstombs (buf, ui->usri3_home_dir_drive, MAX_PATH);
                       if (buf[0])
                         strcat (buf, "\\");
+                      else
+                        {
+                          env = getenv ("SYSTEMDRIVE");
+                          if (env && *env)
+                            strcat (strcpy (buf, env), "\\");
+                          else
+                            GetSystemDirectoryA (buf, MAX_PATH);
+                        }
                     }
-                  if (!buf[0])
-                    strcat (strcpy (buf, getenv ("SYSTEMDRIVE")), "\\");
                   setenv ("HOMEPATH", buf + 2, 1);
                   buf[2] = '\0';
                   setenv ("HOMEDRIVE", buf, 1);
