Return-Path: <cygwin-patches-return-4103-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30054 invoked by alias); 17 Aug 2003 17:50:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30044 invoked from network); 17 Aug 2003 17:50:43 -0000
Date: Sun, 17 Aug 2003 17:50:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] pwdgrp::read_group(): Don't call free() twice with the same address
Message-ID: <20030817175042.GM3101@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030817105058.007e9b40@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030817105058.007e9b40@mail.attbi.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00119.txt.bz2

On Sun, Aug 17, 2003 at 10:50:58AM -0400, Pierre A. Humblet wrote:
> I believe that reverting the original patch and applying the one 
> below fixes the root bug.

Uhm... you *believe* it?

> 2003-08-17  Pierre Humblet  <pierre.humblet@ieee.org>
> 
> 	* grp.cc (read_group): Revert previous change.
> 	* uinfo.cc (pwdgrp::load): Always reset curr_lines.

Never mind.  I've checked this in.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
