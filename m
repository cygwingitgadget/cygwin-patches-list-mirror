Return-Path: <cygwin-patches-return-7140-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18365 invoked by alias); 15 Dec 2010 14:12:07 -0000
Received: (qmail 18323 invoked by uid 22791); 15 Dec 2010 14:11:56 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Wed, 15 Dec 2010 14:11:52 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 13B886D4272; Wed, 15 Dec 2010 15:11:49 +0100 (CET)
Date: Wed, 15 Dec 2010 18:47:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Ensure that the default ACL contains the standard entries
Message-ID: <20101215141149.GW10566@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4D02A41C.8030406@t-online.de> <20101211204653.GA26611@calimero.vinschen.de> <4D07E02A.2020202@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4D07E02A.2020202@t-online.de>
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
X-SW-Source: 2010-q4/txt/msg00019.txt.bz2

On Dec 14 22:22, Christian Franke wrote:
> Hi Corinna,
> 
> Corinna Vinschen wrote:
> >Hi Christian,
> >
> >On Dec 10 23:05, Christian Franke wrote:
> >>The ACL from Cygwin always contains the three (USER|GROUP|OTHER)_OBJ
> >>entries. It might be existing practice elsewhere to return these
> >>entries also in the default ACL. The attached patch adds these
> >>entries with empty permissions if necessary.
> >>
> >>The patch would fix this rsync issue:
> >>http://cygwin.com/ml/cygwin/2010-11/msg00429.html
> >>
> >>The logic for DEF_CLASS_OBJ is unchanged.
> >
> >This looks good, except that the faked default entries for group and
> >other are set to 0.  That's rather unexpected. ...
> >
> >This is rather easy to fix (and you added comments in that place), ...
> 
> New patch attached.

Thanks, applied.

> >I'm not entirely sure yet, but maybe the acl function should not
> >fake these default entries.  From my POV it seems a better approach
> >if acl(SETACL) actually creates these entries if *any* default entry
> >is in the incoming acl.  And, it should create these entries with
> >useful permission values.  This seems to reflect the Linux behaviour
> >much closer.  What do you think?
> 
> AFIAK a minimal ACL must contain the three entries u/g/o which are
> equivalent to the mode permission bits. The default ACL has likely
> the same requirement.

Apparently yes.  I just tested this on Linux and Solaris.  On Linux
the missing entries are added with default values, on Solaris 10
you are required to enter at least the three default o/g/u entries,
otherwise setfacl prints an error message

 "Missing user/group owner, other, mask entry"

> If this is the case, then I would suggest to do both:
> 
> 1. Fake these entries in acl(GETACL) if required. This would ensure
> that the default ACL is complete even if the Windows ACL was not
> created by Cygwin.
> 
> 2. Create these entries in acl(SETACL) if required. This would
> ensure that the following reasonable requirement holds if the
> Windows ACL was created by Cygwin before:
> 
> - "getfacl foo | setfacl -f - foo" should not change the (Windows)
> ACL of "foo".

Ok, fine with me.

> >   Would you implement this?
> 
> Yes, but may take some time.

No worries.  We won't release 1.7.8 before January.

> >Btw., while testing your patch I found a bug in setfacl which disallowed
> >to delete user/group-specific default entries.  I opted for rewriting the
> >function which examines an incoming acl entry (getaclentry).  Would you
> >mind to test this bit, too?  The new code accepts a trailing colon, but
> >I think that's ok.  The SGI setfacl tool used on Linux is even more
> >relaxed syntax-wise and also accepts trailing colons.
> 
> I've done a few test, looks good.

Thank you!

> An unrelated issue found during testing:
> 
> mkdir() may duplicate Windows ACL entries. Testcase (German XP SP3):
> [...]
> Problem in security.cc:alloc_sd() ?

Indeed.  Thanks for the report.  I fixed that in CVS, hopefully.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
