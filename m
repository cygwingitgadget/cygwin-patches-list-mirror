Return-Path: <cygwin-patches-return-2268-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 28428 invoked by alias); 30 May 2002 08:04:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28370 invoked from network); 30 May 2002 08:04:38 -0000
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "'Corinna Vinschen'" <cygwin-patches@cygwin.com>
Subject: RE: Cleanup of ntdll.h
Date: Thu, 30 May 2002 01:04:00 -0000
Message-ID: <00e901c207b0$9ac7d060$0200a8c0@lifelesswks>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
Importance: Normal
In-Reply-To: <20020530095651.Y30892@cygbert.vinschen.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 30 May 2002 08:04:18.0378 (UTC) FILETIME=[9915DAA0:01C207B0]
X-SW-Source: 2002-q2/txt/msg00251.txt.bz2



> -----Original Message-----
> From: cygwin-patches-owner@cygwin.com 
> [mailto:cygwin-patches-owner@cygwin.com] On Behalf Of Corinna Vinschen
> Sent: Thursday, 30 May 2002 5:57 PM
> To: cygpatch
> Subject: Cleanup of ntdll.h
> 
> 
> Hi,
> 
> I've cleaned up the usage of NTDLL.DLL functions slightly.  For some
> reason the function ZwQueryInformationProcess has been additionally
> defined even though NtQueryInformationProcess was already available.
> Additional functions have been defined as ZwXXX while formerly
> already defined functions did use the NtXXX style.
> 
> I changed that now so that all functions are called with Nt prefix.

This is incorrect. BOTH definitions should exist. NtXXX are kernel mode
calls, ZwXXX are user mode calls that gate through to kernel mode calls
via int 2eh.

Rob
