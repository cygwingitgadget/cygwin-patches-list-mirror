Return-Path: <cygwin-patches-return-7699-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14597 invoked by alias); 16 Aug 2012 08:41:57 -0000
Received: (qmail 12560 invoked by uid 22791); 16 Aug 2012 08:41:16 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Thu, 16 Aug 2012 08:41:02 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 057872C00CA; Thu, 16 Aug 2012 10:40:59 +0200 (CEST)
Date: Thu, 16 Aug 2012 08:41:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: New modes for cygpath that terminate path with null byte, nothing
Message-ID: <20120816084058.GA20051@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <50124C62.9080405@dancol.org> <20120727093245.GB30208@calimero.vinschen.de> <502AC7DD.5060003@dancol.org> <20120815050205.GA28917@ednor.casa.cgf.cx> <502B2F77.2010204@dancol.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <502B2F77.2010204@dancol.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2012-q3/txt/msg00020.txt.bz2

On Aug 14 22:11, Daniel Colascione wrote:
> On 8/14/12 10:02 PM, Christopher Faylor wrote:
> > On Tue, Aug 14, 2012 at 02:49:17PM -0700, Daniel Colascione wrote:
> >> On 7/27/2012 2:32 AM, Corinna Vinschen wrote:
> >>> There's just the problem of the copyright assignment.  If you want to
> >>> provide a non-obvious patch, or if the patch adds new functionality, we
> >>> need a copyright assignment from you.  Please see the section "Before
> >>> you get started" on http://cygwin.com/contrib.html and the assignment
> >>> form http://cygwin.com/assign.txt
> >>>
> >>> As soon as my manager has the assignment, I'll apply your patch.
> >>
> >> Do you guys still want the patch (and papers that go with it)? If so, could I
> >> discuss the particulars of the assignment off-list somewhere?
> > 
> > As I mentioned, it seems like you can easily get the functionality
> > you're looking for by using standard Cygwin tools so, IMO, we don't need
> > your patch.
> 
> I didn't know what the final decision was; that's why I asked. Corinna
> said she wanted the patch. As for the feature itself: piping through
> tr is fine, but having cygpath output paths in the desired way in the
> first place keeps error information around (without pipefail, $? is
> tr's exit status) and involves fewer forks. There's precedent in "echo
> -n" too.

What's your problem with the assignment form?  You can send me PM
to my address as mentioned in the ChangeLog files.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
