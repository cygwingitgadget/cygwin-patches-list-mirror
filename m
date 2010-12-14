Return-Path: <cygwin-patches-return-7138-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19088 invoked by alias); 11 Dec 2010 20:47:16 -0000
Received: (qmail 19041 invoked by uid 22791); 11 Dec 2010 20:47:03 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Sat, 11 Dec 2010 20:46:57 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 631C76D435B; Sat, 11 Dec 2010 21:46:54 +0100 (CET)
Date: Tue, 14 Dec 2010 21:23:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Ensure that the default ACL contains the standard entries
Message-ID: <20101211204653.GA26611@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4D02A41C.8030406@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4D02A41C.8030406@t-online.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q4/txt/msg00017.txt.bz2

Hi Christian,

On Dec 10 23:05, Christian Franke wrote:
> The ACL from Cygwin always contains the three (USER|GROUP|OTHER)_OBJ
> entries. It might be existing practice elsewhere to return these
> entries also in the default ACL. The attached patch adds these
> entries with empty permissions if necessary.
> 
> The patch would fix this rsync issue:
> http://cygwin.com/ml/cygwin/2010-11/msg00429.html
> 
> The logic for DEF_CLASS_OBJ is unchanged.

Thanks for the patch.  There are two problem with it, unfortunately.
Consider the setfacl tool.  The -m option basically works like this:

  acl (path, GETACL);
  modify_acl ();
  acl (path, SETACL);

Now, what happens with your patch is this.  Let's assume I add a
single default entry:

  $ getfacl dir
  [...]
  user::rwx
  group::r-x
  mask::rwx
  other::r-x
  $ setfacl -m d:u:corinna:rwx dir
  [...]
  user::rwx
  group::r-x
  mask::rwx
  other::r-x
  default:user::---
  default:user:corinna:rwx
  default:group::---
  default:mask::rwx
  default:other::---

This looks good, except that the faked default entries for group and
other are set to 0.  That's rather unexpected.  Actually, by default the
default entries should reflect the standard permission bits.  At least
that's what happens in the above example on Linux (I tried with
different values for the permission bits):

  $ setfacl -m d:u:corinna:rwx dir
  [...]
  user::rwx
  group::r-x
  mask::rwx
  other::r-x
  default:user::rwx
  default:user:corinna:rwx
  default:group::r-x
  default:mask::rwx
  default:other::r-x

This is rather easy to fix (and you added comments in that place), but
here comes problem #2.  In reality, the Windows ACL does not contain any
default entries except for the default entry for user corinna:

  $ icacls dir
  c:\cygwin\home\corinna\dir VINSCHEN\corinna:(F)
			     VINSCHEN\vinschen:(RX)
			     Everyone:(RX)
			     VINSCHEN\corinna:(OI)(CI)(IO)(RX,W,DC)

Ok, but, what happens if I call setfacl again?  The first call to acl
in setfacl returns the faked default entries.  So, after modifying the
acl according to the command line, the SETACL call now still contains
the faked acl entry.  Which means, they are now written back to the
dir's ACL.  Just call setfacl with the same command line again:

  $ setfacl -m d:u:corinna:rwx dir
  $ icacls dir
  c:\cygwin\home\corinna\tmp VINSCHEN\corinna:(F)
			     VINSCHEN\vinschen:(RX)
			     Everyone:(RX)
			     CREATOR OWNER:(OI)(CI)(IO)(D,Rc,WDAC,WO,RA,WA)
			     VINSCHEN\corinna:(OI)(CI)(IO)(RX,W,DC)
			     CREATOR GROUP:(OI)(CI)(IO)(Rc,RA)
			     Everyone:(OI)(CI)(IO)(Rc,RA)

Even though nothing has changed, the ACL is now different since it
actually reflects the so far faked default entries.  I'm not sure if
that's feasible behaviour.  Besides, due to the faked default entries
defaulting to 0 permissions, subsequently created files in that
directory will have 000 permissions by default.  Uh oh.

I'm not entirely sure yet, but maybe the acl function should not
fake these default entries.  From my POV it seems a better approach
if acl(SETACL) actually creates these entries if *any* default entry
is in the incoming acl.  And, it should create these entries with
useful permission values.  This seems to reflect the Linux behaviour
much closer.  What do you think?  Would you implement this?

Btw., while testing your patch I found a bug in setfacl which disallowed
to delete user/group-specific default entries.  I opted for rewriting the
function which examines an incoming acl entry (getaclentry).  Would you
mind to test this bit, too?  The new code accepts a trailing colon, but
I think that's ok.  The SGI setfacl tool used on Linux is even more
relaxed syntax-wise and also accepts trailing colons.


Corinna
