Return-Path: <cygwin-patches-return-3160-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27934 invoked by alias); 13 Nov 2002 16:18:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27925 invoked from network); 13 Nov 2002 16:18:24 -0000
Message-ID: <3DD27B59.3FA8990@ieee.org>
Date: Wed, 13 Nov 2002 08:18:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: ntsec patch 1: uid==gid, chmod, alloc_sd, is_grp_member
References: <3DD159F7.45001468@ieee.org> <20021113135916.Q10395@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q4/txt/msg00111.txt.bz2

Corinna Vinschen wrote:
> 
> On Tue, Nov 12, 2002 at 02:43:51PM -0500, Pierre A. Humblet wrote:
> > > It's just a flaw in is_grp_member() but it's still needed to get the
> > > information about the group membership.  is_grp_member() shouldn't check
> > > the current token if the uid isn't myself->uid but otherwise it's ok.
> >
> > That's the heart of the matter. How do you propose to fix is_grp_member()?
> > I believe it would involve contacting the PDC for domain users. IMHO it's
> > unacceptable for performance reasons.
> > That's why I would only insist on B1), not B3).
> 
> I think I found an easy (not necessaily fast) solution which doesn't
> involve calling the PDC.  Basically we do already depend on /etc/group
> heavily so we can do this here, too, IMHO:

Yes, that works (most of the time) assuming that /etc/group was build with 
mkgroup -u.
But still, I wouldn't do it, for many reasons:
- it adds overhead to stat (), which is already slow
- it only considers the gid of the file, but not the unrelated groups
  that may be present in the file acl, so it doesn't achieve B3
  nor B2.
- it doesn't help at all if mkgroup wasn't run with -u
- it doesn't help at all when the acl was built by cygwin
- it doesn't help at all in the usual case where the owner permissions
  are wider than those of groups
- it assumes that all processes with a given "uid" will always
  run with the groups derived from /etc/passwd and /etc/group. 
  Although this is typical, it is not necessarily true. setgid ()
  or setgroups () might have been called to change that.
- the permission for the owner should reflect the permission given 
  to the uid itself, independently of the groups that the process
  may or may not be in at the time it accesses a file.
- We rely on /etc/group mostly to map gid <=> sid. Relying on it even more
  exposes us to user screw up and unexpected behavior. 
  Again, the permission given to a uid in Unix are independent of what's 
  in /etc/group. 
Unfortunately the Windows and Unix models of security diverge here,
and Cygwin is caught in between. I would go for simplicity. 


> > > > -  owner_sid.debug_print ("alloc_sd: owner SID =");
> > > And this one?
> > I thought that was a debug leftover from the time you introduced the
> > caching. It's not done anywhere else.
> 
> No, I was already often happy  to see the SID at this point.  It helped
> debugging.  I'd like to keep it.

OK, then for consistency let's also debug_print the group SID.

> > Good question. I was puzzled by the original comment and code:
> >          * Add unrelated ACCESS_DENIED_ACE to the beginning but
> >          * behind the owner_deny, ACCESS_ALLOWED_ACE to the end.
> > The ACCESS_DENIED_ACE part made no sense to me because if there are a
> > bunch of ACCESS_DENIED following each other, their order doesn't matter.
> > So I thought that the intention of the original code was that "unrelated
> > ACE" should not affect the owner and should thus be positioned after the
> > ACCESS_ALLOWED_ACE of the owner (i.e. the original author meant
> > owner_allow, not owner_deny, in the comment).
> 
> No, the original code actually knows that the current situation is
> either
> 
>         owner_allow
>         group_ace
>         ...
> 
> or
> 
>         owner_deny
>         owner_allow
>         group_ace
>         ...
> 
> The code just differs between having or having not an owner_deny.
> All denies are going to the beginning of the ACL, maintaining the
> canonical order.  The canonical order places user ACEs in from of
> group ACEs.  To keep this order, the remaining unrelated deny
> ACEs are positioned after the owner ACE.  That's all and that's
> correct, AFAICS.

OK, what you are proposing is actually close to what the patch I sent 
at the beginning of October was doing. 
The existing code behaves as follows: in the first case above it 
inserts the unrelated deny acl at the top, in the second case it inserts
it after the owner_deny. 
There is no reason for this dual behavior, my October patch was
always inserting the unrelated deny acl at the top.

The reason why I changed the behavior between October and November is 
very much related to the discussion on is_grp_member(). 
The new method insures that the group membership of the owner does not
impede a right that was given explicitly given to the owner.
In other words, if I chmod a file 700, it shouldn't be the case that the
owner only has 600 because she happens to be in some unrelated group
that was in the old acl. Doing so (changing the right) is actually
closer to the Windows security model than to the Unix one.

Pierre
