Return-Path: <cygwin-patches-return-3457-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6393 invoked by alias); 24 Jan 2003 14:50:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6382 invoked from network); 24 Jan 2003 14:50:04 -0000
Date: Fri, 24 Jan 2003 14:50:00 -0000
From: Jason Tishler <jason@tishler.net>
Subject: setregid() and setreuid() patch
To: Cygwin-Patches <cygwin-patches@cygwin.com>
Mail-followup-to: Cygwin-Patches <cygwin-patches@cygwin.com>
Message-id: <20030124145520.GA612@tishler.net>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_upkry2A9Fy2kDGTwbQCGIA)"
User-Agent: Mutt/1.4i
X-SW-Source: 2003-q1/txt/msg00106.txt.bz2


--Boundary_(ID_upkry2A9Fy2kDGTwbQCGIA)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
Content-length: 303

The attached patch implements setregid() and setreuid() as recommended
by Pierre in:

    http://cygwin.com/ml/cygwin-developers/2003-01/msg00115.html

Thanks,
Jason

-- 
PGP/GPG Key: http://www.tishler.net/jason/pubkey.asc or key servers
Fingerprint: 7A73 1405 7F2B E669 C19D  8784 1AFD E4CC ECF4 8EF6

--Boundary_(ID_upkry2A9Fy2kDGTwbQCGIA)
Content-type: text/plain; charset=us-ascii; NAME=setreuid.patch
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=setreuid.patch
Content-length: 3541

Index: cygwin.din
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v
retrieving revision 1.75
diff -u -p -r1.75 cygwin.din
--- cygwin.din	22 Jan 2003 10:43:38 -0000	1.75
+++ cygwin.din	24 Jan 2003 14:29:17 -0000
@@ -715,6 +715,12 @@ setlocale
 _setlocale = setlocale
 setpgid
 _setpgid = setpgid
+setregid
+_setregid = setregid
+setregid32
+setreuid
+_setreuid = setreuid
+setreuid32
 setrlimit
 _setrlimit = setrlimit
 setsid
Index: syscalls.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.240
diff -u -p -r1.240 syscalls.cc
--- syscalls.cc	15 Jan 2003 10:21:23 -0000	1.240
+++ syscalls.cc	24 Jan 2003 14:29:17 -0000
@@ -2131,6 +2131,31 @@ setuid (__uid16_t uid)
   return setuid32 (uid16touid32 (uid));
 }
 
+extern "C" int
+setreuid32 (__uid32_t ruid, __uid32_t euid)
+{
+  int ret = 0;
+  bool tried = false;
+  __uid32_t old_euid = myself->uid;
+
+  if (ruid != ILLEGAL_UID && cygheap->user.real_uid != ruid && euid != ruid)
+    tried = !(ret = seteuid32 (ruid));
+  if (!ret && euid != ILLEGAL_UID)
+    ret = seteuid32 (euid);
+  if (tried && (ret || euid == ILLEGAL_UID) && seteuid32 (old_euid))
+    system_printf ("Cannot restore original euid %u", old_euid);
+  if (!ret && ruid != ILLEGAL_UID)
+    cygheap->user.real_uid = ruid;
+  debug_printf ("real: %u, effective: %u", cygheap->user.real_uid, myself->uid);
+  return ret;
+}
+
+extern "C" int
+setreuid (__uid32_t ruid, __uid32_t euid)
+{
+  return setreuid32 (uid16touid32 (ruid), uid16touid32 (euid));
+}
+
 /* setegid: from System V.  */
 extern "C" int
 setegid32 (__gid32_t gid)
@@ -2207,6 +2232,31 @@ setgid (__gid16_t gid)
   if (!ret)
     cygheap->user.real_gid = myself->gid;
   return ret;
+}
+
+extern "C" int
+setregid32 (__gid32_t rgid, __gid32_t egid)
+{
+  int ret = 0;
+  bool tried = false;
+  __gid32_t old_egid = myself->gid;
+
+  if (rgid != ILLEGAL_GID && cygheap->user.real_gid != rgid && egid != rgid)
+    tried = !(ret = setegid32 (rgid));
+  if (!ret && egid != ILLEGAL_GID)
+    ret = setegid32 (egid);
+  if (tried && (ret || egid == ILLEGAL_GID) && setegid32 (old_egid))
+    system_printf ("Cannot restore original egid %u", old_egid);
+  if (!ret && rgid != ILLEGAL_GID)
+    cygheap->user.real_gid = rgid;
+  debug_printf ("real: %u, effective: %u", cygheap->user.real_gid, myself->gid);
+  return ret;
+}
+
+extern "C" int
+setregid (__gid32_t rgid, __gid32_t egid)
+{
+  return setregid32 (gid16togid32 (rgid), gid16togid32 (egid));
 }
 
 /* chroot: privileged Unix system call.  */
Index: include/cygwin/version.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/version.h,v
retrieving revision 1.98
diff -u -p -r1.98 version.h
--- include/cygwin/version.h	22 Jan 2003 10:43:39 -0000	1.98
+++ include/cygwin/version.h	24 Jan 2003 14:29:17 -0000
@@ -170,12 +170,13 @@ details. */
        70: Export asprintf, _asprintf_r, vasprintf, _vasprintf_r
        71: Export strerror_r
        72: Export nanosleep
+       73: Export setreuid32, setreuid, setregid32, setregid
      */
 
      /* Note that we forgot to bump the api for ualarm, strtoll, strtoull */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 72
+#define CYGWIN_VERSION_API_MINOR 73
 
      /* There is also a compatibity version number associated with the
 	shared memory regions.  It is incremented when incompatible

--Boundary_(ID_upkry2A9Fy2kDGTwbQCGIA)
Content-type: text/plain; charset=us-ascii; NAME=setreuid.ChangeLog
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=setreuid.ChangeLog
Content-length: 316

2003-01-24  Pierre Humblet <pierre.humblet@ieee.org>
	    Jason Tishler  <jason@tishler.net>

	* cygwin.din: Export setreuid32, setreuid, setregid32, setregid
	* syscalls.cc (setreuid32): New function.
	(setreuid): Ditto.
	(setregid32): Ditto.
	(setregid): Ditto.
	* include/cygwin/version.h: Bump API minor number.

--Boundary_(ID_upkry2A9Fy2kDGTwbQCGIA)--
