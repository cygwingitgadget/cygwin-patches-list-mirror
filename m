Return-Path: <cygwin-patches-return-7885-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26791 invoked by alias); 13 May 2013 14:26:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 26780 invoked by uid 89); 13 May 2013 14:26:36 -0000
X-Spam-SWARE-Status: No, score=-1.8 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.1
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.84/v0.84-167-ge50287c) with ESMTP; Mon, 13 May 2013 14:26:36 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id C5C695201ED; Mon, 13 May 2013 16:26:33 +0200 (CEST)
Date: Mon, 13 May 2013 14:26:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] DocBook XML toolchain modernization
Message-ID: <20130513142633.GB9456@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <51783EBC.30409@etr-usa.com> <20130425084305.GA29270@calimero.vinschen.de> <517F15AF.5080307@etr-usa.com> <20130430184703.GB6865@ednor.casa.cgf.cx> <51801469.9070606@etr-usa.com> <20130430190706.GC6865@ednor.casa.cgf.cx> <51802510.5000803@etr-usa.com> <20130430202737.GA1858@ednor.casa.cgf.cx> <51803D76.5010302@etr-usa.com> <20130501003154.GB3781@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20130501003154.GB3781@ednor.casa.cgf.cx>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SW-Source: 2013-q2/txt/msg00023.txt.bz2

On Apr 30 20:31, Christopher Faylor wrote:
> On Tue, Apr 30, 2013 at 03:53:58PM -0600, Warren Young wrote:
> >On 4/30/2013 14:27, Christopher Faylor wrote:
> >> On Tue, Apr 30, 2013 at 02:09:52PM -0600, Warren Young wrote:
> >>>   Embedding <html> within <html> is eeevil.
> >>
> >> faq.html is a pretty simple file and it seems to work.  Are there any
> >> non-religious advantages to doing this?
> >
> >Conceivably browsers could stop tolerating it.
> 
> Yeah, that's what I thought you'd say.  I don't think it's worth the
> effort and expense of duplicating Cygwin's CSS elsewhere but maybe
> there's a clever way to avoid the html nesting which wouldn't require
> that.
> 
> >>> - Any comments about the other items in my FUTURE WORK section?
> >>> Unconditional green light, or do you want to approve them one by one?
> >>
> >> You have the right to change anything in the doc directory.  Anything
> >> outside of that will require approval.
> >
> >The final removal of doctool requires replacing the DOCTOOL/SGML 
> >comments in winsup/cygwin/{path,pinfo}.cc with Doxygen comments, and 
> >folding most of the contents of winsup/cygwin/*.sgml into Doxygen 
> >comments within the relevant source files.
> 
> I'd rather just move this out of the code entirely.  The user visible
> interfaces aren't going to change and we haven't made a habit of
> adding new DOCTOOL tags.  I don't know who first thought that adding
> these was a good idea (it may predate my time on the project even
> though CVS insists that I added it with version 1.1) but, if Corinna
> agrees when she gets back, I'd like to just get rid of these.

I have not the faintest problem here, so I guess this means, just nuke
'em.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat
