Return-Path: <cygwin-patches-return-3710-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2053 invoked by alias); 18 Mar 2003 13:02:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1960 invoked from network); 18 Mar 2003 13:02:53 -0000
Date: Tue, 18 Mar 2003 13:02:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: "Cygwin-Patches@Cygwin.Com" <cygwin-patches@cygwin.com>
Subject: Re: /proc/cpuinfo fix
Message-ID: <20030318130250.GA1228@cygbert.vinschen.de>
Mail-Followup-To: "Cygwin-Patches@Cygwin.Com" <cygwin-patches@cygwin.com>
References: <LPEHIHGCJOAIPFLADJAHMEABDHAA.chris@atomice.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LPEHIHGCJOAIPFLADJAHMEABDHAA.chris@atomice.net>
User-Agent: Mutt/1.4i
X-SW-Source: 2003-q1/txt/msg00359.txt.bz2

On Tue, Mar 18, 2003 at 01:45:05AM -0000, Chris January wrote:
> This patch changes Corinna's fix for the IsProcessorFeaturePresent missing
> export so that the cpuid instruction is called (if available) even on non-NT
> systems, giving more detailed information. This patch does not allow for the
> bug in IsProcessorFeaturePresent on Windows NT 4 (i.e. on 486DX processors
> it will incorrectly report that an FPU is not present).
> This patch is UNTESTED on Windows 95/98/Me since I can't do that until
> tomorrow.

I've tested it on 98SE and ME and it worked fine.  I've applied it to
the trunk and the dontuse-21 branch.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
