Return-Path: <cygwin-patches-return-3756-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7549 invoked by alias); 27 Mar 2003 09:40:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7540 invoked from network); 27 Mar 2003 09:40:52 -0000
Date: Thu, 27 Mar 2003 09:40:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] performance patch for /proc/registry -- version 2
Message-ID: <20030327094049.GD23762@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <LPEHIHGCJOAIPFLADJAHAEHODHAA.chris@atomice.net> <3E820411.1020100@hekimian.com> <20030326202213.GZ23762@cygbert.vinschen.de> <3E821FEE.2000408@hekimian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E821FEE.2000408@hekimian.com>
User-Agent: Mutt/1.4i
X-SW-Source: 2003-q1/txt/msg00405.txt.bz2

On Wed, Mar 26, 2003 at 04:47:26PM -0500, Joe Buehler wrote:
> Corinna Vinschen wrote:
> 
> >However... am I doing something wrong?  I'm trying to find out what the
> >performance improvement is on my XP box and both versions of the DLL
> >(w/ and w/o your patch) are running 7.5 minutes for 
> >
> >  ls -lR /proc/registry > /dev/null
> >
> >Or is that only a problem on older systems?  You're running NT4SP5, right?
> >
> >Other than that your patch looks fine.
> 
> It may be that XP has the WIN32 API fixed.  The different is drastic
> on my NT4 SP5 box.  You can see the difference just by doing
> ls -l /proc/registry/HKEY_LOCAL_MACHINE.  With patch comes back instantly,
> without you have to sit and wait.

Applied.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
