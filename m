Return-Path: <cygwin-patches-return-2546-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 1851 invoked by alias); 29 Jun 2002 23:22:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1837 invoked from network); 29 Jun 2002 23:22:26 -0000
Message-Id: <3.0.5.32.20020629191915.0080d930@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Sun, 30 Jun 2002 05:57:00 -0000
To: Corinna Vinschen <cygwin-patches@cygwin.com>
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: Windows username in get_group_sidlist
In-Reply-To: <20020625112554.V22705@cygbert.vinschen.de>
References: <3D1726E7.4EC19839@ieee.org>
 <3.0.5.32.20020623235117.008008f0@mail.attbi.com>
 <20020624120506.Z22705@cygbert.vinschen.de>
 <20020624130226.GA19789@redhat.com>
 <20020624151450.G22705@cygbert.vinschen.de>
 <3D1726E7.4EC19839@ieee.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1025407155==_"
X-SW-Source: 2002-q2/txt/msg00529.txt.bz2

--=====================_1025407155==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 1722

At 11:25 AM 6/25/2002 +0200, Corinna Vinschen wrote:
>> I would actually read passwd by calling extract_nt_dom_user (),
>> modifying it to first read the domain from the passwd file, and 
>> if that fails, use LookupAccountSid [currently it tries 
>> LookupAccountSid first, getting the sid from passwd]. 
>
>Actually it sounds good.  Do you have a patch?

Corinna,

Here it is. Actually, here they are. You can choose. In both cases
extract_nt_dom_user () first reads domain\username name in gecos.
If that fails it reads the sid (again in gecos !) and calls 
LookupAccountSid.

The "strict" version wants to see "U-domain\username" to avoid falling back.
The "soft" version keeps some of the existing features (that are never
exercised in normal cases) and accepts also "U-username" and the cygwin
user name. In those two cases LookupAccountSid is also called (to try to 
fill the domain, overwriting the username from passwd if it succeeds). 
Note that the cygwin user name is never parsed for domain\user.

So "strict" and "soft" can only differ if the U- field is messed up AND 
if LookupAccountSid fails, ALTHOUGH the sid is good in gecos!
The sid must be good for the seteuid to work.

My preference would be to use the strict version, the other one is 
offered in the spirit of making minimal changes. If you adopt it, delete
the third line below.

Pierre

2002-06-29  Pierre Humblet <pierre.humblet@ieee.org>

	security.cc (extract_nt_dom_user): Check for all buffer overflows.
	Call LookupAccountSid after trying to get domain & user from passwd. 
	Only accept correct syntax for U-domain\username. 
	(get_group_sidlist): Obtain the domain and user by calling 
	extract_nt_dom_user instead of LookupAccountSid.


--=====================_1025407155==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="security.cc.diff.strict"
Content-length: 2675

--- security.cc.orig	2002-06-27 20:30:22.000000000 -0400
+++ security.cc	2002-06-29 16:36:10.000000000 -0400
@@ -60,43 +60,35 @@
 void
 extract_nt_dom_user (const struct passwd *pw, char *domain, char *user)
 {
-  cygsid psid;
-  DWORD ulen =3D UNLEN + 1;
-  DWORD dlen =3D INTERNET_MAX_HOST_NAME_LENGTH + 1;
-  SID_NAME_USE use;
-  char buf[INTERNET_MAX_HOST_NAME_LENGTH + UNLEN + 2];
-  char *c;
+  char *d, *u, *c;

-  strcpy (domain, "");
-  strcpy (buf, pw->pw_name);
   debug_printf ("pw_gecos =3D %x (%s)", pw->pw_gecos, pw->pw_gecos);

-  if (psid.getfrompw (pw) &&
-      LookupAccountSid (NULL, psid, user, &ulen, domain, &dlen, &use))
-    return;
-
-  if (pw->pw_gecos)
+  if ((d =3D strstr (pw->pw_gecos, "U-")) !=3D NULL &&
+      (d =3D=3D pw->pw_gecos || d[-1] =3D=3D ','))
     {
-      if ((c =3D strstr (pw->pw_gecos, "U-")) !=3D NULL &&
-	  (c =3D=3D pw->pw_gecos || c[-1] =3D=3D ','))
+      c =3D strchr (d + 2, ',');
+      if ((u =3D strchr (d + 2, '\\')) !=3D NULL && (c =3D=3D NULL || u < =
c) &&
+	  (u - d <=3D INTERNET_MAX_HOST_NAME_LENGTH + 2))
 	{
-	  buf[0] =3D '\0';
-	  strncat (buf, c + 2, INTERNET_MAX_HOST_NAME_LENGTH + UNLEN + 1);
-	  if ((c =3D strchr (buf, ',')) !=3D NULL)
-	    *c =3D '\0';
+	  strlcpy(domain, d + 2, u - d - 1);
+	  if (c =3D=3D NULL)
+	    c =3D u + UNLEN + 1;
+	  if (c - u <=3D UNLEN + 1)
+	    {
+	      strlcpy(user, u + 1, c - u);
+	      return;
+	    }
 	}
     }
-  if ((c =3D strchr (buf, '\\')) !=3D NULL)
-    {
-      *c++ =3D '\0';
-      strcpy (domain, buf);
-      strcpy (user, c);
-    }
-  else
-    {
-      strcpy (domain, "");
-      strcpy (user, buf);
-    }
+
+  cygsid psid;
+  DWORD ulen =3D UNLEN + 1;
+  DWORD dlen =3D INTERNET_MAX_HOST_NAME_LENGTH + 1;
+  SID_NAME_USE use;
+  domain[0] =3D user[0] =3D 0;
+  if (psid.getfrompw (pw))
+    LookupAccountSid (NULL, psid, user, &ulen, domain, &dlen, &use);
 }

 extern "C" HANDLE
@@ -490,18 +482,9 @@
   char domain[INTERNET_MAX_HOST_NAME_LENGTH + 1];
   WCHAR wserver[INTERNET_MAX_HOST_NAME_LENGTH + 3];
   char server[INTERNET_MAX_HOST_NAME_LENGTH + 3];
-  DWORD ulen =3D sizeof (user);
-  DWORD dlen =3D sizeof (domain);
-  SID_NAME_USE use;
   cygsidlist sup_list;

   auth_pos =3D -1;
-  if (!LookupAccountSid (NULL, usersid, user, &ulen, domain, &dlen, &use))
-    {
-      debug_printf ("LookupAccountSid () %E");
-      __seterrno ();
-      return FALSE;
-    }

   grp_list +=3D well_known_world_sid;
   if (usersid =3D=3D well_known_system_sid)
@@ -511,6 +494,7 @@
     }
   else
     {
+      extract_nt_dom_user (pw, domain, user);
       if (!get_logon_server (domain, server, wserver))
 	return FALSE;
       if (my_grps)

--=====================_1025407155==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="security.cc.diff.soft"
Content-length: 2734

--- security.cc.orig	2002-06-27 20:30:22.000000000 -0400
+++ security.cc	2002-06-29 16:34:10.000000000 -0400
@@ -60,43 +60,34 @@
 void
 extract_nt_dom_user (const struct passwd *pw, char *domain, char *user)
 {
-  cygsid psid;
-  DWORD ulen =3D UNLEN + 1;
-  DWORD dlen =3D INTERNET_MAX_HOST_NAME_LENGTH + 1;
-  SID_NAME_USE use;
-  char buf[INTERNET_MAX_HOST_NAME_LENGTH + UNLEN + 2];
-  char *c;
+  char *d, *u, *c;

-  strcpy (domain, "");
-  strcpy (buf, pw->pw_name);
+  domain[0] =3D 0;
+  strlcpy (user, pw->pw_name, UNLEN+1);
   debug_printf ("pw_gecos =3D %x (%s)", pw->pw_gecos, pw->pw_gecos);

-  if (psid.getfrompw (pw) &&
-      LookupAccountSid (NULL, psid, user, &ulen, domain, &dlen, &use))
-    return;
-
-  if (pw->pw_gecos)
-    {
-      if ((c =3D strstr (pw->pw_gecos, "U-")) !=3D NULL &&
-	  (c =3D=3D pw->pw_gecos || c[-1] =3D=3D ','))
-	{
-	  buf[0] =3D '\0';
-	  strncat (buf, c + 2, INTERNET_MAX_HOST_NAME_LENGTH + UNLEN + 1);
-	  if ((c =3D strchr (buf, ',')) !=3D NULL)
-	    *c =3D '\0';
-	}
-    }
-  if ((c =3D strchr (buf, '\\')) !=3D NULL)
-    {
-      *c++ =3D '\0';
-      strcpy (domain, buf);
-      strcpy (user, c);
-    }
-  else
+  if ((d =3D strstr (pw->pw_gecos, "U-")) !=3D NULL &&
+      (d =3D=3D pw->pw_gecos || d[-1] =3D=3D ','))
     {
-      strcpy (domain, "");
-      strcpy (user, buf);
-    }
+      c =3D strchr (d + 2, ',');
+      if ((u =3D strchr (d + 2, '\\')) =3D=3D NULL || (c !=3D NULL && u > =
c))
+	u =3D d + 1;
+      else if (u - d <=3D INTERNET_MAX_HOST_NAME_LENGTH + 2)
+	strlcpy(domain, d + 2, u - d - 1);
+      if (c =3D=3D NULL)
+        c =3D u + UNLEN + 1;
+      if (c - u <=3D UNLEN + 1)
+	strlcpy(user, u + 1, c - u);
+    }
+  if (domain[0])
+    return;
+
+  cygsid psid;
+  DWORD ulen =3D UNLEN + 1;
+  DWORD dlen =3D INTERNET_MAX_HOST_NAME_LENGTH + 1;
+  SID_NAME_USE use;
+  if (psid.getfrompw (pw))
+    LookupAccountSid (NULL, psid, user, &ulen, domain, &dlen, &use);
 }

 extern "C" HANDLE
@@ -490,18 +481,9 @@
   char domain[INTERNET_MAX_HOST_NAME_LENGTH + 1];
   WCHAR wserver[INTERNET_MAX_HOST_NAME_LENGTH + 3];
   char server[INTERNET_MAX_HOST_NAME_LENGTH + 3];
-  DWORD ulen =3D sizeof (user);
-  DWORD dlen =3D sizeof (domain);
-  SID_NAME_USE use;
   cygsidlist sup_list;

   auth_pos =3D -1;
-  if (!LookupAccountSid (NULL, usersid, user, &ulen, domain, &dlen, &use))
-    {
-      debug_printf ("LookupAccountSid () %E");
-      __seterrno ();
-      return FALSE;
-    }

   grp_list +=3D well_known_world_sid;
   if (usersid =3D=3D well_known_system_sid)
@@ -511,6 +493,7 @@
     }
   else
     {
+      extract_nt_dom_user (pw, domain, user);
       if (!get_logon_server (domain, server, wserver))
 	return FALSE;
       if (my_grps)

--=====================_1025407155==_--
