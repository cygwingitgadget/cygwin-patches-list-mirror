Return-Path: <cygwin-patches-return-5335-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12019 invoked by alias); 7 Feb 2005 17:19:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11995 invoked from network); 7 Feb 2005 17:19:35 -0000
Received: from unknown (HELO mx1.redhat.com) (66.187.233.31)
  by sourceware.org with SMTP; 7 Feb 2005 17:19:35 -0000
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j17HJZ7t017609
	for <cygwin-patches@sources.redhat.com>; Mon, 7 Feb 2005 12:19:35 -0500
Received: from potter.sfbay.redhat.com (potter.sfbay.redhat.com [172.16.27.15])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j17HJYO13764
	for <cygwin-patches@sources.redhat.com>; Mon, 7 Feb 2005 12:19:34 -0500
Received: from cygbert.vinschen.de (vpn50-38.rdu.redhat.com [172.16.50.38])
	by potter.sfbay.redhat.com (8.12.8/8.12.8) with ESMTP id j17HJWIR013848
	for <cygwin-patches@sources.redhat.com>; Mon, 7 Feb 2005 12:19:33 -0500
Received: by cygbert.vinschen.de (Postfix, from userid 500)
	id AF50757D77; Mon,  7 Feb 2005 18:19:25 +0100 (CET)
Date: Mon, 07 Feb 2005 17:19:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: Cygwin Patches <cygwin-patches@sources.redhat.com>
Subject: Re: patch to allow touch to work on HPFS (and others, maybe??)
Message-ID: <20050207171925.GG19096@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Corinna Vinschen <vinschen@redhat.com>,
	Cygwin Patches <cygwin-patches@sources.redhat.com>
References: <0IBJ002LDVDB2K@pmismtp01.mcilink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0IBJ002LDVDB2K@pmismtp01.mcilink.com>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2005-q1/txt/msg00038.txt.bz2

On Feb  7 09:34, Mark Paulus wrote:
> Attached is a patch that works to allow me to do a 
> touch on my mounted HPFS filesystem.  I'm not sure
> about clearcase, or others, but it works on HPFS and
> NTFS. 
> 
> 	* times.cc: Use GENERIC_WRITE instead of FILE_WRITE_ATTRIBUTES.

That's reverting a more than three years old patch.  Please read
http://cygwin.com/ml/cygwin/2001-08/msg00666.html which explains why
opening with GENERIC_WRITE is not generally a good idea.  If you want
to get it working for HPFS or whatever, use the FS flags present in
the local path_conv variable called win32 to conditionalize the call.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
