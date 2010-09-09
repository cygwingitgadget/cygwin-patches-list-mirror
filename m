Return-Path: <cygwin-patches-return-7081-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11580 invoked by alias); 9 Sep 2010 07:50:59 -0000
Received: (qmail 11157 invoked by uid 22791); 9 Sep 2010 07:50:27 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Thu, 09 Sep 2010 07:50:22 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id B86DC6D435B; Thu,  9 Sep 2010 09:50:18 +0200 (CEST)
Date: Thu, 09 Sep 2010 07:50:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Mounting /tmp at TMP or TEMP as a last resort
Message-ID: <20100909075018.GW16534@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4C880761.2030503@ixiacom.com> <4C880DC2.1070706@ixiacom.com> <20100908224108.GB13153@ednor.casa.cgf.cx> <4C881565.7050705@ixiacom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4C881565.7050705@ixiacom.com>
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
X-SW-Source: 2010-q3/txt/msg00041.txt.bz2

On Sep  8 15:59, Earl Chew wrote:
> On 08/09/2010 3:41 PM, Christopher Faylor wrote:
> > Thanks for the patch but I don't think this is generally useful.  If you
> > need to mount /tmp somewhere else then it should be fairly trivial to
> > automatically update /etc/fstab.  Corinna may disagree, but I think we
> > should keep the parsing of /etc/fstab as lean as possible; particularly
> > when there are alternatives to modifying Cygwin to achieve the desired
> > result.
> 
> Yes, I understand what you're saying.
> 
> In our situation, we prefer an out-of-the-box deployment. (We're
> essentially trying to get to a "untar this and use it" state).
> 
> That said, I don't think it's possible for /etc/fstab to inspect
> environment variables, so manipulation of /etc/fstab would
> require the assistance of some other script to edit /etc/fstab on
> the fly --- and even then it would be difficult to track changes
> to the environment variables.

Apart from changing /etc/fstab or /etc/fstab.d/$USER by some installer
script, why not just add a one-liner profile script along the lines of

 /etc/profile.d/tmp-mnt.sh:

   mount -f `cygpath -m "${TEMP}"` /tmp


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
