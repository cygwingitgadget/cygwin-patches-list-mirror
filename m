Return-Path: <cygwin-patches-return-1967-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 23490 invoked by alias); 11 Mar 2002 08:35:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23449 invoked from network); 11 Mar 2002 08:35:10 -0000
Date: Mon, 11 Mar 2002 04:25:00 -0000
From: egor duda <deo@logos-m.ru>
X-Mailer: The Bat! (v1.53 RC/4)
Reply-To: egor duda <cygwin-patches@cygwin.com>
Organization: deo
X-Priority: 3 (Normal)
Message-ID: <19061518398.20020311113202@logos-m.ru>
To: Christopher Faylor <cygwin-patches@cygwin.com>
CC: Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
Subject: Re: dumper.exe help/version patch
In-Reply-To: <20020309183625.GC19168@redhat.com>
References: <20020309065328.40363.qmail@web20002.mail.yahoo.com>
 <20020309183625.GC19168@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q1/txt/msg00324.txt.bz2

Hi!

Saturday, 09 March, 2002 Christopher Faylor cgf@redhat.com wrote:

CF> On Fri, Mar 08, 2002 at 10:53:28PM -0800, Joshua Daniel Franklin wrote:
>>Here is the next in the series of patches to standardize the help and
>>version options in the utils. This also adds GNUish options to dumper.
>>I left the "Compiled on __DATE__" out of
>>print_version since there is a #ifdef __GNUC__ in the file and I don't
>>know whether that trick works with all compilers.
>>
>>2002-03-09  Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
>>* dumper.cc (usage) Standardize usage output. Generalize to allow use for help.
>>            (longopts) New struct. Added longopts for all options.
>>            (print_version) New function. 
>>            (main) Change getopt to getopt_long. Accommodate new help and 
>>            version options. 

CF> I'd like Egor to approve this patch, if possible.

i have no objections to this patch.

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19
