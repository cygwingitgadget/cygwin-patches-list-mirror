Return-Path: <cygwin-patches-return-1630-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 11694 invoked by alias); 26 Dec 2001 17:46:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11661 invoked from network); 26 Dec 2001 17:46:30 -0000
Date: Fri, 09 Nov 2001 03:46:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: A few fixes to winsup/utils/cygpath.cc
Message-ID: <20011226174623.GA21656@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20011226130350.7718.qmail@lizard.curl.com> <20011226173530.GB21023@redhat.com> <20011226174012.23919.qmail@lizard.curl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011226174012.23919.qmail@lizard.curl.com>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2001-q4/txt/msg00162.txt.bz2

On Wed, Dec 26, 2001 at 12:40:12PM -0500, Jonathan Kamens wrote:
>2001-12-26  Jonathan Kamens  <jik@curl.com>
>
>	* cygpath.cc (doit): Detect and warn about an empty path.  Detect
>	and warn about errors converting a path.
>	(main): Set prog_name correctly -- don't leave an extra slash or
>	backslash at the beginning of it.

Applied.  Thanks.

cgf
