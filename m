Return-Path: <cygwin-patches-return-2956-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 7962 invoked by alias); 12 Sep 2002 00:46:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7947 invoked from network); 12 Sep 2002 00:46:45 -0000
Message-Id: <3.0.5.32.20020911204241.00810100@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Wed, 11 Sep 2002 17:46:00 -0000
To: Corinna Vinschen <cygwin-patches@cygwin.com>
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: initgroups
In-Reply-To: <20020911161252.V1574@cygbert.vinschen.de>
References: <3D7F4284.46484222@ieee.org>
 <3.0.5.32.20020910213124.0080e5a0@mail.attbi.com>
 <20020911123808.Q1574@cygbert.vinschen.de>
 <3D7F4284.46484222@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2002-q3/txt/msg00404.txt.bz2

At 04:12 PM 9/11/2002 +0200, Corinna Vinschen wrote:
>>  why is the largest possible gid value forbidden? 
>
>It's not forbidden in the first place, it has a special meaning
>when used as parameter to chown(), see
>http://www.opengroup.org/onlinepubs/007904975/functions/chown.html

OK, thanks Corinna. However we also give it special meaning (noop) 
in setegid () (and similarly for uid in seteuid). 
http://www.opengroup.org/onlinepubs/007904975/functions/setegid.html
gives us no such choice. We can either 1) accept it (if the user has been
foolish enough to put it in /etc/group),
or 2) return EINVAL if we decide that our implementation does not 
support it outright (even if it's in /etc/group).

If we decide on 1) shouldn't we remove calls to {ug}id16to(ug}id32 from
passwd.cc, grp.cc and syscalls.cc, EXCEPT in the various cases of chown 
(i.e. simply do as getgrgid (), which doesn't call gid16togid32)?
Also, we shouldn't rely on ILLEGAL_UID in dcrt0. 
If we decide on 2), shouldn't we enforce it everywhere? One possibility is
not to read in passwd and group entries with "illegal" {ug}id values.

Pierre
