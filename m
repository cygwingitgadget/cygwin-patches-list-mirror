Return-Path: <cygwin-patches-return-4829-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11464 invoked by alias); 8 Jun 2004 07:21:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11167 invoked from network); 8 Jun 2004 07:20:38 -0000
Date: Tue, 08 Jun 2004 07:21:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: fchdir
Message-ID: <20040608072034.GA11463@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040603204818.00806dd0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20040603204818.00806dd0@incoming.verizon.net>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q2/txt/msg00181.txt.bz2

On Jun  3 20:48, Pierre A. Humblet wrote:
> 2004-06-04  Pierre Humblet <pierre.humblet@ieee.org>
> 
> 	* path.cc (fchdir): Pass the Posix path to chdir.

I've applied this patch.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Co-Project Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
