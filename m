Return-Path: <cygwin-patches-return-4243-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24189 invoked by alias); 26 Sep 2003 12:22:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24176 invoked from network); 26 Sep 2003 12:22:21 -0000
Date: Fri, 26 Sep 2003 12:22:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: {Patch]: Giving access to pinfo after seteuid and exec
Message-ID: <20030926122220.GA29894@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030925214748.0081f330@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030925214748.0081f330@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00259.txt.bz2

On Thu, Sep 25, 2003 at 09:47:48PM -0400, Pierre A. Humblet wrote:
> This patch sets the _pinfo acl in order to allow access after 
> seteuid and exec.
> 
> While looking at spawn.cc I also noticed oddities in pinfo related
> error handling, and reworked them. I also restored impersonation in
> case of CreateProcessAsUser failure.

Looks ok except for:

> @@ -42,9 +43,9 @@ pinfo_fixup_after_fork ()
>  {
>    if (hexec_proc)
>      CloseHandle (hexec_proc);
> -
> +  /* Keeps the cygpid from being reused. No rights required */
>    if (!DuplicateHandle (hMainProc, hMainProc, hMainProc, &hexec_proc, 0,
> -			TRUE, DUPLICATE_SAME_ACCESS))
> +			TRUE, 0))
>      {
>        system_printf ("couldn't save current process handle %p, %E", hMainProc);
>        hexec_proc = NULL;

Somehow I'm missing a description why that's necessary and the
implications.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
