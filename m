Return-Path: <cygwin-patches-return-3490-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24889 invoked by alias); 4 Feb 2003 16:40:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24878 invoked from network); 4 Feb 2003 16:40:23 -0000
Message-Id: <3.0.5.32.20030204113915.007f5b20@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com (Unverified)
Date: Tue, 04 Feb 2003 16:40:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: handle leak in internal_getgroups
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1044394755==_"
X-SW-Source: 2003-q1/txt/msg00139.txt.bz2

--=====================_1044394755==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 371

Corinna,

Sorry, I just noticed a handle leak in internal_getgroups
(change of 2003/1/17). It only happens when called from the
new function in the patch I just sent. It's a two line fix,
with a lot of whitespace changes. 

Pierre

2003/02/04  Pierre Humblet  <pierre.humblet@ieee.org>
 
	* grp.cc (internal_getgroups): Do not return without closing
	the process handle.

--=====================_1044394755==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="grp.diff"
Content-length: 1775

Index: grp.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/grp.cc,v
retrieving revision 1.75
diff -u -p -r1.75 grp.cc
--- grp.cc	4 Feb 2003 14:58:04 -0000	1.75
+++ grp.cc	4 Feb 2003 16:26:55 -0000
@@ -263,27 +263,28 @@ internal_getgroups (int gidsetsize, __gi
 	      if (srchsid)
 		{
 		  for (DWORD pg =3D 0; pg < groups->GroupCount; ++pg)
-		    if (*srchsid =3D=3D groups->Groups[pg].Sid)
-		      return 1;
-		  return 0;
+		    if ((cnt =3D (*srchsid =3D=3D groups->Groups[pg].Sid)))
+		      break;
+		  cnt =3D -1;
 		}
-	      for (int gidx =3D 0; (gr =3D internal_getgrent (gidx)); ++gidx)
-		if (sid.getfromgr (gr))
-		  for (DWORD pg =3D 0; pg < groups->GroupCount; ++pg)
-		    if (sid =3D=3D groups->Groups[pg].Sid &&
-			sid !=3D well_known_world_sid)
-		      {
-			if (cnt < gidsetsize)
-			  grouplist[cnt] =3D gr->gr_gid;
-			++cnt;
-			if (gidsetsize && cnt > gidsetsize)
-			  {
-			    if (hToken !=3D cygheap->user.token)
-			      CloseHandle (hToken);
-			    goto error;
-			  }
-			break;
-		      }
+	      else
+		for (int gidx =3D 0; (gr =3D internal_getgrent (gidx)); ++gidx)
+		  if (sid.getfromgr (gr))
+		    for (DWORD pg =3D 0; pg < groups->GroupCount; ++pg)
+		      if (sid =3D=3D groups->Groups[pg].Sid &&
+			  sid !=3D well_known_world_sid)
+		        {
+			  if (cnt < gidsetsize)
+			    grouplist[cnt] =3D gr->gr_gid;
+			  ++cnt;
+			  if (gidsetsize && cnt > gidsetsize)
+			    {
+			      if (hToken !=3D cygheap->user.token)
+				CloseHandle (hToken);
+			      goto error;
+			    }
+			  break;
+			}
 	    }
 	}
       else

--=====================_1044394755==_--
