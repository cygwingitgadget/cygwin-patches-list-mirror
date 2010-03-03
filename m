Return-Path: <cygwin-patches-return-7004-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29582 invoked by alias); 3 Mar 2010 15:06:50 -0000
Received: (qmail 29442 invoked by uid 22791); 3 Mar 2010 15:06:48 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Wed, 03 Mar 2010 15:06:44 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 2273B6D42F5; Wed,  3 Mar 2010 16:06:42 +0100 (CET)
Date: Wed, 03 Mar 2010 15:06:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Add xdr support
Message-ID: <20100303150642.GN17293@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4B764A1F.6060003@cwilson.fastmail.fm>  <4B8D2F9D.4090309@cwilson.fastmail.fm>  <20100302180921.GO5683@calimero.vinschen.de>  <4B8DED87.1080801@cwilson.fastmail.fm>  <20100303091052.GB24732@calimero.vinschen.de>  <4B8E5AD0.9050703@cwilson.fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B8E5AD0.9050703@cwilson.fastmail.fm>
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
X-SW-Source: 2010-q1/txt/msg00120.txt.bz2

On Mar  3 07:49, Charles Wilson wrote:
> Corinna Vinschen wrote:
> > On Mar  3 00:03, Charles Wilson wrote:
> >> But it ain't posix, so...should it really go in posix.sgml?
> > 
> > Yes!  The filename posix.sgml is just historical, it could be better
> > named api.sgml, I guess, but here we are.  Have a look, it contains
> > various chapters with all APIs which follow some lead, SUSv4, BSD,
> > Linux, Solaris, deprecated or "other".  In case of the XDR calls, they
> > should probably go into the Solaris section, unless you think they fit
> > better in one of the other sections.
> 
> OK:
> 
> 2010-03-03  Charles Wilson  <...>
> 
>         * posix.sgml: Add xdr_array, xdr_bool, xdr_bytes, xdr_char,
> 	xdr_double, xdr_enum, xdr_float, xdr_free, xdr_hyper, xdr_int,
> 	xdr_int16_t, xdr_int32_t, xdr_int64_t, xdr_int8_t, xdr_long,
> 	xdr_longlong_t, xdr_netobj, xdr_opaque, xdr_pointer,
> 	xdr_reference, xdr_short, xdr_sizeof, xdr_string, xdr_u_char,
> 	xdr_u_hyper, xdr_u_int, xdr_u_int16_t, xdr_u_int32_t,
> 	xdr_u_int64_t, xdr_u_int8_t, xdr_u_long, xdr_u_longlong_t,
> 	xdr_u_short, xdr_uint16_t, xdr_uint32_t, xdr_uint64_t,
> 	xdr_uint8_t, xdr_union, xdr_vector, xdr_void, xdr_wrapstring,
> 	xdrmem_create, xdrrec_create, xdrrec_endofrecord, xdrrec_eof,
> 	xdrrec_skiprecord, and xdrstdio_create to list of implemented
> 	Solaris functions.

Thank you!  Everything's applied.  I just trimmed the ChangeLog entry
slighty.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
