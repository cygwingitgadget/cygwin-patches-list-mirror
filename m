Return-Path: <cygwin-patches-return-3183-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24757 invoked by alias); 15 Nov 2002 15:24:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24747 invoked from network); 15 Nov 2002 15:24:23 -0000
Message-ID: <3DD511B4.DBF3846E@ieee.org>
Date: Fri, 15 Nov 2002 07:24:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: ntsec patch 1: uid==gid, chmod, alloc_sd, is_grp_member
References: <3.0.5.32.20021113223509.0082c960@mail.attbi.com> <20021114110340.G10395@cygbert.vinschen.de> <3DD3B369.A530D7EE@ieee.org> <20021114173630.A20639@cygbert.vinschen.de> <3DD3D75C.99C07A78@ieee.org> <20021114182323.L10395@cygbert.vinschen.de> <20021114202105.N10395@cygbert.vinschen.de> <3.0.5.32.20021114220454.0082ca20@mail.attbi.com> <20021115105000.A24928@cygbert.vinschen.de> <3DD5053C.E50A33@ieee.org> <20021115160223.L24928@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q4/txt/msg00134.txt.bz2

Corinna Vinschen wrote:
> 
> On Fri, Nov 15, 2002 at 09:31:24AM -0500, Pierre A. Humblet wrote:
> > I am not familar with /var/empty. Is there a reason why
> > owner == group and the modes are not equal?
> 
> ssh-host-config calls
> 
>  chown system.system /var/empty
>  chmod 755 /var/empty
> 
> sshd checks /var/empty for not having more than 755 permissions...
> 
> > This is an exceptional  case where a postinstall script might help.
> 
> Which only helps for new ssh versions.  It could change group like
> 
>   chgrp 544 or 513 /var/empty
> 
> but that only works for default /etc/group files.

544 is still the best solution, IMHO. Let's take the long term view.

> > We discussed is_grp_member in get_nt_attribute and get_nt_object_attribute
> > but this is VERY different. It's in alloc_sd.
> > There is no good reason to call is_grp_member here. The old code was omitting
> > the insertion of an owner_deny ace in that case. That's undesirable because
> > it makes the acl ambiguous. Another bad side effect of omitting the deny ace
> > is that if the groups of the owner of the file are changed, then the modes
> > of the file might also change.
> 
> Uhm?  I don't understand.  The group_deny is only needed if the group
> has more permissions than the user _and_ the user is a member of the
> group.  What is ambiguous in that case?

It's not a group_deny, it's an owner deny (which would go on top, so canonical
order is OK here).
Without the owner_deny, the ACL is ambiguous because it requires knowledge
of token groups at the time the file is accessed, which we can't provide 
reliably. 
Also if the owner is not in the group when alloc_sd is called, and is placed
in the group later, then the owner access mode of the file would change, which 
isn't POSIX.
Let's look at it from another angle: what is gained by going through the trouble
of calling is_grp_member and possibly omitting the owner_deny?


> > >
> > This is really an issue I don't care about, there are very few unrelated
> > deny ACEs out there. I thought that Cygwin approach was to try to conform
> 
> I disagree.  I know how complex NT adminstration might become in a
> complex environment (my friend is NT admin in a big government).
> 
> > to Posix, at the cost of possibly not respecting the canonical order.
> 
> Cygwin tries to be most POSIX compatible but we're also trying to stay
> nice to the user.  The difference is, that so far a non-canonical order
> is only created in the unlikely case of having the group more permissions
> than the user and only if the user is a member of that group.  Your
> solution is positioning nearly all deny ACEs after the user allow ACEs
> since it's very likely that the unrelated ACE has some bit set which is
> also set in the users ACE.

The non canonical order is produced when the group has less permission 
than everyone, which I agree is unlikely. 
It's 100% OK with me to give preference to being nice!

Pierre
