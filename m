Return-Path: <cygwin-patches-return-3889-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5552 invoked by alias); 24 May 2003 20:14:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5530 invoked from network); 24 May 2003 20:14:45 -0000
Date: Sat, 24 May 2003 20:14:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fix for process virtual size display
Message-ID: <20030524201440.GD19367@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20030521164816.GA4885@redhat.com> <ICEBIHGCEJIPLNMBNCMKCEKACGAA.chris@atomice.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ICEBIHGCEJIPLNMBNCMKCEKACGAA.chris@atomice.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00116.txt.bz2

On Sat, May 24, 2003 at 08:06:48PM +0100, Chris January wrote:
> I did some more reading around this and found that a lot of Unix systems
> don't actually have a concept of reserved memory. Given that a large amount
> of memory is reserved, but never comitted by Cygwin processes, this reserved
> memory skews the vmsize quite a bit. With this patch, the values are a lot
> more like Linux, therefore I'm actually for this patch being committed.

Thanks, I've applied the patch.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
