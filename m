Return-Path: <cygwin-patches-return-4955-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21653 invoked by alias); 12 Sep 2004 03:50:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21642 invoked from network); 12 Sep 2004 03:50:08 -0000
Date: Sun, 12 Sep 2004 03:50:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: Setting the winpid in pinfo
Message-ID: <20040912035134.GF18421@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040907212602.0085d7f0@incoming.verizon.net> <3.0.5.32.20040907212602.0085d7f0@incoming.verizon.net> <3.0.5.32.20040910212935.007e4310@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20040910212935.007e4310@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q3/txt/msg00107.txt.bz2

On Fri, Sep 10, 2004 at 09:29:35PM -0400, Pierre A. Humblet wrote:
>	* exceptions.cc: Add header files.
>	(ctrl_c_handler): Do nothing while a Cygwin subprocess is
>	starting.

I checked in a variation of this patch which used myself->ppid_handle
as a method for finding if the process was started by a cygwin process.
This means that a program which execs itself two or more times from
the command prompt will not trigger this behavior but I'm not 100%
sure that that isn't the correct behavior.

I also checked in the other two changes which I've mentioned in this
thread.

Thanks, as always, for your patch.

cgf
