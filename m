Return-Path: <cygwin-patches-return-3174-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22166 invoked by alias); 14 Nov 2002 17:03:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22133 invoked from network); 14 Nov 2002 17:03:14 -0000
Message-ID: <3DD3D75C.99C07A78@ieee.org>
Date: Thu, 14 Nov 2002 09:03:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: ntsec patch 1: uid==gid, chmod, alloc_sd, is_grp_member
References: <3DD27B59.3FA8990@ieee.org> <3DD159F7.45001468@ieee.org> <20021113135916.Q10395@cygbert.vinschen.de> <3DD27B59.3FA8990@ieee.org> <3.0.5.32.20021113223509.0082c960@mail.attbi.com> <20021114110340.G10395@cygbert.vinschen.de> <3DD3B369.A530D7EE@ieee.org> <20021114173630.A20639@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q4/txt/msg00125.txt.bz2

Corinna Vinschen wrote:
> 
> On Thu, Nov 14, 2002 at 09:30:01AM -0500, Pierre A. Humblet wrote:
> > Corinna Vinschen wrote:
> > > Isn't the impersonation token automatically read by OpenProcessToken()
> > > when an impersonation took place?
> >
> > I don't think so.
> 
> I just had another look into MSDN and AFAICS, we would have to call
> OpenThreadToken() with parameter OpenAsSelf set to FALSE instead of
> OpenProcessToken() to get always the current active access token.
> Or how do you understand that?

I don't have the time to verify now, but from memory the answer is no.
The OpenAsSelf flag controls if you open the thread with the credentials (token)
of the process or the credentials of the thread.

If you are emulated, you already have the token in the cygheap->user.
There is no need to open the thread, see how it's done e.g.in setegid.
 

> > - Has anybody reported problems with incorrect owner modes for a file owner
> >   different from the current process user? If not, I wouldn't even start
> >   writing code for it.
> >   We know it can't work all the time, and that to work assuming the default
> >   group membership, it needs mkgroup -u (or PDC lookup). Yesterday I checked
> >   that at a medium size company (~ 150 persons). There where a total of
> >   1047 names in the gr_mem fields. getgroups32 scans them all, every time.
> >   That would be for every file stat.
> 
> You're trying to frustrate me by reality, don't you?
>
Somewhat less bad news, also making what's below obsolete.
You want to know if the file owner uid is in the group of the file gid.
Write a new routine scanning the /etc/group file until you find the gid.
Then scan the members of that group to see if the uid is in it.
That's it (well, there will be mutex too, against threads rereading /etc/group).
Of course you are still forcing everybody to run mkgroup -u.
Where I am today the group file grows to 18 kB, from 3.5 kB. 

Pierre

 
> > - I am a little bit confused by your patch. Your intention is to skip the token
> >   lookup if the file uid isn't that of the current user. You then fall to the
> >   bottom of getgroups32. But there the gid is ALWAYS included in the group
> >   list (because in the context of getgroups the gid is that of the user, not
> >   that of a file). Thus your small patch will always report that the uid is
> >   a member of the gid.
> 
> Look into is_grp_member() again.  getgroups32() isn't called with the
> incoming gid but with pw->pw_gid.  Then the incoming gid is compared
> against the whole list.
> 
> > > Could you then please resend the parts of your #1 patch we agreed upon?
> >
> > OK. Do you want to call is_grp_member all the time or only if the current user
> > is the file owner?
> 
> I still think it's correct to call is_grp_member() always.  The actual
> solution is not to ignore is_grp_member() but to get it to work reasonably
> well in terms of correctness and (sic) time.
> 
> Corinna
> 
> --
> Corinna Vinschen                  Please, send mails regarding Cygwin to
> Cygwin Developer                                mailto:cygwin@cygwin.com
> Red Hat, Inc.
