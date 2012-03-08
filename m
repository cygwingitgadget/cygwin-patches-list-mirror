Return-Path: <cygwin-patches-return-7619-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29969 invoked by alias); 8 Mar 2012 15:56:49 -0000
Received: (qmail 29882 invoked by uid 22791); 8 Mar 2012 15:56:26 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Thu, 08 Mar 2012 15:56:13 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 0157F2C006E; Thu,  8 Mar 2012 16:56:11 +0100 (CET)
Date: Thu, 08 Mar 2012 15:56:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: avoid calling strlen() twice in readlink()
Message-ID: <20120308155610.GA646@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CAKw7uVgatdim4-LuANxwv9UL59jc_EizrEKx6wX4DO1RZ+aKmQ@mail.gmail.com> <4F58D059.1090608@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4F58D059.1090608@redhat.com>
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
X-SW-Source: 2012-q1/txt/msg00042.txt.bz2

On Mar  8 08:29, Eric Blake wrote:
> On 03/08/2012 06:37 AM, VÃ¡clav Zeman wrote:
> > Hi.
> > 
> > Here is a tiny patch to avoid calling strlen() twice in readlink().
> > 
> 
> >  
> > -  ssize_t len = min (buflen, strlen (pathbuf.get_win32 ()));
> > +  size_t pathbuf_len = strlen (pathbuf.get_win32 ());
> > +  size_t len = MIN (buflen, pathbuf_len);
> >    memcpy (buf, pathbuf.get_win32 (), len);
> 
> For that matter, is calling pathbuf.get_win32() twice worth factoring out?

It's just a const char *pointer, and it's an inline method.  I'm pretty
sure the compiler will optimize this just fine.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
