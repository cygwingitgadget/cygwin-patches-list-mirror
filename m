Return-Path: <cygwin-patches-return-2271-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 9850 invoked by alias); 30 May 2002 11:03:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9795 invoked from network); 30 May 2002 11:03:06 -0000
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "'Corinna Vinschen'" <cygwin-patches@cygwin.com>
Subject: RE: Cleanup of ntdll.h
Date: Thu, 30 May 2002 04:03:00 -0000
Message-ID: <00ef01c207c9$93cc35d0$0200a8c0@lifelesswks>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
Importance: Normal
In-Reply-To: <20020530102327.Z30892@cygbert.vinschen.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 30 May 2002 11:03:03.0690 (UTC) FILETIME=[91DE96A0:01C207C9]
X-SW-Source: 2002-q2/txt/msg00254.txt.bz2



> -----Original Message-----
> From: cygwin-patches-owner@cygwin.com 
> [mailto:cygwin-patches-owner@cygwin.com] On Behalf Of Corinna Vinschen
> Sent: Thursday, 30 May 2002 6:23 PM
> To: cygpatch
> Subject: Re: Cleanup of ntdll.h
> 
> 
> On Thu, May 30, 2002 at 06:04:19PM +1000, Robert Collins wrote:
> > > [mailto:cygwin-patches-owner@cygwin.com] On Behalf Of 
> Corinna Vinschen
> > > I changed that now so that all functions are called with 
> Nt prefix.
> > 
> > This is incorrect. BOTH definitions should exist. NtXXX are 
> kernel mode
> > calls, ZwXXX are user mode calls that gate through to 
> kernel mode calls
> > via int 2eh.
> 
> Nope.  From user mode both call types are identical.  There's no need
> to use both forms in Cygwin and since the header is only used inside
> of Cygwin there's also no need to define both variations.  
> One is enough.
> It's all one to me if it's the Zw or Nt version but we should at least
> use always the same.

It was my understandinf that the NtXXX calls cannot be used from user
mode. We should be using the Zw calls.

Rob
