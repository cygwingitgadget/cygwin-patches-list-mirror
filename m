Return-Path: <cygwin-patches-return-3827-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11659 invoked by alias); 19 Apr 2003 01:04:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11648 invoked from network); 19 Apr 2003 01:04:55 -0000
Date: Sat, 19 Apr 2003 01:04:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: /proc/cpuinfo output differs from Linux
Message-ID: <20030419010512.GB29101@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3EA07D56.5070509@biurrun.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EA07D56.5070509@biurrun.de>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00054.txt.bz2

On Sat, Apr 19, 2003 at 12:33:58AM +0200, Diego Biurrun wrote:
>I grepped through the Cygwin sources for "vendor id" and made a small
>patch.  It is not tested but trivial, so I expect it to be fully correct.
>Regards

>2003-04-18  Diego Biurrun  <diego@biurrun.de>
>
>	* fhandler_proc.cc (format_proc_cpuinfo): Change /proc/cpuinfo "vendor id"
>	string to "vendor_id" to conform with Linux systems.

Applied.

Thanks,
cgf
