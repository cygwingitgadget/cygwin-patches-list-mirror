Return-Path: <cygwin-patches-return-3792-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20526 invoked by alias); 8 Apr 2003 21:20:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20515 invoked from network); 8 Apr 2003 21:20:12 -0000
Date: Tue, 08 Apr 2003 21:20:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: PATCH: Better handle accented characters from the console
Message-ID: <20030408212027.GB26129@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <OF6CEF17F8.90DA3582-ON85256D02.0067BCF9-85256D02.006A074C@abinitio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF6CEF17F8.90DA3582-ON85256D02.0067BCF9-85256D02.006A074C@abinitio.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00019.txt.bz2

On Tue, Apr 08, 2003 at 03:18:07PM -0400, Bob Cassels wrote:
>I hope this patch is simple enough to not require paperwork.

It is.  I've applied it with some very minor formatting tweaks to
ChangeLog and code.

Thanks for your contribution.

cgf

>2003-04-08  Bob Cassels <bcassels@abinitio.com>
>        * fhandler_console.cc: In fhandler_console::read, handle
>        certain key up events, to allow pasting accented characters
>        and typing them using the "alt + numerics" sequences.
