Return-Path: <cygwin-patches-return-3170-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7948 invoked by alias); 14 Nov 2002 09:57:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7936 invoked from network); 14 Nov 2002 09:57:39 -0000
Date: Thu, 14 Nov 2002 01:57:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: ntsec patch 1: uid==gid, chmod, alloc_sd, is_grp_member
Message-ID: <20021114105736.F10395@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3DD159F7.45001468@ieee.org> <20021113135916.Q10395@cygbert.vinschen.de> <3DD27B59.3FA8990@ieee.org> <20021113175002.Y10395@cygbert.vinschen.de> <3DD28CAF.4B7C19CE@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DD28CAF.4B7C19CE@ieee.org>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q4/txt/msg00121.txt.bz2

On Wed, Nov 13, 2002 at 12:32:31PM -0500, Pierre A. Humblet wrote:
> Corinna Vinschen wrote:
> > It doesn't add any overhead which isn't already there.
> > 
> If "already" is before the patch, it scans the group file instead of scanning
> the token groups. If "already" is after the patch, it scans the group file
> instead of scanning the token groups or doing nothing, depending if the uid 
> of the file owner differs from the uid of the process. 

So what?  It just uses /etc/group to determine the group membership
of user "username".  What's wrong with that?  "username" is !=
current user so it reflects the default circumstances for that user.
I don't think we can get it better due to Win/POSIX divergence.

> The fundamental problem is that there is not enough information to know
> the "real permissions" of the owner. Is User_foo a member of Admins or not,
> at the time she accesses the file ?

Sure.  We can't know that.  We're reflecting the default.

> You make a lot of assumptions in your example. A more detailed description of
> the way the code works today (before patch) is this:
> 
> If the process running ls -l is a member of Admins:
>  rwxrwxr--
> If the process running ls -l in not a member of Admins:
>  ---rwxr--
> and that's the case *whether or not* User_foo is *nominally* a member of Admins.

Wait, I'm assuming that we have a corrected version of is_grp_member().
We already know that is_grp_member() isn't quite right, currently.
Let's assume is_grp_member() works as expected which means, including
my small patch plus a patch to take all groups in the ACL into account.
Then the most ugly problem - using the access token of another user -
is dropped from our analyzis.

Back to the example.  Assume that user_foo is a member of Admins in
the SAM.  The default case is that access tokens are created with
Admin being one of the token groups.

> With the current patch, the output of ls -l would be
>  ---rwxr--
> if ls -l is run by somebody else than User_foo
> It would be 
>  rwxrwxr--
> if ls -l is run by User_foo if User_foo is *currently* a member of Admins, and
>  ---rwxr-- 
> if ls -l is run by User_foo if User_foo is NOT *currently* a member of Admins 
> To me, that's slightly better than currently.

I'm sorry if I miss something here but with my patch it would be

rwxrwxr--

if ls -l is run by somebody else than User_foo.  

> Note also that your example assumes implicitly that the ACL was not created 
> by Cygwin.

Sure.  That's the whole point in this discussion, isn't it?  Pure Cygwin
ACLs are created according to POSIX rules so that's a non-issue.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
