Return-Path: <cygwin-patches-return-2712-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 30362 invoked by alias); 25 Jul 2002 10:54:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30342 invoked from network); 25 Jul 2002 10:53:59 -0000
Date: Thu, 25 Jul 2002 03:54:00 -0000
From: egor duda <deo@logos-m.ru>
Reply-To: egor duda <cygwin-patches@cygwin.com>
Organization: deo
X-Priority: 3 (Normal)
Message-ID: <147614140186.20020725145317@logos-m.ru>
To: Robert Collins <robert.collins@syncretize.net>
CC: cygwin-patches@cygwin.com
Subject: Re: src/winsup/cygwin ChangeLog cygwin.din
In-Reply-To: <1027592838.31744.0.camel@lifelesswks>
References: <20020724073803.17255.qmail@sources.redhat.com>
 <145518762130.20020724122337@logos-m.ru> <20020724153129.GE13558@redhat.com>
 <149608496601.20020725131913@logos-m.ru> <1027592838.31744.0.camel@lifelesswks>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q3/txt/msg00160.txt.bz2

Hi!

Thursday, 25 July, 2002 Robert Collins robert.collins@syncretize.net wrote:

RC> On Thu, 2002-07-25 at 19:19, egor duda wrote:
>> Wednesday, 24 July, 2002 Christopher Faylor cgf@redhat.com wrote:
>> CF> Hmm.  I wonder if we could automatically generate the version number
>> CF> when cygwin.din changes.
>> 
>> Well, maybe. I'm not sure if we can say "accidental changes" such as
>> touching cygwin.din or converting it from textmode to binmode or
>> something like that from real changes in export table. Anyway, manual
>> updating of version.h is not much work, if you're reminded about it.

RC> It will never hurt to bump API minor, as that is a forwards
RC> compatability flag, not a backwards one. Worst case: we have a few
RC> never-released API versions.

I suppose we want not only indicate that api has been changed, but
also update a comment in version.h which says what exactly is changed.

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19
