Return-Path: <cygwin-patches-return-3961-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7248 invoked by alias); 13 Jun 2003 14:17:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7238 invoked from network); 13 Jun 2003 14:17:01 -0000
Date: Fri, 13 Jun 2003 14:17:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Ping:  [PATCH] One liner to allow i786 (aka pentium4) in cygwin
Message-ID: <20030613141700.GD22654@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3EDCCE5F.70509@ford.com> <3EE9BF64.2060204@ford.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EE9BF64.2060204@ford.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00188.txt.bz2

On Fri, Jun 13, 2003 at 08:11:16AM -0400, Kelley Cook wrote:
>A ping of this simple patch from ten days ago.  In the meantime, the 
>sources.redhat.com
>toplevel config.sub has pulled in the code to bless the 
>pentium4-pc-cygwin target triple
>as an alias for i786-pc-cygwin.

I made an equivalent patch a few days ago.  Sorry for not mentioning it
here.

>Note that as mentioned below either {mingw,w32api}/config.{guess,sub} 
>should also
>be updated to match the toplevel, or I have a really simple autoconf 
>patch that will let you
>delete those bogus copies and properly use the toplevel versions.

We don't control the mingw directory.  Try sending email to

mingw-dvlpr SPLAT lists BOP sourceforge BOP net .

(with SPLAT and BOP replaced by their obvious characters).

Thanks,
cgf
