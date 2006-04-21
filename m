Return-Path: <cygwin-patches-return-5839-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15126 invoked by alias); 21 Apr 2006 21:39:31 -0000
Received: (qmail 15116 invoked by uid 22791); 21 Apr 2006 21:39:31 -0000
X-Spam-Check-By: sourceware.org
Received: from fios.cgf.cx (HELO cgf.cx) (71.248.179.247)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 21 Apr 2006 21:39:30 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id C748C13C01E; Fri, 21 Apr 2006 17:39:28 -0400 (EDT)
Date: Fri, 21 Apr 2006 21:39:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Make getenv() functional before the environment is  initialized
Message-ID: <20060421213928.GC31141@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <027701c65998$178103f0$280010ac@wirelessworld.airvananet.com> <20060421172328.GD7685@calimero.vinschen.de> <01ca01c66574$b295c7d0$280010ac@wirelessworld.airvananet.com> <20060421191314.GA11311@trixie.casa.cgf.cx> <01fc01c6657c$347794c0$280010ac@wirelessworld.airvananet.com> <20060421201200.GA8588@trixie.casa.cgf.cx> <022b01c66582$b3d396a0$280010ac@wirelessworld.airvananet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <022b01c66582$b3d396a0$280010ac@wirelessworld.airvananet.com>
User-Agent: Mutt/1.5.11
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00027.txt.bz2

I just talked to Corinna about this on IRC and neither of us really
cares enough about this to merit a long discussion so I've just checked
in a variation of the cmalloc patch.  The only change that I made was to
define a HEAP_2_STR value so that the HEAP_1_MAX usage is confined to
cygheap.cc where I'd intended it.

cgf
