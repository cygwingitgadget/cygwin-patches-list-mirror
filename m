Return-Path: <cygwin-patches-return-2673-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 1920 invoked by alias); 19 Jul 2002 14:43:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1906 invoked from network); 19 Jul 2002 14:43:22 -0000
Message-ID: <3D382572.5BEF1C2C@ieee.org>
Date: Fri, 19 Jul 2002 07:43:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: Corinna or Pierre please comment? [jason@tishler.net: Re: setuid
References: <3.0.5.32.20020718211250.0080a5e0@mail.attbi.com> <20020719102328.E6932@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q3/txt/msg00121.txt.bz2

Corinna Vinschen wrote:

> Thanks but I don't see why you removed the call to get_user_primary_group().
> You now rely fully on /etc/passwd and /etc/group containing the correct
> information.  Before, prgpsid has been set to a value if it was NULL, now
> it's only used for checking.  This would result in
> 
>   pgrp.PrimaryGroup = NULL;
> 
> in the calling create_token() function.  Which probably results in
> a failing NtCreateToken() function.

Right, I had not considered that. However it's a moot point 
because create_token is only called from seteuid, which checks
that prgpsid isn't NULL (same for usersid). So we can go three ways:
- apply the patch and move on.
- go all the way and remove the test for NULL pgrpsid 
    (we don't check NULL usersid either)
- go back to the way it was, either I produce a new patch or I revert
    that part later.

> Another question.  Shouldn't this in create_token
<snip>
> better be change to
<snip>

It's fine. The idea (see old mail) is that if the pgrpsid is special because 
setgid has set a gid that is not in passwd nor in the aux groups, nor in
the Windows equivalents, (this happens e.g. with mailers setgid to the 
"mail" group), then the token has more rights than what the user
normally has when she logs in. verify_token is then stricter
with that token.
The same kind of issues, just more complicated, occur with setgroups().
I will revisit the whole thing.

Pierre
