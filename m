Return-Path: <cygwin-patches-return-2887-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 4376 invoked by alias); 30 Aug 2002 13:11:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4361 invoked from network); 30 Aug 2002 13:11:45 -0000
Date: Fri, 30 Aug 2002 06:11:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Base readv/writev patch
Message-ID: <20020830151128.I5475@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <000101c24f8e$1a656c40$6132bc3e@BABEL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000101c24f8e$1a656c40$6132bc3e@BABEL>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q3/txt/msg00335.txt.bz2

On Thu, Aug 29, 2002 at 01:06:14AM +0100, Conrad Scott wrote:
> Attached is the base part of the readv/writev patch I sent in
> yesterday, i.e. just the generic syscall.cc and fhandler_base
> parts, w/o any of the socket changes.  Otherwise unchanged from
> before except for the expunging of those darn new-fangled C++ cast
> woojits :-)

I had another look into this patch and it looks good, IMHO.
But I think Chris should give the final go here.  I'm going
to work under that cygwin dll for now.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
