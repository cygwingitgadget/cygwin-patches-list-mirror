Return-Path: <cygwin-patches-return-1588-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 19246 invoked by alias); 14 Dec 2001 17:15:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19227 invoked from network); 14 Dec 2001 17:15:41 -0000
Date: Sun, 04 Nov 2001 14:55:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Minor mkpasswd patch
Message-ID: <20011214171608.GA24469@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20011214121658.A2348@dothill.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011214121658.A2348@dothill.com>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2001-q4/txt/msg00120.txt.bz2

On Fri, Dec 14, 2001 at 12:16:58PM -0500, Jason Tishler wrote:
>The attached fixes a SEGV caused by using the '-p' option:
>
>Fri Dec 14 12:10:39 2001  Jason Tishler <jason@tishler.net>
>
>	* mkpasswd.c (opts): Add indication that '-p' option requires an
>	argument.

Thanks.  Applied.

cgf
