Return-Path: <cygwin-patches-return-3231-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23726 invoked by alias); 24 Nov 2002 21:10:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23717 invoked from network); 24 Nov 2002 21:10:58 -0000
Message-Id: <3.0.5.32.20021124161104.00825ab0@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Sun, 24 Nov 2002 13:10:00 -0000
To: Corinna Vinschen <cygwin-patches@cygwin.com>
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: More passwd/group patches
In-Reply-To: <20021124200239.G1398@cygbert.vinschen.de>
References: <3.0.5.32.20021124112817.008279b0@mail.attbi.com>
 <3.0.5.32.20021124092120.00829650@mail.attbi.com>
 <3DDE4528.3BDCDCEF@ieee.org>
 <3DDE3FB9.2AFAA199@ieee.org>
 <20021122154644.N1398@cygbert.vinschen.de>
 <3DDE4528.3BDCDCEF@ieee.org>
 <3.0.5.32.20021124092120.00829650@mail.attbi.com>
 <3.0.5.32.20021124112817.008279b0@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2002-q4/txt/msg00182.txt.bz2

At 08:02 PM 11/24/2002 +0100, you wrote:
>+  if (aclbufp) {
>+    if (EqualSid (owner_sid, group_sid))
>+      lacl[0].a_perm = lacl[1].a_perm;
>+    aclsort (pos, 0, aclbufp);
>+    if (pos > nentries)
>+      pos = nentries;
>     memcpy (aclbufp, lacl, pos * sizeof (__aclent16_t));
>-  aclsort (pos, 0, aclbufp);
>+  }
>
>Do you see the problem?

Oops, yes. I have aclsort (pos, 0, ACLU);
There is another strange thing in there that I should have mentioned:
we are returning success even if the user gives us an ACLU that's 
tohasmall. Is that how Sun does it? 
I thought that if we were doing that, we should return the first
Acts after sorting them. That's why I moved the sort up. 

itsere
