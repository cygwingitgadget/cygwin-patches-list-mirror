Return-Path: <cygwin-patches-return-4013-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5988 invoked by alias); 15 Jul 2003 03:25:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5978 invoked from network); 15 Jul 2003 03:25:45 -0000
Message-Id: <3.0.5.32.20030714232518.00808560@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net
Date: Tue, 15 Jul 2003 03:25:00 -0000
To: Corinna Vinschen <cygwin-patches@cygwin.com>
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: Problems on accessing Windows network resources
In-Reply-To: <20030712155608.GP12368@cygbert.vinschen.de>
References: <3.0.5.32.20030712093737.00812900@incoming.verizon.net>
 <3.0.5.32.20030711200253.00807190@mail.attbi.com>
 <3.0.5.32.20030711200253.00807190@mail.attbi.com>
 <3.0.5.32.20030712093737.00812900@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1058253918==_"
X-SW-Source: 2003-q3/txt/msg00029.txt.bz2

--=====================_1058253918==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 344

Corinna,

As announced, this patch is only about style conformance and 
efficiency. You have already applied the bug fix part.

Pierre

2003-07-15  Pierre Humblet  <pierre.humblet@ieee.org>

	* security.cc (verify_token): Fix white space and style.
	Use type bool instead of BOOL and char. Use alloca
	instead of malloc and free for my_grps. 


--=====================_1058253918==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="sec2.diff"
Content-length: 2994

Index: security.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/security.cc,v
retrieving revision 1.148
diff -u -p -r1.148 security.cc
--- security.cc	14 Jul 2003 17:04:21 -0000	1.148
+++ security.cc	15 Jul 2003 01:22:50 -0000
@@ -744,30 +744,26 @@ verify_token (HANDLE token, cygsid &user
 	return gsid =3D=3D groups.pgsid;
     }

-  PTOKEN_GROUPS my_grps =3D NULL;
-  BOOL ret =3D FALSE;
-  char saw_buf[NGROUPS_MAX] =3D {};
-  char *saw =3D saw_buf, sawpg =3D FALSE;
+  PTOKEN_GROUPS my_grps;
+  bool saw_buf[NGROUPS_MAX] =3D {};
+  bool *saw =3D saw_buf, sawpg =3D false, ret =3D false;

   if (!GetTokenInformation (token, TokenGroups, NULL, 0, &size) &&
       GetLastError () !=3D ERROR_INSUFFICIENT_BUFFER)
     debug_printf ("GetTokenInformation(token, TokenGroups): %E");
-  else if (!(my_grps =3D (PTOKEN_GROUPS) malloc (size)))
-    debug_printf ("malloc (my_grps) failed.");
+  else if (!(my_grps =3D (PTOKEN_GROUPS) alloca (size)))
+    debug_printf ("alloca (my_grps) failed.");
   else if (!GetTokenInformation (token, TokenGroups, my_grps, size, &size))
     debug_printf ("GetTokenInformation(my_token, TokenGroups): %E");
   else if (!groups.issetgroups ()) /* setgroups was never called */
-    {
-      ret =3D sid_in_token_groups (my_grps, groups.pgsid);
-      if (ret =3D=3D FALSE)
-	ret =3D (groups.pgsid =3D=3D tok_usersid);
-    }
+    ret =3D sid_in_token_groups (my_grps, groups.pgsid)
+          || groups.pgsid =3D=3D usersid;
   else /* setgroups was called */
     {
       struct __group32 *gr;
       cygsid gsid;
-      if (groups.sgsids.count > (int) sizeof (saw_buf) &&
-	  !(saw =3D (char *) calloc (groups.sgsids.count, sizeof (char))))
+      if (groups.sgsids.count > (int) (sizeof (saw_buf) / sizeof (*saw_buf=
))
+	  && !(saw =3D (bool *) calloc (groups.sgsids.count, sizeof (bool))))
 	goto done;

       /* token groups found in /etc/group match the user.gsids ? */
@@ -776,24 +772,21 @@ verify_token (HANDLE token, cygsid &user
 	  {
 	    int pos =3D groups.sgsids.position (gsid);
 	    if (pos >=3D 0)
-	      saw[pos] =3D TRUE;
+	      saw[pos] =3D true;
 	    else if (groups.pgsid =3D=3D gsid)
-	      sawpg =3D TRUE;
-	   else if (gsid !=3D well_known_world_sid &&
-		    gsid !=3D usersid)
+	      sawpg =3D true;
+	    else if (gsid !=3D well_known_world_sid
+		     && gsid !=3D usersid)
 	      goto done;
 	  }
       for (int gidx =3D 0; gidx < groups.sgsids.count; gidx++)
 	if (!saw[gidx])
 	  goto done;
-      if (sawpg ||
-	  groups.sgsids.contains (groups.pgsid) ||
-	  groups.pgsid =3D=3D usersid)
-	ret =3D TRUE;
+      ret =3D sawpg
+	    || groups.sgsids.contains (groups.pgsid)
+	    || groups.pgsid =3D=3D usersid;
     }
 done:
-  if (my_grps)
-    free (my_grps);
   if (saw !=3D saw_buf)
     free (saw);
   return ret;

--=====================_1058253918==_--
