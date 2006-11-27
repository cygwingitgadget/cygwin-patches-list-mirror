Return-Path: <cygwin-patches-return-6006-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3550 invoked by alias); 27 Nov 2006 16:16:53 -0000
Received: (qmail 3535 invoked by uid 22791); 27 Nov 2006 16:16:52 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-71-248-179-54.bstnma.fios.verizon.net (HELO cgf.cx) (71.248.179.54)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Mon, 27 Nov 2006 16:16:45 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id C7C3A13D3C7; Mon, 27 Nov 2006 11:16:43 -0500 (EST)
Date: Mon, 27 Nov 2006 16:16:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [RFC][patch] cygwin/singal.h is not compatible with -std=c89 or -std=c99
Message-ID: <20061127161643.GB551@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4568655E.6030403@sh.cvut.cz> <20061127083341.GB8385@calimero.vinschen.de> <20061127151759.GA30938@trixie.casa.cgf.cx> <20061127153519.GF8385@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061127153519.GF8385@calimero.vinschen.de>
User-Agent: Mutt/1.5.11
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q4/txt/msg00024.txt.bz2

On Mon, Nov 27, 2006 at 04:35:19PM +0100, Corinna Vinschen wrote:
>On Nov 27 10:17, Christopher Faylor wrote:
>> How about the alternative "Don't do that" approach?  I think there are
>> other parts of the header files which won't work with -std=c89.  I've
>> always been coding with the understanding that this is a GNU C environment.
>
>Well, BSD and Linux are using the more portable approach.  Why should
>Cygwin stand back?

Because the "portable" approach pollutes the namespace and, if we change
this, there are several other places which also need to be changed.

Anonymous unions are a feature of gcc and MSVC.  If we really have to do
this then I would like to adopt the convention of  using __extension__.

cgf
