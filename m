Return-Path: <cygwin-patches-return-2500-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 29095 invoked by alias); 24 Jun 2002 02:37:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29056 invoked from network); 24 Jun 2002 02:37:03 -0000
Date: Sun, 23 Jun 2002 20:55:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: YACP
Message-ID: <20020624023742.GA3460@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.CYG.4.44.0206221151001.1308-200000@iocc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.CYG.4.44.0206221151001.1308-200000@iocc.com>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00483.txt.bz2

On Sat, Jun 22, 2002 at 11:52:38AM -0500, Joshua Daniel Franklin wrote:
>2002-06-22  Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
>
>	* cygpath.cc (long_options): Add "dos" and "mixed", correct
>	"close", "file" and "type" to use NULL flag.
>	(usage): Clean up usage output (more), accomodate new options.
>	(main): Add --dos and --mixed options; accomodate all output
>	forms in --type. Make UNIXy output default.

Applied.

Thanks.
cgf
