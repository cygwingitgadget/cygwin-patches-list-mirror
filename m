Return-Path: <cygwin-patches-return-4742-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9641 invoked by alias); 12 May 2004 12:29:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9630 invoked from network); 12 May 2004 12:29:28 -0000
Date: Wed, 12 May 2004 12:29:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: tty's on Terminal Services
Message-ID: <20040512122928.GA26932@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040511192134.007d4950@incoming.verizon.net> <3.0.5.32.20040511192134.007d4950@incoming.verizon.net> <3.0.5.32.20040511215039.007d9210@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20040511215039.007d9210@incoming.verizon.net>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q2/txt/msg00094.txt.bz2

On May 11 21:50, Pierre A. Humblet wrote:
> By the way, while checking the names with sysinternals I noticed 
> there were a lot of mtinfo handles, all mapping the same name.
> They accumulate with each process generation. 

Thanks for the hint.  I've fixed it.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Co-Project Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
