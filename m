Return-Path: <cygwin-patches-return-3461-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15625 invoked by alias); 24 Jan 2003 15:49:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15616 invoked from network); 24 Jan 2003 15:49:17 -0000
Date: Fri, 24 Jan 2003 15:49:00 -0000
From: Jason Tishler <jason@tishler.net>
Subject: Re: setregid() and setreuid() patch
In-reply-to: <20030124152636.GH29236@cygbert.vinschen.de>
To: Cygwin-Patches <cygwin-patches@cygwin.com>
Mail-followup-to: Cygwin-Patches <cygwin-patches@cygwin.com>
Message-id: <20030124155422.GC612@tishler.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.4i
References: <20030124145520.GA612@tishler.net>
 <20030124152636.GH29236@cygbert.vinschen.de>
X-SW-Source: 2003-q1/txt/msg00110.txt.bz2

Corinna,

On Fri, Jan 24, 2003 at 04:26:36PM +0100, Corinna Vinschen wrote:
> Applied with minor changes:
> 
> > +setreuid (__uid32_t ruid, __uid32_t euid)
>              ^^^^^^^^^
> 	     __uid16_t

Oops, yank and put error.  Thanks for cleaning up after me.

> I've also applied the missing declarations in newlib's sys/unistd.h.

Thanks for the above too.

Jason

-- 
PGP/GPG Key: http://www.tishler.net/jason/pubkey.asc or key servers
Fingerprint: 7A73 1405 7F2B E669 C19D  8784 1AFD E4CC ECF4 8EF6
