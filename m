Return-Path: <cygwin-patches-return-3182-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16082 invoked by alias); 15 Nov 2002 15:02:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16029 invoked from network); 15 Nov 2002 15:02:25 -0000
Date: Fri, 15 Nov 2002 07:02:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: ntsec patch 1: uid==gid, chmod, alloc_sd, is_grp_member
Message-ID: <20021115160223.L24928@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20021113223509.0082c960@mail.attbi.com> <20021114110340.G10395@cygbert.vinschen.de> <3DD3B369.A530D7EE@ieee.org> <20021114173630.A20639@cygbert.vinschen.de> <3DD3D75C.99C07A78@ieee.org> <20021114182323.L10395@cygbert.vinschen.de> <20021114202105.N10395@cygbert.vinschen.de> <3.0.5.32.20021114220454.0082ca20@mail.attbi.com> <20021115105000.A24928@cygbert.vinschen.de> <3DD5053C.E50A33@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DD5053C.E50A33@ieee.org>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q4/txt/msg00133.txt.bz2

On Fri, Nov 15, 2002 at 09:31:24AM -0500, Pierre A. Humblet wrote:
> I am not familar with /var/empty. Is there a reason why 
> owner == group and the modes are not equal?

ssh-host-config calls

 chown system.system /var/empty
 chmod 755 /var/empty

sshd checks /var/empty for not having more than 755 permissions...

> This is an exceptional  case where a postinstall script might help.

Which only helps for new ssh versions.  It could change group like

  chgrp 544 or 513 /var/empty
  
but that only works for default /etc/group files.

> We discussed is_grp_member in get_nt_attribute and get_nt_object_attribute
> but this is VERY different. It's in alloc_sd.
> There is no good reason to call is_grp_member here. The old code was omitting
> the insertion of an owner_deny ace in that case. That's undesirable because
> it makes the acl ambiguous. Another bad side effect of omitting the deny ace
> is that if the groups of the owner of the file are changed, then the modes
> of the file might also change.

Uhm?  I don't understand.  The group_deny is only needed if the group
has more permissions than the user _and_ the user is a member of the
group.  What is ambiguous in that case?

> > >                      ace->Header.AceType == ACCESS_DENIED_ACE_TYPE ?
> > > -                    (owner_deny ? 1 : 0) : MAXDWORD,
> > > +                    ace->Mask & owner_allow ? owner_off + 1 : owner_off++
> > > +                    : MAXDWORD,
> > >                      (LPVOID) ace, ace->Header.AceSize))
> > 
> > After applying the patch to my local sandbox I found that I'm still
> > having problems here.  
> What problems?

These problems:

> > While I see the advantage for emulating POSIX
> > permissions closer, I also see that the probability is pretty high
> > that all unrelated deny ACEs will be placed after the owner_allow
> > (which probably has most bits set).  This doesn't really support the
> > wish to produce ACLs in canonical order.  So far, only the group_deny
> > could possibly but unlikely be placed after the owner_allow...
> > 
> This is really an issue I don't care about, there are very few unrelated
> deny ACEs out there. I thought that Cygwin approach was to try to conform 

I disagree.  I know how complex NT adminstration might become in a
complex environment (my friend is NT admin in a big government).

> to Posix, at the cost of possibly not respecting the canonical order.

Cygwin tries to be most POSIX compatible but we're also trying to stay
nice to the user.  The difference is, that so far a non-canonical order
is only created in the unlikely case of having the group more permissions
than the user and only if the user is a member of that group.  Your
solution is positioning nearly all deny ACEs after the user allow ACEs
since it's very likely that the unrelated ACE has some bit set which is
also set in the users ACE.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
