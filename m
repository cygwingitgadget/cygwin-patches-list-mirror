Return-Path: <cygwin-patches-return-2243-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 13267 invoked by alias); 28 May 2002 15:00:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13134 invoked from network); 28 May 2002 15:00:23 -0000
Date: Tue, 28 May 2002 08:00:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: ps help, version patch
Message-ID: <20020528170022.E30892@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20020528033821.GA26746@redhat.com> <20020528142804.31529.qmail@web20006.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020528142804.31529.qmail@web20006.mail.yahoo.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q2/txt/msg00226.txt.bz2

On Tue, May 28, 2002 at 07:28:04AM -0700, Joshua Daniel Franklin wrote:
> --- Christopher Faylor <cgf@redhat.com> wrote:
> > Good formatting, wrong date == extremely minor problem.
> > 
> > Applied.
> > 
> > Thanks.
> > 
> > cgf
> 
> After getting some sleep, I also noticed this line in my usage function:
> 
> With options, %s outputs the long format by default\n", prog_name, prog_name);
> 
> which should probably read:
> 
> With no options, %s outputs the long format by default\n", prog_name,
> prog_name);
>      ^^
> 
> Do I need another patch for this, or can someone just fix YASM (yet another
> stupid mistake)?

I've fixed it.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
