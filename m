Return-Path: <cygwin-patches-return-2023-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 15627 invoked by alias); 4 Apr 2002 04:51:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15607 invoked from network); 4 Apr 2002 04:51:39 -0000
Date: Wed, 03 Apr 2002 20:51:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: stackdump.sgml new file
Message-ID: <20020404045149.GA22318@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20020404043951.19820.qmail@web20010.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020404043951.19820.qmail@web20010.mail.yahoo.com>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00007.txt.bz2

On Wed, Apr 03, 2002 at 08:39:51PM -0800, Joshua Daniel Franklin wrote:
>I was thinking about writing some updated documentation as requested
>lately on the mailing list
>(http://www.cygwin.com/ml/cygwin/2002-03/msg01633.html)
>I've started by writing a new file to document the existance of the 
>cygwin_stackdump() function. ChangeLog:
>
>2001-04-03  Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
>	* stackdump.sgml: New file. Document cygwin_stackdump() function.

I'd probably accept this except for two things:

1) You don't add ChangeLog entries for documentation.

2) The patch is included is an html attachment.

Obviously 1) is a no-op but we really need just a straight patch in
regular text.

cgf
