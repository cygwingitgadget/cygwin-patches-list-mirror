Return-Path: <cygwin-patches-return-2839-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 6247 invoked by alias); 16 Aug 2002 19:33:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6230 invoked from network); 16 Aug 2002 19:33:16 -0000
Message-ID: <3D5D537A.6060002@hekimian.com>
Date: Fri, 16 Aug 2002 12:33:00 -0000
X-Sybari-Trust: 7da5c1c6 b923d9bf 4738785c 00000109
From: Joe Buehler <jbuehler@hekimian.com>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.0.0) Gecko/20020530
X-Accept-Language: en-us, en
MIME-Version: 1.0
Newsgroups: gmane.os.cygwin
To: Pavel Tsekov <ptsekov@gmx.net>
CC:  mc-devel@gnome.org,  cygwin-patches@cygwin.com
Subject: Re: [PATCH suggestion] exceptions.cc, interrupt_setup ()
References: <119122398409.20020816203409@gmx.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q3/txt/msg00287.txt.bz2

Pavel Tsekov wrote:

> I suggest the following very simple patch. Since I may have not
> understand all the specifics of the signal handling mechanism I offer
> it for discussion. Just for the record - this patch solves that
> outstanding problem with MC.

Good work!  I applied this, and initial testing indicates that this may
have cured the emacs subprocess problems also.

Joe Buehler

