Return-Path: <cygwin-patches-return-3159-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31987 invoked by alias); 13 Nov 2002 12:59:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31974 invoked from network); 13 Nov 2002 12:59:19 -0000
Date: Wed, 13 Nov 2002 04:59:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: ntsec patch 1: uid==gid, chmod, alloc_sd, is_grp_member
Message-ID: <20021113135916.Q10395@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3DD159F7.45001468@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DD159F7.45001468@ieee.org>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q4/txt/msg00110.txt.bz2

On Tue, Nov 12, 2002 at 02:43:51PM -0500, Pierre A. Humblet wrote:
> > It's just a flaw in is_grp_member() but it's still needed to get the
> > information about the group membership.  is_grp_member() shouldn't check
> > the current token if the uid isn't myself->uid but otherwise it's ok.
> 
> That's the heart of the matter. How do you propose to fix is_grp_member()?
> I believe it would involve contacting the PDC for domain users. IMHO it's 
> unacceptable for performance reasons. 
> That's why I would only insist on B1), not B3).

I think I found an easy (not necessaily fast) solution which doesn't
involve calling the PDC.  Basically we do already depend on /etc/group
heavily so we can do this here, too, IMHO:

Index: grp.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/grp.cc,v
retrieving revision 1.56
diff -u -p -r1.56 grp.cc
--- grp.cc      30 Sep 2002 15:17:44 -0000      1.56
+++ grp.cc      13 Nov 2002 12:34:45 -0000
@@ -342,6 +342,7 @@ getgroups32 (int gidsetsize, __gid32_t *
     read_etc_group ();
 
   if (allow_ntsec &&
+      strcasematch (username, cygheap->user.name ()) &&
       OpenProcessToken (hMainProc, TOKEN_QUERY, &hToken))
     {
       if (GetTokenInformation (hToken, TokenGroups, NULL, 0, &size)


This skips the GetTokenInformation and just uses the group info
found in /etc/group.  What do you think (besides trying to speed
up getgroups32)?

> > Why are you turning around the order of the conditionals?  I don't see
> > a reason.
> 
> One side is a cygsid, the other is a PSID. I would like the cygsid ==
> operator to apply. Apparently the order matters (I didn't know it).

Ah, ok.

> to test. I should really replace the last line above by "owner_sid == group_sid",
> although that returns TRUE if both are NULL, so there is a small difference
> (but that case should never arise).

Yep.

> > > +    {
> > > +      allow &= ~(S_IRGRP | S_IWGRP | S_IXGRP);
> > 
> > This line is essentially superfluous.  It's job has been done two lines
> > before.
> Uh?

I'm sorry, I misread the situation.

> > Why do you remove this check?  It's still needed when called by
> > set_security_attribute().  Or set_security_attribute() needs that check.
> 
> set_security_attribute() is only called when a file has acls, which AFAIK
> can only happen on NT. So it's OK. 

Hmm, you're right.

> > Why do you remove this check?  It's still an interesting info, isn't it?
> Yes, it's just for uniformity of interface. None of the other security
> routines go into that level of detail when they read passwd. 
> The information is available from the remaining debug_printf.

Ok.

> > > -  owner_sid.debug_print ("alloc_sd: owner SID =");
> > And this one?
> I thought that was a debug leftover from the time you introduced the 
> caching. It's not done anywhere else.

No, I was already often happy  to see the SID at this point.  It helped
debugging.  I'd like to keep it.

> > >         if (!AddAce (acl, ACL_REVISION,
> > >                      ace->Header.AceType == ACCESS_DENIED_ACE_TYPE ?
> > > -                    (owner_deny ? 1 : 0) : MAXDWORD,
> > > +                    ace->Mask & owner_allow ? owner_off + 1 : owner_off++
> > 
> > Could you explain how that should work?  I'm not sure about that.
> > owner_off is the position of the owner_allow ACE.  Since the above
> > test already filters all related ACEs, the incoming ACE is unrelated
> > to the owner entry.  So why do you check the content of the ACE
> > against the bits set in the owner_allow mask?!?
> 
> Good question. I was puzzled by the original comment and code:
> 	   * Add unrelated ACCESS_DENIED_ACE to the beginning but
> 	   * behind the owner_deny, ACCESS_ALLOWED_ACE to the end.
> The ACCESS_DENIED_ACE part made no sense to me because if there are a 
> bunch of ACCESS_DENIED following each other, their order doesn't matter.
> So I thought that the intention of the original code was that "unrelated
> ACE" should not affect the owner and should thus be positioned after the 
> ACCESS_ALLOWED_ACE of the owner (i.e. the original author meant 
> owner_allow, not owner_deny, in the comment).

No, the original code actually knows that the current situation is
either 

	owner_allow
	group_ace
	...

or

	owner_deny
	owner_allow
	group_ace
	...

The code just differs between having or having not an owner_deny.
All denies are going to the beginning of the ACL, maintaining the
canonical order.  The canonical order places user ACEs in from of
group ACEs.  To keep this order, the remaining unrelated deny
ACEs are positioned after the owner ACE.  That's all and that's
correct, AFAICS.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
