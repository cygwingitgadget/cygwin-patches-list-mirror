Return-Path: <cygwin-patches-return-3224-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31456 invoked by alias); 24 Nov 2002 16:08:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31445 invoked from network); 24 Nov 2002 16:08:07 -0000
Date: Sun, 24 Nov 2002 08:08:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: More passwd/group patches
Message-ID: <20021124170805.B1398@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3DDE4528.3BDCDCEF@ieee.org> <3DDE3FB9.2AFAA199@ieee.org> <20021122154644.N1398@cygbert.vinschen.de> <3DDE4528.3BDCDCEF@ieee.org> <3.0.5.32.20021124092120.00829650@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20021124092120.00829650@mail.attbi.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q4/txt/msg00175.txt.bz2

On Sun, Nov 24, 2002 at 09:21:20AM -0500, Pierre A. Humblet wrote:
> At 02:04 PM 11/24/2002 +0100, you wrote:
> 
> Hi Corinna,
> 
> First off I am going to look at the Win98 home directory problem 
> reported on the list, if you have not fixed it already.

I couldn't.  My VM struggled installing 98 the last few hours.
I really really hope this installation will not be that touchy.
Any success?  I assume it's the setting of myself->gid = DEFAULT_GID
at the beginning of internal_getlogin(), somehow.

> >I don't like the idea that these DENY bits are still set when the acl is
> >returned to the application.  The underlying Solaris acl implementation 
> >doesn't know about these bits.  They should be removed before returning
> >the acl to the application.  Otherwise you're using bits which are not
> >defined in acl.h.
> 
> That had crossed my mind. In fact acl.h does not declare any values for
> the a_perm field. Cygwin is simply reproducing the bits in the 
> user, group and other fields. I searched the web and saw that other
> versions of unix did not even agree on the type of the a_perm field (Cygwin
> makes it mode_t) and that the now-defunct standard proposal was silent on the 
> issue. So it seemed to me that all that mattered was consistency with
> the implementation of the routines getfacl, setfacl, etc... 
> I have no problem with masking them off. Defining specific bits in acl.h 
> would be nice in theory, but in absence of a standard perhaps not useful.

Note that acl.h is Solaris compatible.  It doesn't define anything
which isn't defined on Solaris.   The Solaris implementation is
NOT in any way compatible to the withdrawn POSIX proposal.  That
in turn means, Solaris is our role model when it comes to acl(2).

> >You're copying the group bits to the mask?  Didn't you suggest to set
> >it to rwx?  I think you're right.  It would be better to move this line
> >to the initialization of the first lacl members and change it to
> >
> Yes, but not knowing the reason for the current behavior I didn't want
> to change it. It doesn't hurt anything.
> >
> >Same here, shouldn't the DEF_CLASS_OBJ entry have rwx, too?
> >
> Same answer!

Actually, I've just checked on a Solaris box (SunOS 5.8) and except
for a definition problem related to the too releaxed usage of S_IREAD,
S_IWRITE and S_IEXEC, my getfacl utility runs on Solaris, too.  I
used gdb to look into the acl returned by acl(2) and found some
interesting facts:

- The permission bits used are only S_IROTH, S_IWOTH and S_IXOTH.
  No other bits are set...
- ...except for in the CLASS_OBJ entry.  The default setting on that
  machine for all my files is 0x1ff and, frankly, I have no idea
  how to explain that setting.  Interesting enough, the Solaris
  getfacl as well as my getfacl both return 'rwx' as permission bits
  for that entry.

- a_id = -1 in CLASS_OBJ and OTHER_OBJ entries.

I'm going to change getfacl(3) to use S_IROTH instead of S_IREAD etc. 

The appropriate changes to sec_acl.cc would collide with your patch
so I'd like to ask you if you want me to make the necessary changes
to comply with Solaris first and then to send a revised patch, or
if you want to incorporate these changes into your patch, too?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
