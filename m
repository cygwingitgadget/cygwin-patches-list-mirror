Return-Path: <cygwin-patches-return-6822-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27635 invoked by alias); 9 Nov 2009 14:55:16 -0000
Received: (qmail 27614 invoked by uid 22791); 9 Nov 2009 14:55:16 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-42-77.bstnma.fios.verizon.net (HELO cgf.cx) (173.76.42.77)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 09 Nov 2009 14:55:07 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 2CB753B0002 	for <cygwin-patches@cygwin.com>; Mon,  9 Nov 2009 09:54:58 -0500 (EST)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 2944C2B352; Mon,  9 Nov 2009 09:54:58 -0500 (EST)
Date: Mon, 09 Nov 2009 14:55:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: console enhancements: mouse events
Message-ID: <20091109145458.GB31587@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <0M7Ual-1MBB3j1CFD-00whzl@mrelayeu.kundenserver.de>  <20091106101448.GA2568@calimero.vinschen.de>  <4AF73FEC.2050300@towo.net>  <20091109133551.GA10130@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091109133551.GA10130@calimero.vinschen.de>
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
X-SW-Source: 2009-q4/txt/msg00153.txt.bz2

On Mon, Nov 09, 2009 at 02:35:51PM +0100, Corinna Vinschen wrote:
>On Nov 8 23:02, towo@towo.net wrote:
>>Corinna Vinschen schrieb:
>Ooookey, if they aren't listed in terminfo anyway, I have no problems
>to change them.  But we should stick to following the Linux console, I
>guess.

I agree.  I'm surprised that we've had the function keys wrong all these
years.

>>>>* I intended to implement cursor position reports and noticed that
>>>>their request ESC[6n is already handled in the code; it does not work,
>>>>however, so I started to debug it:
>>>This needs some more debugging, I guess.
>>Do you have an opinion about my theory that the wrong read-ahead buffer
>>is being filled here (stdout vs.  stdin)?  If so, I still have no clue
>>how to proceed; maybe you'd kindly give a hint how to access the stdin
>>buffer / stdin fhandler?
>
>I have no opinion yet, since I don't know this part of the code good
>enough.  IIUC you think that the readahead buffer of the wrong
>fhandle_console is filled, the one connected with stdout, not the one
>connected with stdin, right?

I'm still struggling to understand what a "stdout read-ahead buffer"
might be.  Could you point to the place in the code where you see the
problem?

cgf
