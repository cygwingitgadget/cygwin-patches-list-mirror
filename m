Return-Path: <cygwin-patches-return-3365-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15243 invoked by alias); 10 Jan 2003 04:20:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15233 invoked from network); 10 Jan 2003 04:20:01 -0000
Message-Id: <3.0.5.32.20030109231826.007fb720@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Fri, 10 Jan 2003 04:20:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: setfacl
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q1/txt/msg00014.txt.bz2

Corinna,

That was overlooked last time around.

Pierre

2003/01/09  Pierre Humblet  <pierre.humblet@ieee.org>

	* setfacl (usage): Remove double ":" for mask and other.

  
Index: setfacl.c
===================================================================
RCS file: /cvs/src/src/winsup/utils/setfacl.c,v
retrieving revision 1.9
diff -r1.9 setfacl.c
314,315c314,315
<             "         m[ask]::perm\n"
<             "         o[ther]::perm\n"
---
>             "         m[ask]:perm\n"
>             "         o[ther]:perm\n"
