Return-Path: <cygwin-patches-return-4175-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24070 invoked by alias); 7 Sep 2003 05:19:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24061 invoked from network); 7 Sep 2003 05:19:07 -0000
Date: Sun, 07 Sep 2003 05:19:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: nanosleep patch 2
Message-ID: <20030907051907.GB23916@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030904214114.00814b30@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030904214114.00814b30@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00191.txt.bz2

On Thu, Sep 04, 2003 at 09:41:14PM -0400, Pierre A. Humblet wrote:
>2003-09-04  Pierre Humblet <pierre.humblet@ieee.org>
>
>	* signal.cc (nanosleep): Improve test for valid values.
>	Round delay up to resolution. Fix test for negative remainder. 
>	Use timeGetTime through gtod.
>	(sleep): Round up return value.

Applied, with accommodations from previous patch.

Thanks.
cgf
