Return-Path: <cygwin-patches-return-2463-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 9996 invoked by alias); 19 Jun 2002 02:12:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9909 invoked from network); 19 Jun 2002 02:12:27 -0000
Date: Tue, 18 Jun 2002 19:12:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: cygpath cosmetics
Message-ID: <20020619021305.GA20026@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.CYG.4.44.0206182016330.1256-200000@iocc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.CYG.4.44.0206182016330.1256-200000@iocc.com>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00446.txt.bz2

On Tue, Jun 18, 2002 at 08:17:20PM -0500, Joshua Daniel Franklin wrote:
>2002-06-18  Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
>
>	* cygpath.cc (usage): Clean up usage output.
>	(dowin): Correct output of -t mixed for -ADHPSW options.

Applied.  I had to move some functions around to get it to compile,
though.

cgf
