Return-Path: <cygwin-patches-return-4470-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24968 invoked by alias); 2 Dec 2003 09:26:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24957 invoked from network); 2 Dec 2003 09:26:40 -0000
Date: Tue, 02 Dec 2003 09:26:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: Create Global Privilege
Message-ID: <20031202092639.GD1640@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20031129230722.GB6964@cygbert.vinschen.de> <3.0.5.32.20031125205533.0082b2a0@incoming.verizon.net> <3.0.5.32.20031125205533.0082b2a0@incoming.verizon.net> <3.0.5.32.20031126104557.00838210@incoming.verizon.net> <20031129230722.GB6964@cygbert.vinschen.de> <3.0.5.32.20031201225546.0082ce20@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20031201225546.0082ce20@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00189.txt.bz2

On Mon, Dec 01, 2003 at 10:55:46PM -0500, Pierre A. Humblet wrote:
> Also, the utmp/wtmp functions use mutexes to insure safe access.
> That creates two problems, particularly on servers:
> - When users have private copies of Cygwin with different mounts,
>   there can be several utmp/wtmp files. Having a global mutex isn't
>   helpful.
> - If the utmp/wtmp files are unique, a user may not be have the
>   privilege to create a global mutex, so that no mutual protection
>   is achieved.
> Both problems could be solved very simply by using file locking.
> Should I do that some day?

Sure, go ahead.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
