Return-Path: <cygwin-patches-return-7702-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23840 invoked by alias); 16 Aug 2012 12:31:19 -0000
Received: (qmail 23599 invoked by uid 22791); 16 Aug 2012 12:30:52 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Thu, 16 Aug 2012 12:30:38 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 8C5832C00CA; Thu, 16 Aug 2012 14:30:33 +0200 (CEST)
Date: Thu, 16 Aug 2012 12:31:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: /dev/clipboard pasting with small read() buffer
Message-ID: <20120816123033.GH17546@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <502ABB77.2080502@towo.net> <20120816093334.GB20051@calimero.vinschen.de> <502CE384.8050709@towo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <502CE384.8050709@towo.net>
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
X-SW-Source: 2012-q3/txt/msg00023.txt.bz2

On Aug 16 14:11, Thomas Wolff wrote:
> Hi Corinna,
> 
> On 16.08.2012 11:33, Corinna Vinschen wrote:
> >Hi Thomas,
> >
> >thanks for the patch.   I have a few minor nits:
> >
> >On Aug 14 22:56, Thomas Wolff wrote:
> >>--- sav/fhandler_clipboard.cc	2012-07-08 02:36:47.000000000 +0200
> >>+++ ./fhandler_clipboard.cc	2012-08-14 18:25:14.903255600 +0200
> >>...
> >See (*) below.
> >
> >>...
> >>+	  char * _ptr = (char *) ptr;
> >>+	  size_t _len = len;
> >I would prefer to have local variable names here which don't just
> >differ by a leading underscore.  It's a bit confusing.  What about,
> >say, tmp_ptr/tmp_len, or use_ptr/use_len or something like that?
> tmp_OK
> 
> >>+	  char cprabuf [8 + 1];	/* need this length for surrogates */
> >>+	  if (len < 8)
> >>+	    {
> >>+	      _ptr = cprabuf;
> >>+	      _len = 8;
> >>+	    }
> >8?  Why 8?  The size appears to be rather artificial.  The code should
> >use MB_CUR_MAX instead.
> MB_CUR_MAX does not work because its value is 1 at this point

So what about MB_LEN_MAX then?  There's no problem using a multiplier,
but a symbolic constant is always better than a numerical constant.

> >>+	      /* If using read-ahead buffer, copy to class read-ahead buffer
> >>+	         and deliver first byte. */
> >>+	      if (_ptr == cprabuf)
> >>+		{
> >>+		  puts_readahead (cprabuf, ret);
> >>+		  * (char *) ptr = get_readahead ();
> >>+		  ret = 1;
> >(*) Ok, that works, but wouldn't it be more efficient to do that in
> >a tiny loop along the lines of
> >
> >		  int x;
> >		  ret = 0;
> >                   while (ret < len && (x = get_readahead ()) >= 0)
> >		    ptr++ = x;
> >		    ret++;
> >
> >?
> I can add it if you prefer; I just didn't think it's worth the
> effort and concerning efficiency, after that prior trial-and-error
> count-down-loop...

Yeah, that's a valid point.  But maybe we shouldn't make it slower
than necessary?  If you have a good idea how to avoid the other
loop, don't hesitate to submit a patch.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
