Return-Path: <cygwin-patches-return-3139-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 2250 invoked by alias); 7 Nov 2002 12:56:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2241 invoked from network); 7 Nov 2002 12:56:17 -0000
Date: Thu, 07 Nov 2002 04:56:00 -0000
From: Jason Tishler <jason@tishler.net>
Subject: Re: export fseeko() and ftello() patch
In-reply-to: <20021107101213.I2180@cygbert.vinschen.de>
To: Cygwin-Patches <cygwin-patches@cygwin.com>
Mail-followup-to: Cygwin-Patches <cygwin-patches@cygwin.com>
Message-id: <20021107130006.GA1820@tishler.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.4i
References: <20021107040756.GB3920@redhat.com>
 <20021107101213.I2180@cygbert.vinschen.de>
X-SW-Source: 2002-q4/txt/msg00090.txt.bz2

Corinna,

On Thu, Nov 07, 2002 at 10:12:13AM +0100, Corinna Vinschen wrote:
> > The attached patch exports newlib's fseeko() and ftello().  Besides
> 
> Applied, thanks. 

You are very welcome.

> Note, though, that this isn't the ultimate solution.  In the long run
> we must write our own entry points for 32 bit as well as 64 bit off_t.
> The problem is that newlib is still not changed to support both off_t
> types on the FILE-I/O function level.  Sigh.

Understood.  At least PostgreSQL 7.3 (yet to be released) will build
OOTB again.

Thanks,
Jason

-- 
PGP/GPG Key: http://www.tishler.net/jason/pubkey.asc or key servers
Fingerprint: 7A73 1405 7F2B E669 C19D  8784 1AFD E4CC ECF4 8EF6
