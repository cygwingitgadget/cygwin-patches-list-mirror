Return-Path: <cygwin-patches-return-3581-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1054 invoked by alias); 17 Feb 2003 19:35:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1045 invoked from network); 17 Feb 2003 19:35:38 -0000
Message-Id: <3.0.5.32.20030217143506.007f5bb0@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Mon, 17 Feb 2003 19:35:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: grp.cc
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q1/txt/msg00230.txt.bz2

Corinna,

I believe this will take care of Re: uh oh [Roland.Schwingel@onevision.de:
 Re: bash broken with cygwin 1.3.20? - now working with 1.3.20]

Pierre

2003-02-17  Pierre Humblet  <pierre.humblet@ieee.org>

	* grp.cc (internal_getgroups): Handle properly tokens with
	no groups. Fix bug introduced on 2003-02-04. 


Index: grp.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/grp.cc,v
retrieving revision 1.77
diff -u -p -r1.77 grp.cc
--- grp.cc      6 Feb 2003 14:01:53 -0000       1.77
+++ grp.cc      17 Feb 2003 19:19:31 -0000
@@ -267,7 +267,6 @@ internal_getgroups (int gidsetsize, __gi
                  for (DWORD pg = 0; pg < groups->GroupCount; ++pg)
                    if ((cnt = (*srchsid == groups->Groups[pg].Sid)))
                      break;
-                 cnt = -1;
                }
              else
                for (int gidx = 0; (gr = internal_getgrent (gidx)); ++gidx)
@@ -293,8 +292,7 @@ internal_getgroups (int gidsetsize, __gi
        debug_printf ("%d = GetTokenInformation(NULL) %E", size);
       if (hToken != cygheap->user.token)
        CloseHandle (hToken);
-      if (cnt)
-       return cnt;
+      return cnt;
     }
 
   gid = myself->gid;
