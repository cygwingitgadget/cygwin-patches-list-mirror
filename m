Return-Path: <cygwin-patches-return-2903-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 7433 invoked by alias); 31 Aug 2002 16:38:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7419 invoked from network); 31 Aug 2002 16:38:45 -0000
Date: Sat, 31 Aug 2002 09:38:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: /proc patch
Message-ID: <20020831163846.GA11204@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <LPEHIHGCJOAIPFLADJAHIEDICLAA.chris@atomice.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LPEHIHGCJOAIPFLADJAHIEDICLAA.chris@atomice.net>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q3/txt/msg00351.txt.bz2

On Sat, Aug 31, 2002 at 02:49:50PM +0100, Chris January wrote:
>This patch fixes the bug Emil Briggs found. It also uses the HZ define in
>sys/param.h as the number of 'jiffies' per second, instead of hard-coding it
>at 100.

Applied.

Thanks.

cgf
