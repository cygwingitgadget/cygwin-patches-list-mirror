Return-Path: <cygwin-patches-return-2710-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 23550 invoked by alias); 25 Jul 2002 09:20:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23535 invoked from network); 25 Jul 2002 09:20:50 -0000
Date: Thu, 25 Jul 2002 02:20:00 -0000
From: egor duda <deo@logos-m.ru>
Reply-To: egor duda <cygwin-patches@cygwin.com>
Organization: deo
X-Priority: 3 (Normal)
Message-ID: <149608496601.20020725131913@logos-m.ru>
To: Christopher Faylor <cygwin-patches@cygwin.com>
Subject: Re: src/winsup/cygwin ChangeLog cygwin.din
In-Reply-To: <20020724153129.GE13558@redhat.com>
References: <20020724073803.17255.qmail@sources.redhat.com>
 <145518762130.20020724122337@logos-m.ru> <20020724153129.GE13558@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q3/txt/msg00158.txt.bz2

Hi!

Wednesday, 24 July, 2002 Christopher Faylor cgf@redhat.com wrote:

CF> On Wed, Jul 24, 2002 at 12:23:37PM +0400, egor duda wrote:
>>How about this? The check is not a panacea, but at least it catches
>>most typical cases.
>>
>>        * Makefile.in: Check if API version is updated when exports
>>        from dll are changed and stop if not so.

CF> Great idea, Egor.  Please check it in.

Done.

CF> Hmm.  I wonder if we could automatically generate the version number
CF> when cygwin.din changes.

Well, maybe. I'm not sure if we can say "accidental changes" such as
touching cygwin.din or converting it from textmode to binmode or
something like that from real changes in export table. Anyway, manual
updating of version.h is not much work, if you're reminded about it.

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19
