Return-Path: <cygwin-patches-return-3161-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11832 invoked by alias); 13 Nov 2002 16:50:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11820 invoked from network); 13 Nov 2002 16:50:03 -0000
Date: Wed, 13 Nov 2002 08:50:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: ntsec patch 1: uid==gid, chmod, alloc_sd, is_grp_member
Message-ID: <20021113175002.Y10395@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3DD159F7.45001468@ieee.org> <20021113135916.Q10395@cygbert.vinschen.de> <3DD27B59.3FA8990@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DD27B59.3FA8990@ieee.org>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q4/txt/msg00112.txt.bz2

On Wed, Nov 13, 2002 at 11:18:33AM -0500, Pierre A. Humblet wrote:
> Corinna Vinschen wrote:
> > I think I found an easy (not necessaily fast) solution which doesn't
> > involve calling the PDC.  Basically we do already depend on /etc/group
> > heavily so we can do this here, too, IMHO:
> 
> Yes, that works (most of the time) assuming that /etc/group was build with 
> mkgroup -u.
> But still, I wouldn't do it, for many reasons:
> - it adds overhead to stat (), which is already slow

It doesn't add any overhead which isn't already there.

> - it only considers the gid of the file, but not the unrelated groups
>   that may be present in the file acl, so it doesn't achieve B3
>   nor B2.

Agree.

> - it doesn't help at all if mkgroup wasn't run with -u
> - it doesn't help at all when the acl was built by cygwin
> - it doesn't help at all in the usual case where the owner permissions
>   are wider than those of groups

The whole thing is a result of the divergence between Win and Posix.
Unfortunately it's not always the usual case to have owner permissions
wider that group permissions.  Often there aren't even owner permissions
in the ACL since the permissions are given by only group permissions.
And in contrast to Posix the permissions add up to each other.

> - it assumes that all processes with a given "uid" will always
>   run with the groups derived from /etc/passwd and /etc/group. 
>   Although this is typical, it is not necessarily true. setgid ()
>   or setgroups () might have been called to change that.
> - the permission for the owner should reflect the permission given 
>   to the uid itself, independently of the groups that the process
>   may or may not be in at the time it accesses a file.

The problem we're trying to circumvent is the following:

Owner:	User_foo
Group:	Admins
ACL:	Admins rwx
	Everyone r--

Following your suggestion we get:

$ ls -l
 ---rwxr-- 1 User_foo Admins ... bar

This doesn't reflect the real permissions of the user at all, not even
approximately.

The current code creates:

$ ls -l
 rwxrwxr-- 1 User_foo Admins ... bar

which reflects the truth somewhat better *and* solves a lot of problems
we had in earlier implementations.

Granted that the implementation isn't complete.

> - We rely on /etc/group mostly to map gid <=> sid. Relying on it even more
>   exposes us to user screw up and unexpected behavior. 

But that invalidates your attempts to rely more on /etc/group instead
of calling LookupAccountSid/Name.  That's somewhat chicken-egg, isn't
it?  I try to avoid time lags by not calling LookupAccountSid means
to rely more on the correctness of /etc/group and vice versa...

>   Again, the permission given to a uid in Unix are independent of what's 
>   in /etc/group. 

But not in Windows.

> Unfortunately the Windows and Unix models of security diverge here,
> and Cygwin is caught in between. I would go for simplicity. 

The above ls -l example shows the result if we don't use is_grp_member().
We already had a lot of problems due to this some time ago.  I won't return
to the old state.  I, for one, would better like to improve is_grp_member().

> OK, then for consistency let's also debug_print the group SID.

Ok.

> > The code just differs between having or having not an owner_deny.
> > All denies are going to the beginning of the ACL, maintaining the
> > canonical order.  The canonical order places user ACEs in from of
> > group ACEs.  To keep this order, the remaining unrelated deny
> > ACEs are positioned after the owner ACE.  That's all and that's
> > correct, AFAICS.
> 
> OK, what you are proposing is actually close to what the patch I sent 
> at the beginning of October was doing. 
> The existing code behaves as follows: in the first case above it 
> inserts the unrelated deny acl at the top, in the second case it inserts
> it after the owner_deny. 
> There is no reason for this dual behavior, my October patch was
> always inserting the unrelated deny acl at the top.

"The canonical order places user ACEs in from of group ACEs."

> The reason why I changed the behavior between October and November is 
> very much related to the discussion on is_grp_member(). 
> The new method insures that the group membership of the owner does not
> impede a right that was given explicitly given to the owner.
> In other words, if I chmod a file 700, it shouldn't be the case that the
> owner only has 600 because she happens to be in some unrelated group
> that was in the old acl. Doing so (changing the right) is actually
> closer to the Windows security model than to the Unix one.

Sigh, yes, the Windows security model.  It's lovely, isn't it?
If there's any order which would make sense, then it's

	user_denies
	user_allows
	group_denies
	group_allows
	everyone

but that's probably too sophisticated...

I agree that moving the group_denies after the user_allow is closer
to what *we* want.  I recall a discussion on the cygwin ML (was it
in 2000?  I don't know) about Cygwin being incompatible to NT4 since
the ACL was not in the correct order for the cranky file security
dialog.  Thank god, THEY improved that dialog quite a bit in W2K.

I see your point.  Ok with me.  Let's try it with your invention here.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
