Return-Path: <cygwin-patches-return-4459-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18851 invoked by alias); 1 Dec 2003 10:39:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18822 invoked from network); 1 Dec 2003 10:39:44 -0000
Date: Mon, 01 Dec 2003 10:39:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] localtime.cc: Point TZDIR to the /usr/share/zoneinfo
Message-ID: <20031201103943.GC27760@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <87ad6cgb3m.fsf@vzell-de.de.oracle.com> <20031201102807.GB27760@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031201102807.GB27760@cygbert.vinschen.de>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00178.txt.bz2

On Mon, Dec 01, 2003 at 11:28:07AM +0100, Corinna Vinschen wrote:
> On Mon, Dec 01, 2003 at 10:07:25AM +0100, Dr. Volker Zell wrote:
> > Hi
> > 
> > As discussed in cygwin-apps here's a small patch to point cygwin to an existing
> > time zone datasbase when the tzcode/data package is installed.
> 
> Should we do some extra stuff to maintain backward compatibility with
> the old /usr/local/etc path?  I don't think so but...

I've applied the patch as is for now.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
