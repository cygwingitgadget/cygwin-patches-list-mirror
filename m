Return-Path: <cygwin-patches-return-4235-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1473 invoked by alias); 25 Sep 2003 03:55:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1464 invoked from network); 25 Sep 2003 03:55:20 -0000
Date: Thu, 25 Sep 2003 03:55:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Fixing the delete queue security
Message-ID: <20030925035517.GA7964@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030915211808.0081d6d0@incoming.verizon.net> <3.0.5.32.20030915211808.0081d6d0@incoming.verizon.net> <3.0.5.32.20030924233929.0082cd30@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030924233929.0082cd30@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00251.txt.bz2

On Wed, Sep 24, 2003 at 11:39:29PM -0400, Pierre A. Humblet wrote:
>2003-09-25  Pierre Humblet <pierre.humblet@ieee.org>
>
>	* shared_info.h: Update CURR_USER_MAGIC, CURR_SHARED_MAGIC and
>	SHARED_INFO_CB.
>	(mount_info::cb): Delete.
>	(mount_info::version): Delete.
>	(shared_info::delqueue): Delete.
>	* Makefile.in: Do magic for USER_MAGIC, class user_info, instead
>	of for mount_info.

Looks good.  Go ahead.

cgf
