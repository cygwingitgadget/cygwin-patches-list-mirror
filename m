Return-Path: <cygwin-patches-return-3214-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15280 invoked by alias); 22 Nov 2002 04:51:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15271 invoked from network); 22 Nov 2002 04:51:01 -0000
Date: Thu, 21 Nov 2002 20:51:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: cygwin_intenral va_arg bugs
Message-ID: <20021122045109.GA8821@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.GSO.4.44.0211212341420.4275-200000@slinky.cs.nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0211212341420.4275-200000@slinky.cs.nyu.edu>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2002-q4/txt/msg00165.txt.bz2

On Thu, Nov 21, 2002 at 11:45:28PM -0500, Igor Pechtchanski wrote:
>Hi,
>This patch fixes two bugs in va_arg handling in cygwin_internal.
>	Igor

Applied.  Thanks.

cgf

>ChangeLog:
>2002-11-21  Igor Pechtchanski <pechtcha@cs.nyu.edu>
>
>	* external.cc: (cygwin_internal) Fix va_arg references.
