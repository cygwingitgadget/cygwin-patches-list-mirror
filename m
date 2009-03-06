Return-Path: <cygwin-patches-return-6429-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16964 invoked by alias); 6 Mar 2009 14:41:28 -0000
Received: (qmail 16953 invoked by uid 22791); 6 Mar 2009 14:41:27 -0000
X-SWARE-Spam-Status: Yes, hits=6.8 required=5.0 	tests=AWL,BAYES_50,BOTNET,HK_OBFDOM,HK_OBFDOMREQ,J_CHICKENPOX_32
X-Spam-Check-By: sourceware.org
Received: from vms173005pub.verizon.net (HELO vms173005pub.verizon.net) (206.46.173.5)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 06 Mar 2009 14:41:22 +0000
Received: from PHUMBLETLAPXP ([70.88.219.194]) by vms173005.mailsrvcs.net  (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))  with ESMTPA id <0KG300F0MA4CWP50@vms173005.mailsrvcs.net> for  cygwin-patches@cygwin.com; Fri, 06 Mar 2009 08:41:07 -0600 (CST)
Message-id: <029a01c99e69$94a1dbc0$4e0410ac@wirelessworld.airvananet.com>
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
To: <cygwin-patches@cygwin.com>
References: <0KFW0072QPTQUMJ2@vms173001.mailsrvcs.net>  <20090303153801.GA17180@ednor.casa.cgf.cx>  <0b1b01c99c28$8a2c6540$4e0410ac@wirelessworld.airvananet.com>  <20090306054449.GA3971@ednor.casa.cgf.cx>
Subject: Re: [Patch] gethostbyname2  again
Date: Fri, 06 Mar 2009 14:41:00 -0000
MIME-version: 1.0
Content-type: multipart/mixed;  boundary="----=_NextPart_000_0297_01C99E3F.A84DD090"
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
X-SW-Source: 2009-q1/txt/msg00027.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0297_01C99E3F.A84DD090
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 2843


----- Original Message ----- 
From: "Christopher Faylor" <cgf-use-the-mailinglist-please>
To: <cygwin-patches>
Sent: Friday, March 06, 2009 12:44 AM
Subject: Re: [Patch] gethostbyname2 again


| On Tue, Mar 03, 2009 at 12:50:21PM -0500, Pierre A. Humblet wrote:
| >
| >To avoid real-time checks, I could do as what dup_ent does, and have 4 versions
| >of the realloc_ent function, one main one with dst and sz arguments (that one
| >would be called by dup_ent without any  run-time checks) and 3 (actually only
| >1 is needed for now) that invoke the main one with the correct dst based on the
| >type of the src argument . The src argument would be null but would have the
| >right type! That seems to meet your wishes. OK?
| 
| Yes.

OK, here it the patch for realloc_ent. See also attachement.
The third chunk (the change to dup_ent) is not essential.

In addition in the patch that Corinna sent on March 3, the line
+  ret = (hostent *) realloc_ent (sz, unionent::t_hostent);
should be changed to
ret = realloc_ent (sz,  (hostent *) NULL);

In the Changelog the line
  (dup_ent): Remove dst argument and call realloc_ent.
should either be deleted or "Remove dst argument and c" should
be replaced by "C".

Pierre

Index: net.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/net.cc,v
retrieving revision 1.249
diff -u -p -r1.249 net.cc
--- net.cc 3 Mar 2009 11:44:17 -0000 1.249
+++ net.cc 6 Mar 2009 14:28:46 -0000
@@ -264,6 +264,25 @@ struct pservent
 
 static const char *entnames[] = {"host", "proto", "serv"};
 
+static unionent *
+realloc_ent (unionent *&dst, int sz)
+{
+   /* Allocate the storage needed.  Allocate a rounded size to attempt to force
+      reuse of this buffer so that a poorly-written caller will not be using
+      a freed buffer. */
+   unsigned rsz = 256 * ((sz + 255) / 256);
+   unionent * ptr;
+   if ((ptr = (unionent *) realloc (dst, rsz)))
+     dst = ptr;
+   return ptr;
+}
+
+static inline hostent *
+realloc_ent (int sz, hostent * )
+{
+   return (hostent *) realloc_ent (_my_tls.locals.hostent_buf, sz);
+}
+
 /* Generic "dup a {host,proto,serv}ent structure" function.
    This is complicated because we need to be able to free the
    structure at any point and we can't rely on the pointer contents
@@ -355,13 +374,8 @@ dup_ent (unionent *&dst, unionent *src, 
  }
     }
 
-  /* Allocate the storage needed.  Allocate a rounded size to attempt to force
-     reuse of this buffer so that a poorly-written caller will not be using
-     a freed buffer. */
-  unsigned rsz = 256 * ((sz + 255) / 256);
-  dst = (unionent *) realloc (dst, rsz);
-
-  if (dst)
+  /* Allocate the storage needed.  */
+  if (realloc_ent (dst, sz))
     {
       memset (dst, 0, sz);
       /* This field is common to all *ent structures but named differently

------=_NextPart_000_0297_01C99E3F.A84DD090
Content-Type: application/octet-stream;
	name="realloc_ent.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="realloc_ent.diff"
Content-length: 1988

Index: net.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/net.cc,v=0A=
retrieving revision 1.249=0A=
diff -u -p -r1.249 net.cc=0A=
--- net.cc	3 Mar 2009 11:44:17 -0000	1.249=0A=
+++ net.cc	6 Mar 2009 14:28:46 -0000=0A=
@@ -264,6 +264,25 @@ struct pservent=0A=
=20=0A=
 static const char *entnames[] =3D {"host", "proto", "serv"};=0A=
=20=0A=
+static unionent *=0A=
+realloc_ent (unionent *&dst, int sz)=0A=
+{=0A=
+   /* Allocate the storage needed.  Allocate a rounded size to attempt to =
force=0A=
+      reuse of this buffer so that a poorly-written caller will not be usi=
ng=0A=
+      a freed buffer. */=0A=
+   unsigned rsz =3D 256 * ((sz + 255) / 256);=0A=
+   unionent * ptr;=0A=
+   if ((ptr =3D (unionent *) realloc (dst, rsz)))=0A=
+     dst =3D ptr;=0A=
+   return ptr;=0A=
+}=0A=
+=0A=
+static inline hostent *=0A=
+realloc_ent (int sz, hostent * )=0A=
+{=0A=
+   return (hostent *) realloc_ent (_my_tls.locals.hostent_buf, sz);=0A=
+}=0A=
+=0A=
 /* Generic "dup a {host,proto,serv}ent structure" function.=0A=
    This is complicated because we need to be able to free the=0A=
    structure at any point and we can't rely on the pointer contents=0A=
@@ -355,13 +374,8 @@ dup_ent (unionent *&dst, unionent *src,=20=0A=
 	}=0A=
     }=0A=
=20=0A=
-  /* Allocate the storage needed.  Allocate a rounded size to attempt to f=
orce=0A=
-     reuse of this buffer so that a poorly-written caller will not be usin=
g=0A=
-     a freed buffer. */=0A=
-  unsigned rsz =3D 256 * ((sz + 255) / 256);=0A=
-  dst =3D (unionent *) realloc (dst, rsz);=0A=
-=0A=
-  if (dst)=0A=
+  /* Allocate the storage needed.  */=0A=
+  if (realloc_ent (dst, sz))=0A=
     {=0A=
       memset (dst, 0, sz);=0A=
       /* This field is common to all *ent structures but named differently=
=0A=

------=_NextPart_000_0297_01C99E3F.A84DD090--
