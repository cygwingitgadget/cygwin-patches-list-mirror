Return-Path: <cygwin-patches-return-2498-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 12138 invoked by alias); 24 Jun 2002 02:09:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12073 invoked from network); 24 Jun 2002 02:09:26 -0000
Date: Sun, 23 Jun 2002 19:25:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: lib/_cygwin_S_IEXEC.cc and extern "C" scope
Message-ID: <20020624021012.GA17066@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <07c601c21add$428ebae0$6132bc3e@BABEL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07c601c21add$428ebae0$6132bc3e@BABEL>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00481.txt.bz2

On Sun, Jun 23, 2002 at 06:41:51PM +0100, Conrad Scott wrote:
>Another nit: "lib/_cygwin_S_IEXEC.cc" #include's "winsup.h" et al
>inside an extern "C" declaration. Presumably it would be better done
>outside.

>2002-06-23  Conrad Scott  <conrad.scott@dsl.pipex.com>
>
>	* lib/_cygwin_S_IEXEC.cc: Move #include's outside extern "C".

Funny, I was just thinking about this the other day.  This file was a
noble-but-doomed experiment in speeding up stat accesses.  I have
removed it from the repository.  Thanks for reminding me about this.

cgf
