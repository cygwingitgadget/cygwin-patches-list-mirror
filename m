Return-Path: <cygwin-patches-return-2810-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 19710 invoked by alias); 8 Aug 2002 17:48:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19696 invoked from network); 8 Aug 2002 17:48:11 -0000
Date: Thu, 08 Aug 2002 10:48:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: patch so strace can be used with C code
Message-ID: <20020808174811.GE11425@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3D52ABE4.1010403@hekimian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D52ABE4.1010403@hekimian.com>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q3/txt/msg00258.txt.bz2

On Thu, Aug 08, 2002 at 01:35:32PM -0400, Joe Buehler wrote:
>Attached is a patch to allow the strace printf functionality to be
>used inside C code in Cygwin.  It looks like this might have
>worked at some point in the past -- the changes were easy.
>
>Christopher had objected that it would be better to convert the
>C files to C++, but this is a lot easier until that is done -- there
>are several C files still in Cygwin.

http://cygwin.com/ml/cygwin/2002-07/msg00577.html

cgf
