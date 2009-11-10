Return-Path: <cygwin-patches-return-6826-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19773 invoked by alias); 10 Nov 2009 19:44:14 -0000
Received: (qmail 19752 invoked by uid 22791); 10 Nov 2009 19:44:13 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 10 Nov 2009 19:44:07 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 8C4496D41A0; Tue, 10 Nov 2009 20:43:48 +0100 (CET)
Date: Tue, 10 Nov 2009 19:44:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com, cygwin@cygwin.com
Subject: Re: console enhancements: mouse events
Message-ID: <20091110194348.GA28591@calimero.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com, cygwin@cygwin.com
References: <0M7Ual-1MBB3j1CFD-00whzl@mrelayeu.kundenserver.de>  <20091106101448.GA2568@calimero.vinschen.de>  <4AF73FEC.2050300@towo.net>  <20091109133551.GA10130@calimero.vinschen.de>  <4AF99932.5090702@towo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4AF99932.5090702@towo.net>
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
X-SW-Source: 2009-q4/txt/msg00157.txt.bz2

On Nov 10 17:47, Thomas Wolff wrote:
> Corinna Vinschen schrieb:
> I had not expected you to take action on this issue so soon:
> >- Don't create ESC sequences for ALT-key keypresses if key translates
> >  into a multibyte sequence.  This avoids stray bytes in input when
> >  pressing for instance ALT-&ouml; (Umlaut-o) under UTF-8.

I applied the change already an hour before your mail from yesterday.
It makes a lot of sense to subscribe to the cygwin-cvs mailing list,
since you see immediately what has happened in the repository.

> - especially given:
> >...  And, whatever
> >super-duper change we make to this essential console code in future,
> >let's wait until after 1.7.1, please.

Well, it wasn't exactly a super-duper change, rather something I thought
of as a bugfix.

> Actually, I think this is the wrong change. I'm sorry I came up with
> this confusion because I didn't test sufficiently, but as I said in
> my second mail
> >For non-ASCII it works fine,
> and contemplating again
> >If you press Alt-ö, the console generates the sequence ESC 0xc3 0xb6.
> I think this is absolutely the right thing to generate - after all,
> what else should be expected here?
> The "stray bytes" are created in bash/readline, the previous
> behavior of cygwin console in this case was perfect, I'd suggest to
> revert, please.

I was just going to refuse your request, when I had this really spooky
idea of actually *testing* this in an xterm running under Linux.  And,
what shall I say?  Xterm creates the same ESC 0xc3 0xb6 sequence when
pressing Alt-ö.  I'll revert the change.  Note to self: "Testing doesn't
hurt".


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
