Return-Path: <cygwin-patches-return-1855-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 10598 invoked by alias); 9 Feb 2002 09:01:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10569 invoked from network); 9 Feb 2002 09:01:49 -0000
Date: Sat, 09 Feb 2002 15:05:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: Tokenring support for network interfaces
Message-ID: <20020209100146.W14241@cygbert.vinschen.de>
Mail-Followup-To: cygpatch <cygwin-patches@cygwin.com>
References: <20020207151153.Z14241@cygbert.vinschen.de> <Pine.LNX.4.21.0202071532110.9517-100000@rotuma.informatik.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0202071532110.9517-100000@rotuma.informatik.tu-chemnitz.de>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q1/txt/msg00212.txt.bz2

On Thu, Feb 07, 2002 at 04:05:42PM +0100, Alexander Gottwald wrote:
> On Thu, 7 Feb 2002, Corinna Vinschen wrote:
> 
> > Me neither.  Perhaps it's ok to implement it just based on the
> > description (if any and if it's at all possible)?!?
> 
> For NT and 95: every interface which is not ppp is considered as eth type. 
> This is not correct, but at least they're listed. I've searched the msdn
> but found no information where and how it is coded that an network inter-
> face is tokenring or ethernet or something else.
> 
> The Problem with the 2k implementation was that the tokenring adapters
> were left out and xfree could not find the correct interface for the local 
> ip-address.

Ok, I have applied your patch as is.

Thanks!
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
