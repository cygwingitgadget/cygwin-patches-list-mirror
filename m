Return-Path: <cygwin-patches-return-6361-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20480 invoked by alias); 27 Nov 2008 11:15:52 -0000
Received: (qmail 20469 invoked by uid 22791); 27 Nov 2008 11:15:52 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 27 Nov 2008 11:15:03 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id B70596D4308; Thu, 27 Nov 2008 12:15:02 +0100 (CET)
Date: Thu, 27 Nov 2008 11:15:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Add dirent.d_type support to  Cygwin 1.7 ?
Message-ID: <20081127111502.GF30831@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <492DBE7E.7020100@t-online.de> <20081126221012.GA15970@ednor.casa.cgf.cx> <492DD7D0.6050001@t-online.de> <20081127093023.GA9487@calimero.vinschen.de> <1L5eGn-03rme80@fwd09.aul.t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1L5eGn-03rme80@fwd09.aul.t-online.de>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q4/txt/msg00005.txt.bz2

On Nov 27 11:38, Christian Franke wrote:
> Hi Corinna,
> 
> Corinna Vinschen wrote:
> > Shouldn't this condition test positively instead like, say,
> > 
> > !(attr & (FILE_ATTRIBUTE_REPARSE_POINT | FILE_ATTRIBUTE_DEVICE))
> > 
> 
> If any undocumented flag is set, then DT_UNKNOWN should be returned. MS
> might invent new flags, at least on the ntdll layer.

Hmm.  That's the question.  Should we treat new flags as being harmless,
or should we treat them as dangerous?

For instance, if we had done that years ago, before FILE_ATTRIBUTE_ENCRYPTED
had been invented, we would have set all encrypted files to DT_UNKNOWN
later on, until Cygwin would have been rebuilt with a newer winnt.h.

OTOH, DT_UNKNOWN is practically nothing worth to get headaches about.
It just potentially slows down find and ls to the state before inventing
d_type.  So, yeah, I guess it's ok to treat new attributes as
potentially dangerous here.

> Meantime, I found FILE_ATTRIBUTE_VALID_FLAGS in winnt.h. It does not
> include FILE_ATTRIBUTE_DEVICE.
> 
> I would suggest the following logic:
> 
> if (attr)
> {
>   if (attr & ~FILE_ATTRIBUTE_VALID_FLAGS)
>     {
>       /* undocumented flag: DT_UNKNOWN
>          Probably print a warning once:
>         "... please inform cygwin at cygwin.com" */
>     }
>   else if (!(attr & (FILE_ATTRIBUTE_SYSTEM
>                     |FILE_ATTRIBUTE_REPARSE_POINT))
>     {
>       /* DT_REG or DT_DIR */
>     }
>   else
>     /* possible old symlink or something special: DT_UNKNOWN */;
> }

The logic sounds ok to me.  I just don't think we need a warning 
and the condition could be simplified accordingly.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
