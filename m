Return-Path: <cygwin-patches-return-2520-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 4439 invoked by alias); 26 Jun 2002 03:04:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4424 invoked from network); 26 Jun 2002 03:04:09 -0000
Message-Id: <3.0.5.32.20020625225959.0080a290@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Tue, 25 Jun 2002 20:11:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Bug in cvs cygwin1.dll ?
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2002-q2/txt/msg00503.txt.bz2

I don't know if this is the best venue to point to potential
issues with the cvs build, but here it is. The two "mv" below 
work with the official cygwin1.dll
This is on WinME.    e: is a network drive on a Win98.  

Pierre

/src/winsup: mount
<snip>
c: on /c type user (binmode,noumount)
e: on /e type user (binmode,noumount)

/src/winsup: mv cyg.tar.gz /e
mv: cannot stat `/e': Permission denied

/src/winsup: mv cyg.tar.gz /c
mv: cannot move `cyg.tar.gz' to `/c': File exists
