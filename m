Return-Path: <cygwin-patches-return-3782-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24245 invoked by alias); 2 Apr 2003 20:19:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24230 invoked from network); 2 Apr 2003 20:19:37 -0000
Date: Wed, 02 Apr 2003 20:19:00 -0000
From: Jason Tishler <jason@tishler.net>
Subject: Re: cygwin_internal(CW_CHECK_NTSEC, filename) patch
In-reply-to: <20030402183304.GD3147@redhat.com>
To: cygwin-patches@cygwin.com
Mail-followup-to: cygwin-patches@cygwin.com
Message-id: <20030402191854.GA532@tishler.net>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_vJOVSFTCl/esHZK/mhCC3w)"
User-Agent: Mutt/1.4i
References: <20030402131626.GA1888@tishler.net>
 <20030402154258.GA2614@redhat.com> <20030402182213.GA3064@tishler.net>
 <20030402183304.GD3147@redhat.com>
X-SW-Source: 2003-q2/txt/msg00009.txt.bz2


--Boundary_(ID_vJOVSFTCl/esHZK/mhCC3w)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
Content-length: 400

On Wed, Apr 02, 2003 at 01:33:04PM -0500, Christopher Faylor wrote:
> If you just do a path_conv on a path, you can check the 'has_acls ()'
> flag.  I think this just devolves to "allow_ntsec &&
> win32_path.has_acls ()".

See attached for take 2.

Thanks,
Jason

-- 
PGP/GPG Key: http://www.tishler.net/jason/pubkey.asc or key servers
Fingerprint: 7A73 1405 7F2B E669 C19D  8784 1AFD E4CC ECF4 8EF6

--Boundary_(ID_vJOVSFTCl/esHZK/mhCC3w)
Content-type: text/plain; charset=us-ascii; NAME=check_ntsec2.patch
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=check_ntsec2.patch
Content-length: 2380

Index: external.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/external.cc,v
retrieving revision 1.50
diff -u -p -u -p -r1.50 external.cc
--- external.cc	28 Mar 2003 14:21:40 -0000	1.50
+++ external.cc	2 Apr 2003 19:15:15 -0000
@@ -121,6 +121,13 @@ get_cygdrive_prefixes (char *user, char 
   return res;
 }
 
+static DWORD
+check_ntsec (const char *filename)
+{
+  path_conv pc (filename);
+  return allow_ntsec && pc.has_acls ();
+}
+
 extern "C" unsigned long
 cygwin_internal (cygwin_getinfo_types t, ...)
 {
@@ -246,6 +253,11 @@ cygwin_internal (cygwin_getinfo_types t,
 	  pid_t pid = va_arg (arg, pid_t);
 	  pinfo p (pid);
 	  return (DWORD) p->cmdline (n);
+	}
+      case CW_CHECK_NTSEC:
+	{
+	  char *filename = va_arg (arg, char *);
+	  return check_ntsec (filename);
 	}
       default:
 	return (DWORD) -1;
Index: include/cygwin/version.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/version.h,v
retrieving revision 1.112
diff -u -p -u -p -r1.112 version.h
--- include/cygwin/version.h	19 Mar 2003 20:13:57 -0000	1.112
+++ include/cygwin/version.h	2 Apr 2003 19:15:15 -0000
@@ -197,12 +197,13 @@ details. */
 		  fgetpos64 fopen64 freopen64 fseeko64 fsetpos64 ftello64
 		  _open64 _lseek64 _fstat64 _stat64 mknod32
        80: Export pthread_rwlock stuff
+       81: CW_CHECK_NTSEC addition to external.cc
      */
 
      /* Note that we forgot to bump the api for ualarm, strtoll, strtoull */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 80
+#define CYGWIN_VERSION_API_MINOR 81
 
      /* There is also a compatibity version number associated with the
 	shared memory regions.  It is incremented when incompatible
Index: include/sys/cygwin.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/sys/cygwin.h,v
retrieving revision 1.42
diff -u -p -u -p -r1.42 cygwin.h
--- include/sys/cygwin.h	28 Mar 2003 14:21:40 -0000	1.42
+++ include/sys/cygwin.h	2 Apr 2003 19:15:15 -0000
@@ -71,7 +71,8 @@ typedef enum
     CW_STRACE_ACTIVE,
     CW_CYGWIN_PID_TO_WINPID,
     CW_EXTRACT_DOMAIN_AND_USER,
-    CW_CMDLINE
+    CW_CMDLINE,
+    CW_CHECK_NTSEC
   } cygwin_getinfo_types;
 
 #define CW_NEXTPID	0x80000000	/* or with pid to get next one */

--Boundary_(ID_vJOVSFTCl/esHZK/mhCC3w)
Content-type: text/plain; charset=us-ascii; NAME=check_ntsec2.ChangeLog
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=check_ntsec2.ChangeLog
Content-length: 343

2003-04-02  Jason Tishler <jason@tishler.net>
	    Christopher Faylor  <cgf@redhat.com>

	* external.cc (check_ntsec): New function.
	(cygwin_internal): Add CW_CHECK_NTSEC handling to call check_ntsec()
	from applications.
	* include/cygwin/version.h: Bump API minor number.
	* include/sys/cygwin.h (cygwin_getinfo_types): Add CW_CHECK_NTSEC.

--Boundary_(ID_vJOVSFTCl/esHZK/mhCC3w)--
