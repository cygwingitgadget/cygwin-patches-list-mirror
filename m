Return-Path: <cygwin-patches-return-3138-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 9109 invoked by alias); 7 Nov 2002 09:12:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9091 invoked from network); 7 Nov 2002 09:12:19 -0000
Date: Thu, 07 Nov 2002 01:12:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: Cygwin-Patches <cygwin-patches@cygwin.com>
Subject: Re: export fseeko() and ftello() patch
Message-ID: <20021107101213.I2180@cygbert.vinschen.de>
Mail-Followup-To: Cygwin-Patches <cygwin-patches@cygwin.com>
References: <20021107040756.GB3920@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021107040756.GB3920@redhat.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q4/txt/msg00089.txt.bz2

> The attached patch exports newlib's fseeko() and ftello().  Besides

Applied, thanks. 

Note, though, that this isn't the ultimate solution.  In the long run we
must write our own entry points for 32 bit as well as 64 bit off_t.  The
problem is that newlib is still not changed to support both off_t types
on the FILE-I/O function level.  Sigh.

Corinna
