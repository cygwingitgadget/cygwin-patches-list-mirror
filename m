Return-Path: <cygwin-patches-return-2766-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 611 invoked by alias); 3 Aug 2002 23:21:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 597 invoked from network); 3 Aug 2002 23:21:19 -0000
Date: Sat, 03 Aug 2002 16:21:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: WFSO & WFSO
Message-ID: <20020803232144.GB8760@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <031301c23b40$15cb35a0$6132bc3e@BABEL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <031301c23b40$15cb35a0$6132bc3e@BABEL>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q3/txt/msg00214.txt.bz2

On Sat, Aug 03, 2002 at 11:49:54PM +0100, Conrad Scott wrote:
>In "sigproc.cc", there are two functions WFSO and WFMO that wrap
>the two WaitFor... functions with a sigframe.
>
>In "debug.h" there are the following two defines:
>
>#define WaitForSingleObject WFSO
>#define WaitForMultipleObject WFMO
>
>Assuming that the second of these is a typo for
>"WaitForMultipleObjects" (note plural), I've attached a patch.

Please apply this.  Thanks for catching it.

cgf
