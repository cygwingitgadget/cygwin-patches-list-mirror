Return-Path: <cygwin-patches-return-4882-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11675 invoked by alias); 26 Jul 2004 13:21:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11656 invoked from network); 26 Jul 2004 13:21:12 -0000
Date: Mon, 26 Jul 2004 13:21:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix AMD flags in /proc/cpuinfo
Message-ID: <20040726132118.GE30714@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <0c9501c4730a$71ea1550$0207a8c0@avocado>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c9501c4730a$71ea1550$0207a8c0@avocado>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q3/txt/msg00034.txt.bz2

On Jul 26 13:16, Chris January wrote:
> This patch extends Tomas Ukkonen's earlier AMD fix by removing
> Intel-specific flags from /proc/cpuinfo on AMD processors. It also adds
> support for a few more AMD-specific flags. Output for the flags field on
> /proc/cpuinfo on my AMD Athlon XP now matches Linux. I changed a few of
> the names for Intel extended features to match Linux.

Thanks, applied.

Just a friendly hint:  Next time, please include the ChangeLog entry inline
and formatted to fit into 80 columns.  It's much simpler to add to the
ChangeLog file then.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Co-Project Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
