Return-Path: <cygwin-patches-return-2674-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 19827 invoked by alias); 19 Jul 2002 15:06:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19813 invoked from network); 19 Jul 2002 15:06:41 -0000
Date: Fri, 19 Jul 2002 08:06:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: Corinna or Pierre please comment? [jason@tishler.net: Re: setuid
Message-ID: <20020719170639.R6932@cygbert.vinschen.de>
Mail-Followup-To: cygpatch <cygwin-patches@cygwin.com>
References: <3.0.5.32.20020718211250.0080a5e0@mail.attbi.com> <20020719102328.E6932@cygbert.vinschen.de> <3D382572.5BEF1C2C@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D382572.5BEF1C2C@ieee.org>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q3/txt/msg00122.txt.bz2

On Fri, Jul 19, 2002 at 10:42:58AM -0400, Pierre A. Humblet wrote:
> Right, I had not considered that. However it's a moot point 
> because create_token is only called from seteuid, which checks
> that prgpsid isn't NULL (same for usersid). So we can go three ways:
> - apply the patch and move on.
> - go all the way and remove the test for NULL pgrpsid 
>     (we don't check NULL usersid either)
> - go back to the way it was, either I produce a new patch or I revert
>     that part later.

I've choosen the first one and applied your patch.

> It's fine. The idea (see old mail) is that if the pgrpsid is special because 
> setgid has set a gid that is not in passwd nor in the aux groups, nor in
> the Windows equivalents, (this happens e.g. with mailers setgid to the 
> "mail" group), then the token has more rights than what the user
> normally has when she logs in. verify_token is then stricter
> with that token.
> The same kind of issues, just more complicated, occur with setgroups().
> I will revisit the whole thing.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
