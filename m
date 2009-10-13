Return-Path: <cygwin-patches-return-6765-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1294 invoked by alias); 13 Oct 2009 12:51:52 -0000
Received: (qmail 1160 invoked by uid 22791); 13 Oct 2009 12:51:48 -0000
X-SWARE-Spam-Status: No, hits=-2.0 required=5.0 	tests=AWL,BAYES_00,SPF_SOFTFAIL
X-Spam-Check-By: sourceware.org
Received: from qmta08.emeryville.ca.mail.comcast.net (HELO QMTA08.emeryville.ca.mail.comcast.net) (76.96.30.80)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 13 Oct 2009 12:51:41 +0000
Received: from OMTA13.emeryville.ca.mail.comcast.net ([76.96.30.52]) 	by QMTA08.emeryville.ca.mail.comcast.net with comcast 	id sCeN1c00917UAYkA8Crgti; Tue, 13 Oct 2009 12:51:40 +0000
Received: from [192.168.0.101] ([24.10.247.15]) 	by OMTA13.emeryville.ca.mail.comcast.net with comcast 	id sCrf1c0020Lg2Gw8ZCrgks; Tue, 13 Oct 2009 12:51:40 +0000
Message-ID: <4AD477DC.9040004@byu.net>
Date: Tue, 13 Oct 2009 12:51:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: missing va_end calls
Content-Type: multipart/mixed;  boundary="------------070009080408000806040702"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00096.txt.bz2

This is a multi-part message in MIME format.
--------------070009080408000806040702
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 748

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

As promised:

2009-10-13  Eric Blake  <ebb9@byu.net>

	* external.cc (cygwin_internal): Use va_end.
	* fork.cc (child_copy): Likewise.
	* libc/bsdlib.cc (warn, warnx, err, errx): Likewise.
	* pinfo.cc (commune_request): Likewise.
	* strace.cc (strace::prntf, strace_printf): Likewise.

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkrUd9wACgkQ84KuGfSFAYAmgwCffKq34Hs/iAR5y7O3sn9xhxZY
gRQAoJO3qzV6vCwFgxDWrI0eTJRxHk9D
=xgz5
-----END PGP SIGNATURE-----

--------------070009080408000806040702
Content-Type: text/plain;
 name="cygwin.patch31"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin.patch31"
Content-length: 10142


---
 winsup/cygwin/external.cc    |  122 +++++++++++++++++++++++++++--------------
 winsup/cygwin/fork.cc        |    2 +
 winsup/cygwin/libc/bsdlib.cc |    4 ++
 winsup/cygwin/pinfo.cc       |    4 +-
 winsup/cygwin/strace.cc      |    2 +
 5 files changed, 90 insertions(+), 44 deletions(-)

diff --git a/winsup/cygwin/external.cc b/winsup/cygwin/external.cc
index d42971d..27050d5 100644
--- a/winsup/cygwin/external.cc
+++ b/winsup/cygwin/external.cc
@@ -197,34 +197,42 @@ extern "C" unsigned long
 cygwin_internal (cygwin_getinfo_types t, ...)
 {
   va_list arg;
+  unsigned long result = -1;
   va_start (arg, t);

   switch (t)
     {
       case CW_LOCK_PINFO:
-	return 1;
+	result = 1;
+	break;

       case CW_UNLOCK_PINFO:
-	return 1;
+	result = 1;
+	break;

       case CW_GETTHREADNAME:
-	return (DWORD) cygthread::name (va_arg (arg, DWORD));
+	result = (DWORD) cygthread::name (va_arg (arg, DWORD));
+	break;

       case CW_SETTHREADNAME:
 	{
 	  set_errno (ENOSYS);
-	  return 0;
+	  result = 0;
 	}
+	break;

       case CW_GETPINFO:
-	return (DWORD) fillout_pinfo (va_arg (arg, DWORD), 0);
+	result = (DWORD) fillout_pinfo (va_arg (arg, DWORD), 0);
+	break;

       case CW_GETVERSIONINFO:
-	return (DWORD) cygwin_version_strings;
+	result = (DWORD) cygwin_version_strings;
+	break;

       case CW_READ_V1_MOUNT_TABLES:
 	set_errno (ENOSYS);
-	return 1;
+	result = 1;
+	break;

       case CW_USER_DATA:
 	/* This is a kludge to work around a version of _cygwin_common_crt0
@@ -232,25 +240,30 @@ cygwin_internal (cygwin_getinfo_types t, ...)
 	   Hilarity ensues if the DLL is not loaded like while the process
 	   is forking. */
 	__cygwin_user_data.cxx_malloc = &default_cygwin_cxx_malloc;
-	return (DWORD) &__cygwin_user_data;
+	result = (DWORD) &__cygwin_user_data;
+	break;

       case CW_PERFILE:
 	perfile_table = va_arg (arg, struct __cygwin_perfile *);
-	return 0;
+	result = 0;
+	break;

       case CW_GET_CYGDRIVE_PREFIXES:
 	{
 	  char *user = va_arg (arg, char *);
 	  char *system = va_arg (arg, char *);
-	  return get_cygdrive_info (user, system, NULL, NULL);
+	  result = get_cygdrive_info (user, system, NULL, NULL);
 	}
+	break;

       case CW_GETPINFO_FULL:
-	return (DWORD) fillout_pinfo (va_arg (arg, pid_t), 1);
+	result = (DWORD) fillout_pinfo (va_arg (arg, pid_t), 1);
+	break;

       case CW_INIT_EXCEPTIONS:
 	/* noop */ /* init_exceptions (va_arg (arg, exception_list *)); */
-	return 0;
+	result = 0;
+	break;

       case CW_GET_CYGDRIVE_INFO:
 	{
@@ -258,12 +271,14 @@ cygwin_internal (cygwin_getinfo_types t, ...)
 	  char *system = va_arg (arg, char *);
 	  char *user_flags = va_arg (arg, char *);
 	  char *system_flags = va_arg (arg, char *);
-	  return get_cygdrive_info (user, system, user_flags, system_flags);
+	  result = get_cygdrive_info (user, system, user_flags, system_flags);
 	}
+	break;

       case CW_SET_CYGWIN_REGISTRY_NAME:
       case CW_GET_CYGWIN_REGISTRY_NAME:
-	return 0;
+	result = 0;
+	break;

       case CW_STRACE_TOGGLE:
 	{
@@ -272,25 +287,28 @@ cygwin_internal (cygwin_getinfo_types t, ...)
 	  if (p)
 	    {
 	      sig_send (p, __SIGSTRACE);
-	      return 0;
+	      result = 0;
 	    }
 	  else
 	    {
 	      set_errno (ESRCH);
-	      return (DWORD) -1;
+	      result = (DWORD) -1;
 	    }
 	}
+	break;

       case CW_STRACE_ACTIVE:
 	{
-	  return strace.active ();
+	  result = strace.active ();
 	}
+	break;

       case CW_CYGWIN_PID_TO_WINPID:
 	{
 	  pinfo p (va_arg (arg, pid_t));
-	  return p ? p->dwProcessId : 0;
+	  result = p ? p->dwProcessId : 0;
 	}
+	break;
       case CW_EXTRACT_DOMAIN_AND_USER:
 	{
 	  WCHAR nt_domain[MAX_DOMAIN_NAME_LEN + 1];
@@ -304,26 +322,30 @@ cygwin_internal (cygwin_getinfo_types t, ...)
 	    sys_wcstombs (domain, MAX_DOMAIN_NAME_LEN + 1, nt_domain);
 	  if (user)
 	    sys_wcstombs (user, UNLEN + 1, nt_user);
-	  return 0;
+	  result = 0;
 	}
+	break;
       case CW_CMDLINE:
 	{
 	  size_t n;
 	  pid_t pid = va_arg (arg, pid_t);
 	  pinfo p (pid);
-	  return (DWORD) p->cmdline (n);
+	  result = (DWORD) p->cmdline (n);
 	}
+	break;
       case CW_CHECK_NTSEC:
 	{
 	  char *filename = va_arg (arg, char *);
-	  return check_ntsec (filename);
+	  result = check_ntsec (filename);
 	}
+	break;
       case CW_GET_ERRNO_FROM_WINERROR:
 	{
 	  int error = va_arg (arg, int);
 	  int deferrno = va_arg (arg, int);
-	  return geterrno_from_win_error (error, deferrno);
+	  result = geterrno_from_win_error (error, deferrno);
 	}
+	break;
       case CW_GET_POSIX_SECURITY_ATTRIBUTE:
 	{
 	  path_conv dummy;
@@ -334,24 +356,31 @@ cygwin_internal (cygwin_getinfo_types t, ...)
 	  DWORD sd_buf_size = va_arg (arg, DWORD);
 	  set_security_attribute (dummy, attribute, psa, sd);
 	  if (!psa->lpSecurityDescriptor)
-	    return sd.size ();
-	  psa->lpSecurityDescriptor = sd_buf;
-	  return sd.copy (sd_buf, sd_buf_size);
+	    result = sd.size ();
+	  else
+	    {
+	      psa->lpSecurityDescriptor = sd_buf;
+	      result = sd.copy (sd_buf, sd_buf_size);
+	    }
 	}
+	break;
       case CW_GET_SHMLBA:
 	{
-	  return getpagesize ();
+	  result = getpagesize ();
 	}
+	break;
       case CW_GET_UID_FROM_SID:
 	{
 	  cygpsid psid = va_arg (arg, PSID);
-	  return psid.get_id (false, NULL);
+	  result = psid.get_id (false, NULL);
 	}
+	break;
       case CW_GET_GID_FROM_SID:
 	{
 	  cygpsid psid = va_arg (arg, PSID);
-	  return psid.get_id (true, NULL);
+	  result = psid.get_id (true, NULL);
 	}
+	break;
       case CW_GET_BINMODE:
 	{
 	  const char *path = va_arg (arg, const char *);
@@ -359,54 +388,62 @@ cygwin_internal (cygwin_getinfo_types t, ...)
 	  if (p.error)
 	    {
 	      set_errno (p.error);
-	      return (unsigned long) -1;
+	      result = (unsigned long) -1;
 	    }
-	  return p.binmode ();
+	  else
+	    result = p.binmode ();
 	}
+	break;
       case CW_HOOK:
 	{
 	  const char *name = va_arg (arg, const char *);
 	  const void *hookfn = va_arg (arg, const void *);
 	  WORD subsys;
-	  return (unsigned long) hook_or_detect_cygwin (name, hookfn, subsys);
+	  result = (unsigned long) hook_or_detect_cygwin (name, hookfn, subsys);
 	}
+	break;
       case CW_ARGV:
 	{
 	  child_info_spawn *ci = (child_info_spawn *) get_cygwin_startup_info ();
-	  return (unsigned long) (ci ? ci->moreinfo->argv : NULL);
+	  result = (unsigned long) (ci ? ci->moreinfo->argv : NULL);
 	}
+	break;
       case CW_ENVP:
 	{
 	  child_info_spawn *ci = (child_info_spawn *) get_cygwin_startup_info ();
-	  return (unsigned long) (ci ? ci->moreinfo->envp : NULL);
+	  result = (unsigned long) (ci ? ci->moreinfo->envp : NULL);
 	}
+	break;
       case CW_DEBUG_SELF:
 	error_start_init (va_arg (arg, const char *));
 	try_to_debug ();
 	break;
       case CW_SYNC_WINENV:
 	sync_winenv ();
-	return 0;
+	result = 0;
+	break;
       case CW_CYGTLS_PADSIZE:
-	return CYGTLS_PADSIZE;
+	result = CYGTLS_PADSIZE;
+	break;
       case CW_SET_DOS_FILE_WARNING:
 	{
 	  extern bool dos_file_warning;
 	  dos_file_warning = va_arg (arg, int);
-	  return 0;
+	  result = 0;
 	}
 	break;
       case CW_SET_PRIV_KEY:
 	{
 	  const char *passwd = va_arg (arg, const char *);
-	  return setlsapwd (passwd);
+	  result = setlsapwd (passwd);
 	}
+	break;
       case CW_SETERRNO:
 	{
 	  const char *file = va_arg (arg, const char *);
 	  int line = va_arg (arg, int);
 	  seterrno(file, line);
-	  return 0;
+	  result = 0;
 	}
 	break;
       case CW_EXIT_PROCESS:
@@ -420,12 +457,13 @@ cygwin_internal (cygwin_getinfo_types t, ...)
 	  HANDLE token = va_arg (arg, HANDLE);
 	  int type = va_arg (arg, int);
 	  set_imp_token (token, type);
-	  return 0;
+	  result = 0;
 	}
+	break;

       default:
-	break;
+	set_errno (ENOSYS);
     }
-  set_errno (ENOSYS);
-  return (unsigned long) -1;
+  va_end (arg);
+  return result;
 }
diff --git a/winsup/cygwin/fork.cc b/winsup/cygwin/fork.cc
index 49ff2e1..ac2e9ca 100644
--- a/winsup/cygwin/fork.cc
+++ b/winsup/cygwin/fork.cc
@@ -758,10 +758,12 @@ child_copy (HANDLE hp, bool write, ...)
 	}
     }

+  va_end (args);
   debug_printf ("done");
   return true;

  err:
+  va_end (args);
   TerminateProcess (hp, 1);
   set_errno (EAGAIN);
   return false;
diff --git a/winsup/cygwin/libc/bsdlib.cc b/winsup/cygwin/libc/bsdlib.cc
index 92677d8..61797e4 100644
--- a/winsup/cygwin/libc/bsdlib.cc
+++ b/winsup/cygwin/libc/bsdlib.cc
@@ -181,6 +181,7 @@ warn (const char *fmt, ...)
   va_list ap;
   va_start (ap, fmt);
   vwarn (fmt, ap);
+  va_end (ap);
 }

 extern "C" void
@@ -189,6 +190,7 @@ warnx (const char *fmt, ...)
   va_list ap;
   va_start (ap, fmt);
   vwarnx (fmt, ap);
+  va_end (ap);
 }

 extern "C" void
@@ -211,6 +213,7 @@ err (int eval, const char *fmt, ...)
   va_list ap;
   va_start (ap, fmt);
   vwarn (fmt, ap);
+  va_end (ap);
   exit (eval);
 }

@@ -220,6 +223,7 @@ errx (int eval, const char *fmt, ...)
   va_list ap;
   va_start (ap, fmt);
   vwarnx (fmt, ap);
+  va_end (ap);
   exit (eval);
 }

diff --git a/winsup/cygwin/pinfo.cc b/winsup/cygwin/pinfo.cc
index 0243ac8..cfbb4ee 100644
--- a/winsup/cygwin/pinfo.cc
+++ b/winsup/cygwin/pinfo.cc
@@ -584,8 +584,6 @@ _pinfo::commune_request (__uint32_t code, ...)
   HANDLE request_sync = NULL;
   bool locked = false;

-  va_start (args, code);
-
   res.s = NULL;
   res.n = 0;

@@ -595,6 +593,7 @@ _pinfo::commune_request (__uint32_t code, ...)
       goto err;
     }

+  va_start (args, code);
   si._si_commune._si_code = code;
   switch (code)
     {
@@ -608,6 +607,7 @@ _pinfo::commune_request (__uint32_t code, ...)

     break;
     }
+  va_end (args);

   locked = true;
   char name_buf[MAX_PATH];
diff --git a/winsup/cygwin/strace.cc b/winsup/cygwin/strace.cc
index 04fb0ee..fb62e29 100644
--- a/winsup/cygwin/strace.cc
+++ b/winsup/cygwin/strace.cc
@@ -274,6 +274,7 @@ strace::prntf (unsigned category, const char *func, const char *fmt, ...)

   va_start (ap, fmt);
   vprntf (category, func, fmt, ap);
+  va_end (ap);
 }

 extern "C" void
@@ -285,6 +286,7 @@ strace_printf (unsigned category, const char *func, const char *fmt, ...)
     {
       va_start (ap, fmt);
       strace.vprntf (category, func, fmt, ap);
+      va_end (ap);
     }
 }

-- 
1.6.5.rc1


--------------070009080408000806040702--
