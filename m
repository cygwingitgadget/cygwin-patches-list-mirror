Return-Path: <cygwin-patches-return-2735-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 8786 invoked by alias); 26 Jul 2002 21:17:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8772 invoked from network); 26 Jul 2002 21:17:13 -0000
Date: Fri, 26 Jul 2002 14:17:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: fhandler::close patch
Message-ID: <20020726211724.GA3404@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <015f01c234ae$fcf60290$6132bc3e@BABEL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <015f01c234ae$fcf60290$6132bc3e@BABEL>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q3/txt/msg00183.txt.bz2

On Fri, Jul 26, 2002 at 03:16:08PM +0100, Conrad Scott wrote:
>2002-07-26  Conrad Scott  <conrad.scott@dsl.pipex.com>
>
>	* fhandler_registry.cc (fhandler_registry::close): Return any
>	error result to the caller.
>	* syscalls.cc (_close): Return result of fhandler::close to the
>	caller.

Applied.  Thanks.

cgf
