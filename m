Return-Path: <cygwin-patches-return-2299-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 4474 invoked by alias); 4 Jun 2002 02:37:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4423 invoked from network); 4 Jun 2002 02:37:48 -0000
Message-Id: <3.0.5.32.20020603223130.007f6e10@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Mon, 03 Jun 2002 19:37:00 -0000
To: Corinna Vinschen <cygwin-patches@cygwin.com>
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: Name aliasing in security.cc
In-Reply-To: <20020603190657.B22554@cygbert.vinschen.de>
References: <3.0.5.32.20020530215740.007fc380@mail.attbi.com>
 <3.0.5.32.20020530215740.007fc380@mail.attbi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1023172290==_"
X-SW-Source: 2002-q2/txt/msg00282.txt.bz2

--=====================_1023172290==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 1323

At 07:06 PM 6/3/2002 +0200, Corinna Vinschen wrote:
>On Thu, May 30, 2002 at 09:57:40PM -0400, Pierre A. Humblet wrote:
>> a) keep lookup_name() as it is?
>> b) remove it entirely?
>
>I think b) is the way to go.  IMHO we should deprecate using ntsec
>w/o SID in the passwd/group files.

Here it is. Lots of trivial changes. Tested by running chown.

Pierre

2002-06-03  Pierre Humblet <pierre.humblet@ieee.org>

	* sec_helper.cc (lookup_name): Suppress.
	* security.cc (alloc_sd): Remove logsrv argument.
	Remove two calls to lookup_name.
	(set_security_attribute): Remove logsrv argument.
	Remove logsrv argument in call to alloc_sd.
	(set_nt_attribute): Remove logsrv argument.
	Remove logsrv argument in call to set_security_attribute.
	(set_file_attribute): Remove logsrv argument.
	Remove logsrv argument in call to set_nt_attribute.
	(set_file_attribute): Remove logsrv argument.
	Remove logsrv argument in call to set_file_attribute.
	* syscalls.cc (chown_worker): Remove logserver argument in
	call to set_file_attribute.
	(chmod): Ditto.
	* shm.cc (shmget): Remove logsrv argument in call to alloc_sd.
	* uinfo.cc (internal_getlogin): Replace calls to
	lookup_name by call to LookupAccountName.
	* security.h: Remove logsrv in declarations of set_file_attribute
	and alloc_sd. Remove declaration of lookup_name.


--=====================_1023172290==_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="sec_helper.cc.diff"
Content-length: 429

--- sec_helper.cc.orig	2002-06-03 18:20:48.000000000 -0400
+++ sec_helper.cc	2002-06-03 18:27:30.000000000 -0400
@@ -266,6 +266,7 @@
   return grp_member;
 }
 
+#if 0 // unused
 #define SIDLEN	(sidlen = MAX_SID_LEN, &sidlen)
 #define DOMLEN	(domlen = INTERNET_MAX_HOST_NAME_LENGTH, &domlen)
 
@@ -334,6 +335,7 @@
 
 #undef SIDLEN
 #undef DOMLEN
+#endif //unused
 
 int
 set_process_privilege (const char *privilege, BOOL enable)

--=====================_1023172290==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="security.cc.diff"
Content-length: 2386

--- security.cc.orig	2002-06-03 18:20:48.000000000 -0400
+++ security.cc	2002-06-03 18:51:12.000000000 -0400
@@ -1353,7 +1353,7 @@
 }

 PSECURITY_DESCRIPTOR
-alloc_sd (__uid32_t uid, __gid32_t gid, const char *logsrv, int attribute,
+alloc_sd (__uid32_t uid, __gid32_t gid, int attribute,
 	  PSECURITY_DESCRIPTOR sd_ret, DWORD *sd_size_ret)
 {
   BOOL dummy;
@@ -1372,8 +1372,7 @@
   cygsid owner_sid;
   struct passwd *pw =3D getpwuid32 (uid);
   strcpy (owner, pw ? pw->pw_name : getlogin ());
-  if ((!pw || !owner_sid.getfrompw (pw))
-      && !lookup_name (owner, logsrv, owner_sid))
+  if (!pw || !owner_sid.getfrompw (pw))
     return NULL;
   debug_printf ("owner: %s [%d]", owner,
 		*GetSidSubAuthority(owner_sid,
@@ -1384,8 +1383,7 @@
   struct __group32 *grp =3D getgrgid32 (gid);
   if (grp)
     {
-      if ((!grp || !group_sid.getfromgr (grp))
-	  && !lookup_name (grp->gr_name, logsrv, group_sid))
+      if (!grp || !group_sid.getfromgr (grp))
 	return NULL;
     }
   else
@@ -1616,14 +1614,13 @@
   InitializeSecurityDescriptor ((PSECURITY_DESCRIPTOR)sd_buf,
 				SECURITY_DESCRIPTOR_REVISION);
   psa->lpSecurityDescriptor =3D alloc_sd (geteuid32 (), getegid32 (),
-					cygheap->user.logsrv (),
 					attribute, (PSECURITY_DESCRIPTOR)sd_buf,
 					&sd_buf_size);
 }

 static int
 set_nt_attribute (const char *file, __uid32_t uid, __gid32_t gid,
-		  const char *logsrv, int attribute)
+		  int attribute)
 {
   if (!wincap.has_security ())
     return 0;
@@ -1640,7 +1637,7 @@
     }

   sd_size =3D 4096;
-  if (!(psd =3D alloc_sd (uid, gid, logsrv, attribute, psd, &sd_size)))
+  if (!(psd =3D alloc_sd (uid, gid, attribute, psd, &sd_size)))
     return -1;

   return write_sd (file, psd, sd_size);
@@ -1649,12 +1646,12 @@
 int
 set_file_attribute (int use_ntsec, const char *file,
 		    __uid32_t uid, __gid32_t gid,
-		    int attribute, const char *logsrv)
+		    int attribute)
 {
   int ret =3D 0;

   if (use_ntsec && allow_ntsec)
-    ret =3D set_nt_attribute (file, uid, gid, logsrv, attribute);
+    ret =3D set_nt_attribute (file, uid, gid, attribute);
   else if (allow_ntea && !NTWriteEA (file, ".UNIXATTR", (char *) &attribut=
e,
 				     sizeof (attribute)))
     {
@@ -1671,5 +1668,5 @@
 {
   return set_file_attribute (use_ntsec, file,
 			     myself->uid, myself->gid,
-			     attribute, cygheap->user.logsrv ());
+			     attribute);
 }

--=====================_1023172290==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="security.h.diff"
Content-length: 1780

--- security.h.orig	2002-06-03 18:20:50.000000000 -0400
+++ security.h	2002-06-03 19:59:46.000000000 -0400
@@ -168,7 +168,7 @@
 int __stdcall get_file_attribute (int, const char *, int *,
 				  __uid32_t * =3D NULL, __gid32_t * =3D NULL);
 int __stdcall set_file_attribute (int, const char *, int);
-int __stdcall set_file_attribute (int, const char *, __uid32_t, __gid32_t,=
 int, const char *);
+int __stdcall set_file_attribute (int, const char *, __uid32_t, __gid32_t,=
 int);
 LONG __stdcall read_sd(const char *file, PSECURITY_DESCRIPTOR sd_buf, LPDW=
ORD sd_size);
 LONG __stdcall write_sd(const char *file, PSECURITY_DESCRIPTOR sd_buf, DWO=
RD sd_size);
 BOOL __stdcall add_access_allowed_ace (PACL acl, int offset, DWORD attribu=
tes, PSID sid, size_t &len_add, DWORD inherit);
@@ -191,10 +191,6 @@

 /* sec_helper.cc: Security helper functions. */
 BOOL __stdcall is_grp_member (__uid32_t uid, __gid32_t gid);
-/* `lookup_name' should be called instead of LookupAccountName.
- * logsrv may be NULL, in this case only the local system is used for look=
up.
- * The buffer for ret_sid (40 Bytes) has to be allocated by the caller! */
-BOOL __stdcall lookup_name (const char *, const char *, PSID);
 int set_process_privilege (const char *privilege, BOOL enable =3D TRUE);

 /* shared.cc: */
@@ -209,7 +205,7 @@

 int __stdcall NTReadEA (const char *file, const char *attrname, char *buf,=
 int len);
 BOOL __stdcall NTWriteEA (const char *file, const char *attrname, const ch=
ar *buf, int len);
-PSECURITY_DESCRIPTOR alloc_sd (__uid32_t uid, __gid32_t gid, const char *l=
ogsrv, int attribute,
+PSECURITY_DESCRIPTOR alloc_sd (__uid32_t uid, __gid32_t gid, int attribute,
           PSECURITY_DESCRIPTOR sd_ret, DWORD *sd_size_ret);

 extern inline SECURITY_ATTRIBUTES *

--=====================_1023172290==_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="shm.cc.diff"
Content-length: 448

--- shm.cc.orig	2002-05-29 19:48:00.000000000 -0400
+++ shm.cc	2002-06-03 18:30:28.000000000 -0400
@@ -461,7 +461,7 @@
   /* create a sd for our open requests based on shmflag & 0x01ff */
   InitializeSecurityDescriptor (psd,
 				    SECURITY_DESCRIPTOR_REVISION);
-  psd = alloc_sd (getuid32 (), getgid32 (), cygheap->user.logsrv (),
+  psd = alloc_sd (getuid32 (), getgid32 (),
 		  shmflg & 0x01ff, psd, &sd_size);
 
   if (key == (key_t) - 1)

--=====================_1023172290==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="uinfo.cc.diff"
Content-length: 1217

--- uinfo.cc.orig	2002-06-03 18:20:52.000000000 -0400
+++ uinfo.cc	2002-06-03 20:42:16.000000000 -0400
@@ -150,17 +150,19 @@
 	 and a domain user may have the same name. */
       if (!ret && user.domain ())
 	{
+	  char domain[DNLEN + 1];
+	  DWORD dlen =3D sizeof (domain);
+	  siz =3D sizeof (tu);
+	  SID_NAME_USE use =3D SidTypeInvalid;
 	  /* Concat DOMAIN\USERNAME for the next lookup */
 	  strcat (strcat (strcpy (buf, user.domain ()), "\\"), user.name ());
-	  if (!(ret =3D lookup_name (buf, NULL, user.sid ())))
-	    debug_printf ("Couldn't retrieve SID locally!");
-	}
+          if (!LookupAccountName (NULL, buf, tu, &siz,
+	                          domain, &dlen, &use) ||
+               !legal_sid_type (use))
+	        debug_printf ("Couldn't retrieve SID locally!");
+	  else user.set_sid (tu);

-      /* If that fails, too, as a last resort try to get the SID from
-	 the logon server. */
-      if (!ret && !(ret =3D lookup_name (user.name (), user.logsrv (),
-				       user.sid ())))
-	debug_printf ("Couldn't retrieve SID from '%s'!", user.logsrv ());
+	}

       /* If we have a SID, try to get the corresponding Cygwin user name
 	 which can be different from the Windows user name. */

--=====================_1023172290==_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="syscalls.cc.diff"
Content-length: 627

--- syscalls.cc.orig	2002-06-03 18:23:44.000000000 -0400
+++ syscalls.cc	2002-06-03 20:07:06.000000000 -0400
@@ -798,7 +798,7 @@
 	  if (win32_path.isdir())
 	    attrib |= S_IFDIR;
 	  res = set_file_attribute (win32_path.has_acls (), win32_path, uid,
-				    gid, attrib, cygheap->user.logsrv ());
+				    gid, attrib);
 	}
       if (res != 0 && (!win32_path.has_acls () || !allow_ntsec))
 	{
@@ -926,7 +926,7 @@
       if (win32_path.isdir ())
 	mode |= S_IFDIR;
       if (!set_file_attribute (win32_path.has_acls (), win32_path, uid, gid,
-				mode, cygheap->user.logsrv ())
+				mode)
 	  && allow_ntsec)
 	res = 0;
 

--=====================_1023172290==_--
