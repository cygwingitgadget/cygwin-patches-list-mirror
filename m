Return-Path: <cygwin-patches-return-3173-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1813 invoked by alias); 14 Nov 2002 16:36:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1721 invoked from network); 14 Nov 2002 16:36:32 -0000
Date: Thu, 14 Nov 2002 08:36:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: ntsec patch 1: uid==gid, chmod, alloc_sd, is_grp_member
Message-ID: <20021114173630.A20639@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3DD27B59.3FA8990@ieee.org> <3DD159F7.45001468@ieee.org> <20021113135916.Q10395@cygbert.vinschen.de> <3DD27B59.3FA8990@ieee.org> <3.0.5.32.20021113223509.0082c960@mail.attbi.com> <20021114110340.G10395@cygbert.vinschen.de> <3DD3B369.A530D7EE@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DD3B369.A530D7EE@ieee.org>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q4/txt/msg00124.txt.bz2

On Thu, Nov 14, 2002 at 09:30:01AM -0500, Pierre A. Humblet wrote:
> Corinna Vinschen wrote:
> > Isn't the impersonation token automatically read by OpenProcessToken()
> > when an impersonation took place?
> 
> I don't think so.

I just had another look into MSDN and AFAICS, we would have to call
OpenThreadToken() with parameter OpenAsSelf set to FALSE instead of
OpenProcessToken() to get always the current active access token.
Or how do you understand that?

> - Has anybody reported problems with incorrect owner modes for a file owner
>   different from the current process user? If not, I wouldn't even start
>   writing code for it. 
>   We know it can't work all the time, and that to work assuming the default
>   group membership, it needs mkgroup -u (or PDC lookup). Yesterday I checked 
>   that at a medium size company (~ 150 persons). There where a total of
>   1047 names in the gr_mem fields. getgroups32 scans them all, every time. 
>   That would be for every file stat.

You're trying to frustrate me by reality, don't you?

> - I am a little bit confused by your patch. Your intention is to skip the token
>   lookup if the file uid isn't that of the current user. You then fall to the
>   bottom of getgroups32. But there the gid is ALWAYS included in the group
>   list (because in the context of getgroups the gid is that of the user, not
>   that of a file). Thus your small patch will always report that the uid is
>   a member of the gid.

Look into is_grp_member() again.  getgroups32() isn't called with the
incoming gid but with pw->pw_gid.  Then the incoming gid is compared
against the whole list.

> > Could you then please resend the parts of your #1 patch we agreed upon?
> 
> OK. Do you want to call is_grp_member all the time or only if the current user
> is the file owner?

I still think it's correct to call is_grp_member() always.  The actual
solution is not to ignore is_grp_member() but to get it to work reasonably
well in terms of correctness and (sic) time.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
