Return-Path: <cygwin-patches-return-4634-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5712 invoked by alias); 29 Mar 2004 15:13:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5702 invoked from network); 29 Mar 2004 15:13:55 -0000
Date: Mon, 29 Mar 2004 15:13:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH]: Trivial move in pthread::atforkprepare
Message-ID: <20040329151354.GB2712@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <18918.1080548778@www17.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18918.1080548778@www17.gmx.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q1/txt/msg00124.txt.bz2

On Mon, Mar 29, 2004 at 10:26:18AM +0200, Thomas Pfaff wrote:
>MT_INTERFACE->fixup_before_fork () should be done as the last step  in
>pthread::atforkprepare.
>
>I am sorrry if the Changelog contains spaces, but i have limited internet
>access at the moment (only Webmail).
>
>2004-03-29  Thomas Pfaff  <tpfaff@gmx.net>
>
>	* thread.cc (pthread::atforkprepare): Call
>	MT_INTERFACE->fixup_before_fork at the end of atforkprepare.

Applied.

Thanks.
cgf
