Return-Path: <cygwin-patches-return-2962-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 29560 invoked by alias); 13 Sep 2002 14:15:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29545 invoked from network); 13 Sep 2002 14:15:32 -0000
Message-ID: <3D81F339.6766E6CD@ieee.org>
Date: Fri, 13 Sep 2002 07:15:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: initgroups
References: <3D7F4284.46484222@ieee.org> <3.0.5.32.20020910213124.0080e5a0@mail.attbi.com> <20020911123808.Q1574@cygbert.vinschen.de> <3D7F4284.46484222@ieee.org> <3.0.5.32.20020911204241.00810100@mail.attbi.com> <20020913104233.C1574@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q3/txt/msg00410.txt.bz2

Corinna Vinschen wrote:

> > If we decide on 1) shouldn't we remove calls to {ug}id16to(ug}id32 from
> > passwd.cc, grp.cc and syscalls.cc, EXCEPT in the various cases of chown
> > (i.e. simply do as getgrgid (), which doesn't call gid16togid32)?
> > Also, we shouldn't rely on ILLEGAL_UID in dcrt0.
> > If we decide on 2), shouldn't we enforce it everywhere? One possibility is
> > not to read in passwd and group entries with "illegal" {ug}id values.
> 
> After looking into this I think 2) is the way to go.  We can't support
> that uid/gid for apparent reasons so we should take the approach to
> invalidate it everywhere, yes.
> 
> However, that would mean that we have to treat both values as
> illegal, ILLEGAL_[UG]ID and ILLEGAL_[UG]ID16.  This looks a little
> bit weird to me...

Good point. But that's due to the transition from 16 to 32 bits (when do
you plan to complete it?) and it depends on the user's perspective.

If the user thinks that cygwin allows only 16 bit {ug}id's in passwd & group, 
then only 0xFFFF is illegal and nothing is weird.

If the user thinks cygwin allows 32 bit entries in passwd & group, then all 
entries ending with 0xFFFF are illegal, which is weird, but there
are much weirder things in that situation.

For the moment if a group has a gid > 0xFFFF,
then getgrnam() will find it but will return a truncated gid.
However getgrgid(gid) and even getgrgid((getgrnam())->gr_gid) never work 
properly. They either fail or return an aliased group. 
If the truncated gid was stored in the Cygwin internal passwd structures, 
then getgrgid(gid) would always return a group, but possibly an alias...

Until 32 bit {ug}id's are completely supported, I would consider as invalid 
everything ending with 0xFFFF.

Pierre
