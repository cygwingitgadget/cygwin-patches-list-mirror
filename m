Return-Path: <cygwin-patches-return-3180-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29306 invoked by alias); 15 Nov 2002 14:31:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29237 invoked from network); 15 Nov 2002 14:31:16 -0000
Message-ID: <3DD5053C.E50A33@ieee.org>
Date: Fri, 15 Nov 2002 06:31:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: ntsec patch 1: uid==gid, chmod, alloc_sd, is_grp_member
References: <20021113135916.Q10395@cygbert.vinschen.de> <3DD27B59.3FA8990@ieee.org> <3.0.5.32.20021113223509.0082c960@mail.attbi.com> <20021114110340.G10395@cygbert.vinschen.de> <3DD3B369.A530D7EE@ieee.org> <20021114173630.A20639@cygbert.vinschen.de> <3DD3D75C.99C07A78@ieee.org> <20021114182323.L10395@cygbert.vinschen.de> <20021114202105.N10395@cygbert.vinschen.de> <3.0.5.32.20021114220454.0082ca20@mail.attbi.com> <20021115105000.A24928@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q4/txt/msg00131.txt.bz2

Corinna Vinschen wrote:
> 
> Sorry, I still have some problems:

Me too!
 
> Looking for the modes.  Before that change:
> 
>   drwxr-xr-x    2 SYSTEM   SYSTEM          0 Jul  7 11:39 /var/empty
> 
> With that patch:
> 
>   drwxrwxr-x    2 SYSTEM   SYSTEM          0 Jul  7 11:39 /var/empty
> 
> I'm not against the patch since it reflects the permissions obviously
> better than the old version.  However, how many people are running
> sshd now with the above /var/empty settings.  Urgh.

> I only see two choices:
> - Let it as it is now.
> - Force all people with a running sshd installation to chmod 544
>   /var/empty.

I am in favor of showing the truth. The basic problem is that
owner == group but they have different permissions, which is 
non-sensical in Windows. 
In this specific case it helps to lie, but if we lie and the intention 
of the user was to chmod to 775 or 770, the user would have every right
to complain bitterly and we would have a very lame excuse.  
I am not familar with /var/empty. Is there a reason why 
owner == group and the modes are not equal?
This is an exceptional  case where a postinstall script might help.

> > @@ -1664,18 +1666,25 @@ alloc_sd (__uid32_t uid, __gid32_t gid,
> >        if (attribute & S_ISVTX)
> >       null_allow |= FILE_READ_DATA;
> >      }
> > -
> > -  /* Construct deny attributes for owner and group. */
> > -  DWORD owner_deny = 0;
> > -  if (is_grp_member (uid, gid))
> > -    owner_deny = ~owner_allow & (group_allow | other_allow);
> 
> Erm... that's not exactly what we agreed upon...

We discussed is_grp_member in get_nt_attribute and get_nt_object_attribute
but this is VERY different. It's in alloc_sd.
There is no good reason to call is_grp_member here. The old code was omitting
the insertion of an owner_deny ace in that case. That's undesirable because
it makes the acl ambiguous. Another bad side effect of omitting the deny ace
is that if the groups of the owner of the file are changed, then the modes
of the file might also change.
  

> >         if (!AddAce (acl, ACL_REVISION,
> >                      ace->Header.AceType == ACCESS_DENIED_ACE_TYPE ?
> > -                    (owner_deny ? 1 : 0) : MAXDWORD,
> > +                    ace->Mask & owner_allow ? owner_off + 1 : owner_off++
> > +                    : MAXDWORD,
> >                      (LPVOID) ace, ace->Header.AceSize))
> 
> After applying the patch to my local sandbox I found that I'm still
> having problems here.  
What problems?

> While I see the advantage for emulating POSIX
> permissions closer, I also see that the probability is pretty high
> that all unrelated deny ACEs will be placed after the owner_allow
> (which probably has most bits set).  This doesn't really support the
> wish to produce ACLs in canonical order.  So far, only the group_deny
> could possibly but unlikely be placed after the owner_allow...
> 
This is really an issue I don't care about, there are very few unrelated
deny ACEs out there. I thought that Cygwin approach was to try to conform 
to Posix, at the cost of possibly not respecting the canonical order.
Once the canonical order is broken (by group_deny), I don't see what extra
harm is done to break it a little more with the unrelated ACEs. 
In both cases the Windows security GUI will complain equally. 

Pierre
