Return-Path: <cygwin-patches-return-4592-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18312 invoked by alias); 9 Mar 2004 02:51:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18300 invoked from network); 9 Mar 2004 02:51:19 -0000
Date: Tue, 09 Mar 2004 02:51:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Implement TIOCSBRK / TIOCCBRK serial ioctl
Message-ID: <20040309025117.GA10641@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.LNX.4.58.0403031239150.12078@gyre.weather.fi> <Pine.LNX.4.58.0403090423480.3832@gyre.weather.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0403090423480.3832@gyre.weather.fi>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q1/txt/msg00082.txt.bz2

2004-03-03  Jaakko Hyvatti  <jaakko.hyvatti@iki.fi>

	* fhandler_serial.cc (fhandler_serial::ioctl): Implement TIOCSBRK
	and TIOCCBRK which set and clear break condition on serial TxD.

Applied.  Thanks.

cgf
