Return-Path: <cygwin-patches-return-3705-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30598 invoked by alias); 14 Mar 2003 09:03:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30532 invoked from network); 14 Mar 2003 09:03:47 -0000
Date: Fri, 14 Mar 2003 09:03:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin@cygwin.com, "Cygwin-Patches@Cygwin.Com" <cygwin-patches@cygwin.com>
Subject: Re: Cygwin installation choke
Message-ID: <20030314090345.GC27047@cygbert.vinschen.de>
Mail-Followup-To: cygwin@cygwin.com,
	"Cygwin-Patches@Cygwin.Com" <cygwin-patches@cygwin.com>
References: <20030313225350.GV27047@cygbert.vinschen.de> <LPEHIHGCJOAIPFLADJAHMEMNDGAA.chris@atomice.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LPEHIHGCJOAIPFLADJAHMEMNDGAA.chris@atomice.net>
User-Agent: Mutt/1.4i
X-SW-Source: 2003-q1/txt/msg00354.txt.bz2

Chris,

On Thu, Mar 13, 2003 at 11:57:43PM -0000, Chris January wrote:
> Corinna, the cpuid results are still valid if the user doesn't have NT. Only
> in the worst case scenario (i.e. a user running Windows 95/98 on a 486) will
> it be necessary to resort to falling back on the registry values alone.

thanks but your patch isn't valid AFAICS.  Besides the fact that a ChangeLog
is missing, it expects to find the same registry values as in NT.  But the
"~Mhz" value isn't available for example, only "VendorIdentifier", "Identifier"
and a REG_DWORD value called "Update Status".

> -	  if (IsProcessorFeaturePresent (PF_XMMI64_INSTRUCTIONS_AVAILABLE))
> -	    print (" sse2");
> +      if (!wincap.is_winnt ())
             ^^^^^^^^^^^^^^^^^^^
	     You don't mean this, do you?

> +        {
> +	      print ("flags           :");
> +	      if (IsProcessorFeaturePresent (PF_3DNOW_INSTRUCTIONS_AVAILABLE))
> +	        print (" 3dnow");

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
