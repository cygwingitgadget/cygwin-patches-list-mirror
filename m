Return-Path: <cygwin-patches-return-4208-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27502 invoked by alias); 11 Sep 2003 15:59:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27486 invoked from network); 11 Sep 2003 15:59:05 -0000
Date: Thu, 11 Sep 2003 15:59:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygcheck: do not check package integrity with a -d flag
Message-ID: <20030911155904.GA9981@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.GSO.4.56.0309111108450.5235@slinky.cs.nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.56.0309111108450.5235@slinky.cs.nyu.edu>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00224.txt.bz2

On Thu, Sep 11, 2003 at 11:12:36AM -0400, Igor Pechtchanski wrote:
> Hi,
> 
> As requested on cygwin-developers@ and cygwin@, this patch adds a flag
> ("-d", or "--dump-only") that instructs cygcheck to not check for the

Shouldn't that be --dumb-only?

SCNR,
I'm going to check it in,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
