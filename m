Return-Path: <cygwin-patches-return-7035-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19870 invoked by alias); 7 May 2010 21:32:38 -0000
Received: (qmail 19860 invoked by uid 22791); 7 May 2010 21:32:37 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-55-5.bstnma.fios.verizon.net (HELO cgf.cx) (173.76.55.5)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Fri, 07 May 2010 21:32:31 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 7353813C061	for <cygwin-patches@cygwin.com>; Fri,  7 May 2010 17:32:29 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201)	id 38BB42B352; Fri,  7 May 2010 17:32:29 -0400 (EDT)
Date: Fri, 07 May 2010 21:32:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: CFA: pseudo-reloc v2
Message-ID: <20100507213228.GA22747@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4AC7910E.1010900@cwilson.fastmail.fm> <4AC82056.7060308@cwilson.fastmail.fm> <4BE1A2C5.4090604@gmail.com> <20100505175614.GA6651@ednor.casa.cgf.cx> <4BE1BFCC.6060703@gmail.com> <20100505191317.GA14692@ednor.casa.cgf.cx> <4BE23275.1030009@cwilson.fastmail.fm> <20100506134901.GA21258@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100506134901.GA21258@ednor.casa.cgf.cx>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q2/txt/msg00018.txt.bz2

I've checked in the change to cause _pei386_runtime_relocator() to be
called from the DLL rather than the program.  This function is only
called by the DLL when the per_process data indicates that it is
ok to do so.  Otherwise it defaults to the old behavior.

Fixing the behavior reported in the cygwin list will still require a
relink to pull in the new version of libcygwin.a which reflects the new
api change.

The majority of changes to pseudo-reloc.cc were line deletions.  There
is still more cleanup that could be done but I got bored.  The major
change was to modify _pei386_runtime_relocator to take a per_process
structure and remove the already-initialized check.  This was no longer
needed since the function is only called when it is really needed now.

http://cygwin.com/ml/cygwin-cvs/2010-q2/msg00068.html

cgf
