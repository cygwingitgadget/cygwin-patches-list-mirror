Return-Path: <cygwin-patches-return-3153-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 10558 invoked by alias); 11 Nov 2002 16:16:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10516 invoked from network); 11 Nov 2002 16:16:35 -0000
Date: Mon, 11 Nov 2002 08:16:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Make ip.h and tcp.h work under -fnative-struct or -fms-bitfields
Message-ID: <20021111161644.GB16199@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3DCF707D.2010205@netstd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DCF707D.2010205@netstd.com>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2002-q4/txt/msg00104.txt.bz2

On Mon, Nov 11, 2002 at 04:55:25PM +0800, Wu Yongwei wrote:
>Hi,
>
>What's the status of this patch?
>
>----------
>ChangeLog:
>
>2002-10-28  Wu Yongwei <adah@netstd.com>
>
>    * ip.h (struct ip): Use u_char to indicate bitfields to make it
>    work with -fnative-struct/-fms-bitfields.
>    (struct ip_timestamp): Ditto.
>    * tcp.h (struct tcphdr): Ditto.
>----------
>
>Am I really going the wrong way (any examples)? Or should I submit a new 
>patch as Danny suggests?

Danny's suggestion is correct.  The rest of the header files which accomodate
this are probably using __attribute__((packed)) .  The argument that the header
works ok for you on MSVC is a non-issue for cygwin.

cgf
