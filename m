Return-Path: <cygwin-patches-return-2108-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 20842 invoked by alias); 25 Apr 2002 03:19:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20705 invoked from network); 25 Apr 2002 03:18:57 -0000
Message-ID: <3CC77639.2000901@ece.gatech.edu>
Date: Wed, 24 Apr 2002 20:19:00 -0000
From: Charles Wilson <cwilson@ece.gatech.edu>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: Charles Wilson <cwilson@ece.gatech.edu>
CC: Robert Collins <robert.collins@itdomain.com.au>,
	cygwin-patches@cygwin.com
Subject: Re: Packaging information
References: <FC169E059D1A0442A04C40F86D9BA7600C5EE0@itdomain003.itdomain.net.au> <3CC6CDFE.9040600@ece.gatech.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q2/txt/msg00092.txt.bz2



Charles Wilson wrote:


>> Why not link to them via cvsweb?
> 
> 
> 
> Hey, yeah -- that'll work.  Where should generic-* go -- in one of the 
> existing repositories under cygwin-apps (probably not), or should I 
> create another?  If I should create another, what should it be called? 
> resources?
> 
> existing /cvs/cygwin-apps/ modules:
> 
> cygrunsrv  cygutils  htdocs  libgetopt++  mknetrel  resedit


Any objections to the following:

I'll create a new module under /cvs/cygwin-apps: 'resources', and add 
generic-build-script and generic-readme to it.  (I think I have enough 
write access to do that.

I'll commit the previously posted patch to htdocs/setup.html, except 
that the links to generic-* will be modified to cvsweb paths.

Okay?

--Chuck

