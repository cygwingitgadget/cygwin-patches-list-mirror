Return-Path: <cygwin-patches-return-7142-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17528 invoked by alias); 16 Dec 2010 11:10:42 -0000
Received: (qmail 17478 invoked by uid 22791); 16 Dec 2010 11:10:32 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Thu, 16 Dec 2010 11:10:27 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id E29D66D4272; Thu, 16 Dec 2010 12:10:24 +0100 (CET)
Date: Mon, 20 Dec 2010 21:33:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Ensure that the default ACL contains the standard entries
Message-ID: <20101216111024.GX10566@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4D02A41C.8030406@t-online.de> <20101211204653.GA26611@calimero.vinschen.de> <4D07E02A.2020202@t-online.de> <20101215141149.GW10566@calimero.vinschen.de> <4D090D12.6020407@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4D090D12.6020407@t-online.de>
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
X-SW-Source: 2010-q4/txt/msg00021.txt.bz2

Hi Christian,

On Dec 15 19:46, Christian Franke wrote:
> Corinna Vinschen wrote:
> >>
> >>New patch attached.
> >Thanks, applied.
> >
> 
> Thanks - rsync issue is now fixed.

Good start.

> >>mkdir() may duplicate Windows ACL entries. Testcase (German XP SP3):
> >>[...]
> >>Problem in security.cc:alloc_sd() ?
> >Indeed.  Thanks for the report.  I fixed that in CVS, hopefully.
> >
> >
> 
> At least the testcase is now OK :-)

Indeed, but the patch was still wrong.  It just droped all ACEs for
creator_owner, creator_group and other in the "unrelated ACE copy loop"
unconditionally.  In fact dropping them is only allowed for newly
created directories.  I applied another patch which should work better.

> BTW: Are there any long term plans to actually implement the acl "mask" ?
> Should be possible by mapping the "mask" restrictions to deny acl
> entries for each named entry:

There are no such plans, but that doesn't mean I wouldn't take patches
which implement this.  In fact I would be *very* happy to get patches
which improve ACL handling, and I'm not finicky in terms of the type
of enhancement.  Various ideas come to mind:

- Fix acl(2) by handling deny ACEs at all.

- Implement the POSIX 1003.1e functions (maybe simply in terms of
  the existing Solaris API).

- Add missing Solaris ACL functions (acl_get, facl_get, acl_set, facl_set,
  acl_fromtext, acl_totext, acl_free, acl_strip, acl_trivial).

- Add Solaris NFSv4 ACLs, which, coincidentally, are almost equivalent
  to Windows ACLs.  This would work nicely for NTFS ACLs, of course.
  See http://docs.sun.com/app/docs/doc/819-2252/acl-5?l=en&a=view

- Last but not least:  Actually handle "mask".

Adding deny entries which correspond to the mask value sounds like an
interesting idea.  Of course they shouldn't be added if they are not
necessary since deny entries and the problems with the so-called
"canonical ACL order" are such a bloody mess.

OTOH, if you don't fake the mask entry, you need a way to stick the mask
into the Windows ACL.  Even twice, the normal mask and the default mask.

This only works if you have a SID which you use for this purpose.

Hmm...

What about redefining the NULL SID?  Right now three bits in the
NULL SID acess mask are used:

  S_ISUID     ->  FILE_APPEND_DATA
  S_ISGID     ->  FILE_WRITE_DATA
  S_ISVTX     ->  FILE_READ_DATA

I don't see that anything speaks against adding other meanings to
the remaining 29 bits.  For instance:

  mask-r      ->  FILE_READ_EA
  mask-w      ->  FILE_WRITE_EA
  mask-x      ->  FILE_EXECUTE
  def-mask-r  ->  FILE_READ_ATTRIBUTES
  def-mask-w  ->  FILE_WRITE_ATTRIBUTES
  def-mask-x  ->  FILE_DELETE_CHILD

If we do this, we can add an actual mask and we can not only use it
in acl(), but also in alloc_sd().

Does that sound useful?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
