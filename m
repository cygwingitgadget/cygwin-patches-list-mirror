Return-Path: <cygwin-patches-return-2757-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 7099 invoked by alias); 31 Jul 2002 09:53:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7085 invoked from network); 31 Jul 2002 09:53:38 -0000
Date: Wed, 31 Jul 2002 02:53:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Performance: fhandler_socket and ready_for_read()
Message-ID: <20020731115336.F3921@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <07f001c2381e$43118070$6132bc3e@BABEL> <20020731002910.GD17985@redhat.com> <086701c2382f$2c6b19b0$6132bc3e@BABEL> <20020731012133.GB21134@redhat.com> <08e301c23833$d05627f0$6132bc3e@BABEL> <20020731020213.GC21291@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020731020213.GC21291@redhat.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q3/txt/msg00205.txt.bz2

On Tue, Jul 30, 2002 at 10:02:13PM -0400, Chris Faylor wrote:
> Now that you mention it, though, this could be handled (correctly?) by
> calling set_r_no_interrupt whenever we first create a socket iff
> winsock2_active.  I think putting this in the fdsock function would
> catch this.  This means that I didn't have to virtualize this method.
> Agh.

I agree.  Just setting the flag is cleaner than overriding the method
while the flag is still set to a wrong value, isn't it?

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
