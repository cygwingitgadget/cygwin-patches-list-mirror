Return-Path: <cygwin-patches-return-3046-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 15490 invoked by alias); 25 Sep 2002 12:24:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15417 invoked from network); 25 Sep 2002 12:24:25 -0000
Date: Wed, 25 Sep 2002 05:24:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: changes to /proc ctty and uid/gid handling
Message-ID: <20020925122445.GA13353@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <LPEHIHGCJOAIPFLADJAHOEIFCNAA.chris@atomice.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LPEHIHGCJOAIPFLADJAHOEIFCNAA.chris@atomice.net>
User-Agent: Mutt/1.4i
X-SW-Source: 2002-q3/txt/msg00494.txt.bz2

On Tue, Sep 24, 2002 at 02:17:15PM +0100, Chris January wrote:
>2002-09-24  Christopher January <chris@atomice.net>
>
>	* fhandler_proc.cc (format_process_stat): make ctty a real device number.
>	(format_process_status): use effective uid/gid as real and saved uid/gid.

Applied.  Thanks.

cgf
