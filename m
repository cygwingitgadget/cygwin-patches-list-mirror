Return-Path: <cygwin-patches-return-4342-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21473 invoked by alias); 6 Nov 2003 15:19:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21464 invoked from network); 6 Nov 2003 15:19:25 -0000
Date: Thu, 06 Nov 2003 15:19:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] fhandler_disk_file::opendir memory leak
Message-ID: <20031106151923.GA15066@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20031106131507.64464.qmail@web13808.mail.yahoo.com> <20031106132923.37170.qmail@web13801.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031106132923.37170.qmail@web13801.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00061.txt.bz2

On Thu, Nov 06, 2003 at 01:29:23PM +0000, Ian Ray wrote:
>Oops. Typo. Retry.

Thanks for the patch.  I noticed this yesterday when I was hacking on
this function and I fixed it in a different way after I checked in my
access_worker change.  I haven't checked it in yet since I can't check
my changes right now as I'm away from my system.

cgf

>2003-11-06  Ian Ray  <ran_iay@yahoo.com>
>
>	* fhandler_disk_file.cc (fhandler_disk_file::opendir): Guard against
>	memory leak.
>
