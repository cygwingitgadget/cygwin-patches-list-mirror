Return-Path: <cygwin-patches-return-2295-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 22878 invoked by alias); 3 Jun 2002 17:11:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22852 invoked from network); 3 Jun 2002 17:11:38 -0000
Date: Mon, 03 Jun 2002 10:11:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: getgrgid() and setegid()
Message-ID: <20020603191135.C22554@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20020602194017.007e5ca0@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20020602194017.007e5ca0@mail.attbi.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q2/txt/msg00278.txt.bz2

On Sun, Jun 02, 2002 at 07:40:17PM -0400, Pierre A. Humblet wrote:
> 2002-05-30  Pierre Humblet <pierre.humblet@ieee.org>
> 
> 	syscalls.cc (setegid32): Verify the correctness of the gid 
> 	of the group returned by getgrgid32.

Applied.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
