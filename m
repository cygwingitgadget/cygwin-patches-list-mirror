Return-Path: <cygwin-patches-return-2814-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 30340 invoked by alias); 10 Aug 2002 15:11:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30326 invoked from network); 10 Aug 2002 15:11:43 -0000
Message-ID: <3D552D58.20840521@yahoo.com>
Date: Sat, 10 Aug 2002 08:11:00 -0000
From: Earnie Boyd <earnie_boyd@yahoo.com>
X-Accept-Language: en
MIME-Version: 1.0
To: Casper Hornstrup <chorns@users.sourceforge.net>
CC: mingw-patches@lists.sourceforge.net, cygwin-patches@cygwin.com
Subject: Re: [MinGW-patches] [PATCH] Windows Sockets Helper definitions
References: <002b01c23ff8$1d9f3e90$0c00000a@casper> <000601c2403b$ff2ef1f0$a898a7cb@DANNY> <007101c2404a$e5108d60$0a00000a@casper>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q3/txt/msg00262.txt.bz2

Casper Hornstrup wrote:
> 
> The Platform SDK contains more than the Win32 API, so maybe we should decide
> if
> w32api should be a platform SDK or we should have a new subproject for such
> additions that isn't strictly Win32 APIs. Other Windows Sockets files would
> be more
> Platform SDK material than Win32 API material. Also DirectX is really not
> Win32 APIs
> either. I vote for a new CVS module for the non-Win32 API stuff.
> 

I've created winsup/w32sdk for this.  I'll create a corresponding entry
in the mingw CVS once we have files.

Earnie.
