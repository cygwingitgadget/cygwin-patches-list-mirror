Return-Path: <cygwin-patches-return-3157-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1499 invoked by alias); 12 Nov 2002 19:43:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1487 invoked from network); 12 Nov 2002 19:43:43 -0000
Message-ID: <3DD159F7.45001468@ieee.org>
Date: Tue, 12 Nov 2002 11:43:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: ntsec patch 1: uid==gid, chmod, alloc_sd, is_grp_member
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q4/txt/msg00108.txt.bz2


Corinna Vinschen wrote:
> 
> Hi Pierre,
> 
> On Wed, 06 Nov 2002 11:28:30 -0500, Pierre A. Humblet wrote:
> > Note that is_grp_member is expensive: a passwd scan + getting the token
> > groups in a malloc'ed structure. I am wondering if the effort is
> > justified, considering that it is useless when the ACL is built by
> > Cygwin (because Cygwin will put an access denied ACE if needed).
> 
> basically the function has been designed to help acl_access (the
> implementation of access(2) when ntsec is on, see sec_acl.cc).
> I looked into that implementation and there it's called always with
> the correct (own) uid.

No problem there.

> > This raises a basic issue: What is get_attribute_from acl trying to
> > accomplish? I can see several answers:
> > A) For "other" and "group", have "modes" report the true access rights
> >    A1) if the ACL was built by Cygwin
> >    A2) all the time.
> > I believe we can easily do A2.
> >
> > B) For "user", have "modes" report the true access rights
> >    B1) if the ACL was built by Cygwin
> >    B2) if the file uid is the current euid
> >    B3) all the time
> > The patch stands somewhere between B1 and B2 (we don't take all the
> > group ACE in consideration, only the gid). Should we reduce to B1
> > (by removing is_grp_member completely)
> > or extend to B2 (perhaps by using AccessCheck)?
> > Doing B3 would require looking up the PDC etc..,  not recommended.
> 
> I don't understand.  get_attribute_from_acl() creates a UNIX mode from
> the ACL.  It gets the owner and group SID as input so it just creates
> the UNIX permission bits from the ACL according to the way they are
> interpreted by NT.  What is the exact problem?  Somehow I'm missing
> that.

The problem is the flaw in is_grp_member, see below.

> > Although I didn't do it, I would remove is_grp_member completely.
> > If it is kept, the output of stat and "ls -l" can depend on the sid
> > of the user running the command. That's undesirable.
> 
> It's just a flaw in is_grp_member() but it's still needed to get the
> information about the group membership.  is_grp_member() shouldn't check
> the current token if the uid isn't myself->uid but otherwise it's ok.

That's the heart of the matter. How do you propose to fix is_grp_member()?
I believe it would involve contacting the PDC for domain users. IMHO it's 
unacceptable for performance reasons. 
That's why I would only insist on B1), not B3).

> 
> Why are you turning around the order of the conditionals?  I don't see
> a reason.

One side is a cygsid, the other is a PSID. I would like the cygsid ==
operator to apply. Apparently the order matters (I didn't know it).
 
> > @@ -1266,31 +1264,37 @@ get_attribute_from_acl (int * attribute,
> >         if (ace->Mask & FILE_APPEND_DATA)
> >           *flags |= S_ISUID;
> >       }
> > -      else if (owner_sid && ace_sid == owner_sid)
> > +      else if (ace_sid == owner_sid)
> > [...]
> > -      else if (group_sid && ace_sid == group_sid)
> > +      else if (ace_sid == group_sid)
> > [...]
> >    *attribute &= ~(S_IRWXU | S_IRWXG | S_IRWXO | S_ISVTX | S_ISGID | S_ISUID);
> > +  if (owner_sid && group_sid && EqualSid (owner_sid, group_sid))
> 
> Why are you checking owner_sid && group_sid for non-NULL here while
> removing these checks in the lines before?
Because in the lines before the cygsid == operator already checks for non-null, 
so it's useless to test twice. However EqualSid doesn't test, so it's necessary
to test. I should really replace the last line above by "owner_sid == group_sid",
although that returns TRUE if both are NULL, so there is a small difference
(but that case should never arise).

> 
> > +    {
> > +      allow &= ~(S_IRGRP | S_IWGRP | S_IXGRP);
> 
> This line is essentially superfluous.  It's job has been done two lines
> before.
Uh?

> 
> Why do you remove this check?  It's still needed when called by
> set_security_attribute().  Or set_security_attribute() needs that check.

set_security_attribute() is only called when a file has acls, which AFAIK
can only happen on NT. So it's OK. 
If it's not OK, the test should be moved to set_security_attribute() 
as you suggest. 
> 
> > -      if (!pw)
> > -     {
> > -       debug_printf ("no /etc/passwd entry for %d", uid);
> > -       set_errno (EINVAL);
> > -       return NULL;
> > -     }
> 
> Why do you remove this check?  It's still an interesting info, isn't it?
Yes, it's just for uniformity of interface. None of the other security
routines go into that level of detail when they read passwd. 
The information is available from the remaining debug_printf.

> 
> > -  owner_sid.debug_print ("alloc_sd: owner SID =");
> And this one?
I thought that was a debug leftover from the time you introduced the 
caching. It's not done anywhere else.

> >    if (gid == myself->gid)
> >      group_sid = cygheap->user.groups.pgsid;
> > +  else if (uid == ILLEGAL_GID)
>               ^^^
oops, thanks.

>
> > -        * Add unrelated ACCESS_DENIED_ACE to the beginning but
> > -        * behind the owner_deny, ACCESS_ALLOWED_ACE to the end.
> > +        * Add unrelated ACCESS_DENIED_ACE to the beginning,
> > +        * preferrably before the owner_allowed ACE,
> > +        * ACCESS_ALLOWED_ACE to the end.
> >          */
> >         if (!AddAce (acl, ACL_REVISION,
> >                      ace->Header.AceType == ACCESS_DENIED_ACE_TYPE ?
> > -                    (owner_deny ? 1 : 0) : MAXDWORD,
> > +                    ace->Mask & owner_allow ? owner_off + 1 : owner_off++
> 
> Could you explain how that should work?  I'm not sure about that.
> owner_off is the position of the owner_allow ACE.  Since the above
> test already filters all related ACEs, the incoming ACE is unrelated
> to the owner entry.  So why do you check the content of the ACE
> against the bits set in the owner_allow mask?!?

Good question. I was puzzled by the original comment and code:
	   * Add unrelated ACCESS_DENIED_ACE to the beginning but
	   * behind the owner_deny, ACCESS_ALLOWED_ACE to the end.
The ACCESS_DENIED_ACE part made no sense to me because if there are a 
bunch of ACCESS_DENIED following each other, their order doesn't matter.
So I thought that the intention of the original code was that "unrelated
ACE" should not affect the owner and should thus be positioned after the 
ACCESS_ALLOWED_ACE of the owner (i.e. the original author meant 
owner_allow, not owner_deny, in the comment).
However that breaks the MS canonical order where all access denied ACEs
should be in front. 
So what my code is doing is this: if the unrelated ACE doesn't affect
the owner, put the ACE in front to please MS. If it affects the owner,
place it behind the owner_allow.


Pierre
