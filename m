Return-Path: <cygwin-patches-return-4977-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19169 invoked by alias); 22 Sep 2004 14:28:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19139 invoked from network); 22 Sep 2004 14:28:54 -0000
Date: Wed, 22 Sep 2004 14:28:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH]: Still path.cc
Message-ID: <20040922143054.GF26453@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040921215840.0081d100@incoming.verizon.net> <Pine.CYG.4.58.0409220918030.2736@fordpc.vss.fsi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.CYG.4.58.0409220918030.2736@fordpc.vss.fsi.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q3/txt/msg00129.txt.bz2

On Wed, Sep 22, 2004 at 09:20:50AM -0500, Brian Ford wrote:
>On Tue, 21 Sep 2004, Pierre A. Humblet wrote:
>>Avoid infinite loop with names starting in double dots.
>
>This may not be appropriate for this list, but...
>
>Thank you, thank you, thank you! I often mistype ../somewhere as
>..somewhere and lock up my shell.

Are you saying that you noticed this problem and didn't report it?
Or, did you report it and we missed it?

If it's the former then shame on you.  If it is the latter then shame on
us and minor shame on you for not being persistent in bringing this
serious bug to our attention.

cgf
