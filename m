Return-Path: <cygwin-patches-return-2444-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 31879 invoked by alias); 16 Jun 2002 12:26:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31865 invoked from network); 16 Jun 2002 12:26:20 -0000
Message-ID: <3D0C835E.CB5CDC30@yahoo.com>
Date: Sun, 16 Jun 2002 05:26:00 -0000
From: Earnie Boyd <earnie_boyd@yahoo.com>
Reply-To: Earnie Boyd <Cygwin-Patches@Cygwin.Com>
X-Accept-Language: en
MIME-Version: 1.0
To: egor duda <cygwin-patches@cygwin.com>
Subject: Re: Patch to add NtShutdownSystem() to w32api
References: <100171979873.20020616151345@logos-m.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q2/txt/msg00427.txt.bz2

egor duda wrote:
> 
> Hi!
> 
>   NtShutdownSystem() is crude no-caches-flushed-and-no-apps-notified
> but almost always working way to restart nt system.
> 
> egor.            mailto:deo@logos-m.ru icq 5165414 fidonet 2:5020/496.19
> 
>   ------------------------------------------------------------------------
>                                    Name: w32api-ntshutdownsystem.diff
>    w32api-ntshutdownsystem.diff    Type: unspecified type (application/octet-stream)
>                                Encoding: base64
> 
>                                         Name: w32api-ntshutdownsystem.ChangeLog
>    w32api-ntshutdownsystem.ChangeLog    Type: unspecified type (application/octet-stream)
>                                     Encoding: base64

Uh, these aren't yet a part of w32api.  Cygwin, supplies a header for
one in winsup/cygwin and I know that both WINE and ReactOS both have
their own versions.  We have discussed on the mingw-dvlpr list of
possibly adding this so that everyone doesn't have to invent new
wheels.  I see that you have a new file for ntdll.h but from where did
you get your ntdll.def?

Earnie.
