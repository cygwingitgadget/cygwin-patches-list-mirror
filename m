Return-Path: <cygwin-patches-return-1959-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 12930 invoked by alias); 9 Mar 2002 18:37:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12887 invoked from network); 9 Mar 2002 18:37:16 -0000
Date: Sat, 09 Mar 2002 13:19:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Cc: Egor Duda <deo@logos-m.ru>
Subject: Re: dumper.exe help/version patch
Message-ID: <20020309183625.GC19168@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com, Egor Duda <deo@logos-m.ru>
References: <20020309065328.40363.qmail@web20002.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020309065328.40363.qmail@web20002.mail.yahoo.com>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q1/txt/msg00316.txt.bz2

On Fri, Mar 08, 2002 at 10:53:28PM -0800, Joshua Daniel Franklin wrote:
>Here is the next in the series of patches to standardize the help and
>version options in the utils. This also adds GNUish options to dumper.
>I left the "Compiled on __DATE__" out of
>print_version since there is a #ifdef __GNUC__ in the file and I don't
>know whether that trick works with all compilers.
>
>2002-03-09  Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
>* dumper.cc (usage) Standardize usage output. Generalize to allow use for help.
>            (longopts) New struct. Added longopts for all options.
>            (print_version) New function. 
>            (main) Change getopt to getopt_long. Accommodate new help and 
>            version options. 

I'd like Egor to approve this patch, if possible.

cgf
