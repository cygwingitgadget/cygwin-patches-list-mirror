Return-Path: <cygwin-patches-return-3458-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21792 invoked by alias); 24 Jan 2003 15:16:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21783 invoked from network); 24 Jan 2003 15:16:29 -0000
Date: Fri, 24 Jan 2003 15:16:00 -0000
From: Jason Tishler <jason@tishler.net>
Subject: Re: setregid() and setreuid() patch
In-reply-to: <20030124145520.GA612@tishler.net>
To: Cygwin-Patches <cygwin-patches@cygwin.com>
Mail-followup-to: Cygwin-Patches <cygwin-patches@cygwin.com>
Message-id: <20030124152120.GB612@tishler.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.4i
References: <20030124145520.GA612@tishler.net>
X-SW-Source: 2003-q1/txt/msg00107.txt.bz2

On Fri, Jan 24, 2003 at 09:55:20AM -0500, Jason Tishler wrote:
> The attached patch implements setregid() and setreuid() as recommended
> by Pierre in:
> 
>     http://cygwin.com/ml/cygwin-developers/2003-01/msg00115.html

Oops.  I just realized that I need to submit a corresponding newlib
patch to declare setregid() and setreuid().

Jason

-- 
PGP/GPG Key: http://www.tishler.net/jason/pubkey.asc or key servers
Fingerprint: 7A73 1405 7F2B E669 C19D  8784 1AFD E4CC ECF4 8EF6
