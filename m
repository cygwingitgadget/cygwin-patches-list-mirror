Return-Path: <cygwin-patches-return-5324-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18905 invoked by alias); 28 Jan 2005 15:11:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18863 invoked from network); 28 Jan 2005 15:10:59 -0000
Received: from unknown (HELO apmail1.astralpoint.com) (65.114.186.130)
  by sourceware.org with SMTP; 28 Jan 2005 15:10:59 -0000
Received: from [127.0.0.1] (helo=phumblet.no-ip.org)
	by usched40576.usa1ma.alcatel.com with esmtp (Exim 4.43)
	id IB18U8-0000DO-MK
	for cygwin-patches@cygwin.com; Fri, 28 Jan 2005 10:10:56 -0500
Message-ID: <41FA5600.FD6CE295@phumblet.no-ip.org>
Date: Fri, 28 Jan 2005 15:11:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Reply-To: pierre.humblet@ieee.org
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: fs_info::update
References: <3.0.5.32.20050127215809.00f1d4c0@incoming.verizon.net> <20050128094524.GY31117@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2005-q1/txt/msg00027.txt.bz2

Corinna Vinschen wrote:
> 
> 
> This looks pretty much like a band-aid.  I can see the use for checking
> the last error code, but shouldn't Cygwin opt for safety and not assume
> ACLs?  Also, if there's no right to read a remote drive, there might be
> a good reason for that, which doesn't necessarily mean the drive has acls.
> 
> After all, the effect of chmod -r can be reverted with Windows own means.

Background: I noticed all of that when testing the SetCurrentDirectory("c:\\").
Took me a while to understand why chmod stopped working. On XP HOME there
is no security gui, so I had to use cacls. Not nice.

By the time we call fs_info::update, we have done a successful
GetFileAttributes for a file on the disk. So we know we can access it OK.
I can't imagine any mechanism whereby GetVolumeInfo would return ACCESS_DENIED
if there were no acls. For remote drives has_acls is off by default (smbntsec).

Pierre
